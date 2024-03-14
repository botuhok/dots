" vim config with autocomplete (coc.nvim)
" 22/02/2024
" by astat
"
"
"
" ::: COC.VIM ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
" K                                  - information about word under cursor
" Space+a                            - show all errors in code
" Space+ac                           - fix code under cursor
" :CocList marketplace               - search all available lsp-servers
"
" ::: OTHER HOTKEYS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
" Ctrl+Up, Ctrl+Down                 - MULTICURSOR
" Ctrl+n                             - find word under cursor and multiedit
" Ctrl+p                             - open filesystem finder!
" Space+n                            - NERDTreeToggle
" Space+m                            - built-in filemanager
" Ctrl+k, Ctrl +j in visual mode     - move selected lines up/down
" Space+u                            - undotree (git analog)
" F5                                 - Compile and Run
" F8                                 - Debug (GDB)
" F6                                 - Compile and Run (stdin from test file)
" :Hexmode      - open hex editor
"

syntax on                       "syntax highlighting, see :help syntax
set encoding=UTF-8
filetype plugin indent on       "file type detection, see :help filetype

set expandtab
set autoindent
set smartindent
" set clipboard=unnamedplus          " use system clipboard
set textwidth=0                    " отключить автоперенос строк
set tabstop=2
set softtabstop=2
set shiftwidth=2

"""""""""""""""""""""""""""""""""" Отступы для разных типов файлов
au BufRead,BufNewFile *.py,*pyw set tabstop=4

au BufRead,BufNewFile *.py,*pyw set softtabstop=4
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

set nocompatible
set number                      "display line number
set relativenumber              "display relative line numbers
set path+=**                    "improves searching, see :help path
set noswapfile                  "disable use of swap files
set wildmenu                    "completion menu
set backspace=indent,eol,start  "ensure proper backspace functionality
set undodir=~/.cache/nvim/undo  "undo ability will persist after exiting file
set undofile                    "see :help undodir and :help undofile
set undolevels=10000            " maximum number of changes that can be undone
set undoreload=100000           " maximum number lines to save for undo on a buffer reload
set hls                         " выделять найденные элементы
set incsearch                   "see results while search is being typed, see :help incsearch
set smartindent                 "auto indent on new lines, see :help smartindent
set ic                          "ignore case when searching
" set colorcolumn=80            "display color when line reaches pep8 standards
set showmatch                   "display matching bracket or parenthesis
set hlsearch incsearch          "highlight all pervious search pattern with incsearch
set scrolloff=8                 " за сколько строк до края начинать скролить

set termguicolors     " enable true colors support
" highlight ColorColumn ctermbg=9 "display ugly bright red bar at color column number

command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" Статусная строка.
" set laststatus=2
" set statusline=%1*\ %f%m%r%h%w\%=%([%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y]%)\ %([%l,%v][%p%%]\ %)



""""""""""""""""""""""""""""""""""""""""""""""""""""""" КУРСОР
let &t_SI.="\e[5 q" "SI = режим вставки
let &t_SR.="\e[3 q" "SR = режим замены
let &t_EI.="\e[2 q" "EI = нормальный режим
"Где 1 - это мигающий прямоугольник
"2 - обычный прямоугольник
"3 - мигающее подчёркивание
"4 - просто подчёркивание
"5 - мигающая вертикальная черта
"6 - просто вертикальная черта

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"::::::::::::::::::::::::::::::::: PLUGINS
"::::::::::::::::::::::::::::::::::
" AUTOINSTALL VIM-PLUG 
"""""""""""""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()
    " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
      Plug 'junegunn/vim-easy-align'

    " colorschemes
      Plug 'rose-pine/vim'

    " Plug 'vim-airline/vim-airline'
    "
    " Поиск файлов по всей файловой системе
      Plug 'kien/ctrlp.vim'

    " VIM ICONS FOR FILEMANAGER
      Plug 'ryanoasis/vim-devicons'

    " filemanager
      Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

    "Hex editor (:Hexmode)
      Plug 'fidian/hexmode'

    " VIM COLORSCHEMES
      Plug 'rafi/awesome-vim-colorschemes'

    "VIM MULTICURSOR
      " C-n   - add cursor at word
      " A-n   - add cursor at all this words
      Plug 'terryma/vim-multiple-cursors'

    " C-<up> or C-<Down> to add multiline cursor
      Plug 'mg979/vim-visual-multi'           " мультикурсор

    " VIM-SURROUND
      "   cs (] - change () to []
      "   ysiW' - add ''
      "   ys3w' - add ''
      "   ds '  - remove ''
      Plug 'tpope/vim-surround'

    " VIM-COMMENTARY
      " gcc to comment out a line (takes a count), gc to comment out the target of a motion
      Plug 'tpope/vim-commentary'

    " Plug 'ervandew/supertab'                " TAB complete

    " AUTOCOMPLETE
      Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " highlight for c/c++ languages
      Plug 'jackguo380/vim-lsp-cxx-highlight'

    " Plugin outside ~/.vim/plugged with post-update hook
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

    " UndoTree on <leader>u
      Plug 'mbbill/undotree'

call plug#end()


""""""""""""""""""""""""" COC.NVIM SETTINGS
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" FOR VIM LANGUAGE
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" " Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" AUTOINSTALL COC EXTENSIONS
  let g:coc_global_extensions = ['coc-marketplace', 'coc-clangd', 'coc-vimlsp', 'coc-pyright', 'coc-sh']

  " настройка supertab
  " let g:SuperTabDefaultCompletionType = "<c-x><c-f>"
    let g:SuperTabDefaultCompletionType = "context"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :::::::::::::::::::::::::::::::: REMAPS ::::::::::::::::::::::::::::
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

  let mapleader = ' '             " основная горячая клавиша <leader>
  " отключение подсветки после поиска
  nnoremap <leader>, :nohlsearch<CR>

  " включение файлового менеджера. nnoremap - нормальный режим             
  nnoremap <leader>m :Vex<CR>     
  nnoremap <leader>n :NERDTreeToggle<CR>
  let NERDTreeShowHidden=1

  " выравнивание окон, когда экран разделён
  noremap <silent> <leader><Left> :vertical resize +3<CR>
  noremap <silent> <leader><Right> :vertical resize -3<CR>
  noremap <silent> <leader><Up> :resize +3<CR>
  noremap <silent> <leader><Down> :resize -3<CR>

  " заменяет слово под курсором скопированным буфером
  nnoremap S diw"0P

  """"""""" Работа с вкладками.
  " Открываем новую по Ctl+T и закрываем по Ctrl+W.
  nmap <C-t> :tabnew<CR>
  imap <C-t> <Esc>:tabnew<CR>
  " Переключаемся между вкладками Shift+TAB.
  map <S-TAB> :tabprevious<CR>
  nmap <S-TAB> :tabprevious<CR>
  imap <S-TAB> <Esc>:tabprevious<CR>


  " настройки Multi-Cursor
  let g:VM_mouse_mappings    = 1
  let g:VM_theme             = 'iceblue'

  let g:VM_maps = {}
  let g:VM_maps["Undo"]      = 'u'
  let g:VM_maps["Redo"]      = '<C-r>'


  " move select lines
    vmap <C-k> :m '<-2<CR>gv=gv
    vmap <C-j> :m '>+1<CR>gv=gv

  " для плагина undotree
    nmap <leader>u :UndotreeToggle

  " скроллинг страницы при перемещении курсора через C-d, C-u
    nmap <C-d> <C-d>zz
    nmap <C-u> <C-u>zz

