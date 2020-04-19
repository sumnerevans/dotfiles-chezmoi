" Cool other configs to look at
" - http://www.lukesmith.xyz/conf/.vimrc
" - https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup
" - https://github.com/jschomay/.vim/blob/master/vimrc
" - https://github.com/jhgarner/DotFiles
"
" Dependencies
" - bat
" - fzf
" - python-neovim
" - ripgrep
" - wmctrl
" - probably others

" PLUG: https://github.com/junegunn/vim-plug
" =============================================================================
" Automatically install Vim-Plug if it is not yet installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.local/share/nvim/plugged')

" Project Navigation and Configuration
Plug 'airblade/vim-rooter'              " Change vim's cwd to the project root
Plug 'dyng/ctrlsf.vim'                  " Sublime Text-like search
Plug 'editorconfig/editorconfig-vim'    " Use .editorconfig
Plug 'yuki-ycino/fzf-preview.vim'       " Fuzzy finder with preview window
Plug 'tpope/vim-fugitive'               " Git integration

" Integration with environment
Plug 'christoomey/vim-tmux-navigator'   " TMUX alt-h,j,k,l integration

" Themes
Plug 'dracula/vim'
Plug 'iCyMind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'lanox/lanox-vim-theme'
Plug 'mhartington/oceanic-next'
Plug 'ryanoasis/vim-devicons'           " Fancy icons

" UI Chrome
Plug 'gioele/vim-autoswap'              " Swap to the already opened file
Plug 'milkypostman/vim-togglelist'      " Toggle the Quickfix list
Plug 'scrooloose/nerdtree'              " File tree
Plug 'vim-airline/vim-airline'          " Cooler status bar
Plug 'vim-airline/vim-airline-themes'   " Status bar themes
Plug 'Xuyuanp/nerdtree-git-plugin'      " Git integration for NERDTree

" Editor
Plug 'alvan/vim-closetag'               " Automatically close HTML tags
Plug 'aperezdc/vim-template'            " Templates for various types of files
Plug 'jiangmiao/auto-pairs'             " Automatically close parentheses, etc.
Plug 'luochen1990/rainbow'              " Color pairs of parentheses
Plug 'mhinz/vim-signify'                " VCS integration in the gutter
Plug 'terryma/vim-multiple-cursors'     " Allow multiple cursors
Plug 'tpope/vim-commentary'             " Easy commenting of lines
Plug 'tpope/vim-surround'               " Manipulate surrounding delimiters

" Language Support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'             " Syntax support for basically all of the languages

call plug#end()

" CoC Extensions
let g:coc_global_extensions=[
            \ 'coc-css',
            \ 'coc-dictionary',
            \ 'coc-docker',
            \ 'coc-elixir',
            \ 'coc-eslint',
            \ 'coc-go',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-lists',
            \ 'coc-marketplace',
            \ 'coc-omnisharp',
            \ 'coc-python',
            \ 'coc-rust-analyzer',
            \ 'coc-snippets',
            \ 'coc-texlab',
            \ 'coc-tsserver',
            \ 'coc-word',
            \ 'coc-yaml',
            \ ]

" VARIABLES
" =============================================================================
let s:os = system('uname -s')
let $PLUGIN_CONFIG_ROOT = '$HOME/.config/nvim/plugin_configs'

" THEME
" =============================================================================
if ($TERM == 'xterm-256color' || $TERM == 'screen-256color') && !has('gui_running')
    set termguicolors
endif
colorscheme OceanicNext
" set background=dark

highlight NonText ctermfg=DarkRed guifg=#aa3333 ctermfg=DarkBlue guibg=#1b2b34
" highlight Comment ctermfg=74 guifg=#6a6a6a
" TODO: find color is a bit bright

" Highlight past 100 characters
highlight Over100Length ctermbg=red ctermfg=white guibg=#BD4F4F
match Over100Length /\%101v.\+/

" PLUGIN CONFIGURATIONS
" =============================================================================

