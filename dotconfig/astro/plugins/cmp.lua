return {
	"hrsh7th/nvim-cmp",
	opts = function(_, opts)
		local cmp = require("cmp")

		-- opts.mapping["<CR>"] = cmp.mapping.confirm({ select = true })
		opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
			-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.confirm()
				end
			else
				fallback()
			end
		end, { "i", "s", "c" })
		-- opts.mapping["<S-Tab>"] = cmp.config.disable
		-- opts.mapping["<ESC>"] = function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.abort()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end

		-- cmp.event:on("menu_opened", function()
		-- 	vim.b.copilot_suggestion_hidden = true
		-- end)
		--
		-- cmp.event:on("menu_closed", function()
		-- 	vim.b.copilot_suggestion_hidden = false
		-- end)

		opts.enabled = function()
			-- disable completion in telescope prompt
			buftype = vim.api.nvim_buf_get_option(0, "buftype")
			if buftype == "prompt" then
				return false
			end

			-- disable completion in comments
			local context = require("cmp.config.context")
			-- keep command mode completion enabled when cursor is in a comment
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			else
				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end
		end

		opts.sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,

				-- copied from cmp-under, but I don't think I need the plugin for this.
				-- I might add some more of my own.
				function(entry1, entry2)
					local _, entry1_under = entry1.completion_item.label:find("^_+")
					local _, entry2_under = entry2.completion_item.label:find("^_+")
					entry1_under = entry1_under or 0
					entry2_under = entry2_under or 0
					if entry1_under > entry2_under then
						return false
					elseif entry1_under < entry2_under then
						return true
					end
				end,

				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		}

		return opts
	end,
}
