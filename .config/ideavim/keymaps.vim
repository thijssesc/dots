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

" " resize splits
" nnoremap <A-C-h> :vertical resize -2<CR>
" nnoremap <A-C-j> :resize +2<CR>
" nnoremap <A-C-k> :resize -2<CR>
" nnoremap <A-C-l> :vertical resize +2<CR>

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
nnoremap ]q :action PreviousOccurence<CR>
nnoremap [q :action NextOccurence<CR>
" nnoremap ]l :lnext<CR>
" nnoremap [l :lprev<CR>

" blanket
" nnoremap <leader>cp :action blanket.set_report_path<CR>
" nnoremap <leader>cr :action blanket.refresh<CR>
nnoremap <leader>cS :action RunCoverage<CR>
nnoremap <leader>rc :action RunCoverage<CR>
nnoremap <leader>cs :action HideCoverage<CR>

" dap
nnoremap <leader>dc :action Resume<CR>
" nnoremap <leader>dd :action dap.down<CR>
nnoremap <leader>dg :action RunToCursor<CR>
" nnoremap <leader>dh :action dap.hover<CR>
nnoremap <leader>di :action StepInto<CR>
nnoremap <leader>do :action StepOver<CR>
nnoremap <leader>dO :action StepOut<CR>
nnoremap <leader>dr :action EvaluateExpression<CR>
" nnoremap <leader>ds :action dap.scopes<CR>
nnoremap <leader>dS :action Stop<CR>
nnoremap <leader>dt :action ToggleLineBreakpoint<CR>
" nnoremap <leader>du :action dap.up<CR>

" gitsigns
nnoremap [c         :action VcsShowPrevChangeMarker<CR>
nnoremap ]c         :action VcsShowNextChangeMarker<CR>
nnoremap <leader>hs :action Vcs.Diff.IncludeOnlyChangedLinesIntoCommit<CR>
nnoremap <leader>hr :action Vcs.RollbackChangedLines<CR>
nnoremap <leader>hS :action Git.Add<CR>
nnoremap <leader>hu :action Vcs.Diff.ExcludeChangedLinesFromCommit<CR>
" nnoremap <leader>hR :action gitsigns.reset_buffer<CR>
nnoremap <leader>hp :action VcsShowCurrentChangeMarker<CR>
nnoremap <leader>hb :action Annotate<CR>
" nnoremap <leader>tb :action gitsigns.toggle_current_line_blame<CR>
" nnoremap <leader>hd :action gitsigns.diffthis<CR>
" nnoremap <leader>hD :action gitsigns.diffthis('~')<CR>
" nnoremap <leader>td :action gitsigns.toggle_deleted<CR>
" onoremap ih :action gitsigns.select_hunk<CR>
" xnoremap ih :action gitsigns.select_hunk<CR>

" harpoon
nnoremap <C-n>      :action ToggleBookmarkWithMnemonic<CR>
nnoremap <C-q>      :action ToggleBookmark<CR>
nnoremap <C-t>      :action ShowBookmarks<CR>
nnoremap <leader>hh :action GotoBookmarkH<CR>
nnoremap <leader>jj :action GotoBookmarkJ<CR>
nnoremap <leader>kk :action GotoBookmarkK<CR>
nnoremap <leader>ll :action GotoBookmarkL<CR>
" nnoremap <leader>s1 :action term.sendCommand(1, 1)<CR>
" nnoremap <leader>s2 :action term.sendCommand(1, 2)<CR>
nnoremap <leader>tt :action ActivateTerminalToolWindow<CR>
nnoremap <leader>tr :action ActivateTerminalToolWindow<CR>
nnoremap <leader>te :action ActivateTerminalToolWindow<CR>

" lsp
nnoremap gD         :action GotoTypeDeclaration<CR>
nnoremap gd         :action GotoDeclarationOnly<CR>
nnoremap K          :action QuickJavaDoc<CR>
nnoremap gi         :action GotoImplementation<CR>
nnoremap <A-S-k>    :action ParameterInfo<CR>
" nnoremap <leader>wa :action AddToWorkspaces<CR>
" nnoremap <leader>wr :action RemoveFromWorkspaces<CR>
" nnoremap <leader>wl :action ListWorkspaces<CR>
nnoremap <leader>D  :action QuickTypeDefinition<CR>
nnoremap <leader>rn :action RenameElement<CR>
nnoremap <leader>ca :action ShowIntentionActions<CR>
nnoremap gr         :action GotoDeclaration<CR>
" nnoremap <leader>e  :action ShowLineDiagnostics<CR>
nnoremap [d         :action GotoPreviousError<CR>
nnoremap ]d         :action GotoNextError<CR>
" nnoremap <leader> q :action SetLocList<CR>
nnoremap <leader>F  :action ReformatCode<CR>
nnoremap <leader>df :action DebugClass<CR>
nnoremap <leader>dn :action DebugClass<CR>
nnoremap <leader>dp :action RunMenu<CR>
nnoremap <leader>ec :action IntroduceConstant<CR>
nnoremap <leader>ev :action IntroduceVariable<CR>
nnoremap <leader>oi :action OptimizeImports<CR>
vnoremap <leader>ec :action IntroduceConstant<CR>
vnoremap <leader>em :action ExtractMethod<CR>
vnoremap <leader>ev :action IntroduceVariable<CR>

" neogen
" nnoremap <leader>nf :action neogen.generate<CR>

" telescope
" nnoremap <leader>cc :action telescope.extensions.blanket.blanket<CR>
nnoremap <leader>fb :action Switcher<CR>
nnoremap <leader>fB :action Git.Branches<CR>
nnoremap <leader>fC :action Vcs.ShowTabbedFileHistory<CR>
nnoremap <leader>fc :action Vcs.Show.Log<CR>
" nnoremap <leader>fD :action telescope.builtin.dot_files<CR>
nnoremap <leader>ff :action SearchEverywhere<CR>
" nnoremap <leader>fG :action telescope.builtin.git_files<CR>
nnoremap <leader>fg :action FindInPath<CR>
nnoremap <leader>fp :action ManageRecentProjects<CR>
nnoremap <leader>fs :action Vcs.Show.Local.Changes<CR>
" nnoremap <leader>fS :action telescope.builtin.grep_string<CR>

" tree
nnoremap <leader><BS>     :NERDTreeFocus<CR>
nnoremap <leader><BSlash> :NERDTreeToggle<CR>

" intellij specific - lsp
nnoremap <leader>ef :action IntroduceField<CR>
nnoremap <leader>im :action ImplementMethods<CR>
nnoremap <leader>om :action OverrideMethods<CR>
nnoremap gs         :action GotoSuperMethod<CR>
" nnoremap gt         :action GotoTest<CR>
vnoremap <leader>ef :action IntroduceField<CR>
" intellij specific - misc
nnoremap <C-BS>     :action Terminal.SwitchFocusToEditor<CR>
" intellij specific - movement
nnoremap [m :action MethodUp<CR>
nnoremap ]m :action MethodDown<CR>
nnoremap <C-o> :action Back<CR>
nnoremap <C-i> :action Forward<CR>
nnoremap g<C-o> <C-o>
nnoremap g<C-i> <C-i>
" intellij specific - toggle elements
nnoremap <leader>mm :action ViewMainMenu<CR>
nnoremap <leader>pm :action TogglePresentationMode<CR>
nnoremap <leader>sb :action ViewStatusBar<CR>
nnoremap <leader>tb :action ViewToolButtons<CR>
nnoremap <leader>tg :action EditorToggleShowGutterIcons<CR>
nnoremap <leader>tl :action EditorToggleShowLineNumbers<CR>
" intellij specific - tool windows
nnoremap <leader>bw :action ActivateBuildToolWindow<CR>
nnoremap <leader>cw :action ActivateCoverageToolWindow<CR>
nnoremap <leader>dw :action ActivateDebugToolWindow<CR>
nnoremap <leader>ew :action ActivateEventLogToolWindow<CR>
nnoremap <leader>gg :action ActivateVersionControlToolWindow<CR>
nnoremap <leader>mw :action ActivateMavenToolWindow<CR>
nnoremap <leader>pw :action ActivateProblemsViewToolWindow<CR>
nnoremap <leader>rw :action ActivateRunToolWindow<CR>
