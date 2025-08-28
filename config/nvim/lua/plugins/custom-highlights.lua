-- Custom highlight overrides for Aura theme
return {
  {
    "baliestri/aura-theme",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-dark]])
      -- Highlight the line chosen for visual selection
      local ns = vim.api.nvim_create_namespace("visual_line")
      vim.api.nvim_create_autocmd({ "ModeChanged", "CursorMoved" }, {
        callback = function(args)
          local mode = vim.fn.mode()
          if args.event == "ModeChanged" and args.match:match("[vV]:.*") then
            -- track when visual mode is canceled and clear the namespace
            vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
          elseif args.event == "CursorMoved" and mode == "v" or mode == "V" or mode == "" then
            -- clear namespace and re-highlight the range
            vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
            local start_line = vim.fn.line("v")
            local end_line = vim.fn.line(".")
            if start_line > end_line then
              start_line, end_line = end_line, start_line
            end
            vim.api.nvim_buf_set_extmark(0, ns, start_line - 1, 0, {
              end_line = end_line - 1,
              number_hl_group = "CursorLineNr",
            })
          end
        end,
      })

      -- Wait for theme to load, then apply our customizations
      vim.defer_fn(function()
        -- Only customize selection color - keep everything else from Aura theme
        vim.api.nvim_set_hl(0, "Visual", { bg = "#4a4a4a" })
      end, 100)
    end,
  },
}
