-- indent blankline

local M = {
    'lukas-reineke/indent-blankline.nvim',
    name = 'indent-blankline',
    main = 'ibl',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
}

M.opts = {
	scope = {
		enabled = false,
	},
    indent = {
        char = '│',
        tab_char = '│',
    },
    exclude = {
        filetypes = {
            'help',
            'alpha',
            'dashboard',
            'neo-tree',
            'Trouble',
            'trouble',
            'lazy',
            'mason',
            'notify',
            'toggleterm',
            'lazyterm',
        },
    },
}

return M
