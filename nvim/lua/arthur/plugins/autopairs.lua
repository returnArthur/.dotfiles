return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
	},

	config = function()
		local npairs = require("nvim-autopairs")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		npairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				java = false,
			},
			map_c_h = true,
			map_c_w = true,
			map_bs = true,
			map_cr = true,
		})

		-- TAB to jump out of brackets
		vim.keymap.set("i", "<Tab>", function()
			local col = vim.fn.col(".")
			local line = vim.fn.getline(".")
			if line:sub(col, col):match("[%])}'\"]") then
				return "<Right>"
			else
				return "<Tab>"
			end
		end, { expr = true })

		-- make autopairs and nvim-cmp work together
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
