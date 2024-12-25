-- Substitute operator to replace text with whatever is in the unnamed register
return {
	"gbprod/substitute.nvim",
	config = true,
	keys = {
		{ "s", "<cmd>lua require('substitute').operator()<cr>", desc = "substitute" },
		{ "ss", "<cmd>lua require('substitute').line()<cr>", desc = "substitute line" },
		{ "S", "<cmd>lua require('substitute').eol()<cr>", desc = "substitute to eol" },
		{ "s", "<cmd>lua require('substitute').visual()<cr>", desc = "substitute", mode = { "v", "x" } },
	},
}
