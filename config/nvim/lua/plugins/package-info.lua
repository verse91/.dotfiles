return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  keys = {
    {
      "<leader>ns",
      "<cmd>lua require('package-info').show()<cr>",
      desc = "Show Package Info",
    },
    {
      "<leader>nu",
      "<cmd>lua require('package-info').update()<cr>",
      desc = "Update Package",
    },
    {
      "<leader>nd",
      "<cmd>lua require('package-info').delete()<cr>",
      desc = "Delete Package",
    },
  },
  config = function()
    require("package-info").setup({
      -- Không cần Telescope
      autostart = true,
      hide_up_to_date = true,
    })
  end,
}
