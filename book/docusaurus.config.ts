import type * as Preset from "@docusaurus/preset-classic";
import type { Config } from "@docusaurus/types";
import { themes as prismThemes } from "prism-react-renderer";

const config: Config = {
	title: "Meta Contract Documentation",
	tagline: "Meta Contract is a smart contract development framework.",
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

	presets: [
		[
			"classic",
			{
				docs: {
					path: "../docs",
					routeBasePath: "/",
					sidebarPath: require.resolve("./sidebars.ts"),
					editUrl: "https://github.com/metacontract/mc/tree/main/book",
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
		image: "img/ecdysis-logo.png",
		navbar: {
			title: "Meta Contract",
			logo: {
				alt: "Ecdysis Logo",
				src: "img/ecdysis-logo.png",
			},
			items: [
				{
					to: "introduction",
					html: "Introduction",
					position: "left",
				},
				{
					to: "tutorials",
					html: "Tutorial",
					position: "left",
				},
				{
					to: "devops",
					html: "DevOps",
					position: "left",
				},
				{
					to: "plugin-functions",
					html: "Plugin Functions",
					position: "left",
				},
				{
					to: "resources",
					html: "Resources",
					position: "left",
				},
				{
					href: "https://github.com/metacontract/mc",
					label: "GitHub",
					position: "right",
				},
			],
		},
		footer: {
			style: "dark",
			links: [
				{
					title: "Docs",
					items: [
						{
							label: "Introduction",
							to: "/introduction",
						},
						{
							label: "Tutorial",
							to: "/tutorials",
						},
						{
							label: "DevOps",
							to: "/devops",
						},
						{
							label: "Plugin Functions",
							to: "/plugin-functions",
						},
						{
							label: "Resources",
							to: "/resources",
						},
					],
				},
				{
					title: "Community",
					items: [
						{
							label: "Stack Overflow",
							href: "https://stackoverflow.com/questions/tagged/metacontract",
						},
						{
							label: "X",
							href: "https://x.com/ecdysis_xyz",
						},
					],
				},
				{
					title: "More",
					items: [
						{
							label: "GitHub",
							href: "https://github.com/metacontract/mc",
						},
					],
				},
			],
			copyright: `Copyright © ${new Date().getFullYear()} Ecdysis, Inc. Built with Docusaurus.`,
		},
		prism: {
			theme: prismThemes.github,
			darkTheme: prismThemes.dracula,
			additionalLanguages: ["solidity"],
		},
	} satisfies Preset.ThemeConfig,
};

export default config;
