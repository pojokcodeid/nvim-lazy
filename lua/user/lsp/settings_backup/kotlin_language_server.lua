return {
	cmd = { "kotlin-language-server" },
	filetypes = { "kotlin" },
	root_dir = require("lspconfig.util").root_pattern(
		"build.gradle.kts",
		"build.gradle",
		"settings.gradle",
		"gradlew",
		"pom.xml",
		"build.gradle.kts",
		"build.kts",
		".git"
	),
	singe_file_support = true,
}
