" Cool other configs to look at
" - http://www.lukesmith.xyz/conf/.vimrc
" - https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
" - https://github.com/jschomay/.vim/blob/master/vimrc
" - https://github.com/jhgarner/DotFiles
"
" Dependencies
" - python-neovim
" - wmctrl
" - fzf
" - probably others

" PLUG: https://github.com/junegunn/vim-plug =================================
call plug#begin('~/.local/share/nvim/plugged')

" Workspace
Plug 'airblade/vim-rooter'

" Themes
Plug 'dracula/vim'
Plug 'iCyMind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'lanox/lanox-vim-theme'
Plug 'mhartington/oceanic-next'

" Language Support
Plug 'sheerun/vim-polyglot'             " Supports all of the languages
Plug 'idris-hackers/idris-vim'          " Idris Support

" UI
Plug 'jistr/vim-nerdtree-tabs'          " File tree compatibilty with tabs
Plug 'junegunn/fzf'                     " Fuzzy finder
Plug 'luochen1990/rainbow'              " Color pairs of parentheses
Plug 'mhinz/vim-signify'                " VCS integration in the gutter
Plug 'scrooloose/nerdtree'              " File tree
Plug 'vim-airline/vim-airline'          " Cooler status bar
Plug 'vim-airline/vim-airline-themes'   " Status bar themes
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git integration for NERDTree

" Editing
Plug 'alvan/vim-closetag'               " Automatically close HTML tags
Plug 'aperezdc/vim-template'            " Templates for various types of files
Plug 'dyng/ctrlsf.vim'                  " Better find
Plug 'ervandew/supertab'                " Use tab for autocomplete
Plug 'gioele/vim-autoswap'              " Swap to the already opened file
Plug 'milkypostman/vim-togglelist'      " Toggle the Quickfix list
Plug 'terryma/vim-multiple-cursors'     " Allow multiple cursors
Plug 'tpope/vim-commentary'             " Easy commenting of lines
Plug 'tpope/vim-surround'               " Manipulate surrounding delimiters
Plug 'jiangmiao/auto-pairs'             " Automatically close parentheses, etc.

" Code Completion
Plug 'ncm2/ncm2'                        " Code completion Manager
Plug 'roxma/nvim-yarp'                  " Required for ncm2
Plug 'ncm2/ncm2-bufword'                " Completions for words in buffer
Plug 'ncm2/ncm2-path'                   " Completions for paths

" Code Snippets
Plug 'ncm2/ncm2-ultisnips'              " UltiSnips
Plug 'SirVer/ultisnips'

" LanguageClient
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

" Linting
Plug 'w0rp/ale'

call plug#end()

" VARIABLES
let s:os = system('uname -s')
let $PLUGIN_CONFIG_ROOT = '$HOME/.config/nvim/plugin_configs'

" COLOR SCHEME ===============================================================
if $TERM == 'xterm-256color' && !has('gui_running')
    set termguicolors
endif
colorscheme onedark
" set background=dark

highlight NonText ctermfg=DarkRed guifg=#aa3333
highlight Comment ctermfg=74 guifg=#6a6a6a

" Highlight past 100 characters
highlight Over100Length ctermbg=red ctermfg=white guibg=#BD4F4F
match Over100Length /\%101v.\+/

" UI =========================================================================
set colorcolumn=80,100,120                      " Column guides
set mouse=a                                     " Enable mouse scrolling
set number                                      " Show the current line number
set signcolumn=yes                              " Always show the sign column for git gutter
set title                                       " Override the terminal title
set list listchars=tab:\▶\ ,trail:␣,nbsp:␣      " Highlight unwanted whitespace
set showbreak=↩\ 

" PLUGIN CONFIGURATIONS ======================================================
" Vim Rooter
let g:rooter_patterns = ['.rooter_root', 'Makefile', '.git/', 'setup.py', 'Cargo.toml', '__init__.py']

" Airline - Status bar
let g:airline_powerline_fonts = 1       " Enable fancy chars
let g:airline#extensions#languageclient#enabled = 1

