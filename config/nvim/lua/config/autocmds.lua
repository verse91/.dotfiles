-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.md", "*.json", "*.mdx", "*.agx", "*.svx" },
  callback = function()
    vim.cmd("set conceallevel=0")
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
  pattern = { "*.md", "*.json", "*.mdx", "*.agx", "*.svx" },
  callback = function()
    vim.cmd("set conceallevel=3")
  end,
})

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*.analog" },
--   callback = function()
--     vim.cmd("set ft=vue")
--   end,
-- })

-- Auto-open Snacks explorer when starting nvim with a directory
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     local arg = vim.fn.argv(0)
--     if arg and vim.fn.isdirectory(arg) == 1 then
--       -- Check if Snacks is available
--       local ok, snacks = pcall(require, "snacks")
--       if ok then
--         -- Small delay to ensure everything is loaded
--         vim.defer_fn(function()
--           snacks.explorer()
--         end, 100)
--       end
--     end
--   end,
-- })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded",
      })
    end, { buffer = event.buf })
  end,
})
-- Disable completion for Markdown files (blink.cmp)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Check if blink.cmp is available
    local ok, blink_cmp = pcall(require, "blink.cmp")
    if ok then
      -- Disable blink.cmp for the current buffer
      vim.b.blink_cmp_enabled = false
    end

    -- Set completeopt for manual completion
    vim.opt_local.completeopt = "menu,menuone,noinsert"
  end,
})
-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})
-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

-- removes trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})
