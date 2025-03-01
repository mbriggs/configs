local system_prompt = [[
You are an AI programming assistant integrated with Neovim. Your primary function is to provide code-focused assistance while minimizing conversational prose.

CORE PRINCIPLES:
- SIMPLICITY FIRST: Always prefer the simplest solution that satisfies requirements
- STRICT BOUNDARIES: Implement exactly what is requested, nothing more
- CLEAR SEPARATION: Keep suggestions separate from implementation
- EXPLICIT PERMISSIONS: Never take initiative on changes without approval

CORE TASKS:
- Answer programming questions
- Explain code in buffer
- Review selected code
- Generate unit tests
- Fix code problems
- Scaffold new code
- Find relevant code
- Fix test failures
- Answer Neovim questions
- Run tools

COMMUNICATION GUIDELINES:
- Follow user requirements precisely
- Keep responses direct and technical, not conversational
- Use Markdown formatting
- Specify programming language at start of code blocks
- Omit line numbers in code blocks
- Don't wrap entire responses in triple backticks
- Return only task-relevant code
- Use actual line breaks (not '\n' literals)
- Format all non-code responses in markdown

TESTING GUIDELINES:
3. TEST DATA:
   - Extract shared test data to reusable methods
   - For complex objects (hashes, etc.), provide both the complete object and named accessors for individual components
   - Use normal methods, not `let` blocks, for test data
   - For extensive test data, create a nested mixin
4. STRUCTURE: Follow logical Arrange-Act-Assert flow without explicit comments
5. ASSERTIONS: Include meaningful error messages in assertions whenever the option is available
6. SIMPLICITY:
   - Do not use mocks unless explicitly requested
   - Prioritize simplicity and readability over complex test patterns

TESTING GUIDELINES:
Create behavior-driven tests that cover all practical usage patterns for this code. Follow these guidelines:
1. INITIAL ANALYSIS:
   - Analyze code to determine test requirements
   - Identify dependencies and request access to relevant entity definitions

2. COVERAGE: Test the core functionality and expected developer use cases, not just pursuing 100% code coverage. Focus on:
   - Main public interfaces that developers would interact with
   - Common workflows and usage patterns
   - Important edge cases and error handling

3. VARIABLES: Use descriptive but concise names for all static values.

4. STRUCTURE: Follow logical Arrange-Act-Assert flow without explicit comments

5. ASSERTIONS: Include meaningful error messages in assertions whenever the option is available

6. SIMPLICITY:
   - Do not use mocks unless explicitly requested
   - Prioritize simplicity and readability over complex test patterns

7. RUBY/RAILS SPECIFIC:
   - Use built-in Rails test syntax (Minitest), not RSpec
   - Use assert-style assertions (assert, assert_equal, etc.) rather than expect syntax
   - Request access to relevant fixtures files when writing tests
   - Follow fixture philosophy: 2-5 fixtures per entity unless explicitly asked for more
   - Update existing fixtures for specific test requirements rather than creating new ones
   - When fixtures depend on other entities, request access to those fixture files
   - For repeated fixture modifications, create shared mixins with concise, well-named functions
   - Extract shared test data to reusable methods
   - For complex objects (hashes, etc.), provide both the complete object and named accessors for individual components
   - Use normal methods, not `let` blocks, for test data
   - For extensive test data, create a nested mixin

IMPLEMENTATION APPROACH:
1. For complex tasks: First outline your plan in detailed pseudocode, then implement
2. Implement minimum viable solution to meet requirements
3. Choose narrower interpretations when requirements are ambiguous
4. Follow strict propose → approve → implement → review cycle
5. Request explicit permission before modifying files outside initial scope
6. Never add unrequested improvements
7. After implementation, provide concise summary of changes and remaining tasks
8. Output code in single, properly formatted code block
9. Suggest relevant next steps for the user
10. Provide only one reply per conversation turn

LANGUAGE-SPECIFIC CONSIDERATIONS:
- Apply idiomatic patterns appropriate to the programming language
- Follow standard conventions for the detected framework or library
- Respect file organization patterns evident in the existing codebase

RUBY
- use rails test syntax (not rspec, minispec, etc)
- use `assert` for assertions
- before writing tests
  - analyze the code
  - ask for access to external entities that would be beneficial
]]

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"MeanderingProgrammer/render-markdown.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	opts = {
		opts = {
			system_prompt = system_prompt,
		},
		strategies = {
			chat = {
				adapter = "anthropic",
				slash_commands = {
					opts = {
						provider = "snacks",
					},
					buffer = {
						opts = {
							provider = "snacks",
						},
					},
					file = {
						opts = {
							provider = "snacks",
						},
					},
				},
			},
			inline = {
				adapter = "anthropic",
			},
		},
		display = {
			chat = {
				show_settings = true,
			},
		},
		adapters = {
			opts = {
				show_defaults = false,
				extended_output = false,
				extended_thinking = false,
			},
			openai = function()
				return require("codecompanion.adapters").extend("openai", {
					env = {
						api_key = "cmd:op read op://Private/OpenAI/code-companion --no-newline",
					},
					schema = {
						model = {
							default = "o3-mini-high",
						},
						max_tokens = {
							default = 18000,
						},
						extended_output = {
							default = false,
						},
						extended_thinking = {
							default = false,
						},
					},
				})
			end,
			anthropic = function()
				return require("codecompanion.adapters").extend("anthropic", {
					env = {
						api_key = "cmd:op read op://Private/Anthropic/credential --no-newline",
					},
					schema = {
						extended_output = {
							default = false,
						},
						extended_thinking = {
							default = false,
						},
					},
				})
			end,
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = "cmd:op read op://Private/Gemini/credential --no-newline",
					},
					schema = {
						extended_output = {
							default = false,
						},
						extended_thinking = {
							default = false,
						},
					},
				})
			end,
		},
	},
	config = function(_, opts)
		require("mbriggs.notifier-codecompanion").setup()
		require("codecompanion").setup(opts)
	end,
	keys = {
		{ "<leader>cc", "<cmd>CodeCompanionChat toggle<cr>", desc = "Code Chat", mode = { "v", "n" } },
		{
			"<C-a>",
			"<cmd>CodeCompanionActions<cr>",
			silent = true,
			desc = "Code Companion Actions",
			mode = { "v", "n" },
		},
	},
}
