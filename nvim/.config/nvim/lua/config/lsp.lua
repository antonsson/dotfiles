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

