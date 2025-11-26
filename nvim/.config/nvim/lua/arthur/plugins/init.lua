return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	"ThePrimeagen/vim-be-good",
  -- Put this in your init.lua
vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle({ focus = false })
end, { silent = true, noremap = true })
}
