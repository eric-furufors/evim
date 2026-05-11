return {

  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      columns = { "icon" },
      view_options = { show_hidden = false },
      use_default_keymaps = false,
      keymaps = {
        ["<CR>"] = "actions.select",
        ["<BS>"] = "actions.parent",
        ["_"]    = "actions.open_cwd",
        ["q"]    = "actions.close",
        ["gs"]   = "actions.change_sort",
        ["g."]   = "actions.toggle_hidden",
        ["g?"]   = "actions.show_help",
        ["gx"]   = "actions.open_external",
      },
    },
    init = function()
      if vim.fn.argc() == 0 then
        vim.defer_fn(function()
          require("oil").open()
        end, 1)
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua", "python", "c", "cpp" },
      highlight = { enable = true },
    },
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  {
    "sindrets/winshift.nvim",
    opts = {},
  },

}
