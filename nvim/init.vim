""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                            "
"                           VIM configuration                                "
"                                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Environment variables                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $XDG_CONFIG_HOME = !empty($XDG_CONFIG_HOME) ? $XDG_CONFIG_HOME : "~/.config"
let $XDG_CACHE_HOME = !empty($XDG_CACHE_HOME) ? $XDG_CACHE_HOME : "~/.cache"
let $XDG_DATA_HOME = !empty($XDG_DATA_HOME) ? $XDG_DATA_HOME : "~/.local/share"



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Utility functions                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function s:EnsureIsDir(dir)
    if isdirectory(a:dir) == 0
        :silent execute '!mkdir -p' a:dir '>/dev/null 2>&1'
    endif
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Initialization                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install vim-plug if it is not already installed
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
  execute 'silent !curl -fLo ' . $XDG_DATA_HOME . '/nvim/site/autoload/plug.vim ' . '--create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specify a directory for plugins
call plug#begin($XDG_DATA_HOME.'/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'machakann/vim-sandwich'
Plug 'easymotion/vim-easymotion'
" Plug 'liuchengxu/eleline.vim'
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
" Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'thinca/vim-quickrun'
Plug 'wellle/targets.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" TODO: Check which options are needed for VIM / neovim
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Initialize plugin system
call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Plugin Options                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add spaces after comment delimiters y default
let g:NERDSpaceDelims = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Expand snippets with tab
let g:UltiSnipsExpandTrigger = "<tab>"

" Enable deoplete autocompletion on startup
let g:deoplete#enable_at_startup = 1

" Enable smartcase for vim-easymotion
let g:EasyMotion_smartcase = 1

" Use vim-easymotion for default search
" map  / <Plug>(easymotion-sn)
" nmap / <Plug>(easymotion-tn)
" map n <Plug>(easymotion-next)
" map N <Plug>(easymotion-prev)

" Enable italics for gruvbox theme
let g:gruvbox_italic = 1

" Enable poverline symbols for eleline / vim-airline
let g:eleline_powerline_fonts = 1
let g:airline_powerline_fonts = 1

" Enable vim-airline tabline
let g:airline#extensions#tabline#enabled = 1

" testing rounded separators (extra-powerline-symbols):
" let g:airline_left_sep = "\uE0B4"
" let g:airline_right_sep = "\uE0B6"

" set the CN (column number) symbol:
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

" Increase auto complete deloy for deoplete to avoid slowdown when used with
" Semshi
" TODO: Only apply if Semshi is active
" (deprecated)
" let g:deoplete#auto_complete_delay = 100



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  General                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM should remember
set history=500

" Enable filetype plugins
filetype plugin indent on

" Enable switching from unsaved buffers
set hidden

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
" Requires 'set ignorecase'
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good for performance config)
set lazyredraw

" Show linenumbers
set number

" Always show 2 lines above / below the cursor
set scrolloff=2

" Display incomplete commands"
set showcmd

" Always dispaly statusline
set laststatus=2

" Always display tabline
set showtabline=2

" Highlight the current line
set cursorline

" Disable auto comments on new lines
set formatoptions-=cro

" Set directories for undo, backup, and swap files
" Due to '//' at the end, the complete path is used as filename to avoid name
" conflicts
call s:EnsureIsDir($XDG_CACHE_HOME.'/nvim/undo')
call s:EnsureIsDir($XDG_CACHE_HOME.'/nvim/backup')
call s:EnsureIsDir($XDG_CACHE_HOME.'/nvim/swap')
let &undodir=$XDG_CACHE_HOME.'/nvim/undo//'
let &backupdir=$XDG_CACHE_HOME.'/nvim/backup//'
let &directory=$XDG_CACHE_HOME.'/nvim/swap//'

" Persistent undo
set undofile

" Show the effects of a command incrementally, as you type
set inccommand=nosplit

" Use four spaces for indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Enable mouse support for all modes
set mouse=a

" Remove trailing whitespace on save
autocmd! BufWritePre " :%s/\s\+$//e

