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
      folder = 'daily-notes',
      date_format = '%d-%m-%Y',
    },
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      return tostring(title)
    end,
  },
  keys = {
    { '<leader>on', '<cmd>ObsidianToday<cr>', desc = 'ObsidianToday' },
    { 'gf', '<cmd>lua require("obsidian").util.gf_passthrough()<cr>', desc = 'Obsidian gf' },
    { '<leader>ch', '<cmd>lua require("obsidian").util.toggle_checkbox()<cr>', desc = 'Obsidian toggle checkbox' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'ObsidianBacklinks' },
    { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'ObisidanTags' },
    { '<leader>od', '<cmd>ObsidianDailies<cr>', desc = 'ObsidianDailies' },
    { '<leader>oc', '<cmd>ObsidianNew<cr>', desc = 'ObisidanNew' },
  },
}
