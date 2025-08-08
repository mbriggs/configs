---@brief
---
--- https://www.npmjs.com/package/stimulus-language-server
---
--- `stimulus-lsp` can be installed via `npm`:
---
--- ```sh
--- npm install -g stimulus-language-server
--- ```
---
--- or via `yarn`:
---
--- ```sh
--- yarn global add stimulus-language-server
--- ```
return {
	cmd = { "stimulus-language-server", "--stdio" },
	filetypes = { "html", "ruby", "eruby", "blade", "php", "javascript", "typescript" },
	root_markers = { "package.json", "Gemfile", ".git" },
	settings = {
		stimulus = {
			controllers = {
				path = {
					"app/javascript/controllers",
					"app/assets/javascripts/controllers",
					"app/frontend/controllers",
					"app/packs/controllers",
				},
				pattern = "**/*_controller.{js,ts}",
			},
			importMap = true,
		},
	},
}

