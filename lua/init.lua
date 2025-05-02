local ns_id = vim.api.nvim_create_namespace("to-future_line_highlight_ns")
local function highlight_char(bufnr, target, hl)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]

    for i = 0, #line do
        local char = line:sub(i, i)
        if char == target then
            vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, i - 1, {
                end_col = i,
                hl_group = hl
            })
        end
    end

    local temp = vim.api.nvim_create_namespace("to-future-temp")
    local done = false
    vim.on_key(function(key)
        if done and key ~= ';' and key ~= ',' then
            vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
            vim.on_key(nil, temp)
        end
        done = true
    end, temp)
end
local function highlight_forward(bufnr, hl)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]

    local matches = {}
    for i = col + 2, #line do
        local char = line:sub(i, i)
        if matches[char] and char ~= ' ' then
            vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, i - 1, {
                end_col = i,
                hl_group = hl
            })
        end
        matches[char] = true
    end
end
local function highlight_backward(bufnr, hl)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]

    local matches = {}
    for i = col, 0, -1 do
        local char = line:sub(i, i)
        if matches[char] and char ~= ' ' then
            vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, i - 1, {
                end_col = i,
                hl_group = hl
            })
        end
        matches[char] = true
    end
end
local function start_highlight_forward(all_hl, char_hl)
    local bufnr = vim.api.nvim_get_current_buf()
    highlight_forward(bufnr, all_hl)
    vim.cmd('redraw')
    local done = false
    local temp = vim.api.nvim_create_namespace("to-future-temp2")
    vim.on_key(function(key)
        if done then
            highlight_char(bufnr, key, char_hl)
            vim.on_key(nil, temp)
        end
        done = true
    end, temp)
end
local function start_highlight_backward(all_hl, char_hl)
    local bufnr = vim.api.nvim_get_current_buf()
    highlight_backward(bufnr, all_hl)
    vim.cmd('redraw')
    local done = false
    local temp = vim.api.nvim_create_namespace("to-future-temp2")
    vim.on_key(function(key)
        if done then
            highlight_char(bufnr, key, char_hl)
            vim.on_key(nil, temp)
        end
        done = true
    end, temp)
end
return {
    setup = function(opts)
        vim.keymap.set('n', 'f', function()
            start_highlight_forward(opts.all_hl, opts.char_hl)
            return 'f'
        end, { expr = true })
        vim.keymap.set('n', 't', function()
            start_highlight_forward(opts.all_hl, opts.char_hl)
            return 't'
        end, { expr = true })
        vim.keymap.set('n', 'F', function()
            start_highlight_backward(opts.all_hl, opts.char_hl)
            return 'F'
        end, { expr = true })
        vim.keymap.set('n', 'T', function()
            start_highlight_backward(opts.all_hl, opts.char_hl)
            return 'T'
        end, { expr = true })
    end
}
