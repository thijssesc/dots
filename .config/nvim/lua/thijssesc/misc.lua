-- misc

local user_whitespaces = vim.api.nvim_create_augroup('UserWhiteSpaces', {})
vim.api.nvim_create_autocmd('BufWritePre', {
    group = user_whitespaces,
    pattern = '*',
    callback = function(ev)
        if vim.bo[ev.buf].filetype == 'java' then
            return
        end

        local save = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(save)
    end,
})

local user_term = vim.api.nvim_create_augroup('UserTerm', {})
vim.api.nvim_create_autocmd({'BufWinEnter', 'TermOpen', 'WinEnter'}, {
    group = user_term,
    pattern = 'term://*',
    command = 'startinsert',
})

vim.api.nvim_create_autocmd('BufLeave', {
    group = user_term,
    pattern = 'term://*',
    command = 'stopinsert',
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = user_term,
    pattern = '*',
    command = 'setlocal nonumber norelativenumber',
})
