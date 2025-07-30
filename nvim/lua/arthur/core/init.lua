require("arthur.core.options")
require("arthur.core.keymaps")

vim.o.laststatus = 0
vim.o.cmdheight = 0
--tmux
vim.keymap.set("n", "<C-p>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-o>", "<cmd>silent !tmux neww tmux-switcher<CR>")


vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
