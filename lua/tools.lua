require('oil').setup({
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
})

local status, ts_configs = pcall(require, "nvim-treesitter.configs")
if status then
    ts_configs.setup({
        ensure_installed = { "lua", "python", "c", "cpp" },
        highlight = { enable = true },
    })
else
    print("Treesitter hittades inte – kör :PackerSync om du precis har installerat")
end

require('Comment').setup()
require('gitsigns').setup()
require('winshift').setup()

if vim.fn.argc() == 0 then
    vim.defer_fn(function()
        require("oil").open()
    end, 1)
end
