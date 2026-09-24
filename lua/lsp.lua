return {
    {
        "williamboman/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry", -- provides the roslyn server
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = { "lua_ls", "clangd", "eslint", "ts_ls" },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        opts = {
            servers = {
                lua_ls = {},
                clangd = {},
                pyright = {},
                eslint = {}, -- linter
                ts_ls = {}, -- TS/JS/React intellisense
            },
        },
        config = function(_, opts)
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
            for server, config in pairs(opts.servers) do
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end

            -- ESLint auto-fix on save
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
            --     command = "silent! LspEslintFixAll",
            -- })
        end,
    },

    -- C# (Roslyn). Not part of the servers table above.
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        opts = {},
        config = function(_, opts)
            vim.lsp.config("roslyn", {
                settings = {
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_types = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        dotnet_enable_inlay_hints_for_parameters = true,
                    },
                },
            })
            require("roslyn").setup(opts)
        end,
    },

    -- Prettier
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                markdown = { "prettier" },
            },
            -- C# has no entry, so it falls back to Roslyn's formatter
            -- format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },
        },
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            })
            opts.sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            })
        end,
    },
}
