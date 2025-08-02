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
      dashboard = { enabled = false }, -- We might use it later
      dim = { enabled = true }, -- Dim inactive windows
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true }, -- Show scope information
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      toggle = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true }, -- Zen mode

      -- Picker configuration (replaces Telescope)
      picker = {
        enabled = false,
        ui_select = true, -- replace vim.ui.select
        sources = {
          explorer = {
            -- Explorer specific settings
            hidden = false, -- show hidden files by default
            ignored = false, -- show ignored files by default
            git_status = true, -- show git status
            git_untracked = true, -- show untracked files
            git_status_open = false, -- don't show recursive git status for open dirs
            diagnostics = true, -- show diagnostics
            diagnostics_open = false, -- don't show recursive diagnostics for open dirs
            tree = true, -- show file tree
            watch = true, -- watch for file changes
            follow_file = true, -- follow current file

            -- Layout configuration for sidebar
            layout = {
              preset = "sidebar",
              preview = "main", -- show preview in main window
              position = "left",
            },

            focus = "input", -- focus on search input when opening
            auto_close = false, -- don't auto close
            jump = { close = false }, -- don't close when jumping to files

            -- Formatting
            formatters = {
              file = {
                filename_only = true, -- show only filename, not full path
                icon_width = 2,
                git_status_hl = true, -- use git status highlight
              },
              severity = { pos = "right" }, -- diagnostics on the right
            },

            -- Matching/searching
            matcher = {
              sort_empty = false, -- don't sort when search is empty
              fuzzy = false, -- disable fuzzy matching for file browsing
              ignorecase = true,
              smartcase = true,
            },

            -- Sorting
            sort = {
              fields = { "sort" }, -- use the built-in sort field for explorer
            },
          },

          -- Configure other pickers to match your preferences
          files = {
            hidden = false, -- don't show hidden files by default in file picker
            ignored = false, -- don't show ignored files by default
          },

          grep = {
            hidden = false,
            ignored = false,
          },
        },

        -- General picker settings
        layout = {
          preset = function()
            return vim.o.columns >= 120 and "default" or "vertical"
          end,
        },
      },
    },

    keys = {
      {
        "<leader><space>",
        function()
          require("snacks").picker.smart()
        end,
        desc = "Smart Finder (Snacks)",
      },
      {
        "<leader>ff",
        function()
          require("snacks").picker.files()
        end,
        desc = "Find Files (Snacks)",
      },
      {
        "<leader>/",
        function()
          require("snacks").picker.grep()
        end,
        desc = "Grep (Snacks)",
      },
      {
        "<leader>,",
        function()
          require("snacks").picker.buffers()
        end,
        desc = "Buffers (Snacks)",
      },
      {
        "<leader>:",
        function()
          require("snacks").picker.command_history()
        end,
        desc = "Command History (Snacks)",
      },

      -- === File operations ===
      {
        "<leader>fb",
        function()
          require("snacks").picker.buffers()
        end,
        desc = "Buffers (Snacks)",
      },
      {
        "<leader>fn",
        function()
          require("snacks").picker.oldfiles()
        end,
        desc = "Recent Files (Snacks)",
      },
      {
        "<leader>fc",
        function()
          require("snacks").picker.config_files()
        end,
        desc = "Config Files (Snacks)",
      },

      -- === Search ===
      {
        "<leader>sg",
        function()
          require("snacks").picker.grep()
        end,
        desc = "Grep (Snacks)",
      },
      {
        "<leader>sw",
        function()
          require("snacks").picker.word()
        end,
        desc = "Word under cursor (Snacks)",
      },
      {
        "<leader>sb",
        function()
          require("snacks").picker.current_buffer()
        end,
        desc = "Lines in Buffer (Snacks)",
      },

      -- === Project, Diagnostic, Commands ===
      {
        "<leader>p",
        function()
          require("snacks").picker.projects()
        end,
        desc = "Projects (Snacks)",
      },
      {
        "<leader>td",
        function()
          require("snacks").picker.diagnostics()
        end,
        desc = "Diagnostics (Snacks)",
      },
      {
        "<leader>cm",
        function()
          require("snacks").picker.commands()
        end,
        desc = "Commands (Snacks)",
      },

      -- === File Explorer ===
      {
        "<leader>e",
        function()
          require("snacks").explorer.toggle()
        end,
        desc = "Toggle Explorer (Snacks)",
      },
      -- Explorer keys
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "Explorer",
      },
      {
        "<leader>fe",
        function()
          Snacks.explorer.reveal()
        end,
        desc = "Reveal in Explorer",
      },

      -- Top level pickers
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

      -- File pickers
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

      -- Search pickers
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

      -- Utility pickers
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

      -- LSP pickers
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

      -- Git pickers
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

      -- Additional Snacks features
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
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gf",
        function()
          Snacks.lazygit.log_file()
        end,
        desc = "Lazygit Current File History",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gl",
        function()
          Snacks.lazygit.log()
        end,
        desc = "Lazygit Log (cwd)",
      },
      {
        "<c-/>",
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
      {
        "]]<",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
      },
      {
        "[[<",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
      },
    },
  },

  -- Disable telescope and neo-tree
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
