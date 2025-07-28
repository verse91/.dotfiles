-- Enhanced diagnostic and LSP UI configuration
-- This file enhances the visual appearance of diagnostics and LSP indicators

-- Configure diagnostic signs in the gutter with better visibility
local diagnostic_signs = {
  Error = "󰅚",
  Warn = "󰀪", 
  Hint = "󰌶",
  Info = "󰋽"
}

for type, icon in pairs(diagnostic_signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { 
    text = icon, 
    texthl = hl, 
    numhl = hl,
    linehl = "", -- No line highlighting
  })
end

-- Git signs will be configured in the gitsigns plugin file

-- Enhanced diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Could be '●', '▎', 'x', '■', , 
    source = "always",
    spacing = 4,
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return string.format("󰅚 %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        return string.format("󰀪 %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return string.format("󰋽 %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return string.format("󰌶 %s", diagnostic.message)
      end
      return diagnostic.message
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    format = function(diagnostic)
      local icons = {
        [vim.diagnostic.severity.ERROR] = "󰅚",
        [vim.diagnostic.severity.WARN] = "󰀪",
        [vim.diagnostic.severity.INFO] = "󰋽",
        [vim.diagnostic.severity.HINT] = "󰌶",
      }
      local icon = icons[diagnostic.severity] or "󰋽"
      return string.format("%s %s", icon, diagnostic.message)
    end,
  },
})

-- Enhanced LSP handlers with better icons
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  title = "󰋽 Hover",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  title = "󰏪 Signature Help",
})

-- Custom highlight groups for diagnostics with better colors
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Error diagnostics
    vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ec5e68", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#ec5e68", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ec5e68" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ec5e68", italic = true })
    
    -- Warning diagnostics
    vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#e3b341", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#e3b341", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#e3b341" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#e3b341", italic = true })
    
    -- Info diagnostics
    vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#56b6c2", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#56b6c2", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#56b6c2" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#56b6c2", italic = true })
    
    -- Hint diagnostics
    vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#7fb069", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#7fb069", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#7fb069" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#7fb069", italic = true })
  end,
})

-- Trigger the colorscheme autocmd immediately
vim.cmd("doautocmd ColorScheme")

-- Enhanced Git signs colors
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Git signs colors
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#a7da8c", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e3b341", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ec5e68", bold = true })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#56b6c2", bold = true })
    
    -- Sign column background
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" }) -- Transparent background
    
    -- Better sign column line number
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#6d6d6d" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#a277ff", bold = true })
  end,
})

-- Enhanced LSP symbol kinds with better icons
local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

-- Apply the icons to completion kinds
for kind, icon in pairs(kind_icons) do
  vim.lsp.protocol.CompletionItemKind[kind] = icon .. " " .. kind
end
