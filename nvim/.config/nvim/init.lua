--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local map = function(type, key, value)
    vim.api.nvim_set_keymap(type, key, value, {noremap = true, silent = true})
end

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

-- Time for cursor hold
vim.o.updatetime = 250

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

    -- Add commands to reload config
    use {"famiu/nvim-reload"}

    -- Lir file explorer
    use {"tamago324/lir.nvim", requires = {{"nvim-lua/plenary.nvim"}}}

    -- Pimped status line
    use {
        "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }

    -- Color scheme and highlighter
    use {"folke/tokyonight.nvim"}
    use {"marko-cerovac/material.nvim"}
    use {"norcalli/nvim-colorizer.lua"}

    -- git
    use {
        "lewis6991/gitsigns.nvim",
        config = setup("gitsigns"),
        requires = {"nvim-lua/plenary.nvim"}
    }
    use {"tpope/vim-fugitive"}

    -- Comment lines
    use {"b3nj5m1n/kommentary"}

    -- Syntax
    use {"gburca/vim-logcat"}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"nvim-treesitter/nvim-treesitter-textobjects"}

    -- Neovim lsp
    use {"neovim/nvim-lspconfig"}
    use {"folke/lsp-trouble.nvim"}
    use {"ray-x/lsp_signature.nvim"}
    use {"weilbith/nvim-code-action-menu", cmd = "CodeActionMenu"}
    use {"j-hui/fidget.nvim", config = setup("fidget")}
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = setup("lsp_lines")
    })

    -- Snippits
    use {"L3MON4D3/LuaSnip"}
    use {"saadparwaiz1/cmp_luasnip"}

    -- Completion
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-nvim-lua"}
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"hrsh7th/cmp-path"}
    use {"onsails/lspkind.nvim"}

    -- Language tools
    use {
        "simrat39/rust-tools.nvim",
        requires = {
            {"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"},
            {"nvim-telescope/telescope.nvim"}
        }
    }
    use {"dart-lang/dart-vim-plugin"}
    use {
        "akinsho/flutter-tools.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = setup("flutter-tools")
    }

    -- Motion
    use {"phaazon/hop.nvim", config = setup("hop")}

    -- Fuzzy search
    use {"nvim-telescope/telescope.nvim"}

    -- Format multiple file types
    use {"sbdchd/neoformat"}

    -- Show indentation line
    use {"lukas-reineke/indent-blankline.nvim"}

    -- Preview markdown
    use {"npxbr/glow.nvim"}

    -- Focus mode
    use {"folke/zen-mode.nvim", config = setup("zen-mode")}

    -- Clipboard manager
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {{'nvim-telescope/telescope.nvim'}},
        config = setup("neoclip")
    }
end)

-- Highlight yanked text
vim.cmd [[autocmd TextYankPost * silent! lua require"vim.highlight".on_yank()]]

-- Makefiles should use tabulators
vim.cmd [[autocmd FileType make setlocal shiftwidth=4 tabstop=4 noexpandtab]]

-- 2 spaces for selected filetypes
vim.cmd [[autocmd FileType yaml,dart setlocal shiftwidth=2 softtabstop=2 tabstop=2]]

-- Copy to clipboard
map("v", "<leader>y", '"+y')

-- Navigation
map("n", ".", ".`[")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<c-h>", ":ClangdSwitchSourceHeader <cr>")
map("n", "<F4>", ":e ~/.config/nvim/init.lua <cr>")

-- Format file
map("n", "<leader>cf", ":Neoformat<CR>")
map("v", "<leader>cf", ":Neoformat<CR>")

--------------------------------------------------------------------------------
-- Dart tools
--------------------------------------------------------------------------------
vim.g.dart_style_guide = true

--------------------------------------------------------------------------------
-- Color scheme
--------------------------------------------------------------------------------
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_colors = {
    fg = "#d7dae0",
    bg = "#000000",
    bg_dark = "#08080a",
    bg_sidebar = "#08080a",
    bg_float = "#1a1a1c",
    bg_statusline = "#202022",
    border = "#3d59a1",
    yellow = "#e5c07b"
}

-- vim.cmd [[colorscheme tokyonight]]

