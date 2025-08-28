return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "saadparwaiz1/cmp_luasnip", -- For LuaSnip integration
--     "L3MON4D3/LuaSnip",
--     "rafamadriz/friendly-snippets",
--   },
--   opts = function(_, opts)
--     local cmp = require("cmp")
--     local luasnip = require("luasnip")

--     -- Load friendly snippets
--     require("luasnip.loaders.from_vscode").lazy_load()

--     local format_kinds = opts.formatting.format
--     opts.formatting.format = function(entry, item)
--       format_kinds(entry, item)
--       return require("tailwindcss-colorizer-cmp").formatter(entry, item)
--     end

--     -- Custom sorting with your requested configuration
--     opts.sorting = {
--       priority_weight = 2,
--       comparators = {
--         require("cmp.config.compare").locality,      -- gần vị trí con trỏ
--         require("cmp.config.compare").recently_used, -- 🧠 ưu tiên cái bạn vừa dùng
--         require("cmp.config.compare").score,         -- điểm match cao
--         require("cmp.config.compare").offset,
--         require("cmp.config.compare").exact,
--         require("cmp.config.compare").sort_text,
--         require("cmp.config.compare").length,
--         require("cmp.config.compare").order,
--       },
--     }

--     -- Enable ghost text
--     opts.experimental = {
--       ghost_text = true, -- Enable ghost text preview
--     }

--     -- Helper function to check if we have words before cursor
--     local has_words_before = function()
--       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--     end

--     opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
--       ["<Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_next_item()
--         elseif luasnip.expand_or_locally_jumpable() then
--           luasnip.expand_or_jump()
--         elseif has_words_before() then
--           cmp.complete()
--         else
--           fallback()
--         end
--       end, { "i", "s" }),

--       ["<S-Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_prev_item()
--         elseif luasnip.locally_jumpable(-1) then
--           luasnip.jump(-1)
--         else
--           fallback()
--         end
--       end, { "i", "s" }),

--       ["<CR>"] = cmp.mapping({
--         i = function(fallback)
--           if cmp.visible() and cmp.get_active_entry() then
--             cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
--           else
--             fallback()
--           end
--         end,
--         s = cmp.mapping.confirm({ select = true }),
--         c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
--       }),

--       ["<C-Space>"] = cmp.mapping.complete(),
--     })

--     -- Enable autocompletion
--     opts.completion = {
--       autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
--     }

--     return opts
--   end,
}
