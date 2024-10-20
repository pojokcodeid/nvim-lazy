return {
	root_dir = require("lspconfig.util").root_pattern(
		"build",
		"compile_commands.json",
		".git",
		"mvnw",
		"gradlew",
		"pom.xml",
		"build.gradle"
	) or vim.loop.cwd() or vim.fn.getcwd(),
	singe_file_support = true,
}
