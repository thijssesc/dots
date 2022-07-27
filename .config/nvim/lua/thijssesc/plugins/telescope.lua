-- telescope

local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local builtin = require('telescope.builtin')
local telescope = require('telescope')
local themes = require('telescope.themes')

local projects = {}
if os.getenv('TOP_TYPE') == 'laptop' then
    for _, v in pairs { 1, 2, 3, 4, 5, 6 } do
        table.insert(projects, vim.fn.getenv('PROJECT' .. v))
    end
end

telescope.setup {
    defaults = {
        prompt_prefix = '> ',
        selection_caret = '> ',
        entry_prefix = '  ',
        initial_mode = 'normal',
        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        layout_strategy = 'horizontal',
        layout_config = {
            prompt_position = 'bottom',
            width = 0.8,
            preview_cutoff = 120,
            horizontal = {
                width_padding = 0.1,
                height_padding = 0.1,
                preview_width = 0.5,
            },
            vertical = {
                width_padding = 0.05,
                height_padding = 1,
                preview_height = 0.5,
            },
        },
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = false,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' },
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        mappings = {
            i = {
                ['<C-t>'] = false,
                ['<C-k>'] = actions.cycle_history_prev,
                ['<C-j>'] = actions.cycle_history_next,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            },
        },
    },
    pickers = {
        diagnostics = themes.get_dropdown { layout_config = { width = 0.8 } },
        find_files = {
            initial_mode = 'insert',
            file_ignore_patterns = { '%.class', '\\.git/*', 'parser.c', 'target/*', 'node_modules/*' },
            path_display = {
                shorten = {
                    exclude = { 1, -1, -2, -3 },
                },
            },
        },
        git_branches = themes.get_dropdown { previewer = false },
        grep_string = { initial_mode = 'insert' },
        live_grep = { initial_mode = 'insert' },
        lsp_code_actions = themes.get_cursor(),
        lsp_references = themes.get_dropdown { layout_config = { width = 0.8 } },
    },
    extensions = {
        project = {
            base_dirs = projects,
        },
        ['ui-select'] = {
            themes.get_dropdown(),
        },
    },
}

telescope.load_extension('blanket')
telescope.load_extension('harpoon')
telescope.load_extension('project')
telescope.load_extension('ui-select')

local custom = {}

function custom.dot_files()
    local opts = themes.get_dropdown {
        cwd = '~/',
        initial_mode = 'insert',
        previewer = false,
        prompt_title = 'dotfiles',
        layout_config = { width = 0.3 },
    }
    builtin.git_files(opts)
end

function custom.marks()
    local opts = themes.get_dropdown {
        layout_config = { width = 120 },
        previewer = false,
    }
    telescope.extensions.harpoon.marks(opts)
end

function custom.project()
    local opts = themes.get_dropdown { layout_config = { width = 0.3 } }
    telescope.extensions.project.project(opts)
end

vim.keymap.nnoremap { '<leader>cc', telescope.extensions.blanket.blanket }
vim.keymap.nnoremap { '<leader>fb', builtin.buffers }
vim.keymap.nnoremap { '<leader>fB', builtin.git_branches }
vim.keymap.nnoremap { '<leader>fC', builtin.git_bcommits }
vim.keymap.nnoremap { '<leader>fc', builtin.git_commits }
vim.keymap.nnoremap { '<leader>fD', custom.dot_files }
vim.keymap.nnoremap { '<leader>ff', builtin.find_files }
vim.keymap.nnoremap { '<leader>fG', builtin.git_files }
vim.keymap.nnoremap { '<leader>fg', builtin.live_grep }
vim.keymap.nnoremap { '<leader>fp', custom.project }
vim.keymap.nnoremap { '<leader>fs', builtin.git_status }
vim.keymap.nnoremap { '<leader>fS', builtin.grep_string }
vim.keymap.nnoremap { '<C-t>', custom.marks }

return custom
