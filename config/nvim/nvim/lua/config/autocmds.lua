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
