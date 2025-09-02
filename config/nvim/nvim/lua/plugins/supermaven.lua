return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Right>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = {
        "cpp",
      },
      color = {
        suggestion_color = "#414141",
        cterm = 244,
      },
      disable_inline_completion = false,
      disable_keymaps = false,
    })
  end,
}
