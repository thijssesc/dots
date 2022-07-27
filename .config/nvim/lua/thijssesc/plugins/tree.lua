-- tree

local tree = require('nvim-tree')

tree.setup {
    update_cwd = true,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = ' ',
            info = ' ',
            warning = ' ',
            error = '',
        },
    },
    update_focused_file = { enable = true },
    git = { enable = false },
    actions = {
        open_file = {
            window_picker = { enable = false },
        },
    },
    view = {
        width = 40,
        hide_root_folder = true,
        mappings = {
            custom_only = true,
            list = {
                { key = 'l', action = 'cd' },
                { key = { 'q', '<ESC>' }, action = 'close' },
                { key = '<BS>', action = 'close_node' },
                { key = 'p', action = 'copy' },
                { key = 'gy', action = 'copy_absolute_path' },
                { key = 'y', action = 'copy_name' },
                { key = 'Y', action = 'copy_path' },
                { key = 'n', action = 'create' },
                { key = 'v', action = 'cut' },
                { key = 'h', action = 'dir_up' },
                { key = { '<CR>', 'e' }, action = 'edit_no_picker' },
                { key = 'g', action = 'first_sibling' },
                { key = 'r', action = 'full_rename' },
                { key = 'G', action = 'last_sibling' },
                { key = 'a', action = 'paste' },
                { key = 'R', action = 'refresh' },
                { key = '<C-r>', action = 'rename' },
                { key = 'x', action = 'remove' },
                { key = '<C-x>', action = 'split' },
                { key = 's', action = 'system_open' },
                { key = '<C-t>', action = 'tabnew' },
                { key = '.', action = 'toggle_dotfiles' },
                { key = '?', action = 'toggle_help' },
                { key = '<C-v>', action = 'vsplit' },
            },
        },
    },
    renderer = {
        add_trailing = true,
        group_empty = true,
        indent_markers = { enable = true },
        highlight_git = true,
        highlight_opened_files = 'all',
    },
}

vim.keymap.nnoremap { '<leader><BS>', ':NvimTreeFocus<CR>' }
vim.keymap.nnoremap { '<leader><BSlash>', ':NvimTreeToggle<CR>' }
