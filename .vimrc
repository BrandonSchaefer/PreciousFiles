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
set tabstop=4
set shiftwidth=4

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
 
colorscheme cleanphp
"colorscheme tabula
" co lorscheme sand
" co lorscheme moss
"col orscheme elflord
"col orscheme koehler

:nnoremap <F2> :setlocal spell spelllang=en_us
:nnoremap <F1> <Esc>
:imap <F1> <Esc>
:map <F1> <Esc>

:imap jj <Esc>
:imap jJ <Esc>

" Saves the use of ';' but need to hit it twice
noremap ;; ;
map ; :

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

" Map leader key SPACE
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

" Turn off and on line number
"nmap <leader>n :set nu<cr>
"nmap <leader>m :set nu!<cr>

:set hlsearch

set laststatus=2
autocmd BufRead,BufNewFile *.qml setfiletype qml
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile *.capnp set filetype=capnp

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

set so=7

set wildignore=*.o,*~,*.pyc

nmap <leader>n :tabe <C-R>0<cr>

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Where i store my tags
set tags+=~/.tags/tags
set tags+=~/.tags/include_tags

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
   set pastetoggle=<Esc>[201~
   set paste
return ""
endfunction
