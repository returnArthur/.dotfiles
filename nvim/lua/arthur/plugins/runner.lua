return {
	"MarcHamamji/runner.nvim",
	keys = { { "<leader><leader>" } },
	config = function()
		local runner = require("runner")
		local helpers = require("runner.handlers.helpers")
		local utils = require("arthur.core.utils") -- ✅ this was missing

		runner.setup({
			position = "right",
			width = 35,
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

		utils.map("n", "<leader><Space>", runner.run, { desc = "Runner" })
	end,
}
