local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
if not web_devicons_ok then
	return
end

local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
if not material_icon_ok then
	return
end
local prettier_icon = ""
local term_program = vim.fn.getenv("TERM_PROGRAM")
if term_program == vim.NIL then
	prettier_icon = ""
end
material_icon.setup({
	override = {
		["mjs"] = {
			icon = "",
			color = "#f2c55c",
			cterm_color = "220",
			name = "Mjs",
		},
		["js"] = {
			icon = "",
			color = "#f2c55c",
			cterm_color = "220",
			name = "javascript",
		},
		["ts"] = {
			icon = "󰛦",
			color = "#548af7",
			cterm_color = "220",
			name = "ts",
		},
		["jsx"] = {
			icon = "",
			color = "#61dafb",
			cterm_color = "220",
			name = "jsx",
		},
		["tsx"] = {
			icon = "",
			color = "#3699ff",
			cterm_color = "220",
			name = "Tsx",
		},
		["svg"] = {
			icon = "󰜡",
			color = "#FDB03A",
			cterm_color = "220",
			name = "svg",
		},
		["prisma"] = {
			icon = "",
			color = "#0FBFCF",
			cterm_color = "220",
			name = "prisma",
		},
		["json"] = {
			icon = "",
			color = "#f16421",
			cterm_color = "220",
			name = "json",
		},
		["map"] = {
			icon = "",
			color = "#748e54",
			cterm_color = "220",
			name = "map",
		},
		["svelte"] = {
			icon = "",
			color = "#ef510b",
			cterm_color = "220",
			name = "svelte",
		},
		["yaml"] = {
			icon = "󰰳",
			color = "#ef510b",
			cterm_color = "220",
			name = "yaml",
		},
		["vsix"] = {
			icon = "",
			color = "#30A2FF",
			cterm_color = "220",
			name = "vsix",
		},
		["class"] = {
			icon = "󰅶",
			color = "#1e88e5",
			cterm_color = "220",
			name = "JavaClass",
		},
		["java"] = {
			icon = "󰅶",
			color = "#ef510b",
			cterm_color = "220",
			name = "JavaFile",
		},
		["gradle"] = {
			icon = "",
			color = "#9C9C9C",
			cterm_color = "220",
			name = "GradleFile",
		},
		["mod"] = {
			icon = "󰟓",
			color = "#C5362B",
			cterm_color = "220",
			name = "gomod",
		},
		["blade.php"] = {
			icon = "󰫐",
			color = "#ef510b",
			cterm_color = "220",
			name = "bladephp",
		},
		["7z"] = {
			icon = "",
			color = "#9C9C9C",
			cterm_color = "220",
			name = "7z",
		},
		["zip"] = {
			icon = "",
			color = "#9C9C9C",
			cterm_color = "220",
			name = "zip",
		},
		["rar"] = {
			icon = "",
			color = "#9C9C9C",
			cterm_color = "220",
			name = "rar",
		},
		["cfm"] = {
			icon = "",
			color = "#507F89",
			cterm_color = "220",
			name = "cfm",
		},
		["png"] = {
			icon = "󰋩",
			color = "#3574f0",
			cterm_color = "220",
			name = "Png",
		},
		["jpg"] = {
			icon = "󰋩",
			color = "#3574f0",
			cterm_color = "220",
			name = "jpg",
		},
		["csv"] = {
			icon = "",
			color = "#57965c",
			cterm_color = "220",
			name = "csv",
		},
		["sql"] = {
			icon = "",
			color = "#b589ec",
			cterm_color = "220",
			name = "sqlfile",
		},
		["md"] = {
			icon = "",
			color = "#42a5f5",
			cterm_color = "220",
			name = "README_file",
		},
		-- ["go"] = {
		-- 	icon = "󰟓",
		-- 	color = "#0FBFCF",
		-- 	cterm_color = "220",
		-- 	name = "go",
		-- },
	},
	color_icons = true,
	default = true,
})

