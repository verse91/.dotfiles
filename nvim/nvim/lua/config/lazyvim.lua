-- LazyVim configuration overrides
-- This file is loaded after LazyVim's default configuration

-- Disable conflicting extras
vim.g.lazyvim_picker = "snacks" -- Use snacks picker instead of telescope

return {
  -- Disable neo-tree extra since we're using snacks explorer
  { import = "lazyvim.plugins.extras.editor.neo-tree", enabled = false },
  
  -- Disable telescope extra since we're using snacks picker  
  { import = "lazyvim.plugins.extras.editor.telescope", enabled = false },
  
  -- Disable fzf since we're using snacks
  { import = "lazyvim.plugins.extras.editor.fzf", enabled = false },
}
