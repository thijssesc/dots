-- dap

-- TODO: Move to mason.nvim
local M = {
    'mfussenegger/nvim-dap',
    name = 'dap',
    version = '*',
}

M.dependencies = {
    'theHamsta/nvim-dap-virtual-text',
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            { '<leader>du', [[<cmd>lua require('dapui').toggle({ })<CR>]] },
            { '<leader>de', [[<cmd>lua require('dapui').eval()<CR>]], mode = { 'n', 'v' } },
        },
    },
    require('thijssesc.plugins.mason'),
}

M.config = function()
    local dap = require('dap')
    local jdtls_util = require('jdtls.util')

    dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { vim.fn.getenv('HOME') .. '/Software/vscode-node-debug2/out/src/nodeDebug.js' },
    }

    dap.adapters.java = function(callback)
        jdtls_util.execute_command({
            command = 'vscode.java.startDebugSession',
        }, function(err, port)
            assert(not err, vim.inspect(err))
            callback {
                type = 'server',
                host = '127.0.0.1',
                port = port,
            }
        end)
    end

    dap.configurations.java = {
        {
            type = 'java',
            request = 'attach',
            name = 'Debug (Attach) - Remote',
            hostName = '127.0.0.1',
            port = 8000,
        },
    }

    dap.configurations.javascript = {
        {
            type = 'node2',
            request = 'launch',
            program = '${workspaceFolder}/${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
            skipFiles = { '<node_internals>/**' },
        },
    }
    dap.configurations.typescript = vim.tbl_extend('force', {
        outFiles = { '${workspaceFolder}/build/**/*.js' },
    }, dap.configurations.javascript)
    dap.configurations.typescript = dap.configurations.typescript

    dap.defaults.fallback.terminal_win_cmd = 'tabnew'
    dap.defaults.fallback.external_terminal = {
        command = '/usr/bin/st',
        args = { '-e' },
    }
end

M.keys = {
    { '<leader>dc', [[<cmd>lua require('dap').continue()<CR>]] },
    { '<leader>dd', [[<cmd>lua require('dap').down()<CR>]] },
    { '<leader>dg', [[<cmd>lua require('dap').goto_()<CR>]] },
    { '<leader>dh', [[<cmd>lua require('dap.ui.widgets').hover()<CR>]] },
    { '<leader>di', [[<cmd>lua require('dap').step_into()<CR>]] },
    { '<leader>do', [[<cmd>lua require('dap').step_over()<CR>]] },
    { '<leader>dO', [[<cmd>lua require('dap').step_out()<CR>]] },
    {
        '<leader>dr',
        function()
            require('dap').repl.toggle({ height = 15 }, 'split')
            local widgets = require('dap.ui.widgets')
            local scopes = widgets.sidebar(widgets.scopes)

            scopes.toggle()
        end,
    },
    { '<leader>dt', [[<cmd>lua require('dap').toggle_breakpoint()<CR>]] },
    { '<leader>du', [[<cmd>lua require('dap').up()<CR>]] },
}

return M
