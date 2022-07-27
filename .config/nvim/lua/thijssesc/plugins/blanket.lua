-- blanket

local blanket = require('blanket')

blanket.setup {
    report_path = vim.fn.getcwd() .. '/target/site/jacoco/jacoco.xml',
    file_types = 'java',
    signs = {
        priority = 1,
        incomplete_branch = '~',
        uncovered = '-',
        covered = '|',
    },
}

vim.keymap.noremap { { 'n', 't' }, '<leader>cp', blanket.set_report_path }
vim.keymap.noremap { { 'n', 't' }, '<leader>cr', blanket.refresh }
vim.keymap.noremap { { 'n', 't' }, '<leader>cS', blanket.start }
vim.keymap.noremap { { 'n', 't' }, '<leader>cs', blanket.stop }
