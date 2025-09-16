return {
  "sphamba/smear-cursor.nvim",
  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
    smear_insert_mode = true,

    stiffness = 1.0,
    trailing_stiffness = 0.8,
    stiffness_insert_mode = 0.9,
    trailing_stiffness_insert_mode = 0.9,
    damping = 0.9,
    damping_insert_mode = 0.9,
    distance_stop_animating = 0.5,
    time_interval = 10,
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
