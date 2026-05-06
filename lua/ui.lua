-- ============================================================
-- PALETTE — change values here only, everything else updates
-- ============================================================
local P = {
    -- Base tones — warm brown
    base     = "#2e2620",
    mantle   = "#251e18",
    crust    = "#1c1712",
    surface0 = "#3d3028",
    surface1 = "#544538",
    overlay0 = "#9a8e86",  -- bumped up, comments more visible
    subtext0 = "#d4c4bc",  -- *** much brighter, dim monitor safe
    text     = "#ddd0c8",

    -- Accents unchanged
    pink     = "#d75f87",
    green    = "#87af5f",
    yellow   = "#d7af5f",
    mauve    = "#af87d7",
    teal     = "#5fafaf",
    red      = "#d75f5f",
    sky      = "#5fafd7",
    peach    = "#d7875f",
}
-- ============================================================
require("catppuccin").setup({
    no_italic = false,
    term_colors = true,
    transparent_background = false,
    color_overrides = {
        mocha = {
            base     = P.base,
            mantle   = P.mantle,
            crust    = P.crust,
            surface0 = P.surface0,
            surface1 = P.surface1,
            overlay0 = P.overlay0,
            subtext0 = P.subtext0,
            text     = P.text,
            pink     = P.pink,
            green    = P.green,
            yellow   = P.yellow,
            mauve    = P.mauve,
            teal     = P.teal,
            red      = P.red,
        },
    },
    custom_highlights = function(colors)
        return {
            ["Comment"]                = { fg = P.overlay0, style = { "italic" } },
            ["@comment"]               = { fg = P.overlay0, style = { "italic" } },
            ["@keyword"]               = { fg = colors.pink, style = { "bold" } },
            ["@keyword.return"]        = { fg = colors.pink, style = { "bold" } },
            ["@keyword.function"]      = { fg = colors.pink, style = { "bold" } },
            ["@keyword.operator"]      = { fg = colors.pink },
            ["@keyword.import"]        = { fg = colors.pink, style = { "italic" } },
            ["@keyword.conditional"]   = { fg = colors.pink, style = { "bold" } },
            ["@keyword.repeat"]        = { fg = colors.pink, style = { "bold" } },
            ["@type"]                  = { fg = colors.teal },
            ["@type.builtin"]          = { fg = colors.teal, style = { "bold" } },
            ["@type.definition"]       = { fg = colors.teal, style = { "bold" } },
            ["@function"]              = { fg = colors.green },
            ["@function.call"]         = { fg = colors.green },
            ["@function.builtin"]      = { fg = colors.green, style = { "bold" } },
            ["@function.method"]       = { fg = colors.green },
            ["@function.method.call"]  = { fg = colors.green },
            ["@method"]                = { fg = colors.green },
            ["@method.call"]           = { fg = colors.green },
            ["@string"]                = { fg = colors.yellow },
            ["@string.escape"]         = { fg = colors.mauve },
            ["@string.special"]        = { fg = colors.mauve },
            ["@string.regexp"]         = { fg = P.peach },
            ["@number"]                = { fg = colors.mauve },
            ["@float"]                 = { fg = colors.mauve },
            ["@boolean"]               = { fg = colors.mauve, style = { "bold" } },
            ["@constant"]              = { fg = colors.mauve },
            ["@constant.builtin"]      = { fg = colors.mauve, style = { "bold" } },
            ["@constant.macro"]        = { fg = colors.mauve, style = { "bold" } },
            ["@variable"]              = { fg = colors.text },
            ["@variable.builtin"]      = { fg = colors.red, style = { "italic" } },
            ["@variable.member"]       = { fg = colors.yellow, style = { "italic" } },
            ["@property"]              = { fg = colors.yellow, style = { "italic" } },
            ["@parameter"]             = { fg = colors.yellow, style = { "italic" } },
            ["@punctuation.bracket"]   = { fg = colors.subtext0 },
            ["@punctuation.delimiter"] = { fg = colors.subtext0 },
            ["@operator"]              = { fg = colors.subtext0 },
            ["@namespace"]             = { fg = colors.teal, style = { "italic" } },
            ["@module"]                = { fg = colors.teal, style = { "italic" } },
            ["@tag"]                   = { fg = colors.pink },
            ["@tag.attribute"]         = { fg = colors.yellow, style = { "italic" } },
            ["@tag.delimiter"]         = { fg = colors.subtext0 },
            ["LineNr"]                 = { fg = P.surface1, bg = P.base },
            ["CursorLineNr"]           = { fg = P.yellow, bg = P.base, style = { "bold" } },
            ["CursorLine"]             = { bg = P.surface0 },
            ["FoldColumn"]             = { fg = P.surface1, bg = P.base },
            ["SignColumn"]             = { fg = P.surface1, bg = P.base },
            ["EndOfBuffer"]            = { fg = P.base },
            ["Visual"]                 = { bg = P.surface1 },
            ["DiagnosticError"]        = { fg = P.red },
            ["DiagnosticWarn"]         = { fg = P.yellow },
            ["DiagnosticInfo"]         = { fg = P.teal },
            ["DiagnosticHint"]         = { fg = P.sky },
            --
            -- Line numbers
            ["LineNr"]                 = { fg = P.overlay0, bg = P.base },
            ["CursorLineNr"]           = { fg = P.yellow,   bg = P.base, style = { "bold" } },
            ["CursorLine"]             = { bg = P.surface0 },
            ["FoldColumn"]             = { fg = P.overlay0, bg = P.base },
            ["SignColumn"]             = { fg = P.overlay0, bg = P.base },

            -- Tabline
            ["TabLine"]                = { fg = P.overlay0, bg = P.mantle },
            ["TabLineSel"]             = { fg = P.text,     bg = P.surface1, style = { "bold" } },
            ["TabLineFill"]            = { fg = P.overlay0, bg = P.crust },
            ["BufferLineFill"]         = { fg = P.overlay0, bg = P.crust },

            -- If you use bufferline plugin instead
            ["BufferLineBackground"]         = { fg = P.overlay0, bg = P.mantle },
            ["BufferLineBufferSelected"]      = { fg = P.text,     bg = P.surface1, style = { "bold" } },
            ["BufferLineBufferVisible"]       = { fg = P.subtext0, bg = P.mantle },
            ["BufferLineSeparator"]           = { fg = P.crust,    bg = P.mantle },
            ["BufferLineSeparatorSelected"]   = { fg = P.crust,    bg = P.surface1 },
            ["BufferLineIndicatorSelected"]   = { fg = P.pink,     bg = P.surface1 },
            -- Telescope
            ["TelescopeNormal"]          = { fg = P.text,     bg = P.base },
            ["TelescopeBorder"]          = { fg = P.surface1, bg = P.base },
            ["TelescopePromptNormal"]    = { fg = P.text,     bg = P.surface0 },
            ["TelescopePromptBorder"]    = { fg = P.surface1, bg = P.surface0 },
            ["TelescopePromptTitle"]     = { fg = P.base,     bg = P.pink },
            ["TelescopePreviewTitle"]    = { fg = P.base,     bg = P.teal },
            ["TelescopeResultsTitle"]    = { fg = P.base,     bg = P.green },
            ["TelescopePromptPrefix"]    = { fg = P.pink },
            ["TelescopeMatching"]        = { fg = P.yellow,   style = { "bold" } },
            ["TelescopeSelection"]       = { fg = P.text,     bg = P.surface1 },
            ["TelescopeSelectionCaret"]  = { fg = P.pink,     bg = P.surface1 },
            ["TelescopeMultiSelection"]  = { fg = P.mauve,    bg = P.surface0 },
            ["TelescopeResultsNormal"]   = { fg = P.subtext0, bg = P.base },
            ["TelescopePreviewNormal"]   = { fg = P.text,     bg = P.base },
            ["TelescopeResultsComment"]  = { fg = P.overlay0, style = { "italic" } },

            -- Popup / right-click context menu
            ["Pmenu"]      = { fg = P.text,     bg = P.surface0 },
            ["PmenuSel"]   = { fg = P.base,     bg = P.pink,    style = { "bold" } },
            ["PmenuSbar"]  = { bg = P.surface1 },
            ["PmenuThumb"] = { bg = P.overlay0 },
        }
    end,
})
vim.cmd [[colorscheme catppuccin-mocha]]