require('material').setup({
    contrast = {
        sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true, -- Enable contrast for floating windows
        line_numbers = false, -- Enable contrast background for line numbers
        sign_column = false, -- Enable contrast background for the sign column
        cursor_line = false, -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable darker background for non-current windows
        popup_menu = false -- Enable lighter background for the popup menu
    },

    italics = {
        comments = true, -- Enable italic comments
        keywords = false, -- Enable italic keywords
        functions = false, -- Enable italic functions
        strings = false, -- Enable italic strings
        variables = false -- Enable italic variables
    },

    contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
        "terminal", -- Darker terminal background
        "packer", -- Darker packer background
        "qf" -- Darker qf list background
    },

    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false -- Enable higher contrast text for darker style
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_highlights = {} -- Overwrite highlights with your own
})

vim.api.nvim_set_keymap('n', '<leader>mm',
                        [[<Cmd>lua require('material.functions').toggle_style()<CR>]],
                        {noremap = true, silent = true})
vim.g.material_style = "palenight"
vim.cmd [[colorscheme material]]

-- Add the colorizer plugin at this stage must be done after all plugins are loaded
require("colorizer").setup()

--------------------------------------------------------------------------------
-- HOP
--------------------------------------------------------------------------------
map("n", "-", "<cmd>lua require'hop'.hint_words()<cr>")

--------------------------------------------------------------------------------
-- indentline
--------------------------------------------------------------------------------
-- Default to not show indent lines toggle with :IndentLinesToggle
vim.g.indent_blankline_enabled = false
map("n", "<F2>", "<cmd>IndentBlanklineToggle<cr>")

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
map("n", "<leader>f", ":Files<cr>")
map("n", "<leader>b", ":Buffers <cr>")
map("n", "<leader>j", ":GFiles <cr>")
map("n", "<leader>g", ":Rg <cr>")
map("n", "<leader>G", ":Rg <c-r><c-w><cr>")

--------------------------------------------------------------------------------
-- Telescope
--------------------------------------------------------------------------------
local telescope = require("telescope")

local theme = "dropdown"
local border = {" ", " ", " ", " ", " ", " ", " ", " "}
telescope.setup({
    pickers = {
        find_files = {borderchars = border, theme = theme},
        git_files = {borderchars = border, theme = theme},
        live_grep = {borderchars = border, theme = theme},
        buffers = {borderchars = border, theme = theme},
        help_tags = {borderchars = border, theme = theme},
        current_buffer_fuzzy_find = {borderchars = border, theme = theme}
    }
})
telescope.load_extension('neoclip')

map("n", "<leader>f", ":lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>j", ":lua require('telescope.builtin').git_files()<cr>")
map("n", "<leader>g", ":lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>b", ":lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>h", ":lua require('telescope.builtin').help_tags()<cr>")
map("n", "<leader>s",
    ":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")

--------------------------------------------------------------------------------
-- Nvim-cmp
--------------------------------------------------------------------------------
local lspkind = require('lspkind')
local cmp = require("cmp")
cmp.setup {
    -- You must set mapping if you want.
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping.confirm({select = true}),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close()
    },
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    -- You should specify your *installed* sources.
    sources = {
        {name = "nvim_lsp"}, {name = "path"}, {name = "buffer"},
        {name = "nvim_lua"}
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item) return vim_item end
        })
    }
}

--------------------------------------------------------------------------------
-- LSPTrouble
--------------------------------------------------------------------------------
require("trouble")
map("n", "<leader>d", ":TroubleToggle<cr>")

--------------------------------------------------------------------------------
-- Lualine
--------------------------------------------------------------------------------
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "material-stealth",
        component_separators = {"", ""},
        section_separators = {"", ""},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch"},
        lualine_c = {"filename"},
        lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
})

