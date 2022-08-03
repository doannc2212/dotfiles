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
set cursorline
set encoding=utf8
set ff=unix 
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

" Use one space, not two, after punctualtation.
set nojoinspaces

" Numbers
set number
set relativenumber
set numberwidth=5


" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

call plug#begin()

  "Nerd tree
  Plug 'preservim/nerdtree'
  
  " Nerd tree git plugin
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " NERDTree syntax highlight
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  " Prisma
  Plug 'pantharshit00/vim-prisma'

  " Tokyo Night theme
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

  " FZF.vim
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Ag.vim
  Plug 'rking/ag.vim'

  " COCVim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Vim Fugitive
  Plug 'tpope/vim-fugitive'

  " Vim commentary
  Plug 'tpope/vim-commentary'

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

let g:tokyonight_style = "storm"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

let g:tokyonight_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
  \ }

colorscheme tokyonight


imap jj <Esc>

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
autocmd VimEnter * NERDTree | wincmd p

" fzf
noremap <C-p> :GFiles<CR>
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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Remap keys for gotos
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g` :CocDiagnostics <CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> rn <Plug>(coc-rename)

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

command!  EslintShow :CocCommand eslint.showOutputChannel

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

nmap <C-f> :Prettier <CR>

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Easymotion
" s{char}{char} to move to {char}{char} over windows
nmap <Leader>F <Plug>(easymotion-overwin-f)
" Move to line over windows
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Search n-chars
map / <Plug>(easymotion-sn)

" Lightline
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
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

let g:ag_working_path_mode="r"

" Auto close tag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:jsx_ext_required = 0
let g:closetag_enable_react_fragment = 1

" GitGutter fix error for windows
let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'

" Viminimap Config
let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" vim commentary
autocmd FileType xml,html setlocal commentstring=<!--%s--> # here %s is the content wrapped by comment strings
autocmd FileType tsx,jsx setlocal commentstring={/* %s */} # here %s is the content wrapped by comment strings
