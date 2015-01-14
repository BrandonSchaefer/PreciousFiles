" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set showmatch		" Show matching brackets.

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


" For unity
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2

" For compiz 4/8
" set tabstop=8
" set shiftwidth=8
" set formatoptions=croqlt
" set ts=8
" set softtabstop=4
" set shiftwidth=4
" set cindent
" set tw=80
" set cino=(0,t0

" Removes whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Removes trailing whitespace in files on a :w
autocmd BufWritePre *.py :%s/\s\+$//e

colorscheme elflord

:nnoremap <F2> :setlocal spell spelllang=en_us
:nnoremap <F1> <Esc>
:imap <F1> <Esc>
:map <F1> <Esc>

:imap jj <Esc>
:imap jJ <Esc>

nnoremap ; :
vnoremap ; :

" Highlights trailing shitspace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

imap [o printf("\n");<ESC>4hi
map [o iprintf("\n");<ESC>4hi

" Allows saving with root premision
cmap  w!! %!sudo tee > /dev/null %

noremap <F1> <Esc>

" Impoves Ctrl+P
let ctrlp_filters_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jepg|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ "deploy/|lib/|classes/|libs/|devploy/|vendor/|.git/|.hg/|.svn/|.*migrations/" .
    \ ")'"

let my_ctrlp_git_command = "" .
    \ "cd %s && gi ls-files | " .
    \ ctrlp_filters_greps

if has("unix")
    let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type 1 ')' -maxdepth 1$ -not -path '*/\\.*/*' | " .
    \ ctrlp_filters_greps
endif

let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]

" :W becomes :w
cnoreabbrev W w

" Keep visual block while indent
vnoremap < <gv
vnoremap > >gv

" Make y act like other cap
map Y y$

" Map leader key '
let mapleader = "\<Space>"

" Simple save/save quit
nmap <leader>w :w<cr>
nmap <leader>wq :wq<cr>

" Skip to the end of the line when y/p
" TESTING not sure if i want this
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Arrow keys change tabs
:noremap <left> :tabprevious<CR>
:noremap <right> :tabnext<CR>


" diff current vi buff vs edits against orig file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

com! DiffSaved call s:DiffWithSaved()

" nmap <silent><leader>d :DiffSaved<cr>
" nmap <leader>e :diffoff<cr>:q!<cr>

" Turn off and on line number
nmap <leader>n :set nu<cr>
nmap <leader>m :set nu!<cr>

set hlsearch

set laststatus=2
