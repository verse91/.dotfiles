-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Select All with Ctrl + A
-- vim.keymap.set("n", "<C-a>", "ggVG$", { desc = "Select all text" })
-- vim.keymap.set("i", "<C-a>", "<Esc>ggVG$", { desc = "Select all text" })
-- vim.keymap.set("v", "<C-a>", "<Esc>ggVG$", { desc = "Select all text" })

--- NOTE:Maybe this is better but if you copied all text, if text doesnt change,
--- it will not work, it only works when you changed something
local function select_all()
  vim.cmd("normal! ggVG$")
end

vim.keymap.set("n", "<C-a>", select_all, { desc = "Select all text" })
vim.keymap.set("i", "<C-a>", function()
  vim.cmd("stopinsert")
  select_all()
end, { desc = "Select all text" })
vim.keymap.set("v", "<C-a>", function()
  vim.cmd("normal! ggVG$")
end, { desc = "Select all text" })

-- Backspace as Delete in Normal Mode
vim.keymap.set("v", "<BS>", '"_d', { desc = "Delete selection without copying" })
vim.keymap.set(
  { "n", "i" },
  "<C-d>",
  "<Esc>viw<C-g>",
  { desc = "Select current word for immediate replacement", noremap = true }
)

vim.keymap.set("n", "<leader>K", "<Nop>")
vim.keymap.set("n", "U", "<c-u>zz")
vim.keymap.set("n", "D", "<c-d>zz")
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- move lines
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Normal mode
vim.keymap.set("n", "J", "^", { noremap = true })
vim.keymap.set("n", "L", "$", { noremap = true })
vim.keymap.set("n", "i", "<Up>", { noremap = true })
vim.keymap.set("n", "j", "<Left>", { noremap = true })
vim.keymap.set("n", "k", "<Down>", { noremap = true })
vim.keymap.set("n", "l", "<Right>", { noremap = true })

-- Visual mode
vim.keymap.set("v", "i", "<Up>", { noremap = true })
vim.keymap.set("v", "j", "<Left>", { noremap = true })
vim.keymap.set("v", "k", "<Down>", { noremap = true })
vim.keymap.set("v", "l", "<Right>", { noremap = true })
-- Alt+Arrow keys to move lines up/down (exactly like VS Code)
vim.keymap.set("n", "<A-i>", "<cmd>m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("i", "<A-i>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up", silent = true })
vim.keymap.set("i", "<A-k>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down", silent = true })
vim.keymap.set("v", "<A-i>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<A-k>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })

-- -- chatgpt
-- vim.keymap.set("n", "<leader>gp", "<cmd>ChatGPT<cr>", { desc = "Launch ChatGPT" })
-- vim.keymap.set("n", "<leader>gpa", "<cmd>ChatGPTActAs<cr>", { desc = "ChatGPT Act As" })
-- vim.keymap.set("n", "<leader>gpe", "<cmd>ChatGPTEditWithInstructions<cr>", { desc = "ChatGPT Edit With Instructions" })
-- vim.keymap.set("n", "<leader>gpc", "<cmd>ChatGPTCompleteCode<cr>", { desc = "ChatGPT Complete Code" })
-- vim.keymap.set("n", "<leader>gpf", "<cmd>ChatGPTRun fix_bugs<cr>", { desc = "ChatGPT Fix Bugs" })
-- vim.keymap.set("n", "<leader>gpx", "<cmd>ChatGPTRun explain_code<cr>", { desc = "ChatGPT Fix Bugs" })

-- markdown
vim.keymap.set(
  "n",
  "<leader>da",
  '<cmd>setlocal formatoptions-=a<cr><cmd>setlocal textwidth=0<cr><cmd>echo "Auto-wrapping disabled"<cr>',
  { desc = "Disable auto wrap" }
)
vim.keymap.set(
  "n",
  "<leader>ea",
  '<cmd>setlocal formatoptions+=a<cr><cmd>setlocal textwidth=80<cr><cmd>echo "Auto-wrapping enabled"<cr>',
  { desc = "Enable auto wrap" }
)

vim.keymap.set("v", "<leader>mb", "di****<esc>hhp", { desc = "Auto bold" })
vim.keymap.set("v", "<leader>mi", "di**<esc>hp", { desc = "Auto italic" })
vim.keymap.set("v", "<leader>ml", "di[]()<esc>hhhpllli", { desc = "Auto link" })
vim.keymap.set("v", "<leader>mc", "di``<esc>hp", { desc = "Auto backtick" })

vim.keymap.set("n", "<leader>bw", "<cmd>bufdo bwipeout<cr>", { desc = "Close all buffers" })

-- jumps (currently not working)
vim.keymap.set("n", "<leader>jt", "<cmd>/template:<cr><cmd>nohl<cr>", { desc = "Jump to template" })
vim.keymap.set("n", "<leader>js", "<cmd>/style.:<cr><cmd>nohl<cr>", { desc = "Jump to styles" })
vim.keymap.set("n", "<leader>jc", "<cmd>/Component {<cr><cmd>nohl<cr>", { desc = "Jump to component" })

-- harpoon - safely load
-- NOTE: may be this will be useless when you can use <leader> + 1234,...
vim.keymap.set("n", "<leader>ha", function()
  require("harpoon.mark").add_file()
end, { desc = "Harpoon add file" })

vim.keymap.set("n", "<leader>h", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon menu" })

vim.keymap.set("n", "<leader>hl", function()
  require("harpoon.ui").nav_next()
end, { desc = "Harpoon next" })

vim.keymap.set("n", "<leader>hh", function()
  require("harpoon.ui").nav_next()
end, { desc = "Harpoon next" })

-- undotree - safely load
vim.keymap.set("n", "<leader>ut", function()
  vim.cmd.UndotreeToggle()
end, { desc = "Undo tree" })

-- snacks picker - replacing telescope
vim.keymap.set("n", "<leader>?", function()
  Snacks.picker.recent()
end, { desc = "Find recently opened files" })

vim.keymap.set("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "Search diagnostics" })

vim.keymap.set("n", "<leader>jl", function()
  Snacks.picker.jumps()
end, { desc = "Jump list" })

vim.keymap.set("n", "<leader>km", function()
  Snacks.picker.keymaps()
end, { desc = "Keymaps" })

vim.keymap.set("n", "<leader>rg", function()
  Snacks.picker.registers()
end, { desc = "Registers" })

vim.keymap.set("n", "<leader>ht", function()
  Snacks.picker.help()
end, { desc = "Help tags" })

-- ufo - safely load
vim.keymap.set("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })

vim.keymap.set("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds" })

-- snacks explorer
vim.keymap.set("n", "<leader>e", function()
  require("snacks").explorer()
end, { desc = "Explorer" })

-- Improved file finder with snacks
vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files({ hidden = true })
end, { desc = "Find files" })

-- Additional snacks pickers
vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.smart()
end, { desc = "Smart Find Files" })

vim.keymap.set("n", "<leader>,", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>:", function()
  Snacks.picker.command_history()
end, { desc = "Command History" })

vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fg", function()
  Snacks.picker.git_files()
end, { desc = "Git Files" })

