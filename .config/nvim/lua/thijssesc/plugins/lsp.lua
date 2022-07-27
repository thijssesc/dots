-- lsp

local lspconfig = require('lspconfig')
local on_attach = require('thijssesc.plugins.lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
require('cmp_nvim_lsp').update_capabilities(capabilities)

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local servers = {
    { 'ansiblels', { filetypes = { 'yaml', 'yaml.ansible' } } },
    'bashls',
    'clangd',
    -- 'cucumber_language_server',
    { 'gopls', { cmd = { 'gopls', '--remote=auto' } } },
    -- {
    --     'groovyls',
    --     {
    --         cmd = {
    --             'java',
    --             '-jar',
    --             os.getenv('HOME') .. '/Software/groovy-language-server/build/libs/groovy-language-server-all.jar',
    --         },
    --     },
    -- },
    {
        'sumneko_lua',
        {
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT', path = runtime_path },
                    diagnostics = { globals = { 'vim' } },
                    workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                    telemetry = { enabled = false },
                },
            },
        },
    },
    'tsserver',
    { 'yamlls', { filetypes = { 'yaml', 'yaml.docker-compose' } } },
}

require('thijssesc.plugins.cmp')
require('thijssesc.plugins.lsp.java')
-- require('thijssesc.plugins.lsp.null_ls')

for _, server in pairs(servers) do
    local extra_opts = {}
    if type(server) == 'table' then
        extra_opts = server[2] or {}
        server = server[1]
    end

    local opts = vim.tbl_extend('keep', extra_opts, {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    })
    lspconfig[server].setup(opts)
end
