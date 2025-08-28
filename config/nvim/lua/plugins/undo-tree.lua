return {
  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
    },
    config = function()
      -- Undo tree configuration
      vim.g.undotree_WindowLayout = 1
      vim.g.undotree_SplitWidth = 50
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_TreeNodeShape = "*"
      vim.g.undotree_DiffAutoOpen = 1

      -- Windows diff configuration
      if vim.fn.has("win32") == 1 then
        -- Try to find git's diff or use fc command as fallback
        local git_diff = vim.fn.executable("git") == 1 and "git diff --no-index --no-prefix" or nil
        if git_diff then
          vim.g.undotree_DiffCommand = git_diff
        else
          -- Disable diff if no suitable command found
          vim.g.undotree_DiffAutoOpen = 0
        end
      end
    end,
  },
}
