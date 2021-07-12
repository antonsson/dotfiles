local actions = require('lir.actions')
local mark_actions = require('lir.mark.actions')
local clipboard_actions = require('lir.clipboard.actions')
local utils = require("utils")

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

utils.map("n", "<leader>e", ":lua require'lir.float'.toggle()<cr>")

