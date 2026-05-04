require("catppuccin").setup({
    no_italic = false,
    term_colors = true,
    transparent_background = false,
    color_overrides = {
        mocha = {
            base     = "#000000",
            text     = "#c8c6d0",
            overlay0 = "#6e6c7e",
            subtext0 = "#5c5a72",
            pink     = "#d4608a",
            green    = "#86c16e",
            yellow   = "#d4a65a",
            mauve    = "#a98be0",
            teal     = "#56c2b0",
            red      = "#cc6666",
        },
    },
    custom_highlights = function(colors)
        return {
            ["Comment"]                = { fg = colors.overlay0, style = { "italic" } },
            ["@comment"]               = { fg = colors.overlay0, style = { "italic" } },
            ["@keyword"]               = { fg = colors.pink, style = { "bold" } },
            ["@keyword.return"]        = { fg = colors.pink, style = { "bold" } },
            ["@keyword.function"]      = { fg = colors.pink, style = { "bold" } },
            ["@keyword.operator"]      = { fg = colors.pink },
            ["@type"]                  = { fg = colors.teal },
            ["@type.builtin"]          = { fg = colors.teal, style = { "bold" } },
            ["@function"]              = { fg = colors.green },
            ["@function.call"]         = { fg = colors.green },
            ["@function.builtin"]      = { fg = colors.green, style = { "bold" } },
            ["@method"]                = { fg = colors.green },
            ["@method.call"]           = { fg = colors.green },
            ["@string"]                = { fg = colors.yellow },
            ["@string.escape"]         = { fg = colors.mauve },
            ["@number"]                = { fg = colors.mauve },
            ["@float"]                 = { fg = colors.mauve },
            ["@boolean"]               = { fg = colors.mauve, style = { "bold" } },
            ["@constant"]              = { fg = colors.mauve },
            ["@constant.builtin"]      = { fg = colors.mauve, style = { "bold" } },
            ["@variable.member"]       = { fg = colors.yellow, style = { "italic" } },
            ["@property"]              = { fg = colors.yellow, style = { "italic" } },
            ["@parameter"]             = { fg = colors.yellow, style = { "italic" } },
            ["@variable"]              = { fg = colors.text },
            ["@punctuation.bracket"]   = { fg = colors.subtext0 },
            ["@punctuation.delimiter"] = { fg = colors.subtext0 },
            ["@operator"]              = { fg = colors.subtext0 },
            ["@namespace"]             = { fg = colors.teal, style = { "italic" } },
            ["@module"]                = { fg = colors.teal, style = { "italic" } },
        }
    end,
})

vim.cmd [[colorscheme catppuccin-mocha]]

require('lualine').setup({ options = { globalstatus = true } })

require("ibl").setup({
    indent = { char = "│", tab_char = "│" },
    scope  = { enabled = true, show_start = false, show_end = false },
    exclude = {
        filetypes = { "help", "terminal", "lazy", "packer", "telescope", "oil" },
    },
})
