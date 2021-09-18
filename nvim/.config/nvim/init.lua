local utils = require("utils")

--------------------------------------------------------------------------------
-- General neovim configuration
--------------------------------------------------------------------------------
-- Map leader to space
vim.g.mapleader = ","

-- More color to the people
vim.opt.termguicolors = true

-- Enable more mouse controls
vim.opt.mouse = "a"

-- Backspace to remove indents
vim.opt.backspace = {"indent", "eol", "start"}
vim.opt.smartcase = true

-- Scroll before reaching end
vim.opt.scrolloff = 4

-- Default tab handling
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"

-- Undo settings
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Allow buffers not being saved
vim.opt.hidden = true

--------------------------------------------------------------------------------
-- Packer
--------------------------------------------------------------------------------

-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath("data") ..
                         "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command(
        "!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
vim.cmd [[packadd packer.nvim]]

-- Helper setup function for setup without config
local setup = function(mod)
    if pcall(function() require(mod).setup {} end) == false then
        print("Error loading " .. mod)
    end
end

require("packer").startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}

    -- Lir file explorer
    use {"tamago324/lir.nvim", requires = {{"nvim-lua/plenary.nvim"}}}

    -- Pimped status line
    use {
        "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }

    -- Toggle quick/location list
    use {"milkypostman/vim-togglelist"}

    -- Color scheme and highlighter
    use {"antonsson/onedark.nvim"}
    use {"norcalli/nvim-colorizer.lua", config = setup("colorizer")}

    -- git
    use {"airblade/vim-gitgutter"}
    use {"tpope/vim-fugitive"}

    -- Comment lines
    use {"tpope/vim-commentary"}

    -- Syntax
    use {"gburca/vim-logcat"}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"nvim-treesitter/nvim-treesitter-textobjects"}

    -- Neovim bultin lsp
    use {"neovim/nvim-lspconfig"}
    use {"folke/lsp-trouble.nvim", config = setup("trouble")}
    use {"nvim-lua/lsp_extensions.nvim"}
    use {"ray-x/lsp_signature.nvim"}

    -- Completion
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-nvim-lua"}
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"hrsh7th/cmp-path"}

    -- Language tools
    use {
        "simrat39/rust-tools.nvim",
        requires = {
            {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope.nvim'}
        }
    }

    -- Fuzzy search
    use {"junegunn/fzf", dir = "~/.fzf", run = "./install --all"}
    use {"junegunn/fzf.vim"}
    use {"gfanto/fzf-lsp.nvim", config = setup("fzf_lsp")}

    -- Format multiple file types
    use {"sbdchd/neoformat"}

    -- Show indentation line
    use {"Yggdroot/indentLine"}

    -- Preview markdown
    use {"npxbr/glow.nvim"}

    -- Focus mode
    use {"folke/zen-mode.nvim", config = setup("zen-mode")}

    -- Rust tools
    use {"simrat39/rust-tools.nvim"}
end)

-- Highlight yanked text
vim.cmd [[autocmd TextYankPost * silent! lua require"vim.highlight".on_yank()]]

-- Makefiles should use tabulators
vim.cmd [[autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab]]

-- Yaml use 2 spaces
vim.cmd [[autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab]]

-- Copy to clipboard
utils.map("v", "<leader>y", '"+y')

-- Highlight yanked text
vim.cmd [[augroup LuaHighlight]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd TextYankPost * silent! lua require"vim.highlight".on_yank()]]
vim.cmd [[augroup END]]

-- Navigation
utils.map("n", ".", ".`[")
utils.map("n", "j", "gj")
utils.map("n", "k", "gk")
utils.map("n", "<c-h>", ":ClangdSwitchSourceHeader <cr>")
utils.map("n", "<F4>", ":e ~/.config/nvim/init.lua <cr>")

-- Format file
utils.map("n", "<leader>cf", ":Neoformat<CR>")
utils.map("v", "<leader>cf", ":Neoformat<CR>")

-- For easier searching
utils.map("n", "-", "/")
utils.map("n", "_", "?")

--------------------------------------------------------------------------------
-- Color scheme
--------------------------------------------------------------------------------
vim.g.onedark_style = "custom"
vim.g.onedark_transparent_background = true
vim.g.onedark_italic_comment = false
require("onedark").setup()

--------------------------------------------------------------------------------
-- indentline
--------------------------------------------------------------------------------
-- Default to not show indent lines toggle with :IndentLinesToggle
vim.g.indentLine_enabled = 0

--------------------------------------------------------------------------------
-- gitgutter
--------------------------------------------------------------------------------
-- Low priority on gitgutter
vim.g.gitgutter_sign_priority = 0
utils.map("n", "<leader>t", ":GitGutterToggle<cr>")

--------------------------------------------------------------------------------
-- neoformat
--------------------------------------------------------------------------------
-- Prioritize eslint-formatter for javascript
vim.g.neoformat_enabled_javascript = {
    "prettiereslint", "jsbeautify", "clang-format"
}
vim.g.neoformat_enabled_python = {"autopep8", "yapf", "docformatter"}

--------------------------------------------------------------------------------
-- fzf
--------------------------------------------------------------------------------
vim.fn.setenv("FZF_DEFAULT_OPTS", "--layout=reverse --margin=1,3")
vim.api.nvim_set_var("fzf_layout", {window = {width = 0.8, height = 0.8}})
vim.api.nvim_set_var("fzf_preview_window", {"up:40%", "ctrl-/"})
utils.map("n", "<leader>f", ":Files<cr>")
utils.map("n", "<leader>b", ":Buffers <cr>")
utils.map("n", "<leader>j", ":GFiles <cr>")
utils.map("n", "<leader>g", ":Rg <cr>")
utils.map("n", "<leader>G", ":Rg <c-r><c-w><cr>")

--------------------------------------------------------------------------------
-- External plugin configs
--------------------------------------------------------------------------------
require("config.lsp")
require("config.lir")
require("config.cmp")
require("config.lualine")
require("config.treesitter")