" Project Navigation and Configuration ----------------------------------------
" Vim Rooter (airblade/vim-rooter)
let g:rooter_patterns = [
            \'.rooter_root',
            \'.git/',
            \'Makefile',
            \'setup.py',
            \'Cargo.toml',
            \'__init__.py',
            \]

" CtrlSF (dyng/ctrlsf.vim)
nmap <C-S> <Plug>CtrlSFPrompt
vmap <C-S> <Plug>CtrlSFVwordPath
let g:ctrlsf_ackprg = '/usr/bin/rg'
let g:ctrlsf_auto_focus = { "at": "start" }
let g:ctrlsf_default_root = 'cwd'
let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ }
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '30%'

" Editorconfig (editorconfig/editorconfig-vim)
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" FZF Preview (yuki-ycino/fzf-preview.vim)
nnoremap <C-p> :call FzfPreview()<CR>
let g:fzf_preview_filelist_command = 'fd --type f --hidden --follow --exclude .git'
let g:fzf_preview_use_dev_icons = 1

function! FzfPreview()
    silent !git rev-parse --show-toplevel
    if v:shell_error
        FzfPreviewFromResources buffer directory
    else
        FzfPreviewFromResources buffer project
    endif
endfunction

" Integration with Environment ------------------------------------------------
" Tmux Navigator integration (christoomey/vim-tmux-navigator)
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_disable_when_zoomed = 1

nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>

" UI Chrome -------------------------------------------------------------------
" Vim Autoswap (gioele/vim-autoswap)
let g:autoswap_detect_tmux = 1

" ToggleList (milkypostman/vim-togglelist)
nmap <script> <silent> E :call ToggleQuickfixList()<CR>
" TODO come back to this

" NERD Tree (scrooloose/nerdtree, Xuyuanp/nerdtree-git-plugin)
let g:NERDTreeBookmarksFile = "$HOME/.local/share/nvim/.NERDTreeBookmarks"
let g:NerdTreeNaturalSort = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowIgnoredStatus = 1
let g:NERDTreeWinSize = 40
let g:NERDTreeIgnore = [
            \'.aux$[[file]]',
            \'.bk$[[file]]',
            \'.coverage$[[file]]',
            \'.egg-info$[[dir]]',
            \'.fdb_latexmk$[[file]]',
            \'.fls$[[file]]',
            \'.git$[[dir]]',
            \'.gz$[[file]]',
            \'.hypothesis$[[dir]]',
            \'.ibc$[[file]]',
            \'.log$[[file]]',
            \'.mypy_cache$[[dir]]',
            \'.nyc_output$[[dir]]',
            \'.o$[[file]]',
            \'.out$[[file]]',
            \'.pyc$',
            \'.pytest_cache$[[dir]]',
            \'.ropeproject$[[dir]]',
            \'.sass-cache$[[dir]]',
            \'.tmp$[[dir]]',
            \'__pycache__$[[dir]]',
            \'_minted-*',
            \'dist$[[dir]]',
            \]
map <S-T> :NERDTreeToggle<CR>

" Airline (vim-airline/vim-airline)
let g:airline_powerline_fonts = 1                       " Enable fancy chars
let g:airline#extensions#coc#enabled = 1                " Code competion/linting
let g:airline#extensions#fugitiveline#enabled = 1       " Git branch, etc
let g:airline#extensions#nerdtree_status = 1            " Use NERDTree statusline
let g:airline#extensions#tabline#enabled = 1            " Show the tabline
let g:airline#extensions#tabline#show_tabs = 0          " Don't show tabs, just buffers

" Editor ----------------------------------------------------------------------
" Vim Templates (aperezdc/vim-template)
let g:templates_directory = [
            \'~/.vim/vim-templates',
            \'~/.config/nvim/templates',
            \]

" Vim Autopairs (jiangmiao/auto-pairs)
let g:AutoPairsFlyMode = 1

" Rainbow (luochen1990/rainbow)
let g:rainbow_active = 1                " Enable the parentheses coloring
source $PLUGIN_CONFIG_ROOT/rainbow.vim  " Configuration for rainbow

