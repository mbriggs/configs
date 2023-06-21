-- highlight things like todo in comments
return {
	"folke/todo-comments.nvim",
	name = "todo-comments",
	requires = "nvim-lua/plenary.nvim",
	event = "BufRead",
}
