import { readFileSync, readdirSync, writeFileSync } from "node:fs";
import { join, relative } from "node:path";

import { config } from "../config";
import { logMessage, logSuccess } from "./utils";

export function updateLinks(directoryPath: string) {
	const markdownFiles = getMarkdownFiles(directoryPath);

	for (const file of markdownFiles) {
		const originalMarkdown = readFileSync(file, "utf-8");
		const replacedMarkdown = replaceLinks(originalMarkdown, directoryPath);

		writeFileSync(file, replacedMarkdown, "utf-8");
		logMessage(`Updated: ${file}`);
	}

	logSuccess("Successfully converted links.");
}

function getMarkdownFiles(directoryPath: string): string[] {
	return readdirSync(directoryPath)
		.filter((file) => file.endsWith(".md"))
		.map((file) => join(directoryPath, file));
}

function replaceLinks(markdown: string, directoryPath: string) {
	return markdown.replace(
		/\[([^\]]+)\]\((\/[^)]+\.md)(#[^\s)]+)?\)/g,
		(match, text, path, fragment) => {
			if (!path.startsWith("/")) return match;

			const newPath = getNewPath(path, directoryPath);

			return `[${text}](${newPath}${fragment || ""})`;
		},
	);
}

function getNewPath(path: string, directoryPath: string): string {
	let newPath = path;
	for (const copyPath of config.copyPaths) {
		if (newPath.startsWith(`/${copyPath.from}`)) {
			newPath = newPath.replace(`/${copyPath.from}`, `/${copyPath.to}`);
		}
	}
	logMessage(directoryPath);
	logMessage(newPath);
	return relative(
		directoryPath,
		join(config.rootPath, config.docsDir, newPath),
	);
}
