require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = {"javascript"}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        --disable = {"c", "rust"} -- list of language that will be disabled
    },
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
                ["ib"] = "@block.inner",
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
