local nvim_lsp = require("lspconfig")

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = false})
end

local init = {}

local on_attach_lsp = function()
    require "completion".on_attach(
        {
            enable_auto_popup = 1,
            matching_strategy_list = {"exact", "substring", "fuzzy"},
            trigger_keyword_length = 2
        }
    )

    map("n", "ga", ":lua vim.lsp.buf.code_action()<cr>")
    map("n", "gd", ":lua vim.lsp.buf.definition()<cr>")
    map("n", "gD", ":lua vim.lsp.buf.declaration()<cr>")
    map("n", "gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")
    map("n", "gr", ":lua vim.lsp.buf.references()<cr>")
    map("n", "K", ":lua vim.lsp.buf.hover()<cr>")
    map("n", "gi", ":lua vim.lsp.buf.implementation()<cr>")
    map("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<cr>")
    map("n", "1gD", ":lua vim.lsp.buf.type_definition()<cr>")
    map("n", "<leader>n", ":lua vim.lsp.diagnostic.goto_next()<cr>")
    map("n", "<leader>p", ":lua vim.lsp.diagnostic.goto_prev()<cr>")
    map("n", "<leader>i", ":lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")
    map("n", "<leader>d", ":LspTroubleToggle")
end

nvim_lsp.sumneko_lua.setup {on_attach = on_attach_lsp}
nvim_lsp.clangd.setup {on_attach = on_attach_lsp}
nvim_lsp.pyls.setup {on_attach = on_attach_lsp}
nvim_lsp.texlab.setup {on_attach = on_attach_lsp}
nvim_lsp.jsonls.setup {on_attach = on_attach_lsp}
nvim_lsp.html.setup {
    on_attach = on_attach_lsp,
    cmd = { "vscode-html-languageserver", "--stdio" },
    init_options = {
        configurationSection = { "html", "css" }
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

require'nvim-treesitter.configs'.setup {
    ensure_installed = "kotlin", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "c", "cpp", "rust" },  -- list of language that will be disabled
    },
}

require "telescope".setup {
    defaults = {
        theme = "dropdown",
        winblend = 20,
        sorting_strategy = "ascending",
        layout_strategy = "center",
        results_title = false,
        preview_title = "Preview",
        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
        width = 0.7,
        results_height = 0.7,
        borderchars = {
            {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
            prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
            results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
            preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
        }
    }
}

require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }

function init.attach_lsp()
    on_attach_lsp()
    map("n", "<leader>r", ":lua require'telescope.builtin'.lsp_references{}<cr>")
    map("n", "<leader>w", ":lua require'telescope.builtin'.lsp_workspace_symbols{ query = '*' }<cr>")
    map("n", "<leader>d", ":lua require'telescope.builtin'.lsp_document_symbols{ query = 'main' }<cr>")
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        signs = true,
        update_in_insert = false
    }
)

return init
