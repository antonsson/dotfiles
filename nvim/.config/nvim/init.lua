-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd 'packadd packer.nvim'

-- Helper functions
local map = function(type, key, value)
    vim.api.nvim_set_keymap(type, key, value, {noremap = true, silent = false})
end

-- Plugins
require('packer').startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Lua development
    use {'tjdevries/nlua.nvim'}

    -- Lir file explorer
    use {'tamago324/lir.nvim', requires = {{'nvim-lua/plenary.nvim'}}}

    -- Pimped status line
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Toggle quick/location list
    use {'milkypostman/vim-togglelist'}

    -- Color scheme and highlighter
    use {'joshdick/onedark.vim'}
    --use {'antonsson/equinusocio-material.vim'}
    use {'/home/anton/code/github/equinusocio-material.vim'}
    use {'norcalli/nvim-colorizer.lua'}
    use {'tsiemens/vim-aftercolors'}
    use {'bfrg/vim-cpp-modern'}
    use {'folke/lsp-colors.nvim'}

    -- git
    use {'airblade/vim-gitgutter'}
    use {'tpope/vim-fugitive'}

    -- Comment lines
    use {'tpope/vim-commentary'}

    -- Syntax
    use {'dart-lang/dart-vim-plugin'}
    use {'udalov/kotlin-vim'}
    use {'leafgarland/typescript-vim'}
    use {'gburca/vim-logcat'}
    use {'keith/swift.vim'}

    -- Neovim bultin lsp
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/nvim-compe'}
    use {'folke/lsp-trouble.nvim'}
    use {'nvim-lua/lsp_extensions.nvim'}
    use {'ray-x/lsp_signature.nvim'}

    -- Fuzzy search
    use {'junegunn/fzf', dir = '~/.fzf', run = './install --all'}
    use {'junegunn/fzf.vim'}

    -- Format multiple file types
    use {'sbdchd/neoformat'}

    -- Editor config
    use {'editorconfig/editorconfig-vim'}

    -- Show indentation line
    use {'Yggdroot/indentLine'}
end)

-- Map leader to space
vim.g.mapleader = ','

vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.smartcase = true
vim.opt.ruler = true
vim.opt.scrolloff = 4
vim.opt.conceallevel = 0
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'nosplit'
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.hidden = true
vim.opt.cmdheight = 2
vim.opt.updatetime = 100
vim.opt.completeopt = 'menuone,noselect'

-- colorscheme
vim.g.equinusocio_material = 'darker'
vim.cmd [[colorscheme equinusocio_material]]

-- Highlight yanked text
vim.cmd [[autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()]]

-- Makefiles should use tabulators
vim.cmd [[autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab]]

-- Yaml use 2 spaces
vim.cmd [[autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab]]

-- Copy to clipboard
map("v", "<leader>y", "\"+y")

-- Highlight yanked text
vim.cmd [[augroup LuaHighlight]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()]]
vim.cmd [[augroup END]]

-- Navigation
map("n", ".", ".`[")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<c-h>", ":ClangdSwitchSourceHeader <cr>")
map("n", "<F4>", ":e ~/.config/nvim/init.vim <cr>")

-- Format file
map("n", "<leader>cf", ":Neoformat<CR>")
map("v", "<leader>cf", ":Neoformat<CR>")

-- For easier searching
map("n", "-", "/")
map("n", "_", "?")

--------------------------------------------------------------------------------
-- colorizer
--------------------------------------------------------------------------------
require'colorizer'.setup()

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

--------------------------------------------------------------------------------
-- neoformat
--------------------------------------------------------------------------------
-- Prioritize eslint-formatter for javascript
vim.g.neoformat_enabled_javascript = {
    'prettiereslint', 'jsbeautify', 'clang-format'
}
vim.g.neoformat_enabled_python = {'autopep8', 'yapf', 'docformatter'}

--------------------------------------------------------------------------------
-- fzf
--------------------------------------------------------------------------------
vim.cmd "let $FZF_DEFAULT_OPTS='--layout=reverse --margin=1,3'"
vim.cmd "let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }"
vim.cmd "let g:fzf_preview_window = ['up:40%', 'ctrl-/']"
map("n", "<leader>f", ":Files<cr>")
map("n", "<leader>b", ":Buffers <cr>")
map("n", "<leader>j", ":GFiles <cr>")
map("n", "<leader>g", ":Rg <cr>")
map("n", "<leader>G", ":Rg <c-r><c-w><cr>")

--------------------------------------------------------------------------------
-- lualine
--------------------------------------------------------------------------------
local config = {
    options = {
        icons_enabled = true,
        theme = 'equinusocio_material',
        component_separators = {'', ''},
        section_separators = {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
require('lualine').setup(config)

--------------------------------------------------------------------------------
-- nvim-compe
--------------------------------------------------------------------------------
vim.cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
vim.cmd [[inoremap <silent><expr> <CR>      compe#confirm('<CR>')]]
vim.cmd [[inoremap <silent><expr> <C-e>     compe#close('<C-e>')]]
vim.cmd [[inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })]]
vim.cmd [[inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })]]

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require('compe').setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        path = true,
        buffer = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        vsnip = false
    }
}

--------------------------------------------------------------------------------
-- Trouble diagnstics
--------------------------------------------------------------------------------
require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------
local nvim_lsp = require("lspconfig")

local bmap = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value,
                                {noremap = true, silent = false})
