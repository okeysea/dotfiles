const fs = require('fs');

class LSPHeader {
  constructor( name = "", value = "" ){
    this._name      = name;
    this._value     = value;
  }

  set name(value){
    this._name = value;
  }

  set value(value){
    this._value = value;
  }

  get name(){
    return this._name;
  }

  get value(){
    return this._value;
  }

  toProtocolFormat() {
    return `${this._name}: ${this._value}\r\n`;
  }
}

class LSPContent {
  constructor(content = "{}") {
    console.log( content );
    this._content = JSON.parse(content);
  }

  toProtocolFormat() {
    return JSON.stringify( this._content );
  }
}

class RPCData {
  constructor(headers = [], content = new LSPContent()){
    this._headers     = headers;
    this._content     = content;
  }

  toProtocolFormat() {
    const content = this._content.toProtocolFormat();
    const contentLength = new LSPHeader("Content-Length", String( content.length ));
    let ret = contentLength.toProtocolFormat();
    for( const header of this._headers ){
      if( header.name != "Content-Length"){
        ret += header.toProtocolFormat();
      }
    }
    ret += "/r/n";
    ret += content;
    return ret;
  }

  toProtocolFormatDebugRaw() {
    let ret = "";
    for( const header of this._headers ){
      ret += header.toProtocolFormat();
    }
    ret += "\r\n";
    ret += this._content.toProtocolFormat();
    return ret;
  }
}

class Parser {

  constructor(){

    this._chunk    = "";
    this._rpcDatas = [];

    // parse statement
    this._prevMode       = "content";
    this._currMode       = "header"; // header or content or wait
    this._contentBytes   = 0;
    this._contentBuffer  = "";
    this._contentMINE    = "";
    this._contentHeaders = [];

    this._HEADER_SEPARETOR = "\r\n";
  }

  attachStream( stream ) {
    stream.on("data", (chunk) => {
      this.intoStream( chunk );
      this.resumableParse();
    });
  }

  intoStream( text ) {
    this._chunk += text;
  }

  resetParseStatements() {
    this._prevMode       = "content";
    this._currMode       = "header";
    this._contentBytes   = 0;
    this._contentBuffer  = "";
    this._contentMINE    = "";
    this._contentHeaders = [];
  }

  changeMode( mode ){
    this._prevMode = this._currMode;
    this._currMode = mode;
  }

  resumeMode(){
    this.changeMode( this._prevMode );
  }

  resumableParse() {
    switch( this._currMode ){
      case "header":
        const sepIdx = this._chunk.indexOf( this._HEADER_SEPARETOR );
        // ヘッダを切り出して、読んでいないものを残す
        const header = this._chunk.substring(0, sepIdx);
        this._chunk  = this._chunk.slice( sepIdx + this._HEADER_SEPARETOR.length );

        if( sepIdx == -1 || sepIdx == 0 ){
          // \r\n がみつからない場合は、まだ途中
          // \r\n のみである場合は、次からcontent開始
          this.changeMode( sepIdx == 0 ? "content" : "wait" );
          break;
        }

        const h = this.parseHeader( header );

        if( h.name == "Content-Length" ) this._contentBytes = Number(h.value);
        if( h.name == "Content-Type"   ) this._contentMINE  = h.value;
        this._contentHeaders.push(h);

        break;
      case "content":

        // データをヘッダで指定されたバイト数に逹っするまで読む
        this._contentBuffer += this._chunk.substring(0, this._contentBytes);
        this._contentBytes  -= this._contentBuffer.length;
        if( this._contentBytes != 0 ){
          this.changeMode( "wait" );
          break;
        }

        // RPCDataを作成
        const rpcData = new RPCData( this._contentHeaders, new LSPContent( this._contentBuffer ) );
        this._rpcDatas.push( rpcData );

        // パーサー状態を初期状態に戻す
        this.resetParseStatements();

        log( rpcData.toProtocolFormatDebugRaw() );
        break;
      case "wait":
        // waitした処理へ戻す
        this.resumeMode();
        break;
      default:
        break;
    }

    // wait でなければまだデータがあるので再帰
    if( this._currMode != "wait" ){ this.resumableParse() };
  }

  parseHeader( str ) {
    const header = str.split(": ", 2);
    return new LSPHeader( header[0], header[1] );
  }

}

process.stdin.setEncoding("utf8");
const parser = new Parser();
parser.attachStream( process.stdin );

function log( str ) {
  fs.appendFile("/home/user/dotfiles/langserv/langserv-proxy/log.txt", str, (err)=>{
    if( err ) console.log( err );
  });
}
