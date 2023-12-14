-- comment

local M = {
    'numToStr/Comment.nvim',
    name = 'Comment',
    version = '*',
    event = 'VeryLazy',
}

M.dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
}

M.config = function()
    local comment = require('Comment')

    comment.setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
end

return M