end

local on_attach_lsp = function()
    bmap("n", "ga", ":lua vim.lsp.buf.code_action()<cr>")
    bmap("n", "gd", ":lua vim.lsp.buf.definition()<cr>")
    bmap("n", "gD", ":lua vim.lsp.buf.declaration()<cr>")
    bmap("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")
    bmap("n", "gr", ":lua vim.lsp.buf.references()<cr>")
    bmap("n", "K", ":lua vim.lsp.buf.hover()<cr>")
    bmap("n", "gi", ":lua vim.lsp.buf.implementation()<cr>")
    bmap("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<cr>")
    bmap("n", "1gD", ":lua vim.lsp.buf.type_definition()<cr>")
    bmap("n", "<leader>n", ":lua vim.lsp.diagnostic.goto_next()<cr>")
    bmap("n", "<leader>p", ":lua vim.lsp.diagnostic.goto_prev()<cr>")
    bmap("n", "<leader>i", ":lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")
    bmap("n", "<leader>d", ":LspTroubleToggle<cr>")
    require"lsp_signature".on_attach()
    require'lsp_extensions'.inlay_hints()
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
    cmd = {
        "/usr/bin/lua-language-server", "-E",
        "/usr/share/lua-language-server/main.lua"
    },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    },
    on_attach = on_attach_lsp
}
nvim_lsp.clangd.setup {on_attach = on_attach_lsp}
nvim_lsp.pyls.setup {on_attach = on_attach_lsp}
nvim_lsp.texlab.setup {on_attach = on_attach_lsp}
nvim_lsp.jsonls.setup {on_attach = on_attach_lsp}
nvim_lsp.html.setup {
    on_attach = on_attach_lsp,
    cmd = {"vscode-html-languageserver", "--stdio"},
    init_options = {configurationSection = {"html", "css"}}
}
nvim_lsp.rust_analyzer.setup {on_attach = on_attach_lsp}
nvim_lsp.rls.setup {
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true
        }
    }
}
nvim_lsp.bashls.setup {on_attach = on_attach_lsp}
-- nvim_lsp.kotlin_language_server.setup {
--     on_attach = on_attach_lsp,
--     cmd = {"/home/anton/programs/kotlin-lsp-server/bin/kotlin-language-server"},
--     root_dir = nvim_lsp.util.root_pattern("settings.gradle.kts")
-- }
nvim_lsp.tsserver.setup {on_attach = on_attach_lsp}
nvim_lsp.vimls.setup {on_attach = on_attach_lsp}

-- LSP diagnostics
vim.fn.sign_define("LspDiagnosticsSignError",
                   {text = "", texthl = "LspDiagnosticsError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
                   {text = "", texthl = "LspDiagnosticsWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   {text = "", texthl = "LspDiagnosticsInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint",
                   {text = "", texthl = "LspDiagnosticsHint"})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true
    })

--------------------------------------------------------------------------------
-- lir file explorer
--------------------------------------------------------------------------------
local actions = require('lir.actions')
local mark_actions = require('lir.mark.actions')
local clipboard_actions = require('lir.clipboard.actions')

require'lir'.setup {
    show_hidden_files = true,
    devicons_enable = false,
    mappings = {
        ['l'] = actions.edit,
        ['<CR>'] = actions.edit,
        ['<C-s>'] = actions.split,
        ['<C-v>'] = actions.vsplit,
        ['<C-t>'] = actions.tabedit,

        ['h'] = actions.up,
        ['-'] = actions.up,
        ['q'] = actions.quit,
        ['<ESC>'] = actions.quit,

        ['K'] = actions.mkdir,
        ['N'] = actions.newfile,
        ['R'] = actions.rename,
        ['@'] = actions.cd,
        ['Y'] = actions.yank_path,
        ['.'] = actions.toggle_show_hidden,
        ['D'] = actions.delete,

        ['J'] = function()
            mark_actions.toggle_mark()
            vim.cmd('normal! j')
        end,
        ['C'] = clipboard_actions.copy,
        ['X'] = clipboard_actions.cut,
        ['P'] = clipboard_actions.paste
    },
    float = {
        winblend = 0,

        -- -- You can define a function that returns a table to be passed as the third
        -- -- argument of nvim_open_win().
        win_opts = function()
            local width = math.floor(vim.o.columns * 0.6)
            local height = math.floor(vim.o.lines * 0.6)
            return {
                width = width,
                height = height,
                row = math.floor((vim.o.lines - height) / 2),
                col = math.floor((vim.o.columns - width) / 2),
                border = "rounded",
                style = "minimal"
            }
        end
    },
    hide_cursor = true
}

-- use visual mode
function _G.LirSettings()
    -- echo cwd
    vim.api.nvim_echo({{vim.fn.expand('%:p'), 'Normal'}}, false, {})
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]

map("n", "<leader>e", ":lua require'lir.float'.toggle()<cr>",
    {noremap = true, silent = false})

