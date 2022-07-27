-- gitsigns

local gitsigns = require('gitsigns')

gitsigns.setup {
    on_attach = function(buffer)
        vim.keymap.nnoremap {
            ']c',
            function()
                if vim.wo.diff then
                    return ']c'
                end
                vim.schedule(function()
                    gitsigns.next_hunk()
                end)
                return '<Ignore>'
            end,
            { buffer = buffer, expr = true },
        }
        vim.keymap.nnoremap {
            '[c',
            function()
                if vim.wo.diff then
                    return '[c'
                end
                vim.schedule(function()
                    gitsigns.prev_hunk()
                end)
                return '<Ignore>'
            end,
            { buffer = buffer, expr = true },
        }
        vim.keymap.noremap { { 'n', 'v' }, '<leader>hs', gitsigns.stage_hunk, { buffer = buffer } }
        vim.keymap.noremap { { 'n', 'v' }, '<leader>hr', gitsigns.reset_hunk, { buffer = buffer } }
        vim.keymap.nnoremap { '<leader>hS', gitsigns.stage_buffer, { buffer = buffer } }
        vim.keymap.nnoremap { '<leader>hu', gitsigns.undo_stage_hunk, { buffer = buffer } }
        vim.keymap.nnoremap { '<leader>hR', gitsigns.reset_buffer, { buffer = buffer } }
        vim.keymap.nnoremap { '<leader>hp', gitsigns.preview_hunk, { buffer = buffer } }
        vim.keymap.nnoremap {
            '<leader>hb',
            function()
                gitsigns.blame_line { full = true }
            end,
            { buffer = buffer },
        }
        vim.keymap.nnoremap { '<leader>tb', gitsigns.toggle_current_line_blame, { buffer = buffer } }
        vim.keymap.nnoremap { '<leader>hd', gitsigns.diffthis, { buffer = buffer } }
        vim.keymap.nnoremap {
            '<leader>hD',
            function()
                gitsigns.diffthis('~')
            end,
            { buffer = buffer },
        }
        vim.keymap.nnoremap { '<leader>td', gitsigns.toggle_deleted, { buffer = buffer } }
        vim.keymap.noremap { { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = buffer } }
    end,
}
