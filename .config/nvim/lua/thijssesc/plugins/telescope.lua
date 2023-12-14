-- telescope

local M = {
    'nvim-telescope/telescope.nvim',
    name = 'telescope',
    version = '*',
}

M.dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-project.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    require('thijssesc.plugins.blanket'),
    require('thijssesc.plugins.harpoon'),
}

M.opts = function()
    local actions = require('telescope.actions')
    local actions_state = require('telescope.actions.state')
    local previewers = require('telescope.previewers')
    local sorters = require('telescope.sorters')
    local themes = require('telescope.themes')

    local projects = {}
    if os.getenv('TOP_TYPE') == 'laptop' then
        for _, v in pairs { 1, 2, 3, 4, 5, 6 } do
            if not vim.fn.getenv('PROJECT' .. v) == vim.NIL then
                table.insert(projects, vim.fn.getenv('PROJECT' .. v))
            end
        end
    end

    return {
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
                n = {
                    ['<C-t>'] = function(prompt_bufnr)
                        local current_picker = actions_state.get_current_picker(prompt_bufnr)
                        if current_picker.prompt_title == 'harpoon marks' then
                            actions.close(prompt_bufnr)
                        else
                            actions.select_tab(prompt_bufnr)
                        end
                    end,
                    ['<C-n>'] = actions.move_selection_next,
                    ['<C-p>'] = actions.move_selection_previous,
                },
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
end

M.config = function(_, opts)
    local telescope = require('telescope')

    telescope.setup(opts)
    telescope.load_extension('blanket')
    telescope.load_extension('harpoon')
    telescope.load_extension('project')
    telescope.load_extension('ui-select')
end

local function blanket()
    local telescope = require('telescope')
    telescope.extensions.blanket.blanket()
end

local function dot_files()
    local telescope = require('telescope')
    local themes = require('telescope.themes')

    local opts = themes.get_dropdown {
        cwd = '~/',
        initial_mode = 'insert',
        previewer = false,
        prompt_title = 'dotfiles',
        layout_config = { width = 0.3 },
    }

    telescope.builtin.git_files(opts)
end

local function marks()
    local telescope = require('telescope')
    local themes = require('telescope.themes')

    local opts = themes.get_dropdown {
        layout_config = { width = 120 },
        previewer = false,
    }

    telescope.extensions.harpoon.marks(opts)
end

local function project()
    local telescope = require('telescope')
    local themes = require('telescope.themes')

    local opts = themes.get_dropdown {
        layout_config = { width = 0.3 }
    }

    telescope.extensions.project.project(opts)
end

M.keys = {
    { '<leader>cc', blanket },
    { '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]] },
    { '<leader>fB', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]] },
    { '<leader>fC', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]] },
    { '<leader>fc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]] },
    { '<leader>fD', dot_files },
    { '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]] },
    { '<leader>fG', [[<cmd>lua require('telescope.builtin').git_files()<CR>]] },
    { '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]] },
    { '<leader>fp', project },
    { '<leader>fs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]] },
    { '<leader>fS', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]] },
    { '<C-t>', marks },
}

return M
