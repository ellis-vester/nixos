require('neo-tree').setup {
  close_if_last_window = true,
  source_selector = {
    winbar = true,
    status_line = false,
  },
  event_handlers = {
    -- Recipe from https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#hide-cursor-in-neo-tree-window
    -- Hides the curson when clicking around in the Neotree window. Doesn't seem to work tho :(
    {
      event = 'neo_tree_buffer_enter',
      handler = function()
        vim.cmd 'highlight! Cursor blend=100'
      end,
    },
    {
      event = 'neo_tree_buffer_leave',
      handler = function()
        vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
      end,
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
    },
    group_empty_dirs = true,
  },
}

vim.keymap.set('n', '<leader>ns', '<Cmd>Neotree show<CR>')
vim.keymap.set('n', '<leader>nc', '<Cmd>Neotree close<CR>')

vim.cmd 'Neotree show'
