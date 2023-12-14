-- theming

local M = {
    'catppuccin/nvim',
    name = 'catppuccin',
    version = '*',
    priority = 1000,
}

M.init = function()
    vim.cmd.colorscheme('catppuccin')
end

M.opts = {
    flavour = 'macchiato',
    transparent_background = true,
    integrations = {
        nvimtree = {
            transparent_panel = true,
        },
    },
    highlight_overrides = {
        macchiato = function(macchiato)
            return {
                -- general highlighting
                CursorLine = { bg = macchiato.none, fg = macchiato.none, underline = true },
                QuickFixLine = { bg = macchiato.none, fg = macchiato.flamingo, underline = true },

                -- lsp cursor hold highlighting
                LspReferenceRead = { bg = 'NONE', fg = macchiato.none, bold = true, underline = true },
                LspReferenceText = { bg = macchiato.none, fg = macchiato.none, bold = true, underline = true },
                LspReferenceWrite = { bg = macchiato.none, fg = macchiato.none, bold = true, underline = true },
            }
        end,
    },
}

return M
