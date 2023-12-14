-- mason

local M = {
    'williamboman/mason.nvim',
    name = 'mason',
    version = false,
    cmd = 'Mason',
    build = ':MasonUpdate',
}

M.dependencies = {
    'williamboman/mason-lspconfig.nvim',
}

M.opts = {
    ensure_installed = {
        'ansible-language-server',
        'ansible-lint',
        'bash-language-server',
        'eslint_d',
        'gofumpt',
        'golangci-lint',
        'gopls',
        'java-debug-adapter',
        'java-test',
        'jdtls',
        'lua-language-server',
        'node-debug2-adapter',
        'selene',
        'shellcheck',
        'sonarlint-language-server',
        'standardjs',
        'stylua',
        'typescript-language-server',
        'vscode-java-decompiler',
        'yaml-language-server',
    },
}

M.config = function(_, opts)
    require('mason').setup(opts)
    local mr = require('mason-registry')

    vim.api.nvim_create_user_command('MasonInstallAll', function ()
      vim.cmd('MasonInstall ' .. table.concat(opts.ensure_installed, ' '))
    end, {})

    local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
                p:install()
            end
        end
    end

    if mr.refresh then
        mr.refresh(ensure_installed)
    else
        ensure_installed()
    end
end

M.keys = {
    { "<leader>cm", "<cmd>Mason<cr>"}
}

return M
