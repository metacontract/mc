import {
	existsSync,
	readFileSync,
	readdirSync,
	statSync,
	unlinkSync,
} from "node:fs";
import { basename, join } from "node:path";

import { logMessage, updateIndexFile } from "./utils";

export function upsertIndexFile(directoryPath: string) {
	const readmeFile = join(directoryPath, "README.md");

	updateIndexFile(
		directoryPath,
		existsSync(readmeFile)
			? extractIndexItemsFrom(readmeFile)
			: generateIndexItemsFor(directoryPath),
	);
}

function extractIndexItemsFrom(readmeFile: string): string {
	logMessage(`Extracting index items from ${readmeFile}`);

	const readmeMarkdown = readFileSync(readmeFile, "utf-8");
	const indexItems = readmeMarkdown
		// Extract lines that match the pattern of an index item
		.match(/^- \[.*?\]\(.*?\)$/gm)
		// Replace the link with the correct path
		.map((line) => {
			const linkMatch = line.match(/\((.*?)\)/);
			if (linkMatch) {
				let linkPath = linkMatch[1];
				// Directory paths need to be converted to index.md
				if (linkPath.startsWith("/")) {
					linkPath = `${linkPath.split("/").pop()}/index.md`;
				}
				// Convert the link to a relative path
				linkPath = `./${linkPath}`;
				return line.replace(/\((.*?)\)/, `(${linkPath})`);
			}
			return line;
		})
		.join("\n");

	// Remove the README.md file after extracting the index items
	unlinkSync(readmeFile);
	logMessage(`README.md removed: ${readmeFile}`);

	return indexItems;
}

function generateIndexItemsFor(directoryPath: string): string {
	logMessage(`Generating index items for ${directoryPath}`);

	const items = readdirSync(directoryPath);
	let indexItems = "";

	for (const item of items) {
		const itemStats = statSync(join(directoryPath, item));

		if (itemStats.isDirectory()) {
			const dirname = basename(item);
			indexItems += `- [${dirname}](./${dirname}/index.md)\n`;
			continue;
		}
		if (itemStats.isFile()) {
			if (item === "index.md" || item === "README.md") continue;
			indexItems += `- [${basename(item, ".md")}](./${item})\n`;
		}
	}

	return indexItems;
}
