-- Snacks.nvim comprehensive configuration
-- Replaces Neo-tree and Telescope completely
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- Enable all snacks features
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      dim = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      lazygit = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      toggle = { enabled = true },
      terminal = {
        enabled = true,
        size = { width = 0.8, height = 0.4 }, -- kích thước cửa sổ
        shell = "pwsh.exe",
        open_mapping = "<c-t>",
        win = {
          style = "float", -- bắt buộc phải là float
          relative = "editor",
          border = "rounded", -- tùy chọn: "single", "double", "rounded", "solid", "shadow"
        },
        enter_insert = true, -- tự động vào insert mode
        on_exit = function(job_id, exit_code, event_type)
          -- Khi terminal thoát, ép job terminate để tránh E948
          vim.fn.jobstop(job_id)
        end,
      },
      words = { enabled = true },
      zen = { enabled = true },

      -- Explorer configuration
      explorer = {
        enabled = true,
        -- AUTO OPEN: Tự động mở khi chạy nvim với thư mục
        auto_open = function()
          return vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1
        end,

        hidden = false,
        ignored = false,
        git_status = true,
        git_untracked = true,
        diagnostics = true,
        tree = true,
        watch = true,
        follow_file = true,

        -- Layout: Sidebar bên trái với width tùy chỉnh

        focus = "list",
        auto_close = false,

        -- Formatting
        formatters = {
          file = {
            filename_only = true,
            icon_width = 2,
            git_status_hl = true,
          },
          severity = { pos = "right" },
        },

        -- Search/Sort
        matcher = {
          sort_empty = false,
          fuzzy = false,
          ignorecase = true,
          smartcase = true,
        },

        sort = {
          fields = { "sort" },
        },
      },

      -- Picker configuration
      picker = {
        enabled = true,
        ui_select = true,
        win = {
          border = "rounded",
        },

        sources = {
          explorer = {
            layout = {
              layout = {
                preset = "sidebar",
                position = "left",
                width = 25, -- FIXED: Width đúng cách
                backdrop = false,
              },
            },
          },
          files = {
            hidden = false,
            ignored = false,
          },
          grep = {
            hidden = false,
            ignored = false,
          },
        },

        layout = {
          preset = function()
            return vim.o.columns >= 120 and "default" or "vertical"
          end,
        },
      },
    },

    keys = {
      -- === EXPLORER ===
      {
        "<leader>e",
        function()
          Snacks.explorer.toggle()
        end,
        desc = "Toggle Explorer",
      },
      {
        "<leader>fe",
        function()
          Snacks.explorer.reveal()
        end,
        desc = "Reveal in Explorer",
      },

      -- === SMART FINDER ===
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>,",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },

      -- === FILE PICKERS ===
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Git Files",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent Files",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.config_files()
        end,
        desc = "Config Files",
      },

      -- === SEARCH PICKERS ===
      {
        "<leader>sg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Grep Word",
      },
      {
        "<leader>sb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },

      -- === UTILITY PICKERS ===
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help",
      },
      {
        "<leader>sc",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>sj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>sm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo History",
      },
      {
        "<leader>sR",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },

      -- === LSP PICKERS ===
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        desc = "References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto Type Definition",
      },
      {
        "<leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>sS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },

      -- === GIT PICKERS ===
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff",
      },

      -- === ADDITIONAL FEATURES ===
      {
        "<leader>uz",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>ud",
        function()
          Snacks.dim()
        end,
        desc = "Toggle Dim",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Show Notification History",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },

      -- === GIT FEATURES ===
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
      },
      {
        "<leader>gf",
        function()
          Snacks.lazygit.log_file()
        end,
        desc = "Lazygit File History",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },

      -- === TERMINAL ===
      {
        "<c-t>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },

      -- === WORD NAVIGATION ===
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
      },
    },
  },

  -- Disable conflicting plugins
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
