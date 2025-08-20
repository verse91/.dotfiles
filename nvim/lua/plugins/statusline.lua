-- Custom lualine configuration with Aura theme
-- Custom status line
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    -- Custom Lualine component to show attached language server
    local clients_lsp = function()
      local bufnr = vim.api.nvim_get_current_buf()

      local clients = vim.lsp.get_clients({ bufnr = bufnr }) -- Pass bufnr to get clients for current buffer
      if next(clients) == nil then
        return ""
      end

      local c = {}
      for _, client in pairs(clients) do
        table.insert(c, client.name)
      end
      return " " .. table.concat(c, "|")
    end

    -- Function to get mode icon
    local mode_icon = function()
      local current_mode = vim.fn.mode()
      if current_mode == "n" then
        return " NORMAL" -- Icon for Normal mode (changed from  to )
      elseif current_mode == "i" then
        return " INSERT" -- Icon for Insert mode
      elseif current_mode == "v" then
        return " VISUAL" -- Icon for Visual mode
      elseif current_mode == "V" then
        return " V-LINE" -- Icon for Visual Line mode
      elseif current_mode == "" then
        return " V-BLOCK" -- Icon for Visual Block mode
      elseif current_mode == "R" then
        return " REPLACE" -- Icon for Replace mode
      elseif current_mode == "c" then
        return " COMMAND" -- Icon for Command mode
      -- Add more modes and icons as needed
      else
        return " " .. current_mode:upper() -- Default icon for other modes
      end
    end

    -- Your original Aura theme with proper colors
    local custom_theme = {
      normal = {
        a = { fg = "#ffffff", bg = "#a277ff", gui = "bold" },
        b = { fg = "#edecee", bg = "#29263c" },
        c = { fg = "#6d6d6d", bg = "#15141b" },
      },
      insert = {
        a = { fg = "#15141b", bg = "#61ffca", gui = "bold" },
        b = { fg = "#edecee", bg = "#29263c" },
        c = { fg = "#6d6d6d", bg = "#15141b" },
      },
      visual = {
        a = { fg = "#15141b", bg = "#ffca85", gui = "bold" },
        b = { fg = "#edecee", bg = "#29263c" },
        c = { fg = "#6d6d6d", bg = "#15141b" },
      },
      replace = {
        a = { fg = "#ffffff", bg = "#ff6767", gui = "bold" },
        b = { fg = "#edecee", bg = "#29263c" },
        c = { fg = "#6d6d6d", bg = "#15141b" },
      },
      command = {
        a = { fg = "#15141b", bg = "#82e2ff", gui = "bold" },
        b = { fg = "#edecee", bg = "#29263c" },
        c = { fg = "#6d6d6d", bg = "#15141b" },
      },
      inactive = {
        a = { fg = "#6d6d6d", bg = "#29263c" },
        b = { fg = "#6d6d6d", bg = "#15141b" },
        c = { fg = "#6d6d6d", bg = "#15141b" },
      },
    }

    require("lualine").setup({
      options = {
        theme = custom_theme,
        -- Use powerline symbols for separators
        component_separators = { left = "", right = "" }, -- Adjusted for better visual flow
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "Outline" },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            mode_icon, -- Call the function to get the mode icon and text
            separator = { left = "", right = "" }, -- Add separators for this component
            right_padding = 2,
          },
        },
        lualine_b = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 2, right = 0 },
            separator = { left = "", right = "" },
          },
          {
            "filename",
            symbols = {
              modified = "●", -- Dot for modified
              readonly = "", -- Lock for readonly
              unnamed = "", -- Question mark for unnamed
              newfile = "", -- Plus for new file
            },
            separator = { left = "", right = "" },
          },
          {
            "branch",
            icon = "", -- Git branch icon
            color = { fg = "#a277ff" },
            separator = { left = "", right = "" },
          },
          {
            "diff",
            symbols = {
              added = " ", -- Plus for added
              modified = " ", -- Tilde for modified
              removed = " ", -- Minus for removed
            },
            colored = true,
            diff_color = {
              added = { fg = "#61ffca" },
              modified = { fg = "#ffca85" },
              removed = { fg = "#ff6767" },
            },
            separator = { left = "", right = "" },
          },
        },
        lualine_c = {
          {
            function()
              local recording_register = vim.fn.reg_recording()
              if recording_register == "" then
                return ""
              else
                return "  Recording @" .. recording_register -- Microphone icon
              end
            end,
            color = { fg = "#ff6767", gui = "bold" },
          },
        },
        lualine_x = {
          {
            function()
              local buf_size = vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0))
              if buf_size < 1024 then
                return string.format("  %dB", buf_size) -- Database icon
              elseif buf_size < 1024 * 1024 then
                return string.format("  %.1fK", buf_size / 1024)
              else
                return string.format("  %.1fM", buf_size / (1024 * 1024))
              end
            end,
            color = { fg = "#82e2ff" },
            separator = { left = "", right = "" },
          },
          {
            "diagnostics",
            symbols = {
              error = " ", -- Times icon for error
              warn = " ", -- Exclamation triangle for warning
              info = " ", -- Info circle for info
              hint = " ", -- Lightbulb for hint
            },
            diagnostics_color = {
              error = { fg = "#ff6767" },
              warn = { fg = "#ffca85" },
              info = { fg = "#82e2ff" },
              hint = { fg = "#61ffca" },
            },
            update_in_insert = false,
            separator = { left = "", right = "" },
          },
        },
        lualine_y = {
          {
            clients_lsp,
            icon = " ", -- Gear icon for LSP clients
            color = { fg = "#a277ff" },
            separator = { left = "", right = "" },
          },
          {
            "branch", -- Added branch to lualine_y
            icon = "", -- Git branch icon
            color = { fg = "#a277ff" },
            separator = { left = "", right = "" },
          },
          {
            "filetype",
            icon = " ", -- File icon
            color = { fg = "#edecee" },
            separator = { left = "", right = "" },
          },
          {
            "progress",
            icon = " ", -- Clipboard icon for progress
            color = { fg = "#61ffca" },
            separator = { left = "", right = "" },
          },
        },
        lualine_z = {
          {
            "location",
            icon = "un", -- Location pin icon
            separator = { left = "", right = "" },
            left_padding = 2,
          },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            show_filename_only = true,
            hide_filename_extension = false,
            mode = 0,
            buffers_color = {
              active = "lualine_a_normal",
              inactive = "lualine_a_inactive",
            },
            separator = { left = "", right = "" },
            symbols = {
              modified = " ",
              directory = "",
            },
          },
        },
        lualine_y = {
          {
            function()
              return " VERSE"
            end,
            separator = { left = "", right = "" },
            color = { fg = "#61ffca", bg = "#29263c" },
          },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%H:%M") -- Clock icon
            end,
            separator = { left = "", right = "" },
            color = { fg = "#edecee", bg = "#a277ff" },
          },
        },
      },
    })
  end,
}
