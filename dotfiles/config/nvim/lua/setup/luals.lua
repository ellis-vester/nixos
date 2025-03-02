-- Lua LSP configuration for Neovim workspace
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
require('lspconfig').lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath 'config' and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          unpack(vim.api.nvim_get_runtime_file('', true)), -- Required to enable auto complete
        },
      },
    })
  end,
  settings = {
    Lua = {},
  },
}
