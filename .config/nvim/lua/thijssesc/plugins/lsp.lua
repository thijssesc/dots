-- lsp

local M = {
    'neovim/nvim-lspconfig',
    name = 'lspconfig',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
}

M.dependencies = {
    require('thijssesc.plugins.telescope'),
    require('thijssesc.plugins.mason'),
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

M.opts = {
    capabilities = {
        flags = {
            debounce_text_changes = 150,
        },
    },
    servers = {
        ansiblels = {
            filetypes = {
                'yaml', 'yaml.ansible',
            },
        },
        bashls = {},
        clangd = {},
        gopls = {},
        lua_ls = {
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT', path = runtime_path },
                    diagnostics = { globals = { 'vim' } },
                    workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                    telemetry = { enabled = false },
                },
            },
        },
        ts_ls = {},
        yamlls = {
            filetypes = { 'yaml', 'yaml.docker-compose' },
        },
    },
}

M.config = function(_, opts)
    vim.fn.sign_define(opts.name, { texthl = 'DiagnosticSignError', text = '✘' , numhl = '' })
    vim.fn.sign_define(opts.name, { texthl = 'DiagnosticSignWarn', text = '▲' , numhl = '' })
    vim.fn.sign_define(opts.name, { texthl = 'DiagnosticSignHint', text = '⚑' , numhl = '' })
    vim.fn.sign_define(opts.name, { texthl = 'DiagnosticSignInfo', text = '' , numhl = '' })

    vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
            border = 'rounded',
            source = 'always',
        },
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
    )

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            local buffer = ev.buf
            vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'

            vim.keymap.nnoremap { 'gD', vim.lsp.buf.declaration, { buffer = buffer } }
            vim.keymap.nnoremap { 'gd', vim.lsp.buf.definition, { buffer = buffer } }
            vim.keymap.nnoremap { 'K', vim.lsp.buf.hover, { buffer = buffer } }
            vim.keymap.nnoremap { 'gi', vim.lsp.buf.implementation, { buffer = buffer } }
            vim.keymap.nnoremap { '<A-S-K>', vim.lsp.buf.signature_help, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = buffer } }
            vim.keymap.nnoremap {
                '<leader>wl',
                function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end ,
                { buffer = buffer }
            }
            vim.keymap.nnoremap { '<leader>D', vim.lsp.buf.type_definition, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>rn', vim.lsp.buf.rename, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>ca', vim.lsp.buf.code_action, { buffer = buffer } }
            vim.keymap.nnoremap { 'gr', require('telescope.builtin').lsp_references, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>e', vim.diagnostic.open_float, { buffer = buffer } }
            vim.keymap.nnoremap {
                '[d',
                function()
                    vim.diagnostic.goto_prev { enable_popup = false }
                end,
                { buffer = buffer }
            }
            vim.keymap.nnoremap {
                ']d',
                function()
                    vim.diagnostic.goto_next { enable_popup = false }
                end,
                { buffer = buffer }
            }
            vim.keymap.nnoremap {
                '<leader>q',
                function()
                    require('telescope.builtin').diagnostics { bufnr = buffer }
                end,
                { buffer = buffer }
            }
            vim.keymap.nnoremap { '<leader>Q', require('telescope.builtin').diagnostics, { buffer = buffer } }
            vim.keymap.nnoremap {
                '<leader>F',
                function()
                    vim.lsp.buf.format { async = true }
                end,
                { buffer = buffer }
            }

            if client.server_capabilities.documentHighlightProvider then
                local lsp_document_highlight = vim.api.nvim_create_augroup('lsp_document_highlight', {})
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    group = lsp_document_highlight,
                    buffer = buffer,
                    callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd('CursorMoved', {
                    group = lsp_document_highlight,
                    buffer = buffer,
                    callback = vim.lsp.buf.clear_references,
                })
            end
        end
    })

    local capabilities = vim.tbl_deep_extend('force', {},
          vim.lsp.protocol.make_client_capabilities(),
          require('cmp_nvim_lsp').default_capabilities(),
          opts.capabilities or {}
    )

    for server, server_opts in pairs(opts.servers) do
        if server_opts then
            local new_opts = vim.tbl_deep_extend('force', {
                capabilities = vim.deepcopy(capabilities),
            }, opts.servers[server] or {})

            require('lspconfig')[server].setup(new_opts)
        end
    end
end

return M
