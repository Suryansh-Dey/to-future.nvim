Hit `f` or `t` motion, chars get highlighted on the basis of number `;` it will take to reach there.  
No need to check after every stroke if you reached or not. You know the number of `;` needed, or not needed at all, at very `f` or `t` press!


https://github.com/user-attachments/assets/fb2ea0aa-cb20-4936-9382-8960c62ef0b3


# setup in lazy
```lua
return {
    "suryansh-dey/to-future.nvim",
    event = "VeryLazy",
    opts = {}
}
```
## Defaults
```lua
vim.api.nvim_set_hl(0, "to-future-hi-1", { bg = "#ffff00", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "to-future-hi-2", { bg = "#ff8800", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "to-future-hi-3", { bg = "#ff0000", fg = "#000000", bold = true })
opts = {}
return {
    "suryansh-dey/to-future.nvim",
    event = "VeryLazy",
    opts = { all_hl = { "to-future-hi-1", "to-future-hi-2", "to-future-hi-3", "Comment" } },
}
```
