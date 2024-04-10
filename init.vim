"Use Vim settings, rather then Vi settings (much better!).
set nocompatible

"Plug-ins
"load ftplugins and indent files
filetype plugin on
filetype indent on

"setup plug-installed plug-ins
call plug#begin()

" neovim-specific plug-ins
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'
Plug 'mfussenegger/nvim-lint'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

" Auto Pairs
Plug 'jiangmiao/auto-pairs'

" Surround
Plug 'tpope/vim-surround'

" GitGutter
Plug 'airblade/vim-gitgutter'

" Fugitive
Plug 'tpope/vim-fugitive'

" Make Fugitive use Github
Plug 'tpope/vim-rhubarb'

" Golang
Plug 'fatih/vim-go'

" Vim Polyglot - language support
Plug 'sheerun/vim-polyglot'

" Terraform
Plug 'hashivim/vim-terraform'

" Ansible
Plug 'pearofducks/ansible-vim'

" Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'

" The NERD tree
Plug 'preservim/nerdtree'

" NERD tree Git plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" Atom One Dark / Light colourscheme
Plug 'rakr/vim-one'

"backup vim color schemes from old vimfiles
"Plug 'flazz/vim-colorschemes'

" distraction-free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" presentation mode
Plug 'sotte/presenting.vim'

"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Vim-indent-guides
Plug 'nathanaelkane/vim-indent-guides'

" Ctrl-P Atom-like fuzzy file search
Plug 'ctrlpvim/ctrlp.vim'

" Asynchronous task dispatcher
Plug 'tpope/vim-dispatch'

" ALE linter
Plug 'dense-analysis/ale'

call plug#end()

" neovim-specific plug-in configs
" ray-x/go
lua <<EOF
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require('go').setup()
EOF



" Display and UI Settings
set background=dark
set t_Co=256
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"use Atom's One (Dark/Light) colourscheme
let g:AirlineTheme='one'
"use the ron colorscheme if one is unavailable
silent! colorscheme ron
silent! colorscheme one

"show incomplete cmds down the bottom
set showcmd
"show current mode down the bottom
set showmode
"show line numbers
set number
" Highlight current line and column
set cursorline
"show ruler
set ruler
"use visual bell instead of beep
set visualbell

"indent guides using vim-indent-guides plugin
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"store lots of :cmdline history
set history=1000
"display trailing spaces
set list
set listchars=tab:\ \ ,trail:⋅,nbsp:⋅
"don't wrap lines
set wrap
set linebreak
set nolist
"mark the ideal max text width
set colorcolumn=+1
"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1
"turn on syntax highlighting
syntax on
"hide buffers when not displayed
set hidden

"enable Limelight and other settings
"when using Goyo for distraction-free writing
function! s:goyo_enter()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set noshowmode
    set noshowcmd
    set laststatus=0
    set scrolloff=999
    set shortmess=F
    Limelight
endfunction

function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Font Settings
set guifont=Ubuntu\ Mono\ 12



" Formatting Settings
"allow backspacing over everything in insert mode
set backspace=indent,eol,start
set textwidth=0
"default indent settings
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent



" Search and Find Settings
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default



" Undo Settings
if has("win32")
    set undodir=~/vimfiles/undofiles
else
    set undodir=~/.vim/undofiles
endif



" Language-Specific Settings
"enable fmt automatically when saving terraform or Go files
" terraform from: https://github.com/hashivim/vim-terraform
let g:terraform_fmt_on_save=1
" Go from: https://github.com/fatih/vim-go
let g:go_fmt_autosave=1



" System + OS Settings
"mouse work in terminal
set mouse=a
"setup clipboard for Mac OS
set clipboard=unnamed
"disable swapfile
set noswapfile
"make cmdline tab completion similar to bash
set wildmode=list:longest
"enable ctrl-n and ctrl-p to scroll thru matches
set wildmenu
"ignore the following when tab completing
set wildignore=*.o,*.obj,*~


" Key Mappings
" General - Built-ins
"yank to end of line (not including \n)
nnoremap Y y$
"auto-reindent
nnoremap <F10> :%retab<CR>
"scroll sync toggle
nnoremap <F11> scb!
"paste mode
set pastetoggle=<F12>
"forcefully write using sudo tee
cmap w!! w !sudo tee >/dev/null %

" Plug-ins
"ctrlp mapping to ctrl-t like Atom
let g:ctrlp_map = '<c-t>'
let g:ctrlp_cmd = 'CtrlP'
"toggle NerdTree
nnoremap <c-e> :NERDTreeToggle<CR>
nnoremap <F9> :NERDTreeToggle<CR>



" Plug-in Settings
"NERDTree
" Start NERDTree if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Force NERDTree to show hidden files
let NERDTreeShowHidden=1
" NERDTree ignore .pyc files
let NERDTreeIgnore = ['\.pyc$']
" NERDTree Minimal UI
let NERDTreeMinimalUI=1
" NERDTree Minimal Menu until github.com/preservim/nerdtree/issues/1321 is
" resolved
let NERDTreeMinimalMenu=1
" disable auto-collapsing dirs that have only one child
let NERDTreeCascadeSingleChildDir=0

" ctrlp
" ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']



" Functions and AutoCMDs
"jump to last cursor position when opening a file
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd FileType svn,*commit* setlocal spell
"spell check for Markdown files
autocmd FileType markdown setlocal spell

"adjust tabbing for puppet yaml files
autocmd FileType puppet,yaml setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

"adjust tabbing for Makefiles
"in makefiles, don't expand tabs to spaces, since actual tab characters are
"needed, and have indentation at 4 chars to be sure that all indents are tabs
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0

"Vagrant syntax highlighting as ruby
augroup vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END

" compile LaTeX as PDF on save
augroup latex
    autocmd!
    autocmd BufEnter *.tex let b:dispatch='pdflatex %'
    autocmd BufWrite *.tex Dispatch!
augroup END

" compile PlantUML files to PNG on write
augroup plantuml
    autocmd!
    autocmd BufWritePost *.puml !PLANTUML_LIMIT_SIZE=100000 plantuml <afile>
augroup END

" validate circleci config.yml files on write
augroup yaml_circleci
    autocmd!
    autocmd BufWritePost .circleci/config.yml !circleci --token $CIRCLE_TOKEN --org-slug github/$GH_ORG config validate <afile>
augroup END

" turn on cursorcolumn for yaml files
augroup yaml
    autocmd!
    autocmd InsertEnter *.{yaml,yml} set cursorcolumn
    autocmd InsertLeave *.{yaml,yml} set nocursorcolumn
augroup END

" auto fix YAML via ALE
"let g:ale_fix_on_save = 1
"let g:ale_fixers = {'yaml': ['yamllint']}
"let g:ale_pattern_options = {'\.tf$': {'ale_enabled': 0}}


" automatically set paste when pasting in insert mode
" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

" format and unformat JSON
command JSONfmt :%!jq .
command JSONunfmt :%!jq -c .


"tmp

set formatoptions-=o "dont continue comments when pushing o/O
