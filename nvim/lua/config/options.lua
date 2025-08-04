-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Fix for man plugin error on Windows
-- Disable the man plugin to prevent loading errors on Windows
if vim.fn.has("win32") == 1 then
  vim.g.loaded_man = 1
end

-- Disable netrw (file explorer) from opening automatically
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
-- Cross-platform home directory detection
local home_dir = os.getenv("HOME") or os.getenv("USERPROFILE")
local path_sep = package.config:sub(1, 1) -- Get path separator for current OS
vim.opt.undodir = home_dir .. path_sep .. ".vim" .. path_sep .. "undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.timeoutlen = 250
vim.opt.showmatch = true
vim.opt.synmaxcol = 300 -- stop syntax highlighting for performance
vim.opt.laststatus = 2 -- always show statusline

-- Sidebar
vim.opt.numberwidth = 1
vim.opt.showcmd = true
vim.opt.cmdheight = 0

-- Search
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in searcher

vim.opt.termguicolors = true

-- Font configuration
vim.opt.guifont = "Berkeley Mono Semicondensed"

-- Alternative font configurations for different GUI clients:
-- For Neovide:
if vim.g.neovide then
  vim.o.guifont = "Berkeley Mono Semicondensed:h12"
  vim.g.neovide_scale_factor = 1.0
end

-- For terminal Neovim, you need to set the font in your terminal emulator
-- The following is just for reference and won't work in terminal Neovim:
-- Terminal font should be set to "Berkeley Mono Semicondensed" in your terminal settings
-- Enable cursorline permanently
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
-- Disable LSP document highlight (stops highlighting same words) and inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      -- Disable document highlighting
      if client.server_capabilities.documentHighlightProvider then
        client.server_capabilities.documentHighlightProvider = false
      end

      -- Disable inlay hints for this buffer and client
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
      end
    end
  end,
})

-- Additional settings to prevent word highlighting
vim.opt.updatetime = 4000 -- Slow down CursorHold events
-- Clear any existing highlighting
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("highlight clear LspReferenceText")
    vim.cmd("highlight clear LspReferenceRead")
    vim.cmd("highlight clear LspReferenceWrite")
    vim.cmd("highlight clear IlluminatedWordText")
    vim.cmd("highlight clear IlluminatedWordRead")
    vim.cmd("highlight clear IlluminatedWordWrite")
  end,
})

-- Custom selection color will be configured separately

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes" -- Enable sign column for diagnostic icons

-- vim.opt.updatetime = 50 -- Commented out to use the higher value above for disabling highlights
-- vim.opt.colorcolumn = "120" -- Removed column indicator

local float = { focusable = true, style = "minimal", border = "rounded" }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#d8bd92" })

vim.filetype.add({
  extension = {
    mdx = "mdx",
    agx = "agx",
    svx = "svx",
    analog = "analog",
    ag = "ag",
  },
})

vim.filetype.add({
  extension = {
    [".all-contributorsrc"] = ".all-contributorsrc",
  },
})

vim.treesitter.language.register("angular", "angular.html")
vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("markdown", "agx")
vim.treesitter.language.register("markdown", "svx")
vim.treesitter.language.register("vue", "analog")
vim.treesitter.language.register("vue", "ag")
vim.treesitter.language.register("vue", "agx")
vim.treesitter.language.register("json", ".all-contributorsrc")

-- folds
vim.o.foldcolumn = "0" -- Disable fold column to remove the | bars
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- change root dir for grep
vim.g.root_spec = { "cwd" }

-- COMPREHENSIVE INLAY HINTS DISABLING FOR ALL LANGUAGES
-- Global disable first
vim.lsp.inlay_hint.enable(false)
vim.g.inlay_hints_enabled = false

-- Create multiple autocmds to ensure inlay hints stay disabled
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType", "InsertEnter" }, {
  callback = function()
    -- Disable inlay hints for current buffer
    vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
  end,
})

-- Enhanced LspAttach autocmd for comprehensive inlay hints disabling
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      -- Force disable inlay hints immediately
      vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })

      -- Disable inlay hint provider capability if it exists
      if client.server_capabilities.inlayHintProvider then
        client.server_capabilities.inlayHintProvider = false
      end

      -- Set up a timer to continuously disable inlay hints
      local timer = vim.loop.new_timer()
      timer:start(
        0,
        2000,
        vim.schedule_wrap(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
          else
            timer:stop()
            timer:close()
          end
        end)
      )
    end
  end,
})

-- Additional timer to globally disable inlay hints every few seconds
local global_timer = vim.loop.new_timer()
global_timer:start(
  1000,
  3000,
  vim.schedule_wrap(function()
    vim.lsp.inlay_hint.enable(false)
    -- Also disable for all current buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
        vim.lsp.inlay_hint.enable(false, { bufnr = buf })
      end
    end
  end)
)
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#000000", bg = "#000000" })
