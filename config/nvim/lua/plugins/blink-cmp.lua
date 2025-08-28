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
        list = {
          selection = { kind = "auto_select" }, -- Auto-select first item without inserting
        },
        trigger = {
          prefetch_on_insert = true,
        },
        menu = {
          auto_show = true,
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon", "label", gap = 1 },
              { "kind", "source_name" },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon = ctx.kind_icon or ""
                  return kind_icon .. " "
                end,
                highlight = function(ctx)
                  return "CmpKind" .. ctx.kind
                end,
              },
              label = {
                text = function(ctx)
                  return ctx.label
                end,
                highlight = "BlinkCmpLabel",
              },
              kind = {
                text = function(ctx)
                  return ctx.kind
                end,
                highlight = "BlinkCmpKind",
              },
              source_name = {
                text = function(ctx)
                  return ctx.source_name
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
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
        default = { "snippets", "lsp", "path", "buffer" },
        providers = {
          snippets = {
            name = "Snippets",
            priority = 1000,
            opts = {
              friendly_snippets = true,
              search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            },
          },
          lsp = {
            name = "LSP",
            priority = 800,
          },
          path = {
            name = "Path", 
            priority = 600,
          },
          buffer = {
            name = "Buffer",
            priority = 400,
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
