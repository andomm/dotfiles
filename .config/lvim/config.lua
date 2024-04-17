lvim.keys.normal_mode["<C-k>"] = "<cmd>cnext<CR>zz"
lvim.keys.normal_mode["<C-j>"] = "<cmd>cprev<CR>zz"
vim.opt.scrolloff = 10
vim.opt.relativenumber = true

lvim.plugins = {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = true,
    },
  },
}
