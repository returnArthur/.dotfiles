return {
	"MarcHamamji/runner.nvim",
	keys = { { "<leader><leader>" } },
	config = function()
		local runner = require("runner")
		local helpers = require("runner.handlers.helpers")
		local utils = require("arthur.core.utils")

		runner.setup({
			position = "right",
			width = 25,
			height = 10,
		})

		-- LaTeX
		runner.set_handler("tex", function(bufnr)
			helpers.shell_handler("pdflatex --output-directory=out " .. vim.fn.expand("%"))(bufnr)
		end)

		-- C
		runner.set_handler("c", function(bufnr)
			local filename = vim.fn.expand("%:t:r")
			local output = "out/" .. filename
			local cmd = string.format("mkdir -p out && gcc %s -o %s && ./%s", vim.fn.expand("%"), output, output)
			helpers.shell_handler(cmd)(bufnr)
		end)

		-- Go
		runner.set_handler("go", function(bufnr)
			local cmd = "go run " .. vim.fn.expand("%")
			helpers.shell_handler(cmd)(bufnr)
		end)

		-- JavaScript
		runner.set_handler("javascript", function(bufnr)
			local cmd = "node " .. vim.fn.expand("%")
			helpers.shell_handler(cmd)(bufnr)
		end)

		utils.map("n", "<leader><Space>", function()
			local cur_win = vim.api.nvim_get_current_win()
			require("runner").run()
			vim.api.nvim_set_current_win(cur_win)
		end, { desc = "Runner" })
	end,
}

