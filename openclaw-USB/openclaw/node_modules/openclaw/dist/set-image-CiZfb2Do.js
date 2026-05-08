import { n as resolveAgentModelPrimaryValue } from "./model-input-gjsFWrBi.js";
import { n as logConfigUpdated } from "./logging-didorrhm.js";
import { t as applyDefaultModelPrimaryUpdate, u as updateConfig } from "./shared-yc3l08J1.js";
//#region src/commands/models/set-image.ts
async function modelsSetImageCommand(modelRaw, runtime) {
	const updated = await updateConfig((cfg) => {
		return applyDefaultModelPrimaryUpdate({
			cfg,
			modelRaw,
			field: "imageModel"
		});
	});
	logConfigUpdated(runtime);
	runtime.log(`Image model: ${resolveAgentModelPrimaryValue(updated.agents?.defaults?.imageModel) ?? modelRaw}`);
}
//#endregion
export { modelsSetImageCommand };