" ALE - Linting
" let g:ale_open_list = 1                 " Auto open the error list
" let g:ale_completion_enabled = 1        " Enable completion
let g:ale_set_loclist = 0               " Limit the size of the ALE output to 5 lines
let g:ale_set_quickfix = 1              " Limit the size of the ALE output to 5 lines
let g:ale_list_window_size = 5          " Limit the size of the ALE output to 5 lines
let g:ale_sign_error = '✖'              " Consistent sign column with Language Client
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = '➤'
let g:ale_linters = {
            \ 'c': ['clangcheck'],
            \ 'cpp': ['clangcheck'],
            \ 'python': ['mypy'],
            \ 'rust': ['rls'],
            \}
let g:ale_fixers = {
            \ 'c': ['clang-format'],
            \ 'cpp': ['clang-format'],
            \ 'css': ['stylelint'],
            \ 'haskell': ['brittany'],
            \ 'html': ['prettier'],
            \ 'javascript': ['eslint', 'trim_whitespace'],
            \ 'json': ['prettier'],
            \ 'jsx': ['eslint'],
            \ 'markdown': ['prettier'],
            \ 'python': ['isort', 'yapf'],
            \ 'rust': ['rustfmt'],
            \}
let g:ale_tex_chktex_options = '-I -n18 -n44'
let g:ale_cpp_clangtidy_options = '-Wall -std=c++17 -x c++'
let g:ale_cpp_clangcheck_options = '-- -Wall -std=c++17 -x c++'
noremap <C-S-F> :ALEFix<CR>

" FZF - Fuzzy finder
nnoremap <C-p> :FZF<CR>
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Language Client - Handling autocomplete for many languages
set omnifunc=LanguageClient#complete    " Use LanguageClient as the completion engine
let g:LanguageClient_autoStart = 1      " Automatically start language servers.
let g:LanguageClient_loadSettings = 1   " Load the settings from settings.json
let g:LanguageClient_diagnosticsList = "Quickfix"
let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls'],
    \ 'cpp': ['ccls'],
    \ 'cuda': ['ccls'],
    \ 'css': ['css-languageserver', '--stdio'],
    \ 'html': ['html-languageserver', '--stdio'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ 'rust': ['rls'],
    \ 'racket': ['racket', '--lib', 'racket-langserver'],
    \ 'typescript': ['javascript-typescript-stdio'],
\ }

" Language Client keybinds
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> @ :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>

" ToggleList - toggle the quickfix list by pressing E (for errors)
nmap <script> <silent> E :call ToggleQuickfixList()<CR>

" ncm2 - Neovim Completion Manager
autocmd BufEnter * call ncm2#enable_for_buffer()  " enable ncm2 for all buffers
set completeopt=menu,menuone,preview,noselect,noinsert

" UltiSnips - snippet management
" Press enter key to trigger snippet expansion
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" NERD Tree
let g:NERDTreeIndicatorMapCustom = {
            \'Modified': '✹', 'Staged': '✚', 'Untracked': '✭', 'Renamed': '➜', 'Unmerged': '═',
            \'Deleted': '✖', 'Dirty': '✗', 'Clean': '✔︎', 'Unknown': '?' }
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = [
            \'.git$[[dir]]',
            \'.sass-cache$[[dir]]', '__pycache__$[[dir]]', '.pyc',
            \'.nyc_output$[[dir]]', '.tmp$[[dir]]', '.ropeproject$[[dir]]',
            \'.bk$[[file]]', '.out$[[file]]', '.aux$[[file]]', '.log$[[file]]', '_minted-*',
            \'.gz$[[file]]', '.fls$[[file]]', '.fdb_latexmk$[[file]]',
            \'.ibc$[[file]]', '.o$[[file]]',
            \]
let g:NERDTreeWinSize = 40
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_synchronize_view = 0
map <S-T> <plug>NERDTreeTabsToggle<CR>

" Rainbow - Parentheses coloring
let g:rainbow_active = 1                " Enable the parentheses coloring
source $PLUGIN_CONFIG_ROOT/rainbow.vim  " Configuration for rainbow

" Supertab - Use tab for autocomplete
let g:SuperTabDefaultCompletionType = '<c-n>'   " Pressing tab goes down the
                                                " list
" Vim Templates - Templates for various filetypes
let g:templates_directory = '~/.vim/vim-templates'  " Custom templates

