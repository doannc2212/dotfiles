vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<Leader>j", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<Leader>k", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<Leader>q", ":bprevious<CR>:bdelete #<CR>", { silent = true })

vim.keymap.set({ "n", "x" }, "<Leader>r", ":%s///g<Left><Left>")
vim.keymap.set({ "n", "x" }, "<Leader>rc", ":%s///gc<Left><Left><Left>")

vim.keymap.set("n", "<Leader>y", ":%y<CR>")

vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "j", "gj", { silent = true })

vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })

vim.keymap.set("n", "<Leader>l", ":vsplit term://fish <CR>", { silent = true })
vim.keymap.set("t", "<Leader><Esc>", "<C-\\><C-n>", { silent = true })

vim.keymap.set("n", "<Leader>v", ":edit ~/.config/nvim/init.lua<CR>", { silent = true })
vim.keymap.set("n", "<Leader>o", ":DashboardNewFile<CR>", { silent = true })

vim.keymap.set("n", "<Leader>p", require("telescope").extensions.file_browser.file_browser)
vim.keymap.set("n", "<Leader>n", require("telescope.builtin").find_files)
vim.keymap.set("n", "<Leader>t", require("telescope.builtin").treesitter)
vim.keymap.set("n", "<Leader>t", require("telescope.builtin").treesitter)

vim.keymap.set({ "n", "v" }, "<Leader>c", ":Commentary<CR>", { silent = true })