web_devicons.setup({
	override = material_icon.get_icons(),
	override_by_filename = {
		["artisan"] = {
			icon = "󰫐",
			color = "#ef510b",
			cterm_color = "240",
			name = "artisan",
		},
		["vite.config.ts"] = {
			icon = "󰉁",
			color = "#ffab00",
			cterm_color = "240",
			name = "viteconfigts",
		},
		[".releaserc"] = {
			icon = "󰚧",
			color = "#9C9C9C",
			cterm_color = "240",
			name = "releaserc",
		},
		[".profile"] = {
			icon = "󰙄",
			color = "#9C9C9C",
			cterm_color = "240",
			name = "profiledata",
		},
		[".eslint_d"] = {
			icon = "󰱺",
			color = "#4930bd",
			cterm_color = "240",
			name = "eslintd",
		},
		[".eslintrc.cjs"] = {
			icon = "󰱺",
			color = "#4930bd",
			cterm_color = "240",
			name = "eslintrccjs",
		},
		[".htaccess"] = {
			icon = "󰛓",
			color = "#C63C17",
			cterm_color = "240",
			name = "htaccess",
		},
		["pom.xml"] = {
			icon = "󰛓",
			color = "#C63C17",
			cterm_color = "240",
			name = "pomxml",
		},
		[".huskyrc"] = {
			icon = "󰩃",
			color = "#ffffff",
			cterm_color = "240",
			name = "huskyrc",
		},
		[".prettierrc"] = {
			icon = prettier_icon,
			color = "#ea5e5e",
			cterm_color = "240",
			name = "prettierrc",
		},
		[".prettierd"] = {
			icon = prettier_icon,
			color = "#ea5e5e",
			cterm_color = "240",
			name = "prettierd",
		},
		[".vscodeignore"] = {
			icon = "",
			color = "#30A2FF",
			cterm_color = "240",
			name = "vscodeignore",
		},
		[".vsixmanifest"] = {
			icon = "",
			color = "#30A2FF",
			cterm_color = "240",
			name = "vsixmanifest",
		},
		[".prettierignore"] = {
			icon = prettier_icon,
			color = "#ea5e5e",
			cterm_color = "240",
			name = "prettierignore",
		},
		[".sequelizerc"] = {
			icon = "󱙌",
			color = "#397883",
			cterm_color = "220",
			name = "sequelizerc",
		},
		["pre-commit"] = {
			icon = "",
			color = "#75e4b3",
			cterm_color = "240",
			name = "pre",
		},
		["yarn.lock"] = {
			icon = "",
			color = "#ea5e5e",
			cterm_color = "240",
			name = "yarnlock",
		},
		["yarn-error.log"] = {
			icon = "",
			color = "#3d85c6",
			cterm_color = "240",
			name = "yarnerror",
		},
		[".eslintrc.json"] = {
			icon = "󰱺",
			color = "#4746a8",
			cterm_color = "240",
			name = "eslintrc",
		},
		[".eslintignore"] = {
			icon = "󰱺",
			color = "#4746a8",
			cterm_color = "240",
			name = "eslintignore",
		},
		["jest.config.js"] = {
			icon = "󰚐",
			color = "#e37575",
			cterm_color = "220",
			name = "jestconfig",
		},
		["cname"] = {
			icon = "󰖟",
			color = "#e37575",
			cterm_color = "220",
			name = "cname",
		},
		[".nvmrc"] = {
			icon = "",
			color = "#E8274B",
			cterm_color = "220",
			name = "nvmrc",
		},
		[".yarnrc"] = {
			icon = "",
			color = "#3d85c6",
			cterm_color = "240",
			name = "yarnrc",
		},
		[".git-blame-ignore-revs"] = {
			icon = "󰊢",
			color = "#F14C28",
			cterm_color = "220",
			name = "gitblameignorerevs",
		},
		[".mailmap"] = {
			icon = "󰇮",
			color = "#a0d0d0",
			cterm_color = "220",
			name = "mailmap",
		},
		[".vscode-test.js"] = {
			icon = "󰨞",
			color = "#206ba3",
			cterm_color = "220",
			name = "vscodetest",
		},
		[".mention-bot"] = {
			icon = "󰚩",
			color = "#ffffff",
			cterm_color = "220",
			name = "mentionbot",
		},
		[".project"] = {
			icon = "󰈚",
			color = "#5881b1",
			cterm_color = "220",
			name = "project",
		},
		["gradlew"] = {
			icon = "",
			color = "#9C9C9C",
			cterm_color = "220",
			name = "gradlewFile",
		},
		[".classpath"] = {
			icon = "󰅶",
			color = "#9C9C9C",
			cterm_color = "220",
			name = "gradlewFile",
		},
		["dockerfile-development"] = {
			icon = "",
			color = "#0087c9",
			cterm_color = "220",
			name = "gradlewFile-development",
		},
		["dockerfile-staging"] = {
			icon = "",
			color = "#0087c9",
			cterm_color = "220",
			name = "gradlewFile-staging",
		},
	},
})
