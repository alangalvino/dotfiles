"Repeat search with 'S' and 's'
nnoremap s n
nnoremap S N

"to the last non-blank character of a line with 'L' and 'N'
nnoremap L g_
nnoremap N g_
vnoremap L g_
vnoremap N g_

"to the beginning of line with 'H'
vnoremap H 0
nnoremap H 0

"remap change word to 'C' (capital 'c')
nnoremap C c

"remap movement keys to htcn (dvorak)
nnoremap c k
nnoremap n l
nnoremap t j

"Ctrl + y as yank
nnoremap <C-y> p
vnoremap <C-y> p
inoremap <C-y> <Space><Esc>gPi

"Ctrl + y as yank
nnoremap <C-h> X
vnoremap <C-h> x

"Ctrl + g as ESC
nnoremap <C-g> <Esc>
vnoremap <C-g> <Esc>
inoremap <C-g> <Esc>
cmap <C-g> <Esc>

"Search with case insensitive
set ignorecase
