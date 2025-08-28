-- Aura theme highlights for completion menu and UI elements
local M = {}

function M.setup()
  -- Delay execution to ensure colorscheme is loaded
  vim.defer_fn(function()
    -- Blink-cmp completion menu highlights (Aura theme)
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#110f18", fg = "#edecee" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "#110f18", fg = "#a277ff" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#3d375e", fg = "#edecee", bold = true })

    -- Documentation window
    vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#110f18", fg = "#edecee" })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = "#110f18", fg = "#61ffca" })

    -- Signature help
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = "#110f18", fg = "#edecee" })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "#110f18", fg = "#ffca85" })

    -- Kind-specific highlights (Aura colors)
    vim.api.nvim_set_hl(0, "CmpKindSnippet", { fg = "#a277ff", bold = true })
    vim.api.nvim_set_hl(0, "CmpKindKeyword", { fg = "#a277ff" })
    vim.api.nvim_set_hl(0, "CmpKindText", { fg = "#edecee" })
    vim.api.nvim_set_hl(0, "CmpKindMethod", { fg = "#61ffca" })
    vim.api.nvim_set_hl(0, "CmpKindFunction", { fg = "#61ffca" })
    vim.api.nvim_set_hl(0, "CmpKindConstructor", { fg = "#61ffca" })
    vim.api.nvim_set_hl(0, "CmpKindField", { fg = "#ffca85" })
    vim.api.nvim_set_hl(0, "CmpKindVariable", { fg = "#ffca85" })
    vim.api.nvim_set_hl(0, "CmpKindClass", { fg = "#f694ff" })
    vim.api.nvim_set_hl(0, "CmpKindInterface", { fg = "#f694ff" })
    vim.api.nvim_set_hl(0, "CmpKindModule", { fg = "#ff6767" })
    vim.api.nvim_set_hl(0, "CmpKindProperty", { fg = "#ffca85" })
    vim.api.nvim_set_hl(0, "CmpKindUnit", { fg = "#ff6767" })
    vim.api.nvim_set_hl(0, "CmpKindValue", { fg = "#ff6767" })
    vim.api.nvim_set_hl(0, "CmpKindEnum", { fg = "#f694ff" })
    vim.api.nvim_set_hl(0, "CmpKindColor", { fg = "#ff6767" })
    vim.api.nvim_set_hl(0, "CmpKindFile", { fg = "#edecee" })
    vim.api.nvim_set_hl(0, "CmpKindReference", { fg = "#edecee" })
    vim.api.nvim_set_hl(0, "CmpKindFolder", { fg = "#edecee" })
    vim.api.nvim_set_hl(0, "CmpKindEnumMember", { fg = "#f694ff" })
    vim.api.nvim_set_hl(0, "CmpKindConstant", { fg = "#ff6767" })
    vim.api.nvim_set_hl(0, "CmpKindStruct", { fg = "#f694ff" })
    vim.api.nvim_set_hl(0, "CmpKindEvent", { fg = "#61ffca" })
    vim.api.nvim_set_hl(0, "CmpKindOperator", { fg = "#a277ff" })
    vim.api.nvim_set_hl(0, "CmpKindTypeParameter", { fg = "#f694ff" })

    -- Additional popup menu highlights
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#110f18", fg = "#edecee" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3d375e", fg = "#edecee", bold = true })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#3d375e" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#a277ff" })

    -- Float border color
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#110f18", fg = "#a277ff" })

    -- Completion item labels and sources
    vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "#edecee" })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#a277ff", bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = "#6272a4", italic = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = "#ffca85" })
  end, 100)

  -- Kind-specific highlights (Aura colors)
  vim.api.nvim_set_hl(0, "CmpKindSnippet", { fg = "#a277ff", bold = true })
  vim.api.nvim_set_hl(0, "CmpKindKeyword", { fg = "#a277ff" })
  vim.api.nvim_set_hl(0, "CmpKindText", { fg = "#edecee" })
  vim.api.nvim_set_hl(0, "CmpKindMethod", { fg = "#61ffca" })
  vim.api.nvim_set_hl(0, "CmpKindFunction", { fg = "#61ffca" })
  vim.api.nvim_set_hl(0, "CmpKindConstructor", { fg = "#61ffca" })
  vim.api.nvim_set_hl(0, "CmpKindField", { fg = "#ffca85" })
  vim.api.nvim_set_hl(0, "CmpKindVariable", { fg = "#ffca85" })
  vim.api.nvim_set_hl(0, "CmpKindClass", { fg = "#f694ff" })
  vim.api.nvim_set_hl(0, "CmpKindInterface", { fg = "#f694ff" })
  vim.api.nvim_set_hl(0, "CmpKindModule", { fg = "#ff6767" })
  vim.api.nvim_set_hl(0, "CmpKindProperty", { fg = "#ffca85" })
  vim.api.nvim_set_hl(0, "CmpKindUnit", { fg = "#ff6767" })
  vim.api.nvim_set_hl(0, "CmpKindValue", { fg = "#ff6767" })
  vim.api.nvim_set_hl(0, "CmpKindEnum", { fg = "#f694ff" })
  vim.api.nvim_set_hl(0, "CmpKindColor", { fg = "#ff6767" })
  vim.api.nvim_set_hl(0, "CmpKindFile", { fg = "#edecee" })
  vim.api.nvim_set_hl(0, "CmpKindReference", { fg = "#edecee" })
  vim.api.nvim_set_hl(0, "CmpKindFolder", { fg = "#edecee" })
  vim.api.nvim_set_hl(0, "CmpKindEnumMember", { fg = "#f694ff" })
  vim.api.nvim_set_hl(0, "CmpKindConstant", { fg = "#ff6767" })
  vim.api.nvim_set_hl(0, "CmpKindStruct", { fg = "#f694ff" })
  vim.api.nvim_set_hl(0, "CmpKindEvent", { fg = "#61ffca" })
  vim.api.nvim_set_hl(0, "CmpKindOperator", { fg = "#a277ff" })
  vim.api.nvim_set_hl(0, "CmpKindTypeParameter", { fg = "#f694ff" })

  -- Additional popup menu highlights
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "#110f18", fg = "#edecee" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3d375e", fg = "#edecee", bold = true })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#3d375e" })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#a277ff" })

  -- Float border color
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#110f18", fg = "#a277ff" })
end

-- Auto-apply highlights when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    M.setup()
  end,
})

-- Apply highlights immediately
M.setup()

return M
