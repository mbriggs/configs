return {
	"ludovicchabant/vim-gutentags",
	lazy = false,
	init = function()
		vim.g.gutentags_ctags_executable = "ctags" -- or 'uctags'
		vim.g.gutentags_project_root = { ".git", ".hg", ".svn", ".project", "Gemfile", "go.mod", "package.json" }
		vim.g.gutentags_ctags_extra_args = {
			"--recurse=yes",
			"--fields=+a",
			"--fields=+i",
			"--fields=+k",
			"--fields=+n",
			"--fields=+s",
			"--fields=+t",
			"--fields=+l",
			"--extra=+q",
			"--extra=+f",
			"--extra=+s",
			"--extra=+d",
		}
		vim.g.gutentags_ctags_extra_args = {
			"--exclude=.git",
			"--exclude=log",
			"--exclude=tmp",
		}
		vim.g.gutentags_generate_on_missing = 1
		vim.g.gutentags_generate_on_write = 1
	end,
}
