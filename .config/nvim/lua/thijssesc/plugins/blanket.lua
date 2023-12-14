-- blanket

local M = {
    'dsych/blanket.nvim',
    name = 'blanket',
    version = '*',
}

M.config = {
    report_path = vim.fn.getcwd() .. '/target/site/jacoco/jacoco.xml',
    file_types = 'java',
    signs = {
        priority = 1,
        incomplete_branch = '~',
        uncovered = '-',
        covered = '|',
    },
}

M.keys = {
    { '<leader>cp', [[<cmd>lua require('blanket').set_report_path()<CR>]], mode = { 'n', 't' } },
    { '<leader>cr', [[<cmd>lua require('blanket').refresh()<CR>]], mode = { 'n', 't' } },
    { '<leader>cS', [[<cmd>lua require('blanket').start()<CR>]], mode = { 'n', 't' } },
    { '<leader>cs', [[<cmd>lua require('blanket').stop()<CR>]], mode = { 'n', 't' } },
}

return M
