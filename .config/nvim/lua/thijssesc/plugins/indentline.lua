-- indent blankline

local indent_blankline = require('indent_blankline')

indent_blankline.setup {
    buftype_exclude = { 'terminal', 'nofile' },
    char = '┊',
    char_highlight = 'LineNr',
    filetype_exclude = { 'help', 'packer' },
    show_current_context = true,
    use_treesitter = true,
}
