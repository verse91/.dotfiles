return {
  "dmtrKovalenko/fff.nvim",
  build = "cargo build --release",
  opts = {
    prompt = " ",
    max_results = 100,
    layout = {
      width = 0.8,
      height = 0.8,
      prompt_position = "bottom",
      preview_position = "right",
      preview_size = 0.5,
    },
  },
  keys = {
    {
      "ff",
      function()
        require("fff").find_files()
      end,
      desc = "Open file picker",
    },
  },
}
