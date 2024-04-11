return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'my-notes',
        path = '~/my-notes/',
      },
    },
    daily_notes = {
      folder = '~/my-notes/daily-notes/',
      date_format = '%d-%m-%Y',
    },
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      return tostring(title)
    end,
  },
}