-- Lualine — all values flow from P
require('lualine').setup({
    options = {
        theme = {
            normal   = { a = { fg = P.base, bg = P.green,  gui = "bold" }, b = { fg = P.text,     bg = P.surface1 }, c = { fg = P.subtext0, bg = P.surface1 } },
            insert   = { a = { fg = P.base, bg = P.teal,   gui = "bold" }, b = { fg = P.text,     bg = P.surface1 }, c = { fg = P.subtext0, bg = P.surface1 } },
            visual   = { a = { fg = P.base, bg = P.mauve,  gui = "bold" }, b = { fg = P.text,     bg = P.surface1 }, c = { fg = P.subtext0, bg = P.surface1 } },
            replace  = { a = { fg = P.base, bg = P.red,    gui = "bold" }, b = { fg = P.text,     bg = P.surface1 }, c = { fg = P.subtext0, bg = P.surface1 } },
            command  = { a = { fg = P.base, bg = P.yellow, gui = "bold" }, b = { fg = P.text,     bg = P.surface1 }, c = { fg = P.subtext0, bg = P.surface1 } },
            inactive = { a = { fg = P.overlay0, bg = P.crust }, b = { fg = P.overlay0, bg = P.crust }, c = { fg = P.overlay0, bg = P.crust } },
        },
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
    },
    sections = {
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            { 'filename', path = 1, padding = { left = 1, right = 0 } },
            {
                function()
                    local ok, ts = pcall(require, 'nvim-treesitter')
                    if not ok then return "" end

                    local func = ts.statusline({ indicator_size = 100, type_patterns = { 'class', 'function', 'method' } })
                    if func and #func > 40 then func = func:sub(1, 37) .. "..." end

                    if func and func ~= "" then
                        return " -> %#LuaLineFunc#" .. func
                    else
                        return ""
                    end
                end,
                color = { fg = P.text, bg = P.surface1 },
                padding = { left = 1, right = 1 },
            }
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})

vim.api.nvim_set_hl(0, "LuaLineFunc", { fg = P.mauve, bg = P.surface1 })



require("ibl").setup({
    indent = { char = "│", tab_char = "│" },
    scope  = { enabled = true, show_start = false, show_end = false },
    exclude = {
        filetypes = { "help", "terminal", "lazy", "packer", "telescope", "oil" },
    },
})