" Reload buffer when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" Hide line numbers in terminal
augroup TerminalGroup
  au!
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen * startinsert
augroup END

" Makes the space at the end of the line accessible to cursor movements in
" visual block mode
set virtualedit=block


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Colors                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable truecolor support
set termguicolors

" Use dark colorscheme
set background=dark

" Set colorscheme
" colorscheme gruvbox
colorscheme codedark



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Keybindings                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" General

" Set mapleader to SPACE
let mapleader = "\<space>"

" Map semicolon to colon
" nnoremap ; :

" Save the current buffer
nnoremap <leader>w :w<cr>

" Quit the current buffer
nnoremap <leader>q :q<cr>

" Save and quit VIM
nnoremap <leader>wq :wq<cr>

" Yank to the systems clipboard (" register)
xnoremap <leader>y "+y

" Paste from the systems clipboard (" register)
xnoremap <leader>p "+p

" Open netrw
nnoremap <leader>f :Explore<cr>

" Remove search highlight
nnoremap <leader>c :nohlsearch<CR>

" Go to mark
nnoremap <leader>m `

" Go to any linenumber by typing it and pressing enter
nnoremap <CR> G

" Relaod $MYVIMRC
nnoremap <silent> <leader>r :source $MYVIMRC<cr>



"" Windows

" Move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (a:key == 'h')
      vnew
    elseif (a:key == 'j')
      below new
    elseif (a:key == 'k')
      new
    elseif (a:key == 'l')
      rightbelow vnew
    endif
  endif
endfunction



"" Tabs

nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt



"" Folding

" nnoremap <expr> <Tab> foldclosed('.') != -1 ? 'zo' : 'zc'
nnoremap <Tab> za
nnoremap <A-Tab> zM

"" fzf
nnoremap <C-s> :Lines<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               netrw Options                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable directory banner
let g:netrw_banner = 0

" Display directory structure as tree
let g:netrw_liststyle = 3

" Set netrw window size to 25%
let g:netrw_winsize = 25

" Hide hidden files by default
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex
let g:netrw_hide=1

" Disable caching of directory listenings to avoid hidden buffers
let g:netrw_fastbrowse=0



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Filetype specific options                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au BufNewFile,BufRead /*.rasi setf css



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            vimrc custom folding                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Source: https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file
function! VimFolds(lnum)
  let s:thisline = getline(a:lnum)
  if match(s:thisline, '^"" ') >= 0
    return '>2'
  endif
  if match(s:thisline, '^""" ') >= 0
    return '>3'
  endif
  let s:two_following_lines = 0
  if line(a:lnum) + 2 <= line('$')
    let s:line_1_after = getline(a:lnum+1)
    let s:line_2_after = getline(a:lnum+2)
    let s:two_following_lines = 1
  endif
  if !s:two_following_lines
      return '='
    endif
  else
    if (match(s:thisline, '^"""""') >= 0) &&
       \ (match(s:line_1_after, '^"  ') >= 0) &&
       \ (match(s:line_2_after, '^""""') >= 0)
      return '>1'
    else
      return '='
    endif
  endif
endfunction

function! VimFoldText()
  " handle special case of normal comment first
  let s:info = '('.string(v:foldend-v:foldstart).' lines)'
  if v:foldlevel == 1
    let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
  elseif v:foldlevel == 2
    let s:line = '   ●  '.getline(v:foldstart)[3:]
  elseif v:foldlevel == 3
    let s:line = '     ▪ '.getline(v:foldstart)[4:]
  endif
  if strwidth(s:line) > 80 - len(s:info)
    return s:line[:79-len(s:info)+len(s:line)-strwidth(s:line)].s:info
  else
    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  endif
endfunction


" set foldsettings automatically for vim files
augroup fold_vimrc
  autocmd!
  autocmd FileType vim
                   \ setlocal foldmethod=expr |
                   \ setlocal foldexpr=VimFolds(v:lnum) |
                   \ setlocal foldtext=VimFoldText() |
                   \ setlocal fillchars:fold:\ |
                   \ set foldcolumn=3 " foldminlines=2
augroup END



