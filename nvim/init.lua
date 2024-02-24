require("autoinstall_packer")
require("astat")

vim.cmd "command W :execute ':silent w !sudo tee % > /dev/null' | :edit!"    -- записывать файлы от админа с помощью :W

print("======================== SOME HELP INFO ====================================")
print(":PackerSync     - update all plugins")
print(":checkhealth    - check correct preferences")
print("<leader>fs      - grep recursive search in all files in folder")
print("<leader>ff      - find file")
print("<leader>fh      - find help")
print("gd              - go definition")
print("Ctrl-o          - go back after go definition")
print("[d              - previous error")
print("K               - info about function")
print("<C-h> in insert - help about function")

print("========================= CONFIG FILES ======================================")
print("~/.config/nvim/lua/astat/remap.lua      - all hotkeys")
print("~/.config/nvim/lua/astat/autoinstall_packer.lua     - load plugins")
print("~/.config/nvim/lua/after/plugin/lsp.lua - LSP config and hotkeys")


-------------------------------------------------------------------------------------------------------------------
----------------------------------------------- SET ----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
	local opt = vim.opt
	local g = vim.g

	opt.expandtab = true                               -- менять табы на пробелы
	opt.scrolloff = 8                                  -- За сколько строк до края страницы начинать скролл
	opt.ignorecase = true                              -- Игнорировать регистр при поиске
	opt.smartcase = true                               -- Не игнорировать регистр, если есть символы в верхнем регистре
	opt.showmatch = true                               -- Подсвечивать найденные текстовые объекты
	opt.shiftwidth = 4                                 -- Установка количества пробельных символов, для "<", ">"
	opt.tabstop = 4                                    -- 1 таб == 2 пробела c новой строки
	opt.smartindent = true                             -- Подстраивать новые строки под предыдущий отступ
	opt.splitright = true                              -- Вертикальные сплиты становятся справа
	opt.splitbelow = true                              -- Горизонтальные сплиты становятся снизу
	opt.clipboard = 'unnamedplus'                      -- Используем системный буфер обмена
	opt.fixeol = false                                 -- Отключаем дополнение файлов в конце
	opt.completeopt = 'menuone,noselect'               -- Автодополнение (встроенное в Neovim)
	vim.cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]   -- Не автокомментировать новые линии при переходе на новую строку
	opt.swapfile = false                                   -- отключить своп
	opt.backup = false
    opt.undodir = os.getenv("HOME") .. "/.vim/undodir"     -- директория для сохранения изменений в файлах 
    opt.undofile = true
	opt.wildmenu = true                                -- shows a more advanced menu for autocomplete suggestions.
    opt.wrap = false                                   -- перенос строк автоматически выключен
    opt.guicursor = ""                                 -- внешний вид курсора
    vim.cmd([[
    "Map Neovim yank's buffer to your clipboard buffer
    set clipboard+=unnamedplus
    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:ver100-iCursor
    set guicursor+=n-v-c:blinkon0
    set guicursor+=i:blinkwait10
    inoremap { {}<left>
    nnoremap S diw"0P
    ]])

    opt.termguicolors = true

	opt.hlsearch = true
	opt.incsearch = true

	opt.nu = true                                      -- set number
	opt.relativenumber = true
	opt.smartindent = true


-- colorscheme
    vim.cmd('colorscheme rose-pine')
    -- vim.cmd('colorscheme ayu')
    -- vim.cmd('colorscheme onehalfdark')

