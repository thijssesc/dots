-- packer

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd.packadd('packer.nvim')
end

local packer = require('packer')

return packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }
    use { 'nvim-lua/plenary.nvim' }

    -- lsp
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'mfussenegger/nvim-jdtls' }
    use { 'neovim/nvim-lspconfig' }

    -- luasnip
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }

    -- telescope
    use { 'nvim-telescope/telescope.nvim' }
    use { 'nvim-telescope/telescope-project.nvim' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    -- treesitter
    use { 'JoosepAlviste/nvim-ts-context-commentstring' }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update { with_sync = true }
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- lua
    use { 'danymat/neogen' }
    use { 'dsych/blanket.nvim' }
    use { 'jose-elias-alvarez/null-ls.nvim' }
    use { 'kyazdani42/nvim-tree.lua' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'lewis6991/gitsigns.nvim' }
    use { 'lukas-reineke/indent-blankline.nvim' }
    use { 'lukas-reineke/virt-column.nvim' }
    use { 'mfussenegger/nvim-dap' }
    use { 'numToStr/Comment.nvim' }
    use { 'nvim-lualine/lualine.nvim' }
    use { 'stevearc/dressing.nvim' }
    use { 'theHamsta/nvim-dap-virtual-text' }
    use { 'ThePrimeagen/harpoon' }

    -- vimscript
    use { 'pearofducks/ansible-vim' }
    use { 'towolf/vim-helm' }

    -- colorscheme
    use { 'catppuccin/nvim', as = 'catppuccin' }

    -- nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    if packer_bootstrap then
        packer.sync()
    end
end)
