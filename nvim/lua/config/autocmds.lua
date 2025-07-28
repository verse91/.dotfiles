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
