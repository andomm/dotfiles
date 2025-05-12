-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
local function get_arguments()
  return coroutine.create(function(dap_run_co)
    local args = {}
    vim.ui.input({ prompt = 'Args: ' }, function(input)
      args = vim.split(input or '', ' ')
      coroutine.resume(dap_run_co, args)
    end)
  end)
end

-- local function setup_python_configuration(dap, configs)
--   dap.configurations.python = {
--     {
--       type = 'python',
--       request = 'launch',
--       name = 'Launch file',
--       program = '${file}',
--       cwd = vim.fn.getcwd(),
--       args = {},
--       pythonPath = function()
--         return require('venv-selector').get_active_path()
--       end,
--       {
--         type = 'go',
--         name = 'Debug (Arguments)',
--         request = 'launch',
--         program = '${file}',
--         args = get_arguments,
--         buildFlags = configs.delve.buidlFlags,
--       },
--     },
--   }
-- end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
    'nvim-neotest/neotest',
    'nvim-neotest/neotest-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      automatic_installation = true,

      handlers = {},

      ensure_installed = {
        'delve',
      },
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Run with arguments',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        args = get_arguments,
        pythonPath = function()
          return require('venv-selector').python()
        end,
      },
    }
    --     {
    --       type = 'python',
    --       name = 'Debug (Arguments)',
    --       request = 'launch',
    --       program = '${file}',
    --       args = get_arguments,
    --     },
    --   },
    -- }

    require('nvim-dap-virtual-text').setup {}
    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>dt', function()
      require('dap-python').test_method()
    end, { desc = 'Debug: Test Method' })
    vim.keymap.set('n', '<leader>dv', require('nvim-dap-virtual-text').toggle, { desc = 'Debug: Toggle Virtual Text' })
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F4>', dap.close, { desc = 'Debug: Stop' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<F6>', dap.pause, { desc = 'Debug: Pause' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.5 },
            { id = 'breakpoints', size = 0.5 },
          },
          size = 40,
          position = 'left',
        },
        {
          elements = {
            { id = 'repl', size = 1 },
          },
          size = 10,
          position = 'bottom',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
