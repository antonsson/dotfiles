--------------------------------------------------------------------------------
-- Loader cache (~20% startup improvement from Lua bytecode caching)
--------------------------------------------------------------------------------
vim.loader.enable()

--------------------------------------------------------------------------------
-- General neovim configuration
--------------------------------------------------------------------------------
vim.g.mapleader = ","
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.backspace = {"indent", "eol", "start"}
vim.opt.smartcase = true
vim.opt.scrolloff = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.hidden = true
vim.o.updatetime = 250
vim.opt.signcolumn = "yes:1"

-- Rust — vim.g.rustaceanvim must be set BEFORE vim.pack.add loads the plugin
vim.g.rustaceanvim = {
    tools = {},
    server = {
        on_attach = function()
            vim.keymap.set("n", "ga",
                           function() vim.cmd.RustLsp("codeAction") end)
        end,
        default_settings = {["rust-analyzer"] = {}}
    }
}

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

vim.pack.add({
    -- Shared dependencies (must come before anything that requires them)
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons", -- Color scheme
    "https://github.com/folke/tokyonight.nvim", -- Colorizer
    "https://github.com/catgoose/nvim-colorizer.lua",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/gburca/vim-logcat",
    "https://github.com/aznhe21/actions-preview.nvim", -- JS/JSX syntax
    "https://github.com/yuezk/vim-js",
    "https://github.com/maxmellon/vim-jsx-pretty", -- Completion
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/hrsh7th/cmp-nvim-lua",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/onsails/lspkind.nvim",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/AckslD/nvim-neoclip.lua",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/nvim-telescope/telescope-file-browser.nvim",
    "https://github.com/sbdchd/neoformat",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mrcjkb/rustaceanvim"
})

-- Color scheme
require("tokyonight").setup({
    style = "night",
    transparent = true,
    styles = {
        functions = {italic = false},
        keywords = {italic = false},
        comments = {italic = false}
    },
    on_colors = function(colors) colors.fg = "#d7dae0" end,
    on_highlights = function(hl, c)
        hl.LspInlayHint = {bg = c.none, fg = "#545c7e", italic = true}
    end
})
vim.cmd [[colorscheme tokyonight-night]]

-- Show hex colors inline
require("colorizer").setup()

-- Terminal

-- Status line
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "tokyonight",
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

require("gitsigns").setup()

-- Comments (gcc = line, gbc = block, gc in visual)
require("Comment").setup()

local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<tab>"] = cmp.mapping.confirm({select = true}),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort()
    },
    snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end
    },
    sources = cmp.config.sources({
        {name = "nvim_lsp"}, {name = "luasnip"}, {name = "path"},
        {name = "nvim_lua"}
    }, {{name = "buffer"}}),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            before = function(_, vim_item) return vim_item end
        })
    }
})

-- Telescope
local telescope = require("telescope")
telescope.setup({
    defaults = {
        layout_strategy = "vertical",
        layout_config = {vertical = {width = 0.8}}
    }
})
require("neoclip").setup()
telescope.load_extension("neoclip")
telescope.load_extension("ui-select")

-- Formatter
vim.g.neoformat_enabled_javascript = {
    "prettiereslint", "jsbeautify", "clang-format"
}
vim.g.neoformat_enabled_python = {"autopep8", "yapf", "docformatter"}

-- Indentation guides (disabled by default, toggled with F2)
require("ibl").setup({enabled = false})

-- LSP progress indicator
require("fidget").setup({})

