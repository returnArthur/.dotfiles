return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	config = function()
		local comment = require("Comment")
		comment.setup()

		-- Normal mode: Ctrl + /
		vim.keymap.set("n", "<C-_>", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle comment" })

		-- Visual mode: Ctrl + /
		vim.keymap.set("v", "<C-_>", function()
			require("Comment.api").toggle.linewise(vim.fn.visualmode())
		end, { desc = "Toggle comment", silent = true })
	end,
}
