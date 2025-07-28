return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('telescope').setup {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
          },
          prompt_prefix = '🔍 ',
          selection_caret = '➜ ',
          entry_prefix = '  ',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              preview_width = 0.5,
            },
          },
          sorting_strategy = 'ascending',
          file_sorter = require'telescope.sorters'.get_fuzzy_file,
          file_ignore_patterns = {"node_modules", ".git"},
          generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
          path_display = {"truncate"},
          winblend = 10,
          border = {},
          borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
          color_devicons = true,
          use_less = true,
          set_env = { ['COLORTERM'] = 'truecolor' }, -- Default: nil
          file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
          grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
          qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
        }
      }
    end,
  },
}
