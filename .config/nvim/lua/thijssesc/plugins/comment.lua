-- comment

local comment = require('Comment')
local cutils = require('Comment.utils')
local tscc_utils = require('ts_context_commentstring.utils')
local tscc_internal = require('ts_context_commentstring.internal')

comment.setup {
    pre_hook = function(ctx)
        local location = nil
        if ctx.ctype == cutils.ctype.block then
            location = tscc_utils.get_cursor_location()
        elseif ctx.cmotion == cutils.cmotion.v or ctx.cmotion == cutils.cmotion.V then
            location = tscc_utils.get_visual_start_location()
        end

        return tscc_internal.calculate_commentstring {
            key = ctx.ctype == cutils.ctype.line and '__default' or '__multiline',
            location = location,
        }
    end,
}
