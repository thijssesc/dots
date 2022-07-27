-- null-ls

local null_ls = require('null-ls')

null_ls.setup {
    sources = {
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.shellcheck,

        null_ls.builtins.completion.luasnip,
        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.ansiblelint,
        -- null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.selene,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.standardjs,
        -- null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.standardjs,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.terraform_fmt,
    },
}
