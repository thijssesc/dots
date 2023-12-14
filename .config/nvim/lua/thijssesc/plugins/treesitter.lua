-- treesitter

local M = {
    'nvim-treesitter/nvim-treesitter',
    name = 'nvim-treesitter',
    version = false,
    event = 'VeryLazy',
}

M.dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
}

M.build = function()
    require('nvim-treesitter.install').update({ with_sync = true })()
end

M.opts = {
    ensure_installed = 'all',
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = false },
    autopairs = { enable = true },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ['ic'] = '@conditional.inner',
                ['ac'] = '@conditional.outer',
                ['aC'] = '@class.outer',
                ['iC'] = '@class.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['il'] = '@loop.inner',
                ['al'] = '@loop.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>sc'] = '@conditional.outer',
                ['<leader>sf'] = '@function.outer',
                ['<leader>sl'] = '@loop.outer',
                ['<leader>sp'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>sC'] = '@conditional.outer',
                ['<leader>sF'] = '@function.outer',
                ['<leader>sL'] = '@loop.outer',
                ['<leader>sP'] = '@parameter.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
    },
}

M.config = function(_, opts)
    local treesitter = require('nvim-treesitter.configs')
    treesitter.setup(opts)
end

return M
