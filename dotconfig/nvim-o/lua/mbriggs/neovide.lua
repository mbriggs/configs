vim.opt.linespace = 6

-- emulate stuff i set in terms

-- System clipboard paste (Cmd+V)
vim.keymap.set("n", "<D-v>", '"+p')             -- Normal mode
vim.keymap.set("v", "<D-v>", '"+p')             -- Visual mode
vim.keymap.set("i", "<D-v>", "<C-r>+")          -- Insert mode
vim.keymap.set("t", "<D-v>", '<C-\\><C-n>"+pi') -- Terminal mode

-- Text rendering
vim.g.neovide_text_contrast = 0.8 -- Crisper text contrast
vim.g.neovide_text_gamma = 0.8    -- Slightly darker text rendering
vim.o.guifont = "JetBrainsMono Nerd Font:h15:#h-slight:#e-subpixelantialias"

-- Animation feel
vim.g.neovide_scroll_animation_length = 0.15 -- Quick but smooth scrolling
vim.g.neovide_cursor_animation_length = 0.03
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_refresh_rate = 60
vim.g.neovide_no_idle = false
vim.g.neovide_cursor_antialiasing = true

-- Add keybindings to adjust scale factor (zoom)
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.1) end)
vim.keymap.set("n", "<C-->", function() change_scale_factor(1 / 1.1) end)

-- needed to be going off of the right ruby when project changes
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    vim.fn.system('eval "$(rbenv init - zsh)"')
  end,
})

-- Start in home dir
vim.cmd("cd ~")
