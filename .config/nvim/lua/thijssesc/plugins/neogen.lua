-- neogen

local neogen = require('neogen')

neogen.setup { enabled = true }

vim.keymap.nnoremap { '<leader>nf', neogen.generate }