" CtrlSF
nmap     <C-S> <Plug>CtrlSFPrompt
vmap     <C-S> <Plug>CtrlSFVwordPath

" Signify - VCS gutter
let g:signify_sign_delete = '-' " Make delete use - rather than _

" TABS AND BUFFERS ===========================================================
" Editor Tabs
set showtabline=2 " always show the tab bar
map <c-h> :tabp<CR>
map <c-l> :tabn<CR>
map <c-t> :tabnew<CR>

" Navigation between buffers in tab
set splitbelow          " Split below, rather than above
set splitright          " Split to the right, rather than the left
map <A-k> <C-W><C-K>
map <A-j> <C-W><C-J>
map <A-h> <C-W><C-H>
map <A-l> <C-W><C-L>

" Quickfix
au FileType qf call AdjustWindowHeight(5, 5)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

" EDITING ====================================================================
set hidden                  " Don't close when switching buffers
set scrolloff=5             " Always have 5 lines above/below the current line
set virtualedit=onemore     " Allow the cursor to go one past the EOL
set pastetoggle=<F2>        " Make C-S-V paste work better

" Tabs
set shiftwidth=4            " 4 is the only way
set expandtab               " Insert spaces instead of tabs

" Shortcuts for the things I type a lot in insert mode
source $HOME/.vim/shortcuts

" Make j and k behave nicer when the line wraps
noremap j gj
noremap k gk

" Make Vim the use the system clipboard
if s:os ==# "Linux\n"
    set clipboard+=unnamedplus
else
    set clipboard+=unnamed
endif

" Commenting
noremap <F8> :Commentary<CR>

" Run make
nnoremap <F5> :make<CR>
nnoremap <S-F5> :make run<CR>

" Clean up paragraph
noremap <C-c> vipgq

" Search
set ignorecase  " ignore case...
set smartcase   " unless the search string has uppercase letters

" Undo and Swap (~/tmp is a tmpfs, so writing to it does not use disk)
set undofile                    " Use an undo file
set undodir=~/tmp/nvim/undo//   " Store undo files in ~/tmp to avoid disk I/O
set directory=~/tmp/nvim/swap// " Store swap files in ~/tmp to aviod disk I/O

" FILETYPE SPECIFIC CONFIGURATIONS ===========================================
set modeline " allow stuff like vim: set spelllang=en_us at the top of files

" Automatically break lines at 80 characters on TeX/LaTeX, Markdown, and text
" files
" Enable spell check on TeX/LaTeX, Markdown, and text files
autocmd BufNewFile,BufRead *.tex,*.md,*.txt,*.rst setlocal tw=80
autocmd BufNewFile,BufRead *.tex,*.md,*.txt,*.rst setlocal linebreak breakindent
autocmd BufNewFile,BufRead *.tex,*.md,*.txt,*.rst setlocal spell spelllang=en_gb
autocmd BufNewFile,BufRead *.tex,*.md,*.txt,*.rst highlight Over100Length none

" Automatically break lines at 100 characters when writing HTML files
" Enable spell check on HTML files
autocmd BufNewFile,BufRead *.html setlocal tw=100
autocmd BufNewFile,BufRead *.html setlocal spell spelllang=en_gb

" Automatically break lines at 80 characters when writing emails in mutt
" Enable spell check for emails in mutt and quotes file
autocmd BufRead $HOME/tmp/mutt-*,$HOME/.local/share/chezmoi/dot_mutt/quotes setlocal tw=72
autocmd BufRead $HOME/tmp/mutt-*,$HOME/.local/share/chezmoi/dot_mutt/quotes setlocal spell spelllang=en_gb
autocmd BufRead $HOME/tmp/mutt-*,$HOME/.local/share/chezmoi/dot_mutt/quotes setlocal colorcolumn=72,80
autocmd BufRead $HOME/tmp/mutt-*,$HOME/.local/share/chezmoi/dot_mutt/quotes match Over100Length /\%73v.\+/

" Use TAB = 2 spaces for a few file types
autocmd FileType javascript,xhtml,html,scss,yaml,css,markdown,rst,lisp setlocal shiftwidth=2

" Make spelling a top level syntax element
autocmd FileType * syntax spell toplevel

" Disable folding on RST
autocmd FileType rst setlocal nofoldenable
