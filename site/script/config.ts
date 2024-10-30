import { type Config, defaultConfig } from "./soldocs/utils";

export const config: Config = {
	...defaultConfig,
	copyPaths: [
		{
			from: "src/std/",
			to: "02-guides/02-development/03-std-functions/05-std/",
		},
		{
			from: "src/devkit/",
			to: "03-api/03-api-details/",
		},
		// {
		// 	from: "lib/ucs-contracts/src/",
		// 	to: "03-api/03-api-details/ucs-contracts/",
		// },
	],
	docsDir: "site/docs",
};
