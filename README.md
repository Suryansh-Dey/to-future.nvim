# setup in lazy
```lua
vim.api.nvim_set_hl(0, "to-future-hi-1", { bg = "#ffffff", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "to-future-hi-2", { bg = "#ffff00", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "to-future-hi-3", { bg = "#ff8800", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "to-future-hi-4", { bg = "#ff0000", fg = "#000000", bold = true })
return {
    "suryansh-dey/to-future.nvim",
    event = "VeryLazy",
    opts = { all_hl = { "to-future-hi-1", "to-future-hi-2", "to-future-hi-3", "to-future-hi-4", "Comment" } },
}
```
