-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/anton/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/anton/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/anton/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/anton/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/anton/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["dart-vim-plugin"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/dart-vim-plugin"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["equinusocio-material.vim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/equinusocio-material.vim"
  },
  fzf = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  indentLine = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["kotlin-vim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/kotlin-vim"
  },
  ["lir.nvim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/lir.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp-trouble.nvim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/lsp-trouble.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/onedark.vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/anton/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["swift.vim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/swift.vim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/typescript-vim"
  },
  ["vim-aftercolors"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/vim-aftercolors"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-cpp-modern"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/vim-cpp-modern"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-logcat"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/vim-logcat"
  },
  ["vim-togglelist"] = {
    loaded = true,
    path = "/home/anton/.local/share/nvim/site/pack/packer/start/vim-togglelist"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
