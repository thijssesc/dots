-- cmp

local cmp = require('cmp')
local luasnip = require('luasnip')
local neogen = require('neogen')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.shortmess:append('c')

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

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = next,
        ['<C-n>'] = next,
        ['<S-Tab>'] = prev,
        ['<C-p>'] = prev,
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    }, {
        { name = 'buffer', keyword_length = 5 },
    }),
    experimental = {
        ghost_text = true,
        view = { entries = true },
    },
}

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
