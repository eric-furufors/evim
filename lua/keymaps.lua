local opts = { noremap = true, silent = true }

-- Hjälpare: samma som opts men med beskrivning
local function d(desc)
    return { noremap = true, silent = true, desc = desc }
end

-- Diagnostics / LSP
vim.keymap.set('n', '<leader>ii', vim.diagnostic.open_float, d('Show diagnostics'))
vim.keymap.set('n', '<leader>id', vim.lsp.buf.definition, d('Go to definition'))
vim.keymap.set("n", "<leader>ip", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
    d('Preview definition'))
vim.keymap.set('n', '<leader>ih', ':FSHere<cr>', d('Switch between companion files'))
vim.keymap.set('n', '<C-k>', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, d('Toggle inlay hints'))
vim.keymap.set('n', '<leader>ia', vim.lsp.buf.code_action, d('Code action'))
vim.keymap.set('n', '<leader>ir', vim.lsp.buf.rename, d('Rename symbol'))
vim.keymap.set('n', '<leader>if', function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
    d('Format file'))

-- Window navigation
vim.keymap.set('n', '<leader>wh', '<C-w>h', d('Window left'))
vim.keymap.set('n', '<leader>wj', '<C-w>j', d('Window down'))
vim.keymap.set('n', '<leader>wk', '<C-w>k', d('Window up'))
vim.keymap.set('n', '<leader>wl', '<C-w>l', d('Window right'))
vim.keymap.set('n', '<leader>wH', '<C-w>H', d('Move window left'))
vim.keymap.set('n', '<leader>wJ', '<C-w>J', d('Move window down'))
vim.keymap.set('n', '<leader>wK', '<C-w>K', d('Move window up'))
vim.keymap.set('n', '<leader>wL', '<C-w>L', d('Move window right'))

-- Save/Quit
vim.keymap.set('n', '<leader>ww', ':w<CR>', d('Save'))
vim.keymap.set('n', '<leader>wa', ':wa<CR>', d('Save all'))
vim.keymap.set('n', '<leader>qq', ':q<CR>', d('Quit'))
vim.keymap.set('n', '<leader>qa', ':qa<CR>', d('Quit all'))

-- Splits
local function nvim_root_vsplit()
    local current_dir = vim.fn.expand('%:p:h')

    local root_file = vim.fs.find({ '.git', 'Makefile', 'go.mod', 'Cargo.toml' }, {
        path = current_dir,
        upward = true
    })[1]

    local target_dir = root_file and vim.fn.fnamemodify(root_file, ':h') or current_dir

    -- Using 'botright vsplit' forces the new window to the far right
    vim.cmd('botright vsplit | e ' .. target_dir)
end
vim.keymap.set('n', '<leader>se', nvim_root_vsplit, d('Vsplit right at project root'))
vim.keymap.set('n', 'ss', ':split<CR>', d('Horizontal split'))
vim.keymap.set('n', 'sv', ':vsplit<CR>', d('Vertical split'))

-- LaTeX
vim.keymap.set("n", "<leader>ll", function()
    local file = vim.fn.expand("%")
    vim.cmd("write")
    vim.cmd("!pdflatex " .. file)
end, d('Compile LaTeX'))

vim.keymap.set("n", "<leader>lw", function()
    local file = vim.fn.expand("%")
    vim.cmd("write")
    local output = vim.fn.system({ "texcount", file })
    print(output)
end, d('Word count LaTeX'))

-- Blackhole paste
vim.keymap.set('v', '<leader>p', '"_dP', d('Paste without overwriting register'))

-- Disable F1
vim.keymap.set('', '<F1>', '<Nop>', opts)

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, d('Toggle undotree'))

-- Telescope
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', d('Find files'))
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', d('Live grep'))
vim.keymap.set('n', '<leader>fs', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
    d('Fuzzy workspace symbols'))
vim.keymap.set('n', '<leader>fa', '<cmd>Telescope<cr>', d('All Telescope commands'))
vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', d('Search keymaps'))

-- Git
vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', d('Toggle git blame'))
vim.keymap.set('n', '<leader>gh', '<cmd>Telescope git_file_history<cr>', d('Git file history'))
vim.keymap.set('n', '<leader>fm', '<cmd>Telescope git_status<cr>', d('Git modified files'))
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope git_commits<cr>', d('Git commit history'))
vim.keymap.set('n', '<leader>fc', function()
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values

    pickers.new({}, {
        prompt_title = 'Merge conflicts',
        finder = finders.new_oneshot_job(
            { 'git', 'diff', '--name-only', '--relative', '--diff-filter=U' }, {}),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end, d('Git merge conflict files'))

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
    vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
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
    vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
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
