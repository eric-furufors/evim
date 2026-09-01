return {
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- Only keep the ones that actually work
      ensure_installed = { "lua_ls", "clangd" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    opts = {
      servers = {
        lua_ls = {},
        clangd = {},
        pyright = {},
      },
    },
    config = function(_, opts)
      -- The modern 0.11+ way to enable servers
      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },

  -- DADBOD SETUP (The stable replacement for SQL work)
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      -- Optional: Setup DBUI settings here
      vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { 
      "hrsh7th/cmp-nvim-lsp",
      "kristijanhusak/vim-dadbod-completion", -- Add this as a dependency
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })
      -- This is the key: Tell cmp to use Dadbod for sql files
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }, {
        { name = "buffer" },
      })

      -- Add this specifically for SQL files
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
