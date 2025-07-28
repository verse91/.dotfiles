-- -- Disabled blink.cmp configuration (using nvim-cmp instead)
-- return {
--   -- Empty table to prevent nil return error
-- }

return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter", -- Use enter preset as base
        -- Custom Tab behavior to match your nvim-cmp config
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_forward()
            elseif cmp.is_visible() then
              return cmp.accept()
            else
              return false
            end
          end,
          "fallback"
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_backward()
            else
              return false
            end
          end,
          "fallback"
        },
        ["<C-Space>"] = { "show" },
        ["<C-y>"] = { "select_and_accept" },
      },
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        list = {
          selection = { kind = "auto_select" }, -- Auto-select first item without inserting
        },
        trigger = {
          prefetch_on_insert = true,
        },
        menu = {
          auto_show = true,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
              { "source_name" },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = false, -- Enable ghost text for snippet preview
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            opts = {
              friendly_snippets = true,
              search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            },
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = {
          Snippet = "󰩫",
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      },
    },
  },
}
