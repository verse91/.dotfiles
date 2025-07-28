return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      -- Customize the which-key panel appearance and behavior
      opts.preset = "helix" -- Keeping helix style
      opts.delay = 100 -- delay before showing which-key (in ms)
      opts.sort = { "local", "order", "group", "alphanum", "mod" } -- Control sorting order
      opts.keys = {
          scroll_up = "<Up>", -- binding to scroll up inside the popup
        scroll_down = "<Down>", -- binding to scroll down inside the popup
      }
      opts.filter = function(mapping)
        -- Filter out mappings you don't want to show
        -- Hide mappings without descriptions
        if not mapping.desc or mapping.desc == "" then
          return false
        end

        -- Hide Keywordprg specifically
        if mapping.lhs == "K" and (mapping.desc == "Keywordprg" or mapping.desc:match("Keywordprg")) then
          return false
        end

        -- Hide specific keybindings you don't want to see
        local hidden_keys = {
          -- Other keys you might want to hide:
          -- "<leader>l", -- Hide Lazy menu
          -- "<leader>L", -- Hide LazyVim changelog
        }

        for _, key in ipairs(hidden_keys) do
          if mapping.lhs == key then
            return false
          end
        end

        return true
      end
      opts.spec = opts.spec or {}

      -- Add custom key descriptions and groups
      local custom_spec = {
        -- Custom group names and descriptions
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug/Disable" },
        { "<leader>e", group = "Explorer" },
        { "<leader>f", group = "File/Find" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>j", group = "Jump" },
        { "<leader>k", group = "Keymaps" },
        { "<leader>l", group = "LSP/Lazy" },
        { "<leader>m", group = "Markdown" },
        { "<leader>r", group = "Replace/Registers" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Terminal/Toggle" },
        { "<leader>u", group = "UI/Undo" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Diagnostics/Trouble" },

        -- Custom key descriptions
        { "<leader>fp", desc = "Show full file path" },
        { "<leader>bw", desc = "Close all buffers" },
        { "<leader>da", desc = "Disable auto wrap" },
        { "<leader>ea", desc = "Enable auto wrap" },
        { "<leader>mb", desc = "Auto bold" },
        { "<leader>mi", desc = "Auto italic" },
        { "<leader>ml", desc = "Auto link" },
        { "<leader>mc", desc = "Auto backtick" },
        { "<leader>jt", desc = "Jump to template" },
        { "<leader>js", desc = "Jump to styles" },
        { "<leader>jc", desc = "Jump to component" },
        { "<leader>ha", desc = "Harpoon add file" },
        { "<leader>h", desc = "Harpoon menu" },
        { "<leader>hl", desc = "Harpoon next" },
        { "<leader>hh", desc = "Harpoon next" },
        { "<leader>ut", desc = "Undo tree" },
        { "<leader>?", desc = "Find recently opened files" },
        { "<leader>sd", desc = "Search diagnostics" },
        { "<leader>jl", desc = "Jump list" },
        { "<leader>km", desc = "Keymaps" },
        { "<leader>rg", desc = "Registers" },
        { "<leader>ht", desc = "Help tags" },
        { "zR", desc = "Open all folds" },
        { "zM", desc = "Close all folds" },
        { "U", desc = "Scroll up (centered)" },
        { "D", desc = "Scroll down (centered)" },
        { "J", desc = "Join lines" },
      }

      -- Merge custom spec with existing spec
      vim.list_extend(opts.spec, custom_spec)

      return opts
    end,
  },
}
