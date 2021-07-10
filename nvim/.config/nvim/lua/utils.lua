local utils = {}

utils.map = function(type, key, value)
    vim.api.nvim_set_keymap(type, key, value, {noremap = true, silent = false})
end

return utils
