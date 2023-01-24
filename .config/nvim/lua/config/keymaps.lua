-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<Leader>m", require("telescope").extensions.flutter.commands)

vim.keymap.set(
  { "n", "v" },
  "<Leader>5",
  "<cmd>FlutterRun --flavor development --target=lib/main_development.dart<CR>",
  { silent = true, desc = "Run Flutter Development" }
)
