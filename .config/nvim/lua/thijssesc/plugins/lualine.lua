-- lualine

local lualine = require('lualine')

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = nil, right = nil },
        section_separators = { left = nil, right = nil },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'diagnostics' },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = { 'nvim-tree', 'quickfix' },
}
