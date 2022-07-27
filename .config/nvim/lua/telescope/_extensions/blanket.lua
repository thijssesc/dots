-- blanket telescope extension

local blanket = require('blanket')
local telescope = require('telescope')
local make_entry = require('telescope.make_entry')

local file_pattern

local function set_root_path(prompt_bufnr)
    local content = require('telescope.actions.state').get_selected_entry()
    require('telescope.actions').close(prompt_bufnr)
    blanket.__user_config.report_path = vim.fn.getcwd() .. '/' .. vim.fn.expandcmd(content.value)
    blanket.refresh()
end

local function get_jacoco_files()
    local files = vim.fn.expand(file_pattern)
    local results = {}
    for str in files:gmatch('[^\r\n]+') do
        table.insert(results, str)
    end

    return results
end

local function telescope_blanket(opts)
    opts = opts or require('telescope.themes').get_dropdown()

    require('telescope.pickers').new(opts, {
        prompt_title = 'blanket',
        finder = require('telescope.finders').new_table {
            results = get_jacoco_files(),
            entry_maker = make_entry.gen_from_file(),
        },
        sorter = require('telescope.config').values.generic_sorter(opts),
        attach_mappings = function(_, map)
            map('i', '<CR>', set_root_path)
            map('n', '<CR>', set_root_path)
            return true
        end,
    }):find()
end

local function setup(opts)
    file_pattern = opts.file_pattern or '**/jacoco/jacoco.xml'
end

return telescope.register_extension {
    setup = setup,
    exports = { blanket = telescope_blanket },
}
