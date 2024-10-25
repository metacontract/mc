import type * as Preset from "@docusaurus/preset-classic";
import type { Config } from "@docusaurus/types";
import { themes as prismThemes } from "prism-react-renderer";

const config: Config = {
	title: "Meta Contract",
	tagline:
		"A flexible and upgradeable smart contract framework optimized for AI integration and DevOps efficiency, enabling streamlined development and testing.",
	favicon: "img/favicon.ico",

	url: "https://mc-book.ecdysis.xyz",
	baseUrl: "/",

	organizationName: "metacontract",
	projectName: "mc",

	onBrokenLinks: "warn",
	onBrokenMarkdownLinks: "warn",

	i18n: {
		defaultLocale: "en",
		locales: ["en"],
	},

	plugins: [require.resolve("docusaurus-lunr-search")],

	headTags: [
		{
			tagName: "link",
			attributes: {
				rel: "preconnect",
				href: "https://fonts.googleapis.com",
			},
		},
		{
			tagName: "link",
			attributes: {
				rel: "preconnect",
				href: "https://fonts.gstatic.com",
				crossorigin: "anonymous",
			},
		},
		{
			tagName: "link",
			attributes: {
				rel: "stylesheet",
				href: "https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,100..900;1,100..900&display=swap",
			},
		},
	],

	presets: [
		[
			"classic",
			{
				docs: {
					path: "../docs",
					routeBasePath: "/",
					sidebarPath: require.resolve("./sidebars.ts"),
					editUrl: "https://github.com/metacontract/mc/tree/main/book",
					breadcrumbs: false,
					showLastUpdateTime: true,
				},
				theme: {
					customCss: "./src/css/custom.css",
				},
			} satisfies Preset.Options,
		],
	],

	markdown: {
		mermaid: true,
		format: "detect",
	},
	themes: ["@docusaurus/theme-mermaid"],

	themeConfig: {
		colorMode: {
			defaultMode: "dark",
			respectPrefersColorScheme: true,
		},
		navbar: {
			title: "Meta Contract",
			logo: {
				alt: "Meta Contract Logo",
				src: "img/logo.png",
			},
			items: [
				{
					type: "search",
					position: "left",
				},
				{
					to: "introduction",
					html: "Guides",
					position: "right",
				},
				{
					to: "tutorials",
					html: "API",
					position: "right",
				},
				{
					to: "devops",
					html: "Examples",
					position: "right",
				},
				// {
				// 	type: "docsVersionDropdown",
				// 	position: "right",
				// 	dropdownItemsAfter: [
				// 		{
				// 			to: "https://github.com/metacontract/mc/releases",
				// 			label: "Releases",
				// 		},
				// 	],
				// 	dropdownActiveClassDisabled: true,
				// },
				{
					type: "html",
					position: "right",
					value: "<div />",
					className: "navbar-divider",
				},
				{
					href: "https://github.com/metacontract/mc",
					className: "header-social-icon header-github-link",
					"aria-label": "GitHub repository",
					position: "right",
				},
				{
					href: "https://x.com/ecdysis_xyz",
					className: "header-social-icon header-x-link",
					"aria-label": "X",
					position: "right",
				},
				{
					type: "html",
					position: "right",
					value: "<div />",
					className: "navbar-divider",
				},
			],
		},
		docs: {
			sidebar: {
				autoCollapseCategories: false,
			},
		},
		footer: {
			style: "dark",
			copyright: `Copyright © 2024-present <a href="https://github.com/metacontract/mc/graphs/contributors" target="_blank" rel="noopener noreferrer">Meta Contract Contributors</a>. Released under the <a href="https://github.com/metacontract/mc/blob/main/LICENSE" target="_blank" rel="noopener noreferrer">MIT License</a>.`,
		},
		prism: {
			theme: prismThemes.github,
			darkTheme: prismThemes.dracula,
			additionalLanguages: ["solidity"],
		},
	} satisfies Preset.ThemeConfig,
	customFields: {
		deploymentCode: `mc.init("MyDAO");
mc.use(Propose.propose.selector, address(new Propose()));
mc.use(Vote.vote.selector, address(new Vote()));
mc.use(Tally.tally.selector, address(new Tally()));
mc.use(Execute.execute.selector, address(new Execute()));
mc.deploy();`,
		upgradeCode: `mc.load("MyDAO");
mc.upgrade(
    Propose.propose.selector,
    address(new ProposeV2())
);`,
	},
};

export default config;
