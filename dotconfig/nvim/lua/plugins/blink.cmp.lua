return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*", -- REQUIRED release tag to download pre-built binaries

	opts = {
		highlight = { use_nvim_cmp_as_default = true },
		keymap = {
			show = "<D-space>",
			hide = "<S-CR>",
			accept = "<C-y>",
			select_next = { "<Tab>", "<Down>", "<C-n>" },
			select_prev = { "<S-Tab>", "<Up>", "<C-p>" },
			scroll_documentation_down = "<PageDown>",
			scroll_documentation_up = "<PageUp>",
		},
		nerd_font_variant = "mono",
		windows = {
			documentation = {
				min_width = 15,
				max_width = 50,
				max_height = 15,
				border = vim.g.borderStyle,
				auto_show = true,
				auto_show_delay_ms = 250,
			},
			autocomplete = {
				min_width = 10,
				max_height = 10,
				border = vim.g.borderStyle,
				-- selection = "auto_insert", -- PENDING https://github.com/Saghen/blink.cmp/issues/117
				selection = "preselect",
				cycle = { from_top = false },
				-- https://github.com/Saghen/blink.cmp/blob/819b978328b244fc124cfcd74661b2a7f4259f4f/lua/blink/cmp/windows/autocomplete.lua#L285-L349
				draw = function(ctx)
					-- differentiate snippets from LSPs, the user, and emmet
					local icon, source = ctx.kind_icon, ctx.item.source
					local client = source == "LSP" and vim.lsp.get_client_by_id(ctx.item.client_id).name
					if source == "Snippets" or (client == "basics_ls" and ctx.kind == "Snippet") then
						icon = "󰩫"
					elseif source == "Buffer" or (client == "basics_ls" and ctx.kind == "Text") then
						icon = "󰦨"
					elseif client == "emmet_language_server" then
						icon = "󰯸"
					end

					-- FIX for tokyonight
					local iconHl = vim.g.colors_name:find("tokyonight") and "BlinkCmpKind" or "BlinkCmpKind" .. ctx.kind

					return {
						{
							" " .. ctx.item.label .. " ",
							fill = true,
							hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
							max_width = 45,
						},
						{ icon .. ctx.icon_gap, hl_group = iconHl },
					}
				end,
			},
		},
		kind_icons = {
			Text = "",
			Method = "󰊕",
			Function = "󰊕",
			Constructor = "",
			Field = "󰇽",
			Variable = "󰂡",
			Class = "⬟",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "󰒕",
			Color = "󰏘",
			Reference = "",
			File = "󰉋",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "󰅲",
		},
	},
}

-- return {
-- 	"saghen/blink.cmp",
-- 	lazy = false,
-- 	version = "v0.*",
--
-- 	opts = {
-- 		highlight = {
-- 			-- sets the fallback highlight groups to nvim-cmp's highlight groups
-- 			-- useful for when your theme doesn't support blink.cmp
-- 			-- will be removed in a future release, assuming themes add support
-- 			use_nvim_cmp_as_default = true,
-- 		},
-- 		keymap = {
-- 			show = "<C-space>",
-- 			hide = "<C-e>",
-- 			accept = "<Tab>",
-- 			select_prev = { "<Up>", "<C-p>" },
-- 			select_next = { "<Down>", "<C-n>" },
--
-- 			show_documentation = {},
-- 			hide_documentation = {},
-- 			scroll_documentation_up = "<C-b>",
-- 			scroll_documentation_down = "<C-f>",
--
-- 			snippet_forward = "<Tab>",
-- 			snippet_backward = "<S-Tab>",
-- 		},
-- 		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
-- 		-- adjusts spacing to ensure icons are aligned
-- 		nerd_font_variant = "normal",
--
-- 		-- experimental auto-brackets support
-- 		accept = { auto_brackets = { enabled = false } },
--
-- 		-- experimental signature help support
-- 		trigger = { signature_help = { enabled = false } },
-- 	},
-- }