-- LSP
require("lspconfig.ui.windows").default_options.border = "single"
do
    local client_caps = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(
                             client_caps)
    vim.lsp.config("*", {capabilities = capabilities})

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    vim.lsp.config("lua_ls", {
        cmd = {
            "/usr/bin/lua-language-server", "-E",
            "/usr/share/lua-language-server/main.lua"
        },
        settings = {
            Lua = {
                runtime = {version = "LuaJIT", path = runtime_path},
                diagnostics = {globals = {"vim"}},
                workspace = {library = vim.api.nvim_get_runtime_file("", true)},
                telemetry = {enable = false}
            }
        },
        capabilities = capabilities
    })
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("jedi_language_server")
    vim.lsp.enable("texlab")
    vim.lsp.enable("jsonls")
    vim.lsp.config("html", {
        cmd = {"vscode-html-languageserver", "--stdio"},
        init_options = {configurationSection = {"html", "css"}}
    })
    vim.lsp.enable("html")
    vim.lsp.enable("bashls")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("vimls")
    vim.lsp.enable("gopls")

    vim.diagnostic.config({
        virtual_text = false,
        underline = false,
        update_in_insert = true,
        severity_sort = false,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN] = "▲",
                [vim.diagnostic.severity.HINT] = "⚑",
                [vim.diagnostic.severity.INFO] = "»"
            }
        }
    })

    vim.lsp.inlay_hint.enable(true)
end

--------------------------------------------------------------------------------
-- Custom modules
--------------------------------------------------------------------------------
require("switch_case")
vim.keymap.set("n", "<leader>c",
               "<cmd>lua require('switch_case').switch_case()<CR>")

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------

-- Telescope
vim.keymap.set("n", "<leader>f",
               ":lua require('telescope.builtin').find_files()<cr>")
vim.keymap.set("n", "<leader>j",
               ":lua require('telescope.builtin').git_files()<cr>")
vim.keymap.set("n", "<leader>g",
               ":lua require('telescope.builtin').live_grep()<cr>")
vim.keymap.set("n", "<leader>b",
               ":lua require('telescope.builtin').buffers()<cr>")
vim.keymap.set("n", "<leader>h",
               ":lua require('telescope.builtin').help_tags()<cr>")
vim.keymap.set("n", "<leader>s",
               ":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")

-- Formatter
vim.keymap.set("n", "<leader>cf", ":Neoformat<CR>")
vim.keymap.set("v", "<leader>cf", ":Neoformat<CR>")

-- Indent guides toggle
vim.keymap.set("n", "<F2>", function()
    require("ibl").setup_buffer(0, {
        enabled = not require("ibl.config").get_config(0).enabled
    })
end)

-- Code actions preview
vim.keymap.set("n", "<a-cr>",
               ":lua require('actions-preview').code_actions()<cr>")

-- LSP
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<cr>")
vim.keymap.set("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<cr>")
vim.keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<cr>")
vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<cr>")
vim.keymap.set("n", "<leader>a", ":lua vim.lsp.buf.code_action()<cr>")
vim.keymap.set("n", "<leader>i",
               ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>")
vim.keymap.set("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<cr>")

-- Navigation
vim.keymap.set("n", ".", ".`[")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<F4>", ":e ~/.config/nvim/init.lua <cr>")
vim.keymap.set("n", "<C-,>", ",")

-- Clipboard
vim.keymap.set("v", "<leader>y", '"+y')

-- Escape insert mode
vim.keymap.set("i", "§", "<esc>")

-- Diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>n",
               function() vim.diagnostic.jump({count = 1, float = true}) end)
vim.keymap.set("n", "<leader>p",
               function() vim.diagnostic.jump({count = -1, float = true}) end)


vim.keymap.set("n", "<leader>e", ":Explore<CR>")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "h", "-", { buffer = true, remap = true })
    vim.keymap.set("n", "l", "<CR>", { buffer = true, remap = true })
  end,
})

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------
vim.cmd [[autocmd TextYankPost * silent! lua require"vim.highlight".on_yank()]]

--------------------------------------------------------------------------------
-- GUI (Neovide)
--------------------------------------------------------------------------------
vim.o.guifont = "FiraCode Nerd Font:h14"

if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.04
    vim.g.neovide_cursor_trail_size = 0.3
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_hide_mouse_when_typing = true
end
