# setup in lazy
```lua
vim.api.nvim_set_hl(0, "to-future-hi", { bg = "#005555", fg = "#ffffff", bold = true })
return {
   "suryansh-dey/to-future.nvim",
   event = "VeryLazy",
   opts = { all_hl = "Comment", char_hl = "to-future-hi" },
}
```
