import { execSync } from "node:child_process";
import { readdirSync, statSync } from "node:fs";
import { join } from "node:path";
import { copySync, removeSync } from "fs-extra";
import { config } from "../config";
import { logError, logInfo, logMessage, logSuccess } from "./utils";

function compareAndDeleteDirectories(from: string, to: string) {
	const fromFiles = new Set(readdirSync(from));
	const toFiles = readdirSync(to);

	for (const file of toFiles) {
		// Ignore 'index.md' files
		if (file === "index.md") {
			continue;
		}

		const fromFilePath = join(from, file);
		const toFilePath = join(to, file);

		if (!fromFiles.has(file)) {
			removeSync(toFilePath);
			logError(
				`Deleted file or directory in 'to' but not in 'from': ${toFilePath}`,
				true,
			);
		} else if (statSync(toFilePath).isDirectory()) {
			// If it's a directory, recurse into it
			compareAndDeleteDirectories(fromFilePath, toFilePath);
		}
	}
}

export function generateAndMoveForgeDocs() {
	try {
		// // Ensure the PATH includes the directory where forge is installed
		// process.env.PATH = `${process.env.HOME}/.foundry/bin:${process.env.PATH}`;

		// // Generate solidity docs into the temporary directory using `forge doc`
		// execSync(`cd ${config.rootPath} && forge doc -o ${config.tempDir}`, {
		// 	stdio: "inherit",
		// });
		// logInfo(`Generated solidity docs in ${config.rootPath}/${config.tempDir}`);

		// Move generated docs to appropriate directories
		if (config.copyPaths.length > 0) {
			for (const copyPath of config.copyPaths) {
				const from = join(
					config.rootPath,
					config.tempDir,
					config.tempDirOffset,
					copyPath.from,
				);
				const to = join(config.rootPath, config.docsDir, copyPath.to);
				logMessage(`Copying ${from} to ${to}`);
				copySync(from, to);

				// Recursively compare and delete files and directories in 'to' that are not in 'from'
				compareAndDeleteDirectories(from, to);
			}
		}

		// // Remove unnecessary temporary directory
		// removeSync(`${config.rootPath}/${config.tempDir}`);
		// logInfo(`Removed temporary directory ${config.rootPath}/${config.tempDir}`);

		logSuccess("Successfully generated and moved solidity docs");
	} catch (error) {
		console.error("Failed to generate and move solidity docs:\n", error);
		process.exit(1);
	}
}
