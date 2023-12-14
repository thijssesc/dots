-- cmp

local M = {
    'hrsh7th/nvim-cmp',
    name = 'cmp',
    version = false,
    event = 'InsertEnter',
}

M.dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
            'L3MON4D3/LuaSnip',
        }
    },
    require('thijssesc.plugins.neogen'),
}

M.opts = function()
    vim.api.nvim_set_hl(0, 'CmpGhostText', {
        link = 'Comment',
        default = true,
    })

    local cmp = package.loaded.cmp
    local defaults = require('cmp.config.default')()
    local luasnip = package.loaded.luasnip
    local neogen = package.loaded.neogen

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    local next = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif neogen.jumpable() then
            neogen.jump_next()
        elseif luasnip.expandable() then
            luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end, { 'i', 's' })

    local prev = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif neogen.jumpable(-1) then
            neogen.jump_prev()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { 'i', 's' })

    return {
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-n>'] = next,
            ['<Tab>'] = next,
            ['<C-p>'] = prev,
            ['<S-Tab>'] = prev,
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-y'] = cmp.config.disable,
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm { select = true },
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
        }, {
            { name = 'buffer', keyword_length = 5 },
        }),
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, item)
                local menu_icon = {
                    nvim_lsp = 'λ',
                    luasnip = '⋗',
                    buffer = 'Ω',
                    path = '🖫',
                }
                item.menu = menu_icon[entry.source.name]

                return item
            end,
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        experimental = {
            ghost_text = {
                hl_group = 'CmpGhostText',
            },
            view = { entries = true },
        },
        sorting = defaults.sorting,
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
    }
end

M.config = function(_, opts)
    local cmp = require('cmp')

    cmp.setup(opts)

    cmp.setup.cmdline('/', {
        sources = cmp.config.sources {
            { name = 'buffer' },
        },
    })

    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' },
        }, {
            { name = 'cmdline' },
        }),
    })
end

return M
