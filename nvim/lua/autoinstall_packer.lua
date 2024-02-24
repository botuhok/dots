
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
 PACKER_BOOTSTRAP = fn.system({
  "git",
  "clone",
  "--depth",
  "1",
  "https://github.com/wbthomason/packer.nvim",
  install_path,
 })
 print("Installing packer close and reopen Neovim...")
 vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
 return
end

-- Have packer use a popup window
packer.init({
 display = {
  open_fn = function()
   return require("packer.util").float({ border = "rounded" })
  end,
 },
})

-- Install your plugins here
return packer.startup(function(use)
 use ("wbthomason/packer.nvim") -- Have packer manage itself 

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }


    -- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
    use 'junegunn/vim-easy-align'

    -- colorschemes
    use({ 'rose-pine/neovim', as = 'rose-pine' })
    use 'rafi/awesome-vim-colorschemes'

    --filemanager
    use 'preservim/nerdtree'

    --icons
    use 'ryanoasis/vim-devicons'

    -- hex editor
    use 'RaafatTurki/hex.nvim'

    -- parsers
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- Coc and kotlin
    -- use {'neoclide/coc.nvim', branch = 'release'}
    -- use 'weirongxu/coc-kotlin'

    -- View treesitter information
    -- use 'nvim-treesitter/playground'

    -- VIM-COMMENTARY
    -- gcc to comment out a line (takes a count), gc to comment out the target of a motion
    use 'tpope/vim-commentary'

    -- VIM MULTICURSOR
    -- C-n   - add cursor at word
    -- A-n   - add cursor at all this words
    use 'terryma/vim-multiple-cursors'
    ---------------- MULTICURSOR SETTINGS -------------------------------
    vim.cmd("let g:VM_mouse_mappings    = 1")                          --
    vim.cmd("let g:VM_theme             = 'iceblue'")                  --
    vim.cmd("let g:VM_maps = {}")                                      --
    vim.cmd("let g:VM_maps['Undo']      = 'u'")                        --
    vim.cmd("let g:VM_maps['Redo']      = '<C-r>'")                    --
    ---------------------------------------------------------------------
    -- autoalign
    use 'Vonr/align.nvim'

    -- C-k or C-j to add multiline cursor
    use 'mg979/vim-visual-multi'


    -- UndoTree on <leader>u
    use 'mbbill/undotree'


    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            run = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},


    }
}


 if PACKER_BOOTSTRAP then
  require("packer").sync()
 end
end)
