return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function(_, opts)
      -- Set up Neo-tree with custom options
      require("neo-tree").setup(opts)

      -- Custom highlight groups for Neo-tree background
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Change these colors to your preference:
          -- For a darker background:
          vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#110f18" })
          vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#110f18" })
          vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#110f18" })
          vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "#110f18", fg = "#3b334b" })
          vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#3b334b" })

          -- Hide the header/title completely
          vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = "#110f18", bg = "#110f18" })
          vim.api.nvim_set_hl(0, "NeoTreeTabInactive", { fg = "#110f18", bg = "#110f18" })
          vim.api.nvim_set_hl(0, "NeoTreeTabActive", { fg = "#110f18", bg = "#110f18" })
          vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorInactive", { fg = "#110f18", bg = "#110f18" })
          vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorActive", { fg = "#110f18", bg = "#110f18" })

          -- For a lighter background (uncomment these instead):
          -- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#f0f0f0" })
          -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#f0f0f0" })
          -- vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#f0f0f0" })
          -- vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "#f0f0f0", fg = "#d0d0d0" })

          -- For a custom color (example: dark blue):
          -- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#1e1e2e" })
          -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#1e1e2e" })
          -- vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "#1e1e2e" })
          -- vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "#1e1e2e", fg = "#313244" })
        end,
      })

      -- Apply the highlights immediately
      vim.schedule(function()
        vim.cmd("doautocmd ColorScheme")
      end)
    end,
    opts = {
      -- Hide the header/title bar
      enable_git_status = true,
      enable_diagnostics = true,
      sources = { "filesystem", "buffers", "git_status" },
      source_selector = {
        winbar = false,
        statusline = false,
        show_scrolled_off_parent_node = false,
        content_layout = "start",
        tabs_layout = "equal",
        sources = {
          { source = "filesystem", display_name = "" },
          { source = "buffers", display_name = "" },
          { source = "git_status", display_name = "" },
        },
      },
      -- Custom highlighting
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        window = {
          -- Show only current folder name instead of full path
          width = 30,
        },
        components = {
          name = function(config, node, state)
            local name = node.name
            if node.type == "directory" and node:get_depth() == 1 then
              -- For root directory, show only folder name
              name = vim.fn.fnamemodify(node.path, ":t")
              if name == "" then
                name = vim.fn.fnamemodify(node.path, ":p:h:t")
              end
            end
            return {
              text = name,
              highlight = node.type == "directory" and "NeoTreeDirectoryName" or "NeoTreeFileName",
            }
          end,
        },
      },
      window = {
        position = "left",
        -- Show only current folder name, not full path
        popup_border_style = "rounded",
        -- Hide the header/title bar
        insert_as = "child",
        auto_expand_width = false,
        mappings = {
          ["J"] = function(state)
            local tree = state.tree
            local node = tree:get_node()
            local siblings = tree:get_nodes(node:get_parent_id())
            local renderer = require("neo-tree.ui.renderer")
            renderer.focus_node(state, siblings[#siblings]:get_id())
          end,
          ["K"] = function(state)
            local tree = state.tree
            local node = tree:get_node()
            local siblings = tree:get_nodes(node:get_parent_id())
            local renderer = require("neo-tree.ui.renderer")
            renderer.focus_node(state, siblings[1]:get_id())
          end,
        },
      },
      sort_function = function(a, b)
        -- Simplified check if a path is in the 'notes' directory
        local function is_in_notes_directory(path)
          return string.match(path, "/notes/") or string.match(path, "^notes/")
        end

        -- Get the modification time of a file
        local function get_mod_time(path)
          local attributes = vim.loop.fs_stat(path)
          return attributes and attributes.mtime.sec or 0
        end

        -- Prioritize directories over files
        if a.type ~= b.type then
          return a.type == "directory"
        end

        local a_in_notes = is_in_notes_directory(a.path)
        local b_in_notes = is_in_notes_directory(b.path)

        -- If both nodes are files in 'notes' directories, sort by modification time
        if a_in_notes and b_in_notes and a.type ~= "directory" and b.type ~= "directory" then
          return get_mod_time(a.path) > get_mod_time(b.path)
        end

        -- Default sort by name, assuming `name` property or similar is available
        -- You might need to extract the name from `a.path` and `b.path` if direct comparison is needed
        local a_name = a.path:match("^.+/(.+)$") or a.path
        local b_name = b.path:match("^.+/(.+)$") or b.path
        return a_name < b_name
      end,
    },
  },
}
