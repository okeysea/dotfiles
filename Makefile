.PHONY: help install uninstall install-nvim install-tmux install-bash install-git install-lazygit install-karabiner \
        uninstall-nvim uninstall-tmux uninstall-bash uninstall-git uninstall-lazygit uninstall-karabiner \
        check-stow list clean

.DEFAULT_GOAL := help

## help: Show this help message
help:
	@echo "Dotfiles Management"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*##"; printf ""} \
		/^[a-zA-Z_-]+:.*##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } \
		/^##/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 4) }' $(MAKEFILE_LIST)
	@echo ""

check-stow: ## Check if GNU stow is installed
	@command -v stow >/dev/null 2>&1 || { echo >&2 "GNU stow is not installed. Install it with 'brew install stow' or 'apt install stow'"; exit 1; }
	@echo "GNU stow is installed: $$(stow --version | head -n1)"

## Installation targets:
install: check-stow ## Install all dotfiles
	@echo "Installing all dotfiles..."
	@$(MAKE) install-nvim
	@$(MAKE) install-tmux
	@$(MAKE) install-bash
	@$(MAKE) install-git
	@$(MAKE) install-lazygit-manual
	@$(MAKE) install-karabiner-manual
	@echo ""
	@echo "Installation complete!"
	@echo "Note: Bash scripts need to be sourced in your ~/.bashrc or ~/.zshrc"
	@echo "      See README.md for details"

install-nvim: check-stow ## Install NeoVim configuration
	@echo "Installing NeoVim config..."
	@mkdir -p ~/.config/nvim
	@if [ -f ~/.config/nvim/init.vim ] && [ ! -L ~/.config/nvim/init.vim ]; then \
		echo "WARNING: ~/.config/nvim/init.vim exists and is not a symlink. Backup it first!"; \
		exit 1; \
	fi
	@ln -sf $(PWD)/NeoVim/init.vim ~/.config/nvim/init.vim
	@ln -sf $(PWD)/NeoVim/user_autoload ~/.config/nvim/user_autoload
	@ln -sf $(PWD)/NeoVim/lua ~/.config/nvim/lua
	@echo "NeoVim config installed"

install-tmux: check-stow ## Install tmux configuration
	@echo "Installing tmux config..."
	@if [ -f ~/.tmux.conf ] && [ ! -L ~/.tmux.conf ]; then \
		echo "WARNING: ~/.tmux.conf exists and is not a symlink. Backup it first!"; \
		exit 1; \
	fi
	@ln -sf $(PWD)/tmux/.tmux.conf ~/.tmux.conf
	@echo "Tmux config installed"

install-bash: check-stow ## Install bash/zsh scripts
	@echo "Installing bash scripts..."
	@mkdir -p ~/.local/share/bash-scripts
	@ln -sf $(PWD)/bash ~/.local/share/bash-scripts
	@echo ""
	@echo "Bash scripts installed to ~/.local/share/bash-scripts/bash/"
	@echo ""
	@echo "Add the following to your ~/.bashrc or ~/.zshrc:"
	@echo ""
	@echo "  # Git branch in prompt"
	@echo "  source ~/.local/share/bash-scripts/bash/show_git_branch.sh"
	@echo ""
	@echo "  # FZF utilities"
	@echo "  source ~/.local/share/bash-scripts/bash/cd_with_fzf.sh"
	@echo "  source ~/.local/share/bash-scripts/bash/cd_git_worktree.sh"
	@echo "  source ~/.local/share/bash-scripts/bash/ssh_config_with_fzf.sh"
	@echo ""
	@echo "  # Tmux logging"
	@echo "  source ~/.local/share/bash-scripts/bash/tmux_autologging_ssh.sh"
	@echo "  source ~/.local/share/bash-scripts/bash/tmux_with_logging.sh"
	@echo ""

install-git: check-stow ## Install git configuration
	@echo "Installing git config..."
	@if [ -f ~/.gitconfig ] && [ ! -L ~/.gitconfig ]; then \
		echo "WARNING: ~/.gitconfig exists and is not a symlink."; \
		echo "Current git config will be preserved. Merging manually recommended."; \
		echo "You can manually link with: ln -sf $(PWD)/git/gitconfig ~/.gitconfig"; \
		exit 1; \
	fi
	@ln -sf $(PWD)/git/gitconfig ~/.gitconfig
	@echo "Git config installed"

install-lazygit-manual: ## Install lazygit configuration (macOS/Linux)
	@echo "Installing lazygit config..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		mkdir -p ~/Library/Application\ Support/lazygit; \
		if [ -f ~/Library/Application\ Support/lazygit/config.yml ] && [ ! -L ~/Library/Application\ Support/lazygit/config.yml ]; then \
			echo "WARNING: lazygit config exists and is not a symlink. Backup it first!"; \
			exit 1; \
		fi; \
		ln -sf $(PWD)/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml; \
		echo "Lazygit config installed (macOS)"; \
	else \
		mkdir -p ~/.config/lazygit; \
		if [ -f ~/.config/lazygit/config.yml ] && [ ! -L ~/.config/lazygit/config.yml ]; then \
			echo "WARNING: lazygit config exists and is not a symlink. Backup it first!"; \
			exit 1; \
		fi; \
		ln -sf $(PWD)/lazygit/config.yml ~/.config/lazygit/config.yml; \
		echo "Lazygit config installed (Linux)"; \
	fi

install-karabiner-manual: ## Install Karabiner-Elements config (macOS only)
	@echo "Installing Karabiner-Elements config..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		mkdir -p ~/.config/karabiner; \
		if [ -f ~/.config/karabiner/karabiner.json ] && [ ! -L ~/.config/karabiner/karabiner.json ]; then \
			echo "WARNING: karabiner config exists and is not a symlink. Backup it first!"; \
			exit 1; \
		fi; \
		ln -sf $(PWD)/karabiner/karabiner.json ~/.config/karabiner/karabiner.json; \
		echo "Karabiner config installed"; \
	else \
		echo "Karabiner is macOS only, skipping..."; \
	fi

## Uninstallation targets:
uninstall: check-stow ## Uninstall all dotfiles
	@echo "Uninstalling all dotfiles..."
	@-$(MAKE) uninstall-nvim
	@-$(MAKE) uninstall-tmux
	@-$(MAKE) uninstall-bash
	@-$(MAKE) uninstall-git
	@echo "Uninstall complete!"

uninstall-nvim: ## Uninstall NeoVim configuration
	@echo "Uninstalling NeoVim config..."
	@rm -f ~/.config/nvim/init.vim
	@rm -f ~/.config/nvim/user_autoload
	@rm -f ~/.config/nvim/lua
	@echo "NeoVim config uninstalled"

uninstall-tmux: ## Uninstall tmux configuration
	@echo "Uninstalling tmux config..."
	@rm -f ~/.tmux.conf
	@echo "Tmux config uninstalled"

uninstall-bash: ## Uninstall bash/zsh scripts
	@echo "Uninstalling bash scripts..."
	@rm -f ~/.local/share/bash-scripts/bash
	@echo "Bash scripts uninstalled"

uninstall-git: ## Uninstall git configuration
	@echo "Uninstalling git config..."
	@rm -f ~/.gitconfig
	@echo "Git config uninstalled"

clean: ## Clean up autogenerated files
	@echo "Cleaning up autogenerated files..."
	@find . -name "_autogenerated_*.vim" -type f -delete
	@echo "Clean complete"