vim.keymap.set("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent Files" })

vim.keymap.set("n", "<leader>sb", function()
  Snacks.picker.lines()
end, { desc = "Buffer Lines" })

vim.keymap.set("n", "<leader>sg", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

-- NOTE: this is better than / then type the word IF your cursor is on the word
vim.keymap.set("n", "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "Grep Word" })

vim.keymap.set("n", "<leader>sc", function()
  Snacks.picker.command_history()
end, { desc = "Command History" })

vim.keymap.set("n", "<leader>sC", function()
  Snacks.picker.commands()
end, { desc = "Show all commands" })

vim.keymap.set("n", "<leader>sD", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })

vim.keymap.set("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "Help Pages" })

vim.keymap.set("n", "<leader>sH", function()
  Snacks.picker.highlights()
end, { desc = "Highlights" })

vim.keymap.set("n", "<leader>sj", function()
  Snacks.picker.jumps()
end, { desc = "Jumps" })

vim.keymap.set("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "Keymaps" })

vim.keymap.set("n", "<leader>sm", function()
  Snacks.picker.marks()
end, { desc = "Marks" })

vim.keymap.set("n", "<leader>sq", function()
  Snacks.picker.qflist()
end, { desc = "Quickfix List" })

vim.keymap.set("n", "<leader>sR", function()
  Snacks.picker.resume()
end, { desc = "Resume" })

vim.keymap.set("n", "<leader>su", function()
  Snacks.picker.undo()
end, { desc = "Undo History" })

vim.keymap.set("n", "<leader>uC", function()
  Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })

-- Buffer navigation (Lualine buffers style)
vim.keymap.set("n", "<C-Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bd!<cr>", { desc = "Force close buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Close other buffers" })

-- Window splits - previous buffer in original window, current buffer in new split
vim.keymap.set("n", "<leader>|", function()
  local prev_buf = vim.fn.bufnr("#") -- Get previous buffer

  -- If there's a valid previous buffer
  if prev_buf > 0 and prev_buf ~= vim.api.nvim_get_current_buf() then
    vim.cmd("vsplit") -- Create vertical split (current buffer goes to right)
    vim.cmd("wincmd h") -- Move to left window
    vim.api.nvim_set_current_buf(prev_buf) -- Set previous buffer in left window
    vim.cmd("wincmd l") -- Move back to right window
  else
    vim.cmd("vsplit") -- Fallback to normal split
  end
end, { desc = "Split vertical" })

vim.keymap.set("n", "<leader>_", function()
  local prev_buf = vim.fn.bufnr("#") -- Get previous buffer

  -- If there's a valid previous buffer
  if prev_buf > 0 and prev_buf ~= vim.api.nvim_get_current_buf() then
    vim.cmd("split") -- Create horizontal split (current buffer goes to bottom)
    vim.cmd("wincmd k") -- Move to top window
    vim.api.nvim_set_current_buf(prev_buf) -- Set previous buffer in top window
    vim.cmd("wincmd j") -- Move back to bottom window
  else
    vim.cmd("split") -- Fallback to normal split
  end
end, { desc = "Split horizontal:" })
