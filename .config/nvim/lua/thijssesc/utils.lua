-- utils

local keymap = {}
local utils = {}

function utils.trim_whitespace()
    if vim.bo.filetype == 'java' then
        return
    end

    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
end

function utils.remove_netrw_mappings()
    local mappings = { ['n'] = '<C-l>' }
    for mode, mapping in pairs(mappings) do
        if vim.fn.hasmapto('<Plug>NetrwRefresh') ~= 0 then
            vim.api.nvim_buf_del_keymap(0, mode, mapping)
        end
    end
end

function utils.reload()
    for name, _ in pairs(package.loaded) do
        if name:match('^thijssesc') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
end

local function make_mapper(defaults, opts)
    local args, map_args = {}, {}
    for k, v in pairs(opts) do
        if type(k) == 'number' then
            args[k] = v
        else
            map_args[k] = v
        end
    end

    local mode = opts.mode or args[1]
    local lhs = opts.lhs or args[2]
    local rhs = opts.rhs or args[3]
    local map_opts = vim.tbl_extend('force', defaults, map_args)

    vim.keymap.set(mode, lhs, rhs, map_opts)
end

function keymap.map(opts)
    make_mapper({ silent = true, noremap = true }, opts)
end

function keymap.noremap(opts)
    make_mapper({ silent = true, noremap = true }, opts)
end

local modes = { 'c', 'i', 'n', 'o', 's', 't', 'v', 'x' }
for _, v in pairs(modes) do
    keymap[v .. 'map'] = function(opts)
        table.insert(opts, 1, v)
        make_mapper({ silent = true, noremap = false }, opts)
    end
    keymap[v .. 'noremap'] = function(opts)
        table.insert(opts, 1, v)
        make_mapper({ silent = true, noremap = true }, opts)
    end
end

vim.keymap = vim.tbl_extend('keep', vim.keymap, keymap)

return utils
