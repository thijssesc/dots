" plug

Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'

" vim.keymap.nnoremap { 'l', api.tree.change_root_to_node, buffer = buffer }
let g:NERDTreeMapQuit = 'q'
" vim.keymap.nnoremap { '<ESC>', api.tree.close, buffer = buffer }
" vim.keymap.nnoremap { '<BS>', api.node.navigate.parent_close, buffer = buffer }
" vim.keymap.nnoremap { 'p', api.fs.copy.node, buffer = buffer }
" vim.keymap.nnoremap { 'gy', api.fs.copy.absolute_path, buffer = buffer }
" vim.keymap.nnoremap { 'y', api.fs.copy.filename, buffer = buffer }
" vim.keymap.nnoremap { 'Y', api.fs.copy.relative_path, buffer = buffer }
" vim.keymap.nnoremap { 'n', api.fs.create, buffer = buffer }
" vim.keymap.nnoremap { 'v', api.fs.cut, buffer = buffer }
" vim.keymap.nnoremap { 'h', api.tree.change_root_to_parent, buffer = buffer }
" vim.keymap.nnoremap { '<CR>', api.node.open.edit, buffer = buffer }
" vim.keymap.nnoremap { 'e' , api.node.open.edit, buffer = buffer }
let g:NERDTreeMapJumpFirstChild = 'gg'
" vim.keymap.nnoremap { 'r', api.fs.rename_full, buffer = buffer }
let g:NERDTreeMapJumpLastChild = 'G'
" vim.keymap.nnoremap { 'a', api.fs.paste, buffer = buffer }
let g:NERDTreeMapRefreshRoot = 'R'
nremap <C-r> <Action>(RenameFile)
" vim.keymap.nnoremap { 'x', api.fs.remove, buffer = buffer }
let g:NERDTreeMapOpenSplit = '<C-x>'
" vim.keymap.nnoremap { 's', api.node.run.system, buffer = buffer }
let g:NERDTreeMapOpenInTab = '<C-t>'
" vim.keymap.nnoremap { '.', api.tree.toggle_hidden_filter, buffer = buffer }
" vim.keymap.nnoremap { '?', api.tree.toggle_help, buffer = buffer }
let g:NERDTreeMapOpenVSplit = '<C-v>'

