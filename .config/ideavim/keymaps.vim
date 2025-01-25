" keymaps

let mapleader = ' '

" reload nvim configurations
nnoremap <leader>rr :source ~/.config/ideavim/ideavimrc<CR>

" stop the search hightlighting
nnoremap <leader>nh :set nohlsearch<CR>

" paste from clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
" copy (file) to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
vnoremap <leader>Y gg"+yG

" unmap arrow keys
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
noremap <Up>    <Nop>

" auto-center
nnoremap G Gzz
nnoremap N Nzz
nnoremap n nzz

" sorting
nnoremap <leader>so vip:'<,'>sort ui<CR>

" " spell-checking
" map <silent> <leader> se :setlocal spell! spelllang=en_us<CR>
" map <silent> <leader> sn :setlocal spell! spelllang=nl_nl<CR>

" switch buffers
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" splits
nmap <leader>su <Action>(Unsplit)
nmap <leader>sv <Action>(SplitVertically)
nmap <leader>sx <Action>(SplitHorizontally)

" " resize splits
nmap <A-C-h> <Action>(StretchSplitToLeft)
nmap <A-C-j> <Action>(StretchSplitToBottom)
nmap <A-C-k> <Action>(StretchSplitToTop)
nmap <A-C-l> <Action>(StretchSplitToRight)

" " easy switching from/into terminal buffers
" tnoreamp <C-n> <C-\><C-n>
" tnoreamp <C-h> <C-\><C-n><C-w>h
" tnoreamp <C-j> <C-\><C-n><C-w>j
" tnoreamp <C-k> <C-\><C-n><C-w>k
" tnoreamp <C-l> <C-\><C-n><C-w>l
" tnoreamp <C-d> <C-\><C-n><C-w>:q<CR>

" " I hate this
" nnoremap q: <Nop>

