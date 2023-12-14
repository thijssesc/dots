-- tree

local M = {
    'nvim-tree/nvim-tree.lua',
    name = 'nvim-tree',
    version = '*',
}

M.dependencies = {
    'nvim-tree/nvim-web-devicons',
}

M.init = function()
    if not vim.fn.argc(-1) == 1 then
        return
    end

    local stat = vim.loop.fs_stat(vim.fn.argv(0))
    if stat and stat.type == 'directory' then
        require('nvim-tree')
    end
end

M.opts = {
    on_attach = function(buffer)
        local api = package.loaded['nvim-tree.api']

        vim.keymap.nnoremap { 'l', api.tree.change_root_to_node, buffer = buffer }
        vim.keymap.nnoremap { 'q', api.tree.close, buffer = buffer }
        vim.keymap.nnoremap { '<ESC>', api.tree.close, buffer = buffer }
        vim.keymap.nnoremap { '<BS>', api.node.navigate.parent_close, buffer = buffer }
        vim.keymap.nnoremap { 'p', api.fs.copy.node, buffer = buffer }
        vim.keymap.nnoremap { 'gy', api.fs.copy.absolute_path, buffer = buffer }
        vim.keymap.nnoremap { 'y', api.fs.copy.filename, buffer = buffer }
        vim.keymap.nnoremap { 'Y', api.fs.copy.relative_path, buffer = buffer }
        vim.keymap.nnoremap { 'n', api.fs.create, buffer = buffer }
        vim.keymap.nnoremap { 'v', api.fs.cut, buffer = buffer }
        vim.keymap.nnoremap { 'h', api.tree.change_root_to_parent, buffer = buffer }
        vim.keymap.nnoremap { '<CR>', api.node.open.edit, buffer = buffer }
        vim.keymap.nnoremap { 'e' , api.node.open.edit, buffer = buffer }
        vim.keymap.nnoremap { 'gg', api.node.navigate.sibling.first, buffer = buffer }
        vim.keymap.nnoremap { 'r', api.fs.rename_full, buffer = buffer }
        vim.keymap.nnoremap { 'G', api.node.navigate.sibling.last, buffer = buffer }
        vim.keymap.nnoremap { 'a', api.fs.paste, buffer = buffer }
        vim.keymap.nnoremap { 'R', api.tree.reload, buffer = buffer }
        vim.keymap.nnoremap { '<C-r>', api.fs.rename, buffer = buffer }
        vim.keymap.nnoremap { 'x', api.fs.remove, buffer = buffer }
        vim.keymap.nnoremap { '<C-x>', api.node.open.horizontal, buffer = buffer }
        vim.keymap.nnoremap { 's', api.node.run.system, buffer = buffer }
        vim.keymap.nnoremap { '<C-t>', api.node.open.tab, buffer = buffer }
        vim.keymap.nnoremap { '.', api.tree.toggle_hidden_filter, buffer = buffer }
        vim.keymap.nnoremap { '?', api.tree.toggle_help, buffer = buffer }
        vim.keymap.nnoremap { '<C-v>', api.node.open.vertical, buffer = buffer }
    end,
    sync_root_with_cwd = true,
    view = {
        width = 40,
    },
    renderer = {
        add_trailing = true,
        group_empty = true,
        indent_markers = {
            enable = true,
        },
        highlight_git = true,
        highlight_opened_files = 'all',
        root_folder_label = true,
    },
    update_focused_file = {
        enable = true,
    },
    git = {
        enable = false,
    },
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
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
}

M.keys = {
    { '<leader><BS>', [[<cmd>NvimTreeFocus<CR>]] },
    { '<leader><BSlash>', [[<cmd>NvimTreeToggle<CR>]] },
}

return M
