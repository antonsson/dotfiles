--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local map = function(mode, key, value)
    vim.keymap.set(mode, key, value, {noremap = true, silent = true})
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

-- Removes blinking of the sign column
vim.opt.signcolumn = "yes:1"

--------------------------------------------------------------------------------
-- Lazy package
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- LuaFormatter off
require("lazy").setup({
    -- Color scheme
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,

                styles = {
                    functions = { italic = false },
                    keywords = { italic = false },
                },

                on_colors = function(colors)
                    colors.fg = "#d7dae0"
                end
            })
            vim.cmd [[colorscheme tokyonight-night]]
        end,
    },

    -- Show colors
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end
    },

    -- File browser
    {
        "tamago324/lir.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        keys = {
            {"<leader>e", ":lua require'lir.float'.toggle()<cr>"},
        },
        config = function()
            local actions = require("lir.actions")
            local mark_actions = require("lir.mark.actions")
            local clipboard_actions = require("lir.clipboard.actions")
            vim.cmd [[hi LirFloatNormal guibg=#1a1a1c]]
            vim.cmd [[hi LirFloatCurdirWindowNormal guibg=#1a1a1c]]

            -- Disable netrw
            vim.g.loaded_netrwPlugin = 1
            vim.g.loaded_netrw = 1

            require"lir".setup {
                show_hidden_files = true,
                devicons = {
                    enable = true
                },
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
                        mark_actions.toggle_mark('n')
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
                                "╭", "─", "╮", "│", "╯", "─", "╰", "│"
                            }, "Normal")
                        }
                    end
                },
                hide_cursor = true
            }
            vim.api.nvim_create_autocmd({'FileType'}, {
                pattern = {"lir"},
                callback = function()
                    -- use visual mode
                    vim.api.nvim_buf_set_keymap(
                    0,
                    "x",
                    "J",
                    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
                    { noremap = true, silent = true }
                    )

                    -- echo cwd
                    vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
                end
            })
        end,
    },

    -- Status line
    {
        "hoob3rt/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
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
        }
    },

    -- Git signs
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = true,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter.configs").setup {
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
        end
    },

    -- Git commands
    "tpope/vim-fugitive",

    -- gcc to comment block
    {
        "b3nj5m1n/kommentary",
        keys = {
             {"gcc"},
        },
    },

    -- Syntax for logcat files
    {
        "gburca/vim-logcat",
        ft = "logcat",
    },

    {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu"
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim",
        },
        config = function()
            require("lspconfig.ui.windows").default_options.border = "single"

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
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "nvim_lua" }
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol', -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters
                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization.
                        -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        -- luacheck: --ignore 21/_.*
                        before = function(_, vim_item)
                            return vim_item
                        end,
                    })
                }
            }
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            {"<leader>f", ":lua require('telescope.builtin').find_files()<cr>"},
            {"<leader>j", ":lua require('telescope.builtin').git_files()<cr>"},
            {"<leader>g", ":lua require('telescope.builtin').live_grep()<cr>"},
            {"<leader>b", ":lua require('telescope.builtin').buffers()<cr>"},
            {"<leader>h", ":lua require('telescope.builtin').help_tags()<cr>"},
            {"<leader>s", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>"},
        },
        config = function()
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    layout_strategy = 'vertical',
                    layout_config = {vertical = {width = 0.8}}
                },
            })
            telescope.load_extension('neoclip')
        end,
    },

    -- Neoformat - format files
    {
        "sbdchd/neoformat",
        keys = {
            {"<leader>cf", ":Neoformat<CR>", mode = "n"},
            {"<leader>cf", ":Neoformat<CR>", mode = "v"},
        },
        config = function()
            -- Prioritize eslint-formatter for javascript
            vim.g.neoformat_enabled_javascript = {
                "prettiereslint", "jsbeautify", "clang-format"
            }
            vim.g.neoformat_enabled_python = {"autopep8", "yapf", "docformatter"}
        end,
    },

    --  Indentation lines
    {
        "lukas-reineke/indent-blankline.nvim",
        keys = {
            {"<F2>", "<cmd>IndentBlanklineToggle<cr>"},
        },
        config = function()
            vim.g.indent_blankline_enabled = false
        end,
    },

    -- Markdown preview
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        config = true,
    },

    -- Clipboard manager
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {{'nvim-telescope/telescope.nvim'}},
        config = function()
            require("neoclip")
        end,
    },

    -- Progress for lsp operations
    {
        "j-hui/fidget.nvim",
        config = true,
    },

    -- Lsp utilities
    {
        "glepnir/lspsaga.nvim",
        lazy = false,
        dependencies = {
            {"nvim-tree/nvim-web-devicons"},
        },
        keys = {
            {"<leader>ca", "<cmd> Lspsaga code_action<cr>"},
            {"gd", "<cmd>Lspsaga goto_definition<cr>"},
            {"K", "<cmd> Lspsaga hover_doc<cr>"},
            {"<leader>n", "<cmd> Lspsaga diagnostic_jump_next<cr>"},
            {"<leader>p", "<cmd> Lspsaga diagnostic_jump_prev<cr>"},
            {"<leader>d", "<cmd> Lspsaga show_buf_diagnostics<cr>"},
        },
        config = function()
            require("lspsaga").setup({
                symbol_in_winbar = {
                    enable = false,
                },
                lightbulb = {
                    enable = false,
                },
            })
        end,
    },

    -- LSP setup
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "ray-x/lsp_signature.nvim",
            "simrat39/rust-tools.nvim",
            "glepnir/lspsaga.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {"gD", ":lua vim.lsp.buf.declaration()<cr>"},
            {"gw", ":lua vim.lsp.buf.workspace_symbol()<cr>"},
            {"gr", ":lua vim.lsp.buf.references()<cr>"},
            {"gi", ":lua vim.lsp.buf.implementation()<cr>"},
            {"<c-k>", ":lua vim.lsp.buf.signature_help()<cr>"},
        },
        lazy = false,
        config = function()
            local nvim_lsp = require("lspconfig")
            local on_attach_lsp = function() require("lsp_signature").on_attach() end
            local client_caps = vim.lsp.protocol.make_client_capabilities()
            local capabilities = require('cmp_nvim_lsp').default_capabilities(client_caps)
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            nvim_lsp.lua_ls.setup {
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
            nvim_lsp.pylsp.setup {on_attach = on_attach_lsp}
            nvim_lsp.texlab.setup {on_attach = on_attach_lsp}
            nvim_lsp.jsonls.setup {on_attach = on_attach_lsp}
            nvim_lsp.html.setup {
                on_attach = on_attach_lsp,
                cmd = {"vscode-html-languageserver", "--stdio"},
                init_options = {configurationSection = {"html", "css"}}
            }
            nvim_lsp.bashls.setup {on_attach = on_attach_lsp}
            nvim_lsp.tsserver.setup {on_attach = on_attach_lsp}
            nvim_lsp.vimls.setup {on_attach = on_attach_lsp}
            nvim_lsp.gopls.setup {on_attach = on_attach_lsp}

            -- Rust tools will handle attaching the
            require("rust-tools").setup({
                server = {
                    on_attach = function()
                        on_attach_lsp()
                    end,
                }
            })

            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, {
                    -- Use a sharp border with `FloatBorder` highlights
                    border = "single"
                })

            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                underline = false,
                update_in_insert = true,
                severity_sort = false
            })

            local signs = {Error = "", Warn = "", Hint = "", Info = ""}
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
            end
        end,
    },

    -- Debugger
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            dap.adapters.lldb = {
                type = 'executable',
                command = '/usr/bin/lldb-vscode',
                name = 'lldb'
            }
            dap.configurations.rust = {
                {
                    name = "Launch file",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                }
            }
            vim.keymap.set('n', '<F5>', function() dap.continue() end)
            vim.keymap.set('n', '<F10>', function() dap.step_over() end)
            vim.keymap.set('n', '<F11>', function() dap.step_into() end)
            vim.keymap.set('n', '<F12>', function() dap.step_out() end)
            vim.keymap.set('n', 'gb', function() dap.toggle_breakpoint() end)
            vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
            vim.keymap.set('n', '<Leader>uu', function() require("dapui").open() end)
            vim.keymap.set('n', '<Leader>uc', function() require("dapui").close() end)
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap"
        },
        config = function()
            require("dapui").setup()
        end
    }
})
-- LuaFormatter on

-- Highlight yanked text
vim.cmd [[autocmd TextYankPost * silent! lua require"vim.highlight".on_yank()]]

-- Copy to clipboard
map("v", "<leader>y", '"+y')

-- Escape insert mode
map("i", "§", "<esc>")

-- Navigation
map("n", ".", ".`[")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<F4>", ":e ~/.config/nvim/init.lua <cr>")
