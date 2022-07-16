set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch        " incremental searching
set laststatus=2     " always display the status line
set autowrite        " automatically :w before running commands
" set cursorline
set encoding=utf8
highlight LineNr ctermfg=grey
filetype plugin on

set autoindent
set smartindent

set autoread
set autowrite


" Softtabs
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make it obvious where 100 characters is
set textwidth=100
set colorcolumn=+1

" Use one space, not two, after punctiation.
set nojoinspaces

" Numbers
set number
set relativenumber
set numberwidth=5


" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Autocomplete with dictionary owrds when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

call plug#begin()

  "Nerd tree
  Plug 'preservim/nerdtree'

  "Dracula theme
  Plug 'Mofiqul/dracula.nvim'

  " FZF.vim
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " COCVim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Vim Fugitive
  Plug 'tpope/vim-fugitive'

  " GitGutter
  Plug 'airblade/vim-gitgutter'

  " Vim close tag
  Plug 'alvan/vim-closetag'

  " Lightline
  Plug 'itchyny/lightline.vim'

  " Vim easymotion
  Plug 'easymotion/vim-easymotion'

  " Github copilot
  Plug 'github/copilot.vim'

  " Nvim treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Devicons
  Plug 'ryanoasis/vim-devicons'


call plug#end()

" Copy to clipboard
set clipboard=unnamed

set lazyredraw
set termguicolors

set background=dark

colorscheme dracula

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Remove highlights
map <C-c> :nohl<CR>

" VSCode like keymappig
imap <C-s> <Esc>:write<CR>
nmap <C-s> :write<CR>
command! VisualBlock execute "normal! \<C-v>"
imap <C-v> <Esc>:VisualBlock<CR>
nmap <C-v> :VisualBlock<CR>

" NERD tree configuration
nmap <C-b> :NERDTreeToggle<CR>
imap <C-b> <Esc> :NERDTreeToggle<CR>
nmap nf :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeWinSize=60

" fzf
noremap <C-p> :Files<CR>
noremap ` :Buffers<CR>

" Use tab with text block
vmap <Tab> >gv
vmap <S-Tab> <gv

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" coc.vim config
" Remap keys for gotos
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> rn <Plug>(coc-rename)

" Use `:Format` to format current buffer
command! -nargs=0 Format :CocCommand prettier.forceFormatDocument

nmap <C-f> :Format <CR>

" Apply AutoFix to problem on the current line.
nmap <leader>fc  <Plug>(coc-fix-current)

" Easymotion
" s{char}{char} to move to {char}{char} over windows
nmap <Leader>F <Plug>(easymotion-overwin-f)
" Move to line over windows
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Search n-chars
map / <Plug>(easymotion-sn)

" Apply AutoFix to problem on the current line.
nmap <leader>fc  <Plug>(coc-fix-current)

" Easymotion
" s{char}{char} to move to {char}{char} over windows
nmap <Leader>F <Plug>(easymotion-overwin-f)
" Move to line over windows
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Search n-chars
map / <Plug>(easymotion-sn)

" Lightline
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo', 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }


" fzf.vim
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <silent> <leader>c} V}:call NERDComment('x', 'toggle')<CR>
nnoremap <silent> <leader>c{ V{:call NERDComment('x', 'toggle')<CR>

" Auto close tag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:jsx_ext_required = 0
let g:closetag_enable_react_fragment = 1

" GitGutter fix error for windows
let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'

