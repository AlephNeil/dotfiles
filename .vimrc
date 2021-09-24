" This is my vimrc file!

" Part 1: Vim-Plug and filetype

set nocompatible
set showcmd
set shortmess=I
set mouse=a
set splitbelow

set t_Co=256

filetype off

call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'ton/vim-bufsurf'
Plug 'julialang/julia-vim'

Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ajh17/Spacegray.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'PProvost/vim-ps1'
Plug 'digitaltoad/vim-pug'
Plug 'plasticboy/vim-markdown'
Plug 'hdima/python-syntax'
Plug 'mechatroner/rainbow_csv'
Plug 'dag/vim-fish'
Plug 'mboughaba/i3config.vim'

call plug#end()

syntax enable

let g:pymode_python = 'python3'

" if &term =~ "rxvt" && !has('gui_running')
" 	autocmd ColorScheme * highlight! Normal ctermbg=NONE guibg=NONE
" endif
set background=dark
set nu

if has('gui_running')
	set cursorline
else
	set culopt=number
	set cursorline
	autocmd ColorScheme * highlight! Normal ctermbg=NONE
	autocmd ColorScheme * highlight! LineNr ctermbg=NONE
	autocmd ColorScheme * highlight! CursorLineNr ctermbg=NONE
endif

colors PaperColor

" if has('gui_running') || &term =~ "rxvt"
"     set background=dark
" 	colors PaperColor
" 	set nu
" 	set cursorline
" else
" 	function! NFDie()
" 		if bufnr("$") == 1
" 			qa!
" 		else
" 			qa
" 		endif
" 	endfunction
" 	command! Q call NFDie()
"     colors PaperColor
" endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
			\ 'dir': '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll)$',
			\ }

filetype plugin indent on
"let python_highlight_all = 1

" Part 2: Options

set incsearch nohlsearch
set tildeop
set hidden confirm
set ts=4 sts=4 sw=4
set backspace=indent,eol,start
set wrap linebreak nolist
set foldlevel=20
set noautochdir
if has('wildmenu')
	set wildignore+=*.a,*.o
	set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.wav,*.mp3
	set wildignore+=.DS_Store,.git,.hg,.svn
	set wildignore+=*~,*.swp,*.tmp
	set wildmenu
	set wildmode=longest,list
	set fillchars=vert:\ 
endif
set encoding=utf-8

set completeopt+=preview
let g:ycm_autoclose_preview_window_after_insertion = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Part 3: Remappings

inoremap <C-CR>			<CR><Esc>kA<CR>
" inoremap jj				<Esc>

inoremap <C-j>			<down>
inoremap <C-k>			<up>
inoremap <C-h>			<left>
inoremap <C-l>			<right>

nnoremap <silent> <Space> :noh<Bar>:echo<CR>
nnoremap <CR>			o<Esc>
nnoremap <silent> <F8>	:NERDTreeToggle<CR>
nnoremap <silent> <S-F8> :NERDTreeToggle %:p:h<CR>
nnoremap <F3>			:set hlsearch! <bar> set hlsearch?<CR>
nnoremap <silent> <F2>	:set paste!<CR>
map <F4> :exe "vimgrep /" . expand("<cword>") . "/gj **" <bar> cw<CR>
"nnoremap <F5> :wa<Bar>exe "mksession! " . v:this_session<CR>:so ~/sessions/

xnoremap < <gv
xnoremap > >gv

nnoremap j gj
nnoremap k gk

nnoremap <leader>k		:bd<CR>
noremap <leader>p		"0p
noremap <leader>P		"0P
nnoremap <leader>sm		:set ft=markdown<CR>
nnoremap <leader>sj		:set ft=jinja<CR>

nnoremap <silent> <leader>b :BufSurfBack<CR>
nnoremap <silent> <leader>B :b#<CR>
nnoremap <silent> <leader>f :BufSurfForward<CR>
nnoremap <silent> <leader>gf <c-w>gf
nnoremap <silent> <Leader>d :Bclose<CR>
nnoremap <silent> <Leader>D :Bclose!<CR>
nnoremap <leader>q :<c-u>echo "the count is" v:count<CR>
map      <silent> <leader>q :echo 'I am stupid!'<CR>
onoremap <silent> <leader>% :<c-u>normal! ggVG<CR>
vnoremap <silent> <leader>% G$ogg

