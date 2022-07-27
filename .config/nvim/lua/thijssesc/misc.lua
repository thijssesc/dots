-- misc

local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

nvim_create_augroups {
    whitespaces = {
        -- trim whitespaces when writing
        { 'BufWritePre', '*', [[:lua require('thijssesc.utils').trim_whitespace()]] },
    },
    netrw = {
        -- remove the <C-l> mapping when in netrw
        { 'FileType', 'netrw', [[:lua require('thijssesc.utils').remove_netrw_mappings()]] },
    },
    -- turned off for harpoon
    term = {
        -- enter insert mode when opening/switching to a terminal buffer
        { 'BufWinEnter,TermOpen,WinEnter', 'term://*', 'startinsert' },
        -- enter normal mode when exiting a terminal buffer
        { 'BufLeave', 'term://*', 'stopinsert' },
        -- disable numbers in terminal
        { 'TermOpen', '*', 'setlocal nonumber norelativenumber' },
    },
}
