return {
  "sphamba/smear-cursor.nvim",
  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
    smear_insert_mode = true,

    stiffness = 0.8,
    trailing_stiffness = 0.6,
    stiffness_insert_mode = 0.7,
    trailing_stiffness_insert_mode = 0.7,
    damping = 0.95,
    damping_insert_mode = 0.95,
    distance_stop_animating = 0.5,
    time_interval = 17,
    cursor_color = "#d3cdc3",
  },
  config = function(_, opts)
    require("smear_cursor").setup(opts)
    -- tùy chọn bật/tắt nhanh
    vim.api.nvim_create_user_command("SmearCursorToggle", function()
      require("smear_cursor").toggle()
    end, {})
  end,
}
