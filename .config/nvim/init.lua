vim.pack.add {
    'https://github.com/catppuccin/nvim',
    'https://github.com/folke/snacks.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-mini/mini.icons',
    'https://github.com/nvim-mini/mini.statusline',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/stevearc/oil.nvim',
    { src = 'https://github.com/saghen/blink.cmp', version = 'v1.8.0' },
}

vim.api.nvim_create_autocmd('BufWritePre', { command = '%s/\\s\\+$//e' })

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        if mark[1] > 0 and mark[1] < vim.api.nvim_buf_line_count(args.buf) then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function()
                vim.cmd.normal { 'zz', bang = true }
            end)
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
        vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump { count = vim.v.count1, float = true }
        end, { buffer = args.buf })
        vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump { count = -vim.v.count1, float = true }
        end, { buffer = args.buf })
        vim.keymap.set('n', 'gd', require('snacks').picker.lsp_declarations, { buffer = args.buf })
        vim.keymap.set('n', 'gD', require('snacks').picker.lsp_definitions, { buffer = args.buf })
        vim.keymap.set('n', 'gi', require('snacks').picker.lsp_implementations, { buffer = args.buf })
        vim.keymap.set('n', 'gr', require('snacks').picker.lsp_references, { buffer = args.buf })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf })
        vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf })
        vim.keymap.set('n', '<leader>F', function()
            vim.lsp.buf.format { async = true }
        end, { buffer = args.buf })
    end,
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim', 'require' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            telemetry = { enabled = false },
        },
    },
})
vim.lsp.enable { 'bashls', 'gopls', 'lua_ls', 'yamlls' }

require('blink.cmp').setup {
    keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'accept', 'fallback' },
    },
    completion = {
        list = {
            selection = { auto_insert = false },
        },
    },
}
require('gitsigns').setup {
    on_attach = function(bufnr)
        vim.keymap.set('n', ']c', function()
            require('gitsigns').nav_hunk('next')
        end, { buffer = bufnr })
        vim.keymap.set('n', '[c', function()
            require('gitsigns').nav_hunk('prev')
        end, { buffer = bufnr })
        vim.keymap.set('n', '<leader>hr', require('gitsigns').reset_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>hb', function()
            require('gitsigns').blame_line { full = true }
        end, { buffer = bufnr })
    end,
}
require('mason').setup()
require('mini.icons').setup()
require('mini.statusline').setup()
require('oil').setup { skip_confirm_for_simple_edits = true }
require('snacks').setup {
    indent = { animate = { enabled = false } },
    notifier = { enabled = true },
    picker = { enabled = true },
    words = { enabled = true },
}
require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    ignore_install = { 'ipkg' },
    highlight = { enable = true },
}

vim.opt.colorcolumn = '120'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.sidescrolloff = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.winborder = 'rounded'
vim.opt.wrap = false

vim.g.mapleader = ' ' ---@diagnostic disable-line: inject-field

vim.keymap.set('n', '<leader>nh', ':set nohlsearch<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<leader>so', 'vip:\'<,\'>sort ui<CR>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', '[q', ':cprev<CR>')
vim.keymap.set('n', ']l', ':lnext<CR>')
vim.keymap.set('n', '[l', ':lprev<CR>')
vim.keymap.set('n', '<leader>ff', require('snacks').picker.files)
vim.keymap.set('n', '<leader>fg', require('snacks').picker.grep)
vim.keymap.set('n', '<leader><BSlash>', require('oil').open_float)

vim.cmd.colorscheme('catppuccin')
