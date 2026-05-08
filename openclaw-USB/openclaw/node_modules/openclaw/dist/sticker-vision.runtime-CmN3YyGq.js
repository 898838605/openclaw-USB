import { S as findModelInCatalog } from "./model-selection-shared-DOxyWoaQ.js";
import { o as resolveDefaultModelForAgent } from "./model-selection-u8IQheQP.js";
import { a as modelSupportsVision, r as loadModelCatalog } from "./model-catalog-BlLdiT-K.js";
import "./agent-runtime-BcGQ8GlR.js";
//#region extensions/telegram/src/sticker-vision.runtime.ts
async function resolveStickerVisionSupportRuntime(params) {
	const catalog = await loadModelCatalog({ config: params.cfg });
	const defaultModel = resolveDefaultModelForAgent({
		cfg: params.cfg,
		agentId: params.agentId
	});
	const entry = findModelInCatalog(catalog, defaultModel.provider, defaultModel.model);
	if (!entry) return false;
	return modelSupportsVision(entry);
}
//#endregion
export { resolveStickerVisionSupportRuntime };
