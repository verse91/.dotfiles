return {
  "MagicDuck/grug-far.nvim",
  opts = {
    prefills = {
      paths = vim.fn.expand("%"),
    },
    engines = {
      ripgrep = {
        extraArgs = "--hidden --no-ignore",
      },
    },
  },
}
