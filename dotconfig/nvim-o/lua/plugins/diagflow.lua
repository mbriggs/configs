return {
	"dgagn/diagflow.nvim",
	opts = {
		text_align = "left",
		padding_right = 4,
		toggle_event = { "InsertEnter", "InsertLeave" },
		render_event = { "DiagnosticChanged", "CursorMoved" },
		scope = "line",
	},
}
