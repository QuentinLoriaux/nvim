
-- declaration of plugins with lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup({
	"alexghergh/nvim-tmux-navigation",
	"github/copilot.vim",
	"neovim/nvim-lspconfig",
	"mfussenegger/nvim-dap",
	"anuvyklack/hydra.nvim",
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
   	 	'nvim-telescope/telescope.nvim', tag = '0.1.6',
     	 	dependencies = { 'nvim-lua/plenary.nvim', "nvim-treesitter/nvim-treesitter" }
   	 },

	 {
    		"ThePrimeagen/harpoon",
    		branch = "harpoon2",
    		dependencies = { "nvim-lua/plenary.nvim"}
	 },
	 {
	       "folke/which-key.nvim",
	       event = "VeryLazy",
	       init = function()
	         vim.o.timeout = true
	         vim.o.timeoutlen = 300
	       end,
	       opts = {
	         -- your configuration comes here
	         -- or leave it empty to use the default settings
	         -- refer to the configuration section below
	       }
         }
})


-- ======= tmux navigation config ========


local nvim_tmux_nav = require('nvim-tmux-navigation')

nvim_tmux_nav.setup {
    disable_when_zoomed = false -- defaults to false
}

vim.keymap.set('n', "<M-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<M-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<M-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<M-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<M-e>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
-- vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)



-- ====== harpoon config ========

local harpoon = require('harpoon')
harpoon:setup()

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end


-- Set up keybindings for Harpoon

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
--vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- ====== language server protocol configs ========

-- ~/.config/nvim/init.lua

-- Keybindings for LSP actions using the new vim.keymap.set function
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })


require'lspconfig'.rust_analyzer.setup{}


-- ====== Hydra config ========

local Hydra = require("hydra")


local ts_move = require'nvim-treesitter.textobjects.move'
-- Move up/down functions
Hydra({
    hint = [[
 _j_ _J_ : up
 _k_ _K_ : down
  _<Esc>_
    ]],
    config = {
        timeout = 4000,
        hint = {
            border = 'rounded'
        }
    },
    mode = {'n', 'x'},
    body = '<leader>f',
    heads = {
        { 'j', function ()
            ts_move.goto_next_start('@function.outer')
            center_screen()
        end },
        { 'J', function ()
            ts_move.goto_next_end('@function.outer')
            center_screen()
        end },
        { 'k', function ()
            ts_move.goto_previous_start('@function.outer')
            center_screen()
        end },
        { 'K', function ()
            ts_move.goto_previous_end('@function.outer')
            center_screen()
        end },
        { '<Esc>', nil,  { exit = true }}
    }
})
vim.keymap.set({'n', 'x'}, 'gj', function ()
    ts_move.goto_next_start('@function.outer')
    center_screen()
    curr:activate()
end)
vim.keymap.set('o', 'gj', function () ts_move.goto_next_start('@function.outer') end)

vim.keymap.set({'n', 'x'}, 'gk', function ()
    ts_move.goto_previous_start('@function.outer')
    center_screen()
    curr:activate()
end)
vim.keymap.set('o', 'gk', function () ts_move.goto_previous_start('@function.outer') end)

vim.keymap.set({'n', 'x'}, 'gJ', function ()
    ts_move.goto_next_end('@function.outer')
    center_screen()
    curr:activate()
end)
vim.keymap.set('o', 'gJ', function () ts_move.goto_next_end('@function.outer') end)

vim.keymap.set({'n', 'x'}, 'gK', function ()
    ts_move.goto_previous_end('@function.outer')
    center_screen()
    curr:activate()
end)
vim.keymap.set('o', 'gK', function () ts_move.goto_previous_end('@function.outer') end)


local hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters  
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]]

Hydra({
   name = 'Options',
   hint = hint,
   config = {
      color = 'amaranth',
      invoke_on_body = true,
      hint = {
         border = 'rounded',
         position = 'middle'
      }
   },
   mode = {'n','x'},
   body = '<leader>o',
   heads = {
      { 'n', function()
         if vim.o.number == true then
            vim.o.number = false
         else
            vim.o.number = true
         end
      end, { desc = 'number' } },
      { 'r', function()
         if vim.o.relativenumber == true then
            vim.o.relativenumber = false
         else
            vim.o.number = true
            vim.o.relativenumber = true
         end
      end, { desc = 'relativenumber' } },
      { 'v', function()
         if vim.o.virtualedit == 'all' then
            vim.o.virtualedit = 'block'
         else
            vim.o.virtualedit = 'all'
         end
      end, { desc = 'virtualedit' } },
      { 'i', function()
         if vim.o.list == true then
            vim.o.list = false
         else
            vim.o.list = true
         end
      end, { desc = 'show invisible' } },
      { 's', function()
         if vim.o.spell == true then
            vim.o.spell = false
         else
            vim.o.spell = true
         end
      end, { exit = true, desc = 'spell' } },
      { 'w', function()
         if vim.o.wrap ~= true then
            vim.o.wrap = true
            -- Dealing with word wrap:
            -- If cursor is inside very long line in the file than wraps
            -- around several rows on the screen, then 'j' key moves you to
            -- the next line in the file, but not to the next row on the
            -- screen under your previous position as in other editors. These
            -- bindings fixes this.
            vim.keymap.set('n', 'k', function() return vim.v.count > 0 and 'k' or 'gk' end,
                                     { expr = true, desc = 'k or gk' })
            vim.keymap.set('n', 'j', function() return vim.v.count > 0 and 'j' or 'gj' end,
                                     { expr = true, desc = 'j or gj' })
         else
            vim.o.wrap = false
            vim.keymap.del('n', 'k')
            vim.keymap.del('n', 'j')
         end
      end, { desc = 'wrap' } },
      { 'c', function()
         if vim.o.cursorline == true then
            vim.o.cursorline = false
         else
            vim.o.cursorline = true
         end
      end, { desc = 'cursor line' } },
      { '<Esc>', nil, { exit = true } }
   }
})


-- ############  Colorschemes  ############



