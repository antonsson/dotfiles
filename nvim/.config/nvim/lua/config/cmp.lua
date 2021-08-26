local cmp = require('cmp')
cmp.setup {
    -- You must set mapping if you want.
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },

    -- You should specify your *installed* sources.
    sources = {
        {name = 'nvim_lsp'}, {name = 'path'}, {name = 'buffer'},
        {name = 'nvim_lua'}
    }
}

