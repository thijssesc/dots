-- on_attach

return function(client, buffer)
    local builtin = require('telescope.builtin')

    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    local function list_workspace_folders()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end
    local function goto_prev()
        vim.diagnostic.goto_prev { enable_popup = false }
    end
    local function goto_next()
        vim.diagnostic.goto_next { enable_popup = false }
    end
    local function diagnostics()
        builtin.diagnostics { bufnr = 0 }
    end
    local function format()
        vim.lsp.buf.format { async = true }
    end

    vim.keymap.nnoremap { 'gD', vim.lsp.buf.declaration, { buffer = buffer } }
    vim.keymap.nnoremap { 'gd', vim.lsp.buf.definition, { buffer = buffer } }
    vim.keymap.nnoremap { 'K', vim.lsp.buf.hover, { buffer = buffer } }
    vim.keymap.nnoremap { 'gi', vim.lsp.buf.implementation, { buffer = buffer } }
    vim.keymap.nnoremap { '<A-S-K>', vim.lsp.buf.signature_help, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>wl', list_workspace_folders, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>D', vim.lsp.buf.type_definition, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>rn', vim.lsp.buf.rename, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>ca', vim.lsp.buf.code_action, { buffer = buffer } }
    vim.keymap.nnoremap { 'gr', builtin.lsp_references, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>e', vim.diagnostic.open_float, { buffer = buffer } }
    vim.keymap.nnoremap { '[d', goto_prev, { buffer = buffer } }
    vim.keymap.nnoremap { ']d', goto_next, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>q', diagnostics, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>Q', builtin.diagnostics, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>F', format, { buffer = buffer } }

    if client.server_capabilities.document_highlight then
        vim.api.nvim_create_augroup('lsp_document_highlight', {})
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
        })
    end
end
