local opts = { noremap = true, silent = true }

-- Diagnostics / LSP
vim.keymap.set('n', '<leader>ii', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>id', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set("n", "<leader>ip", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { desc = "Preview Definition" })
vim.keymap.set('n', '<leader>ih', ':FSHere<cr>', { silent = true }, { desc = 'Switch between companion files' })

-- Tabs
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', opts)
vim.keymap.set('n', '<leader>tt', ':tabnew | terminal<CR>', opts)
vim.keymap.set('n', '<leader>tc', ':tabc<CR>', opts)

-- Window navigation
vim.keymap.set('n', '<leader>wh', '<C-w>h', opts)
vim.keymap.set('n', '<leader>wj', '<C-w>j', opts)
vim.keymap.set('n', '<leader>wk', '<C-w>k', opts)
vim.keymap.set('n', '<leader>wl', '<C-w>l', opts)
vim.keymap.set('n', '<leader>wH', '<C-w>H', opts)
vim.keymap.set('n', '<leader>wJ', '<C-w>J', opts)
vim.keymap.set('n', '<leader>wK', '<C-w>K', opts)
vim.keymap.set('n', '<leader>wL', '<C-w>L', opts)

-- Save/Quit
vim.keymap.set('n', '<leader>ww', ':w<CR>', opts)
vim.keymap.set('n', '<leader>wa', ':wa<CR>', opts)
vim.keymap.set('n', '<leader>qq', ':q<CR>', opts)
vim.keymap.set('n', '<leader>qa', ':qa<CR>', opts)

-- Splits
vim.keymap.set('n', 'ss', ':split<CR>', opts)
vim.keymap.set('n', 'sv', ':vsplit<CR>', opts)

-- Macros
vim.keymap.set('n', '<leader>mm', '@@')

-- LaTeX
vim.keymap.set("n", "<leader>ll", function()
    local file = vim.fn.expand("%")
    vim.cmd("write")
    vim.cmd("!pdflatex " .. file)
end, { desc = "Compile LaTeX" })

vim.keymap.set("n", "<leader>lw", function()
    local file = vim.fn.expand("%")
    vim.cmd("write")
    local output = vim.fn.system({"texcount", file})
    print(output)
end, { desc = "Word count LaTeX" })

-- Blackhole paste
vim.keymap.set('v', '<leader>p', '"_dP')

-- Disable F1
vim.keymap.set('', '<F1>', '<Nop>', opts)

-- Telescope / Git
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fa', '<cmd>Telescope<cr>', { desc = 'All Telescope commands' })
vim.keymap.set('n', '<leader>bb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = 'Toggle git blame' })
vim.keymap.set('n', '<leader>bh', '<cmd>Telescope git_file_history<cr>', { desc = 'Git file history' })

-- Commands
vim.api.nvim_create_user_command('Rapport', function()
    local lines = {
        '\\documentclass[12pt, a4paper, oneside]{article}',
        '',
        '\\usepackage[utf8]{inputenc}',
        '\\usepackage[T1]{fontenc}',
        '\\usepackage[a4paper, margin=2cm]{geometry}',
        '',
        '\\usepackage[swedish]{babel}',
        '%\\usepackage[english]{babel}',
        '',
        '\\usepackage[style=authoryear, backend=biber]{biblatex}',
        '\\addbibresource{references.bib}',
        '',
        '\\usepackage{listings}',
        '%\\usepackage{graphicx}',
        '',
        '\\lstset{',
        'basicstyle=\\ttfamily\\bfseries,',
        'breakindent=0pt,',
        'breaklines=true',
        '}',
        '\\title{}',
        '\\author{}',
        '\\date{\\today}',
        '',
        '\\begin{document}',
        '\\maketitle',
        '',
        '',
        '\\end{document}',
    }
    vim.api.nvim_put(lines, 'l', true, true)
end, {})

vim.api.nvim_create_user_command('BF', function()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = {
        '\\begin{lstlisting}[basicstyle=\\bfseries]',
        '',
        '\\end{lstlisting}'
    }
    vim.api.nvim_buf_set_lines(0, row, row, true, lines)
    vim.api.nvim_win_set_cursor(0, {row + 2, 0})
end, {})

vim.api.nvim_create_user_command('BILD', function()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = {
        '\\begin{figure}[h]',
        '\\centering',
        '\\includegraphics[width=0.6\\textwidth]{bilder/kursbok.jpg}',
        '\\caption{Kursboks tabell}',
        '\\label{fig:kursbok}',
        '\\end{figure}'
    }
    vim.api.nvim_buf_set_lines(0, row, row, true, lines)
    vim.api.nvim_win_set_cursor(0, {row + 3, 0})
end, {})

vim.api.nvim_create_user_command('Clean', function(o)
    vim.cmd(string.format('%d,%dg/^$/d', o.line1, o.line2))
end, { range = true })

vim.api.nvim_create_user_command("Root", function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("^oil://") then
        local dir = bufname:gsub("^oil://", "")
        vim.cmd("cd " .. vim.fn.fnameescape(dir))
    else
        local dir = vim.fn.expand("%:p:h")
        vim.cmd("cd " .. vim.fn.fnameescape(dir))
    end
end, {})