--------------------------------------------------------------------------------
-- LIR
--------------------------------------------------------------------------------
local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")
vim.cmd [[hi LirFloatNormal guibg=#1a1a1c]]
vim.cmd [[hi LirFloatCurdirWindowNormal guibg=#1a1a1c]]

require"lir".setup {
    show_hidden_files = true,
    devicons_enable = true,
    mappings = {
        ["l"] = actions.edit,
        ["<CR>"] = actions.edit,
        ["<C-s>"] = actions.split,
        ["<C-v>"] = actions.vsplit,
        ["<C-t>"] = actions.tabedit,
        ["h"] = actions.up,
        ["-"] = actions.up,
        ["q"] = actions.quit,
        ["<ESC>"] = actions.quit,
        ["K"] = actions.mkdir,
        ["N"] = actions.newfile,
        ["R"] = actions.rename,
        ["@"] = actions.cd,
        ["Y"] = actions.yank_path,
        ["."] = actions.toggle_show_hidden,
        ["D"] = actions.delete,
        ["J"] = function()
            mark_actions.toggle_mark()
            vim.cmd("normal! j")
        end,
        ["C"] = clipboard_actions.copy,
        ["X"] = clipboard_actions.cut,
        ["P"] = clipboard_actions.paste
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
                style = "minimal",
                border = require("lir.float.helper").make_border_opts({
                    " ", " ", " ", " ", " ", " ", " ", " "
                }, "Normal")
            }
        end
    },
    hide_cursor = true
}

-- use visual mode
function _G.LirSettings()
    -- echo cwd
    vim.api.nvim_echo({{vim.fn.expand("%:p"), "Normal"}}, false, {})
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]

map("n", "<leader>e", ":lua require'lir.float'.toggle()<cr>")

--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------
require"nvim-treesitter.configs".setup {
    ensure_installed = "all",
    ignore_install = {"javascript"},
    highlight = {enable = true},
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner"
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {["ää"] = "@function.outer"},
            goto_next_end = {["äö"] = "@function.outer"},
            goto_previous_start = {["öö"] = "@function.outer"},
            goto_previous_end = {["öä"] = "@function.outer"}
        }
    }
}

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------
local nvim_lsp = require("lspconfig")

local on_attach_lsp = function() require("lsp_signature").on_attach() end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
local runtime_path = vim.split(package.path, ";")
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
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    },
    on_attach = on_attach_lsp,
    capabilities = capabilities
}
nvim_lsp.clangd.setup {on_attach = on_attach_lsp}
nvim_lsp.pyright.setup {on_attach = on_attach_lsp}
nvim_lsp.texlab.setup {on_attach = on_attach_lsp}
nvim_lsp.jsonls.setup {on_attach = on_attach_lsp}
nvim_lsp.html.setup {
    on_attach = on_attach_lsp,
    cmd = {"vscode-html-languageserver", "--stdio"},
    init_options = {configurationSection = {"html", "css"}}
}
nvim_lsp.bashls.setup {on_attach = on_attach_lsp}
nvim_lsp.kotlin_language_server.setup {
    on_attach = on_attach_lsp,
    root_dir = nvim_lsp.util.root_pattern("settings.gradle.kts",
                                          "settings.gradle")
}
nvim_lsp.tsserver.setup {on_attach = on_attach_lsp}
nvim_lsp.vimls.setup {on_attach = on_attach_lsp}

-- Rust tools will handle attaching the
require("rust-tools").setup({server = {on_attach = on_attach_lsp}})

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
        -- Use a sharp border with `FloatBorder` highlights
        border = "single"
    })

map("n", "gD", ":lua vim.lsp.buf.declaration()<cr>")
map("n", "gd", ":lua vim.lsp.buf.definition()<cr>")
map("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")
map("n", "gr", ":lua vim.lsp.buf.references()<cr>")
map("n", "K", ":lua vim.lsp.buf.hover()<cr>")
map("n", "gi", ":lua vim.lsp.buf.implementation()<cr>")
map("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<cr>")
map("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>")
map("n", "<leader>n", ":lua vim.diagnostic.goto_next()<cr>")
map("n", "<leader>p", ":lua vim.diagnostic.goto_prev()<cr>")
map("n", "<leader>i", ":lua vim.diagnostic.show_line_diagnostics()<cr>")

map("n", "<leader>a", ":CodeActionMenu<cr>")
map("n", "<a-cr>", ":CodeActionMenu<cr>")

--------------------------------------------------------------------------------
-- Diagnostics
--------------------------------------------------------------------------------

-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, border="single"})]]

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = false,
    update_in_insert = true,
    severity_sort = false
})

local signs = {Error = "", Warn = "", Hint = " ", Info = ""}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

vim.keymap.set("n", "<leader>l", require("lsp_lines").toggle, {desc = "Toggle lsp_lines"})

--------------------------------------------------------------------------------
-- Neovide
--------------------------------------------------------------------------------
vim.g.neovide_refresh_rate = 140
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_cursor_animation_length = 0.0
vim.g.neovide_cursor_trail_length = 0.0
vim.opt.guifont = { "JetBrains Mono", "h15" }
