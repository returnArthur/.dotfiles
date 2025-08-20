local M = {}

local default_map_options = {
	noremap = true,
	silent = true,
}

M.map = function(mode, lhs, rhs, opts)
	opts = opts or {}

	for key, value in pairs(default_map_options) do
		if opts[key] == nil then
			opts[key] = value
		end
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