" " cycle through qflist and location list
nmap ]q <Action>(PreviousOccurence)
nmap [q <Action>(NextOccurence)
" nmap ]l :lnext<CR>
" nmap [l :lprev<CR>

" blanket
" nmap <leader>cp <Action>(blanket.set_report_path)
" nmap <leader>cr <Action>(blanket.refresh)
nmap <leader>cS <Action>(RunCoverage)
nmap <leader>rc <Action>(RunCoverage)
nmap <leader>cs <Action>(HideCoverage)

" dap
nmap <leader>dc <Action>(Resume)
" nmap <leader>dd <Action>(dap.down)
nmap <leader>dg <Action>(RunToCursor)
" nmap <leader>dh <Action>(dap.hover)
nmap <leader>di <Action>(StepInto)
nmap <leader>do <Action>(StepOver)
nmap <leader>dO <Action>(StepOut)
nmap <leader>dr <Action>(EvaluateExpression)
" nmap <leader>ds <Action>(dap.scopes)
nmap <leader>dS <Action>(Stop)
nmap <leader>dt <Action>(ToggleLineBreakpoint)
" nmap <leader>du <Action>(dap.up)

" gitsigns
nmap [c         <Action>(VcsShowPrevChangeMarker)
nmap ]c         <Action>(VcsShowNextChangeMarker)
nmap <leader>hs <Action>(Vcs.Diff.IncludeOnlyChangedLinesIntoCommit)
nmap <leader>hr <Action>(Vcs.RollbackChangedLines)
nmap <leader>hS <Action>(Git.Add)
nmap <leader>hu <Action>(Vcs.Diff.ExcludeChangedLinesFromCommit)
" nmap <leader>hR <Action>(gitsigns.reset_buffer)
nmap <leader>hp <Action>(VcsShowCurrentChangeMarker)
nmap <leader>hb <Action>(Annotate)
" nmap <leader>tb <Action>(gitsigns.toggle_current_line_blame)
" nmap <leader>hd <Action>(gitsigns.diffthis)
" nmap <leader>hD <Action>(gitsigns.diffthis('~'))
" nmap <leader>td <Action>(gitsigns.toggle_deleted)
" omap ih <Action>(gitsigns.select_hunk)
" xmap ih <Action>(gitsigns.select_hunk)

" harpoon
nmap <C-n>      <Action>(ToggleBookmarkWithMnemonic)
nmap <C-q>      <Action>(ToggleBookmark)
nmap <C-t>      <Action>(ShowBookmarks)
nmap <leader>hh <Action>(GotoBookmarkH)
nmap <leader>jj <Action>(GotoBookmarkJ)
nmap <leader>kk <Action>(GotoBookmarkK)
nmap <leader>ll <Action>(GotoBookmarkL)
" nmap <leader>s1 <Action>(term.sendCommand(1, 1))
" nmap <leader>s2 <Action>(term.sendCommand(1, 2))
nmap <leader>tt <Action>(ActivateTerminalToolWindow)
nmap <leader>tr <Action>(ActivateTerminalToolWindow)
nmap <leader>te <Action>(ActivateTerminalToolWindow)

" lsp
nmap gD         <Action>(GotoTypeDeclaration)
nmap gd         <Action>(GotoDeclarationOnly)
nmap K          <Action>(QuickJavaDoc)
nmap gi         <Action>(GotoImplementation)
nmap <A-S-k>    <Action>(ParameterInfo)
" nmap <leader>wa <Action>(AddToWorkspaces)
" nmap <leader>wr <Action>(RemoveFromWorkspaces)
" nmap <leader>wl <Action>(ListWorkspaces)
nmap <leader>D  <Action>(QuickTypeDefinition)
nmap <leader>rn <Action>(RenameElement)
nmap <leader>ca <Action>(ShowIntentionActions)
nmap gr         <Action>(GotoDeclaration)
" nmap <leader>e  <Action>(ShowLineDiagnostics)
nmap [d         <Action>(GotoPreviousError)
nmap ]d         <Action>(GotoNextError)
" nmap <leader> q <Action>(SetLocList)
nmap <leader>F  <Action>(ReformatCode)
nmap <leader>df <Action>(DebugClass)
nmap <leader>dn <Action>(DebugClass)
nmap <leader>dp <Action>(RunMenu)
nmap <leader>ec <Action>(IntroduceConstant)
nmap <leader>ev <Action>(IntroduceVariable)
nmap <leader>oi <Action>(OptimizeImports)
vmap <leader>ec <Action>(IntroduceConstant)
vmap <leader>em <Action>(ExtractMethod)
vmap <leader>ev <Action>(IntroduceVariable)

" neogen
" nmap <leader>nf <Action>(neogen.generate)

" telescope
" nmap <leader>cc <Action>(telescope.extensions.blanket.blanket)
nmap <leader>fb <Action>(Switcher)
nmap <leader>fB <Action>(Git.Branches)
nmap <leader>fC <Action>(Vcs.ShowTabbedFileHistory)
nmap <leader>fc <Action>(Vcs.Show.Log)
" nmap <leader>fD <Action>(telescope.builtin.dot_files)
nmap <leader>ff <Action>(SearchEverywhere)
" nmap <leader>fG <Action>(telescope.builtin.git_files)
nmap <leader>fg <Action>(FindInPath)
nmap <leader>fp <Action>(ManageRecentProjects)
nmap <leader>fs <Action>(Vcs.Show.Local.Changes)
" nmap <leader>fS <Action>(telescope.builtin.grep_string)

" tree
nmap <leader><BS>     :NERDTreeFocus<CR>
nmap <leader><BSlash> :NERDTreeToggle<CR>

" intellij specific - lsp
nmap <leader>ef <Action>(IntroduceField)
nmap <leader>im <Action>(ImplementMethods)
nmap <leader>om <Action>(OverrideMethods)
nmap gs         <Action>(GotoSuperMethod)
" nmap gt         <Action>(GotoTest)
vmap <leader>ef <Action>(IntroduceField)
" intellij specific - misc
nmap <C-BS>     <Action>(Terminal.SwitchFocusToEditor)
" intellij specific - movement
nmap [m <Action>(MethodUp)
nmap ]m <Action>(MethodDown)
nmap <C-o> <Action>(Back)
nmap <C-i> <Action>(Forward)
nmap g<C-o> <C-o>
nmap g<C-i> <C-i>
" intellij specific - toggle elements
nmap <leader>mm <Action>(ViewMainMenu)
nmap <leader>pm <Action>(TogglePresentationMode)
nmap <leader>sb <Action>(ViewStatusBar)
nmap <leader>tb <Action>(ViewToolButtons)
nmap <leader>tg <Action>(EditorToggleShowGutterIcons)
nmap <leader>tl <Action>(EditorToggleShowLineNumbers)
" intellij specific - tool windows
nmap <leader>bw <Action>(ActivateBuildToolWindow)
nmap <leader>cw <Action>(ActivateCoverageToolWindow)
nmap <leader>dw <Action>(ActivateDebugToolWindow)
nmap <leader>ew <Action>(ActivateEventLogToolWindow)
nmap <leader>gg <Action>(ActivateVersionControlToolWindow)
nmap <leader>mw <Action>(ActivateMavenToolWindow)
nmap <leader>pw <Action>(ActivateProblemsViewToolWindow)
nmap <leader>rw <Action>(ActivateRunToolWindow)
