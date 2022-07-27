-- dap

local dap = require('dap')
local jdtls_util = require('jdtls.util')
local widgets = require('dap.ui.widgets')

require('nvim-dap-virtual-text').setup()

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

local scopes = widgets.sidebar(widgets.scopes)

vim.keymap.nnoremap { '<leader>dc', dap.continue }
vim.keymap.nnoremap { '<leader>dd', dap.down }
vim.keymap.nnoremap { '<leader>dg', dap.goto_ }
vim.keymap.nnoremap { '<leader>dh', widgets.hover }
vim.keymap.nnoremap { '<leader>di', dap.step_into }
vim.keymap.nnoremap { '<leader>do', dap.step_over }
vim.keymap.nnoremap { '<leader>dO', dap.step_out }
vim.keymap.nnoremap {
    '<leader>dr',
    function()
        dap.repl.toggle({ height = 15 }, 'split')
        scopes.toggle()
    end,
}
vim.keymap.nnoremap { '<leader>dt', dap.toggle_breakpoint }
vim.keymap.nnoremap { '<leader>du', dap.up }