nnoremap <Leader>t :term ++close<cr>
tnoremap <Leader>t <c-w>:term ++close<cr>
nnoremap <Leader>T :tab term ++close<cr>
tnoremap <Leader>T <c-w>:tab term ++close<cr>

function! NFTabMove(n, default)
	let i = a:n == 0 ? a:default : (a:n - 1)
	exe "tabmove" i
endfunction
nnoremap <silent> <leader>gt :call NFTabMove(v:count, "+1")<CR>
nnoremap <silent> <leader>gT :call NFTabMove(v:count, "-1")<CR>

function! NFRotate(n)
	let i = (winnr() - 1 + a:n) % winnr('$')
	exe "" . (i+1) . "wincmd w"
endfunction
nnoremap <silent>	<leader>j :call NFRotate(1)<CR>
nnoremap <silent>	<leader>J :call NFRotateBack(-1)<CR>

nnoremap			<leader>e 0v$hy:<c-r>"<CR>

"behave mswin

vnoremap <BS> d

vnoremap <S-Del> "+x
vnoremap <C-Insert> "+y
nnoremap <S-Insert> "+gP
inoremap <S-Insert> <C-C>"+gP
vnoremap <S-Insert> "+p
cnoremap <S-Insert> <C-R>+

noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" AUTOCMDS galore

function! NF_AllTabSizes(size)
	exe 'setlocal sw='.a:size.' ts='.a:size.' sts='.a:size
endfunction

"au FileType html setlocal sw=2 ts=2 sts=2
"au FileType php setlocal sw=2 ts=2 sts=2
"au FileType jinja setlocal sw=2 ts=2 sts=2
au BufRead,BufNew *.wsgi set ft=python
au FileType html :call NF_AllTabSizes(2)
au FileType php :call NF_AllTabSizes(2)
au FileType jinja :call NF_AllTabSizes(2)
au FileType jinja let b:match_words = '<:>,<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,{%:%},{#:#},{{:}},\%({% \)\@<=if:\%({% \)\@<=else:\%({% \)\@<=endif,\%({% \)\@<=block:\%({% \)\@<=endblock,\%({% \)\@<=macro:\%({% \)\@<=endmacro,\%({% \)\@<=raw:\%({% \)\@<=endraw,\%({% \)\@<=for:\%({% \)\@<=endfor'
" au FileType jinja let b:match_words = '<:>,<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,{%:%},\%({% \)\@<=if:\%({% \)\@<=else:\%({% \)\@<=endif,\%({% \)\@<=\([a-z]\+\>\):\%({% \)\@<=end\1'

au FileType markdown iab <buffer> h4 ####
au FileType markdown nnoremap <buffer> <leader>u yypVr
au FileType markdown setlocal textwidth=80
au FileType markdown normal zR

au FileType python setlocal expandtab
au FileType python iab <buffer> mPG methods=['GET', 'POST']
au FileType python setlocal foldmethod=indent
au FileType python setlocal ts=4 sts=4 sw=4

" More fun and games!
au FileType * setlocal formatoptions-=r formatoptions-=o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -nargs=1 -complete=dir NFProjOpen exe 'cd ' . <q-args> . ' |so Session.vim'
nnoremap <leader>po :NFProjOpen 
nnoremap <leader>px :mks!<bar>qa<CR>
nnoremap <leader>m :set ft=markdown<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au FileType jinja iab GLY class="glyphicon glyphicon
au FileType jinja nnoremap <leader>sj :s/JJ\([A-Za-z0-9-]\+\)/{{ \1 }}/g<CR>
cabbr <expr> %% expand('%:p:h')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <Plug>o ^y0o<Esc>D"0pA
nmap <leader>o <Plug>o
" au FileType markdown imap <S-CR> <Esc><Plug>o
imap <S-CR> <Esc><Plug>o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <C-m> gcc
vmap <C-m> <Plug>Commentary


" VIM-AIRLINE

let g:airline_powerline_fonts = 1
let g:airline_section_b = '%{getcwd()}'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
" let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
" let g:airline#extensions#tabline#show_tabs = 0
" let g:airline_symbols.maxlinenr = 'Ξ'
let g:airline_theme = 'onedark'

let g:airline_symbols = get(g:, 'airline_symbols', {})

let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.whitespace = 'Ξ'

" let g:airline_symbols.linenr = 'X'

" JULIA-VIM

let g:latex_to_unicode_auto = 1
