local nvim_lsp = require("lspconfig")

local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = false})
end

local on_attach_lsp = function()
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
    map("n", "<leader>d", ":LspTroubleToggle<cr>")
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
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach_lsp })
nvim_lsp.bashls.setup {on_attach = on_attach_lsp}
-- nvim_lsp.kotlin_language_server.setup {
--     on_attach = on_attach_lsp,
--     cmd = {"/home/anton/programs/kotlin-lsp-server/bin/kotlin-language-server"},
--     root_dir = nvim_lsp.util.root_pattern("settings.gradle.kts")
-- }
nvim_lsp.tsserver.setup { on_attach = on_attach_lsp }
nvim_lsp.vimls.setup {on_attach = on_attach_lsp}

-- nvim-compe
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

require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = false;
    };
}

require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        signs = true,
        update_in_insert = false
    }
)

