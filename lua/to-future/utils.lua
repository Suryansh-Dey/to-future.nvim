local M = {}
local ns_id = vim.api.nvim_create_namespace("to-future_line_highlight_ns")
local function highlight_char(bufnr, matches, hl)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    for i = 2, #matches do
        vim.api.nvim_buf_set_extmark(bufnr, ns_id, row - 1, matches[i], {
            end_col = matches[i] + 1,
            hl_group = hl[math.min(i - 1, #hl)]
        })
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
        if char == ' ' then
            goto continue
        end
        if matches[char] then
            vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, i - 1, {
                end_col = i,
                hl_group = hl[math.min(#matches[char], #hl)]
            })
            table.insert(matches[char], i - 1)
        else
            matches[char] = { i - 1 }
        end
        ::continue::
    end
    return matches
end
local function highlight_backward(bufnr, hl)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]

    local matches = {}
    for i = col, 0, -1 do
        local char = line:sub(i, i)
        if char == ' ' then
            goto continue
        end
        if matches[char] then
            vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, i - 1, {
                end_col = i,
                hl_group = hl[math.min(#matches[char], #hl)]
            })
            table.insert(matches[char], i - 1)
        else
            matches[char] = { i - 1 }
        end
        ::continue::
    end
    return matches
end
M.start_highlight_forward = function(all_hl)
    local bufnr = vim.api.nvim_get_current_buf()
    local matches = highlight_forward(bufnr, all_hl)
    vim.cmd('redraw')
    local done = false
    local temp = vim.api.nvim_create_namespace("to-future-temp2")
    vim.on_key(function(key)
        if done then
            if matches[key] == nil then
                vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
            else
                highlight_char(bufnr, matches[key], all_hl)
            end
            vim.on_key(nil, temp)
        end
        done = true
    end, temp)
end
M.start_highlight_backward = function(all_hl)
    local bufnr = vim.api.nvim_get_current_buf()
    local matches = highlight_backward(bufnr, all_hl)
    vim.cmd('redraw')
    local done = false
    local temp = vim.api.nvim_create_namespace("to-future-temp2")
    vim.on_key(function(key)
        if done then
            if matches[key] == nil then
                vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
            else
                highlight_char(bufnr, matches[key], all_hl)
            end
            vim.on_key(nil, temp)
        end
        done = true
    end, temp)
end

return M
