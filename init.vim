" config file for neovim


" ============================================================ Display settings =======


" allow change of colors
set termguicolors " bg color = #0b032e

" Display colors and cursor stuff
set relativenumber
set cursorline

hi Pmenu   guibg=#50438e 
hi PmenuSel  guibg=#3026c7 gui=bold 
hi PmenuSbar guibg=#b580ef 
hi Normal guibg=none ctermbg=none
hi LineNr guibg=#1b1633 guifg=#6c6781
hi CursorLineNr cterm=bold guibg= guifg=#e6e5ea
hi CursorLine guibg=#231c42
"hi _myCursor guibg=#ff0000 guifg=#00ffff 
"set guicursor=n-v-c-sm:_myCursor,i-ci-ve:ver25,r-cr-o:hor20


" ============================================================ use other scripts =======

" launch init.lua for plugins
source ~/.config/nvim/scripts/init.lua

" ============================================================ Keybindings =======


" For the leader key (shortcut for commands)
map <Space> <Leader>

" leave insert mode
inoremap jj <Esc>

" Comfy shortcuts
nnoremap <CR> O<Esc>
nnoremap !h :noh<CR>


" easier buffer navigation
nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>


" easier window navigation
nnoremap <C-w><C-j> <C-w>s
nnoremap <C-w><C-l> <C-w>v
nnoremap <C-w><C-w> <C-w>q

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-q> 5<C-w><
nnoremap <C-d> 5<C-w>>
nnoremap <C-s> 3<C-w>-
nnoremap <C-z> 3<C-w>+



" easier macros
noremap ² @

" Easier numbers
" nnoremap <silent> à 0
" nnoremap <silent> & 1
" nnoremap <silent> é 2
" nnoremap <silent> " 3
" nnoremap <silent> ' 4
" nnoremap <silent> ( 5
" nnoremap <silent> - 6
" nnoremap <silent> è 7
" nnoremap <silent> _ 8
" nnoremap <silent> ç 9
" 
" nnoremap <silent> 0 à
" nnoremap <silent> 1 &
" nnoremap <silent> 2 é
" nnoremap <silent> 3 "
" nnoremap <silent> 4 '
" nnoremap <silent> 5 (
" nnoremap <silent> 6 -
" nnoremap <silent> 7 è
" nnoremap <silent> 8 _
" nnoremap <silent> 9 ç

" Easier sentences/paragraphs
" nnoremap <silent> ) (
" nnoremap <silent> = )
" nnoremap <silent> ° {
" nnoremap <silent> + }



