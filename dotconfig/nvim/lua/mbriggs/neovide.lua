vim.opt.linespace = 6

-- emulate stuff i set in kitty

-- System clipboard paste (Cmd+V)
vim.keymap.set("n", "<D-v>", '"+p') -- Normal mode
vim.keymap.set("v", "<D-v>", '"+p') -- Visual mode
vim.keymap.set("i", "<D-v>", "<C-r>+") -- Insert mode

-- Map Cmd+F to % (jump to matching bracket)
vim.keymap.set({ "n", "v", "o" }, "<D-f>", "%")
vim.keymap.set("c", "<D-f>", '<C-r>="%"<CR>') -- Command mode for :%s/foo etc.

-- Text rendering
vim.g.neovide_text_contrast = 0.8 -- Crisper text contrast
vim.g.neovide_text_gamma = 0.8 -- Slightly darker text rendering
vim.o.guifont = "JetBrains Mono:h15:#h-slight:#e-subpixelantialias"

-- Animation feel
vim.g.neovide_scroll_animation_length = 0.15 -- Quick but smooth scrolling
vim.g.neovide_cursor_animation_length = 0.03
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_refresh_rate = 60
vim.g.neovide_no_idle = false
vim.g.neovide_cursor_antialiasing = true