" Signify (mhinz/vim-signify)
let g:signify_sign_delete = '-' " Make delete use - rather than _

" Commentary (tpope/vim-commentary)
noremap <F8> :Commentary<CR>

" Language Support ------------------------------------------------------------
" CoC (neoclide/coc.nvim)
set updatetime=300
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call CocAction('doHover')<CR>

" Remap for rename current word
nmap <silent> <F6> <Plug>(coc-rename)

" Go to symbol
nmap <silent> S :CocList symbols<CR>

" Remap for format selected region
xmap <C-S-F> <Plug>(coc-format-selected)
nmap <C-S-F> <Plug>(coc-format)

" VIM SETTINGS
" =============================================================================
set colorcolumn=80,100,120                      " Column guides
set hidden                                      " Don't close when switching buffers
set list listchars=tab:\▶\ ,trail:␣,nbsp:␣      " Highlight unwanted whitespace
set mouse=a                                     " Enable mouse scrolling
set number                                      " Show the current line number
set pastetoggle=<F2>                            " Make C-S-V paste work better
set scrolloff=5                                 " Always have 5 lines above/below the current line
set showbreak=↩\ 
set signcolumn=yes                              " Always show the sign column for git gutter
set title                                       " Override the terminal title
set virtualedit=onemore                         " Allow the cursor to go one past the EOL

" Tabs
set expandtab                                   " Insert spaces instead of tabs
set shiftwidth=4                                " 4 is the only way

" Search
set ignorecase  " ignore case...
set smartcase   " unless the search string has uppercase letters

" Tabs and Buffers ------------------------------------------------------------
set showtabline=2       " Always show the tab bar
set splitbelow          " Default split below, rather than above
set splitright          " Default split to the right, rather than the left

" Buffer navigation
map <C-H> :bp<CR>
map <C-L> :bn<CR>
map <C-W> :bdelete<CR>

" Quickfix --------------------------------------------------------------------
au FileType qf call AdjustWindowHeight(5, 5)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Shortcuts (for the things I type a lot in insert mode) ----------------------
source $HOME/.vim/shortcuts

" Clipboard (use system keyboard) ---------------------------------------------
if s:os ==# "Linux\n"
    set clipboard+=unnamedplus
else
    set clipboard+=unnamed
endif

" Custom keybindings ----------------------------------------------------------
" Make j and k behave nicer when the line wraps
noremap j gj
noremap k gk

" Run make
nnoremap <F5> :make<CR>
nnoremap <S-F5> :make run<CR>

" Clean up paragraph
noremap <C-c> vipgq

" Undo and Swap ---------------------------------------------------------------
" Note: ~/tmp is a tmpfs, so writing to it does not use disk)
set undofile                    " Use an undo file
set undodir=~/tmp/nvim/undo//   " Store undo files in ~/tmp to avoid disk I/O
set directory=~/tmp/nvim/swap// " Store swap files in ~/tmp to aviod disk I/O

" FILETYPE SPECIFIC CONFIGURATIONS
" =============================================================================
set modeline " allow stuff like vim: set spelllang=en_us at the top of files

" Automatically break lines at 80 characters on TeX/LaTeX, Markdown, and text
" files
" Enable spell check on TeX/LaTeX, Markdown, and text files
autocmd BufNewFile,BufRead *.tex,*.md,*.txt,*.rst setlocal tw=80
autocmd BufNewFile,BufRead *.tex,*.md,*.txt,*.rst setlocal linebreak breakindent
autocmd BufNewFile,BufRead *.tex,*.md,*.txt,*.rst setlocal spell spelllang=en_gb
autocmd BufNewFile,BufRead *.tex,*.md,*.txt,*.rst match Over100Length /\%81v.\+/

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
autocmd FileType javascript,xhtml,html,htmldjango,scss,less,yaml,css,markdown,rst,lisp setlocal shiftwidth=2

" Make spelling a top level syntax element
autocmd FileType * syntax spell toplevel

" Disable folding on RST
autocmd FileType rst setlocal nofoldenable
