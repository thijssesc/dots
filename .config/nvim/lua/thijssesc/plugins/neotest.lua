-- neotest

local M = {
    'nvim-neotest/neotest',
    name = 'neotest',
    version = '*',
}

M.dependencies = {
    'nvim-neotest/neotest-go',
}

M.config = function()
    local neotest = require('neotest')

    neotest.setup {
        adapters = {
            require('neotest-go'),
        }
    }

    local neotest_ns = vim.api.nvim_create_namespace('neotest')
    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
                return message
            end,
        },
    }, neotest_ns)
end

M.keys = {
    { '<leader>tn', [[<cmd>lua require('neotest').run.run()<CR>]], noremap = true },
    { '<leader>tf', [[<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>]], noremap = true },
    { '<leader>ta', [[<cmd>lua require('neotest').run.run { strategy = 'dap' }<CR>]], noremap = true, silent = false },
    { '<leader>to', [[<cmd>lua require('neotest').summary.toggle()<CR>]], noremap = true },
}

return M
