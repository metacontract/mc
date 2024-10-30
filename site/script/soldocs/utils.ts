import { execSync } from "node:child_process";
import {
	existsSync,
	readFileSync,
	readdirSync,
	statSync,
	writeFileSync,
} from "node:fs";
import { join } from "node:path";
import { config } from "../config";

export interface Config {
	copyPaths: { from: string; to: string }[];
	log: boolean;
	rootPath: string;
	tempDir: string;
	tempDirOffset: string;
	docsDir: string;
}

export const defaultConfig: Config = {
	copyPaths: [],
	log: false,
	rootPath: execSync("git rev-parse --show-toplevel").toString().trim(),
	tempDir: "temp_soldocs",
	tempDirOffset: "src",
	docsDir: "docs",
};

export function logMessage(message: string, alwaysShow = false) {
	if (config.log || alwaysShow) {
		console.log(message);
	}
}

const colors = {
	red: "\x1b[31m",
	green: "\x1b[32m",
	blue: "\x1b[34m",
	reset: "\x1b[0m",
};

export function logSuccess(message: string, alwaysShow = false) {
	logMessage(`${colors.green}${message}${colors.reset}`, alwaysShow);
}

export function logInfo(message: string, alwaysShow = false) {
	logMessage(`${colors.blue}${message}${colors.reset}`, alwaysShow);
}

export function logError(message: string, alwaysShow = false) {
	logMessage(`${colors.red}${message}${colors.reset}`, alwaysShow);
}

export function updateIndexFile(directoryPath: string, indexItems: string) {
	if (!indexItems) {
		logMessage(
			"No index items generated. The directory might be empty or contain only index.md/README.md.",
		);
		return;
	}

	const indexFilePath = join(directoryPath, "index.md");
	const startMarker = "<!-- START_INDEX -->";
	const endMarker = "<!-- END_INDEX -->";

	let indexContent = "";
	if (existsSync(indexFilePath)) {
		indexContent = readFileSync(indexFilePath, "utf-8");
	}

	const newIndexContent =
		indexContent.includes(startMarker) && indexContent.includes(endMarker)
			? indexContent.replace(
					new RegExp(`${startMarker}[\\s\\S]*${endMarker}`),
					`${startMarker}\n${indexItems}\n${endMarker}`,
				)
			: `# Index\n\n${startMarker}\n${indexItems}\n${endMarker}`;

	writeFileSync(indexFilePath, newIndexContent, "utf-8");
	logInfo(`Index file updated: ${indexFilePath}`);
}

export function getSubdirectories(directoryPath: string): string[] {
	return readdirSync(directoryPath).filter((subdir) => {
		const subdirPath = join(directoryPath, subdir);
		return statSync(subdirPath).isDirectory();
	});
}

export function processPathsInSubdirectories(
	paths: string[],
	callbacks: ((path: string) => void)[],
	isResolved = false,
) {
	for (const path of paths) {
		const resolvedPath = isResolved ? path : resolvePath(path);
		for (const callback of callbacks) {
			callback(resolvedPath);
		}

		const subdirs = getSubdirectories(resolvedPath);
		for (const subdir of subdirs) {
			processPathsInSubdirectories(
				[join(resolvedPath, subdir)],
				callbacks,
				true,
			);
		}
	}
}

export function resolvePath(path: string): string {
	const rootPath = execSync("git rev-parse --show-toplevel").toString().trim();
	return join(rootPath, path);
}

export function extractPaths(copyPaths: Config["copyPaths"]): string[] {
	return copyPaths.map((copyPath) => join(config.docsDir, copyPath.to));
}
