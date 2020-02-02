" https://dougblack.io/words/a-good-vimrc.html
" https://www.youtube.com/watch?v=XA2WjJbmmoM&t=408s
" https://stackoverflow.com/questions/23012391/how-and-where-is-my-viminfo-option-set

" Misc {{{
set nocompatible            " Disable Vi compatibility
set viminfo=%,<500,'1000,/50,:100,h,f1,n~/.vim/cache/viminfo
"           | |    |     |   |    | |  + viminfo file path
"           | |    |     |   |    | + file marks 0-9,A-Z 0=stored
"           | |    |     |   |    + disable 'hlsearch' loading viminfo
"           | |    |     |   + command-line history saved
"           | |    |     + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list
set bs=2                    " same as ":set backspace=indent,eol,start"
" }}}

" Colours {{{
colorscheme badwolf
syntax enable			    " enable syntax processing
" Show trailing whitepace and spaces before a tab:
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
" }}}

" Spaces & Tabs {{{
set tabstop=4    		    " number of visual spaces per TAB
set shiftwidth=4            " how many columns text is indented with the reindent operations (<< and >>)
set softtabstop=4           " number of spaces in tab when editing
set expandtab               " tabs are spaces
" }}}

" UI config {{{
set number			        " show line numbers
set showcmd                 " show command in bottom bar
set cursorline              " highlight current line
filetype indent on          " load filetype-specific indent files
set wildmenu                " visual autocomplete for command menu
"set lazyredraw              " redraw only when we need to.
set showmatch               " highlight matching [{()}]
"set ruler                   " shows line and column number in bottom right
set laststatus=2            " always display status line
set statusline+=%F          " show current file in status line
set statusline+=\ -\        " Separator
set statusline+=FileType:   " Label
set statusline+=%y          " Filetype of the file
set statusline+=%=          " remaining status line is right-aligned
set statusline+=%4l         " Current line
set statusline+=/           " Separator
set statusline+=%L          " Total lines
set statusline+=\ \:\       " Separator
set statusline+=%2c         " Show column number
" }}}

" Searching {{{
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
set path+=**                " Search down in to subfolders, provide tab completion for all file-related tasks
set wildmenu                " Display all matching files when we tab complete
" }}}

" Folding {{{
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" highlight last inserted text
nnoremap gV `[v`]
" }}}

" Leader Shortcuts {{{
let mapleader=","       " leader is comma
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" }}}

" Autogroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    "    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    "            \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" }}}

" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Custom Functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
