require("arthur.core")
require("arthur.lazy")
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "yellow" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "yellow" })

-- Toggle checkbox in markdown
local function toggle_checkbox()
  local line = vim.api.nvim_get_current_line()
  if line:match("%[ %]") then
    line = line:gsub("%[ %]", "[x]", 1)
  elseif line:match("%[x%]") then
    line = line:gsub("%[x%]", "[ ]", 1)
  end
  vim.api.nvim_set_current_line(line)
end

-- Only enable in todo.md
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*/todo.md",
  callback = function()
    -- ====== 1. Add today's heading at the bottom if not present ======
    local date = os.date("%A, %B %d, %Y")
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local found = false

    for _, line in ipairs(lines) do
      if line:match("^# " .. date) then
        found = true
        break
      end
    end

    if not found then
      if #lines == 0 then
        -- file is empty, add heading at top
        vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# " .. date, "" })
      else
        -- add heading at the bottom with one empty line before
        vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "# " .. date, "" })
      end
    end

    -- ====== 2. Set mappings for todos ======
    vim.keymap.set("n", "o", "o- [ ] <Esc>^$a", { buffer = true })
    vim.keymap.set("n", "O", "O- [ ] <Esc>^$a", { buffer = true })
    vim.keymap.set("n", "<leader>tt", toggle_checkbox, { buffer = true, desc = "Toggle checkbox" })

    -- ====== 3. Jump cursor to today's heading ======
    for i, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
      if line:match("^# " .. date) then
        vim.api.nvim_win_set_cursor(0, { i + 1, 0 }) -- move cursor below heading
        break
      end
    end
  end,
})

