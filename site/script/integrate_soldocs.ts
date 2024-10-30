import { config } from "./config";
import { updateLinks } from "./soldocs/update_links";
import { generateAndMoveForgeDocs } from "./soldocs/generate_and_move_forge_docs";
import { upsertIndexFile } from "./soldocs/upsert_index_file";
import {
	extractPaths,
	logSuccess,
	processPathsInSubdirectories,
} from "./soldocs/utils";

function integrateSolDocs() {
	generateAndMoveForgeDocs(); // TODO remove unexisting docs

	processPathsInSubdirectories(extractPaths(config.copyPaths), [
		upsertIndexFile,
		updateLinks,
	]);

	logSuccess("Successfully generated Solidity API docs!", true);
}

integrateSolDocs();