""""""" COC.NVIM REMAPS
  " Symbol renaming
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  " Use CTRL-S for selections ranges
  " Requires 'textDocument/selectionRange' support of language server
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Applying code actions to the selected code block
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying code actions at the cursor position
  nmap <leader>ac  <Plug>(coc-codeaction-cursor)
  " Remap keys for apply code actions affect whole buffer
  nmap <leader>as  <Plug>(coc-codeaction-source)
  " Apply the most preferred quickfix action to fix diagnostic on the current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Remap keys for applying refactor code actions
  nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
  xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
  nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

  " Run the Code Lens action on the current line
  nmap <leader>l  <Plug>(coc-codelens-action)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)
  "
  " Use <c-space> to trigger completion
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call ShowDocumentation()<CR>

  " Mappings for CoCList
  " Show all diagnostics
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>






""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" PYTHON
  " let g:pymode_run_bind='<F5>'
  autocmd Filetype python imap <F5> <Esc>:w<CR>:!clear;python %<CR>
  autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:!python %<CR>
  " autocmd Filetype python nnoremap <F7> :!~/.local/bin/autopep8 --in-place -a %<cr>
  " map <F7> :!~/.local/bin/autopep8 --in-place -a %<cr>
  " map <F6> :!~/.local/bin/pycodestyle %<cr>
  " " set breakpoint
  " au FileType python map <silent> <leader>b ofrom pudb import set_trace; set_trace()<esc>

  " let g:python_highlight_all = 1
  " When python filetype is detected, F5 can be used to execute script 
  " autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" C/C++
    packadd termdebug
    autocmd Filetype c nnoremap <F8> :Termdebug %<<cr>
    autocmd Filetype cpp nnoremap <F8> :Termdebug %<<cr>
    autocmd Filetype cpp nnoremap <F5> :!g++ -g -o %< %<cr>:!./%<<cr>
    autocmd Filetype c noremap <F5> :w<CR> :silent !clear;gcc -std=c99 -lm -no-pie -Wall -g -o %< %<CR> :!echo ":::::::::::: Running ::::::::"&& echo;./%<<CR>
    autocmd Filetype c noremap <F6> :w<CR> :silent !clear;gcc -std=c99 -lm -no-pie -Wall -g -o %< %<CR> :!echo ":::::::::::: Running ::::::::"&& echo;./%< < test<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""" ASM
    autocmd BufNewFile,BufRead *.asm  set ft=nasm
    autocmd BufRead,BufNewFile *.asm setlocal commentstring=;%s
    " make asm
    nnoremap <F5> :w<CR>:!nasm -f elf64 -g -F dwarf % -l %<.lst<CR>:!gcc -o %< %<.o -no-pie && ./%<<CR>




colorscheme ayu
" colorscheme PaperColor
" colorscheme onedark
" colorscheme rosepine
