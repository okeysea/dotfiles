local m = {};

function m.setup()
  vim.api.nvim_out_write("Execute setup avante.nvim\n")

  require('avante_lib').load()
  require('avante').setup({
    provider = "copilot",
    copilot = {
      model = "claude-3.5-sonnet",
      -- max_tokens = 4096,
    },
    behaviour = {
      auto_suggestions = false
    }
  })
end

return m;
