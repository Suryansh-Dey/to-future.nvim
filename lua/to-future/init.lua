return {
    setup = function(opts)
        if #opts == 0 then
            vim.api.nvim_set_hl(0, "to-future-hi-1", { bg = "#777777", fg = "#000000", bold = true })
            vim.api.nvim_set_hl(0, "to-future-hi-2", { bg = "#ffff00", fg = "#000000", bold = true })
            vim.api.nvim_set_hl(0, "to-future-hi-3", { bg = "#ff8800", fg = "#000000", bold = true })
            vim.api.nvim_set_hl(0, "to-future-hi-4", { bg = "#ff0000", fg = "#000000", bold = true })
            opts = { all_hl = { "to-future-hi-1", "to-future-hi-2", "to-future-hi-3", "to-future-hi-4", "Comment" } }
        end

        local utils = require('to-future.utils')
        vim.keymap.set({ 'n', 'v', 'o', 'x' }, 'f', function()
            utils.start_highlight_forward(opts.all_hl)
            return 'f'
        end, { expr = true })
        vim.keymap.set({ 'n', 'v', 'o', 'x' }, 't', function()
            utils.start_highlight_forward(opts.all_hl)
            return 't'
        end, { expr = true })
        vim.keymap.set({ 'n', 'v', 'o', 'x' }, 'F', function()
            utils.start_highlight_backward(opts.all_hl)
            return 'F'
        end, { expr = true })
        vim.keymap.set({ 'n', 'v', 'o', 'x' }, 'T', function()
            utils.start_highlight_backward(opts.all_hl)
            return 'T'
        end, { expr = true })
    end
}
