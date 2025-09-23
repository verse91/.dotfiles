return {
  {
    "saghen/blink.cmp",
    opts = {
      fuzzy = {
        -- Force use of lua implementation to avoid conflicts with fff.nvim
        implementation = "lua",
      },
      keymap = {
        preset = nil, -- Use enter preset as base
        ["<CR>"] = false,
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
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_backward()
            else
              return false
            end
          end,
          "fallback",
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
        menu = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,Search:None",
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
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        },
      },
      sources = {
        default = { "snippets", "lazydev", "lsp", "path", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 90,
          },
          lsp = {
            min_keyword_length = 2, -- Number of characters to trigger provider
            score_offset = 0, -- Boost/penalize the score of the items
          },
          path = {
            min_keyword_length = 0,
            score_offset = -10,
          },
          snippets = {
            min_keyword_length = 1,
            score_offset = 100,
          },
          buffer = {
            min_keyword_length = 4,
            max_items = 5,
            score_offset = -20,
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
