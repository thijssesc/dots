-- null-ls

local M = {
    'nvimtools/none-ls.nvim',
    name = 'null-ls',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
}

M.dependencies = {
    'nvim-lua/plenary.nvim',
    'L3MON4D3/LuaSnip',
    require('thijssesc.plugins.mason'),
}

M.opts = function()
    local null_ls = require('null-ls')
    return {
        sources = {
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.code_actions.shellcheck,

            null_ls.builtins.completion.luasnip,
            null_ls.builtins.completion.spell,

            null_ls.builtins.diagnostics.ansiblelint,
            null_ls.builtins.diagnostics.golangci_lint,
            null_ls.builtins.diagnostics.selene,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.diagnostics.standardjs,

            null_ls.builtins.formatting.gofumpt,
            null_ls.builtins.formatting.standardjs,
            null_ls.builtins.formatting.stylua,
        }
    }
end

return M
