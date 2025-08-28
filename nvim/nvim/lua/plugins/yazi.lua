--- @type LazySpec
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>-",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  --- @type YaziConfig | {}
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    
    -- Configure floating window to match Aura theme
    floating_window_scaling_factor = 0.9,
    yazi_floating_window_winblend = 0,
    yazi_floating_window_border = "rounded",
    
    keymaps = {
      show_help = "<f1>",
    },
    
    -- Configure highlight groups for Aura theme
    highlight_groups = {
      hovered_buffer = { bg = "#3d375e", fg = "#a277ff" }, -- Aura purple
      hovered_buffer_in_same_directory = { bg = "#2a2a2a", fg = "#61ffca" }, -- Aura cyan
    },
  },
}
