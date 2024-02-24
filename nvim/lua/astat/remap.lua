
--------------------------------------------------------------------------------------------------------------------
----------------------------------------------- REMAP --------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

vim.g.mapleader = " "

-- создаём функцию map, чтобы в дальнейшем поменьше писать
local map = vim.keymap.set

	function nm(key, command) 
		map('n', key, command, {noremap = true})
	end

	function im(key, command)
		map('i', key, command, {noremap = true})
	end

	function vm(key, command)
		map('v', key, command, {noremap = true})
	end

	function tm(key, command)
		map('t', key, command, {noremap = true})
	end


nm('<leader>e', ":NERDTreeToggle<CR>")

-- telescope
	local builtin = require('telescope.builtin')
    require('telescope').setup{
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--hidden',
                '--smart-case',
                '-u' -- thats the new thing
            },
        }}
	vim.keymap.set('n', '<Leader>ff', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>', {noremap = true, silent = true})
	vim.keymap.set('n', '<Leader>fs', ':lua require"telescope.builtin".grep_string({ hidden = true, search = vim.fn.input("Grep > ") })<CR>', {noremap = true, silent = true})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Undotree
    nm('<leader>u', vim.cmd.UndotreeToggle)

--групповое изменение всех встреченных слов под курсором 
    nm("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- закладки 
	nm('<S-TAB>', vim.cmd.tabprevious)
	nm('<C-t>', vim.cmd.tabnew)

-- для перемещения выделенной области
    vm('K', ":m '<-2<CR>gv=gv")
    vm('J', ":m '>+1<CR>gv=gv")

-- скроллинг страницы при перемещении курсора через C-d, C-u
    nm('<C-d>', '<C-d>zz')
    nm('<C-u>', '<C-u>zz')

-- yank to global
    nm('<leader>y', "\"+y")
    vm('<leader>y', "\"+y")
    nm('<leader>Y', "\"+Y")

--multicursor
    nm('<C-LeftMouse>', "<Plug>(VM-Mouse-Cursor)")
    nm('<C-RightMouse>', "<Plug>(VM-Mouse-Word)")
    nm('<C-j>', '<Plug>(VM-Add-Cursor-Down)')
    nm('<C-k>', '<Plug>(VM-Add-Cursor-Up)')

-- отменить подсветку найденного
    nm('<leader>,', ':nohlsearch<CR>')

--autoalign
-- align_to_char(length, reverse, preview, marks)
-- align_to_string(is_pattern, reverse, preview, marks)
-- align(str, reverse, marks)
-- operator(fn, opts)
-- Where:
--      length: integer
--      reverse: boolean
--      preview: boolean
--      marks: table (e.g. {1, 0, 23, 15})
--      str: string (can be plaintext or Lua pattern if is_pattern is true)

local NS = { noremap = true, silent = true }

vim.keymap.set('x', 'aa', function() require'align'.align_to_char(1, true)             end, NS) -- Aligns to 1 character, looking left
vim.keymap.set('x', 'as', function() require'align'.align_to_char(2, true, true)       end, NS) -- Aligns to 2 characters, looking left and with previews
vim.keymap.set('x', 'aw', function() require'align'.align_to_string(false, true, true) end, NS) -- Aligns to a string, looking left and with previews
vim.keymap.set('x', 'ar', function() require'align'.align_to_string(true, true, true)  end, NS) -- Aligns to a Lua pattern, looking left and with previews

-- Example gawip to align a paragraph to a string, looking left and with previews
vim.keymap.set(
    'n',
    'gaw',
    function()
        local a = require'align'
        a.operator(
            a.align_to_string,
            { is_pattern = false, reverse = true, preview = true }
        )
    end,
    NS
)

-- Example gaaip to aling a paragraph to 1 character, looking left
vim.keymap.set(
    'n',
    'gaa',
    function()
        local a = require'align'
        a.operator(
            a.align_to_char,
            { length = 1, reverse = true }
        )
    end,
    NS
)

--------------------------------------------------------------------------------------------------------------------
----------------------------------------------- RUN! ---------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--   Run Python 
		vim.cmd "autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>"
		vim.cmd "autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>"
        vim.cmd "autocmd Filetype python nnoremap <F7> :!autopep8 --in-place -a -a %<cr>"


-- Run C++, C
        vim.cmd "autocmd Filetype cpp nnoremap <F5> :!g++ -g -o %< %<cr>:! ./%<<cr>"
        -- vim.cmd "autocmd Filetype c nnoremap <F5> :w <CR> :!gcc % -o -g %< -lm && ./%< <CR>"
        vim.cmd "autocmd Filetype c nnoremap <F5> :w <CR> :!gcc % -o %< -lm && ./%< <CR>"
        vim.cmd "autocmd FileType c nnoremap <F8> :Termdebug %<<CR>"
        vim.cmd "autocmd FileType cpp nnoremap <F8> :Termdebug %<<CR>"
        vim.cmd "autocmd Filetype c packadd termdebug"
        vim.cmd "autocmd Filetype cpp packadd termdebug"


-- Run go
        vim.cmd "autocmd FileType go map <buffer> <F5> :w<CR>:exec '!go run' shellescape(@%, 1)<CR>"


-- Run asm
        -- vim.cmd "autocmd FileType asm map <buffer> <F5> :w<CR>:!as --64 % -o %<.o<cr>:!ld -s %<.o -o %<<cr>:! ./%<<cr>"
        -- vim.cmd "autocmd Filetype *.nasm map <buffer> <F5> :w<CR>:!make<CR>"
        vim.cmd "autocmd FileType *.asm nnoremap <F5> :w<CR>:!nasm -f elf64 -g -F dwarf % -l %<.lst<CR>:!gcc -o %< %<.o -no-pie<CR>"

--  Run lua 
        vim.cmd "autocmd FileType lua map <buffer> <F5> :w<CR>:!lua %<CR>"
        vim.cmd "autocmd FileType lua imap <buffer> <F5> <esc>:w<CR>:exec '!lua' shellescape(@%, 1)<CR>"

-- Run kotlin
        vim.cmd "autocmd FileType kotlin map <buffer> <F5> :w<CR>:!kotlinc % -include-runtime -d %<.jar && java -jar %<.jar<CR>"


