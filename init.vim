" Neovim configuration file

" ============================================================ Display settings =======


" allow change of colors
set termguicolors " bg color = #0b032e
colorscheme evening
" Display colors and cursor stuff

function! WinhlChange(higroup, hischeme)
    let current_winhl = &winhl
    let winhl_list = split(current_winhl, ',') 
    let new_winhl = []
    let found = 0

    for entry in winhl_list
        if entry =~# '\<' . a:higroup . ':'
            let found = 1
            call add(new_winhl, a:higroup . ':' . a:hischeme)
        else
            call add(new_winhl, entry)
        endif
    endfor
    
    if found == 0
        call add(new_winhl, a:higroup . ':' . a:hischeme)
    endif
    let new_winhl_string = join(new_winhl, ',')
    execute 'setlocal winhl=' . new_winhl_string
endfunction




hi LineInsert guibg=#0b032e guifg=#3c11ff
hi LineNormal guibg=#1b1633 guifg=#6c6781
hi winReadOnly guibg=#081701 ctermbg=none
hi winOutFocus guibg=#000000 ctermbg=none
hi winNormal guibg=none ctermbg=none

set nu
augroup numberBar
    autocmd!
    autocmd BufEnter,WinEnter,InsertLeave * setl rnu | :call WinhlChange('LineNr', 'LineNormal')
    autocmd insertEnter  *  setl nornu | :call WinhlChange('LineNr', 'LineInsert')
    autocmd WinLeave * setl nornu | :call WinhlChange('LineNr', 'LineNormal')
augroup END
set cursorline

augroup winStates
	autocmd!
	autocmd WinEnter,BufEnter,FocusGained * :call WinhlChange('Normal', 'winNormal')
	autocmd WinEnter,BufEnter,FocusGained * if &readonly | :call WinhlChange('Normal','winReadOnly') | endif
	autocmd WinLeave,Bufleave,FocusLost * :call WinhlChange('Normal', 'winOutFocus')
augroup END

hi Normal guibg=none ctermbg=none
hi Pmenu   guibg=#50438e 
hi PmenuSel  guibg=#3026c7 gui=bold 
hi PmenuSbar guibg=#b580ef 

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

" copy to clipboard
vnoremap <C-c> "+y

" Comfy shortcuts
nnoremap <CR> O<Esc>
nnoremap !h :noh<CR>
nnoremap !n :set nu!<CR>
nnoremap !r :set rnu!<CR>

" easier buffer navigation
noremap <Left> :bp<CR>
noremap <Right> :bn<CR>
noremap <C-B> :bd<CR>

" easier window navigation
nnoremap <C-w><C-j> <C-w>s
nnoremap <C-w><C-l> <C-w>v
nnoremap <C-w><C-w> <C-w>q

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-Left> 5<C-w><
nnoremap <C-Right> 5<C-w>>
nnoremap <C-Down> 3<C-w>-
nnoremap <C-Up> 3<C-w>+

" easier vertical navigation with numbers
" nnoremap 1 :1<CR>

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



