import "./subsystem-CxWoQXRD.js";
import "./provider-env-vars-pk6C_sd4.js";
import "./failover-error-BCSVecGt.js";
import "./provider-model-shared-DMDlhIax.js";
import "./provider-registry-Ds1zOSz-.js";
import "./runtime-shared-Cg0obnBB.js";
//#region src/plugin-sdk/image-generation-core.ts
const OPENAI_DEFAULT_IMAGE_MODEL = "gpt-image-2";
let imageGenerationCoreAuthRuntimePromise;
async function loadImageGenerationCoreAuthRuntime() {
	imageGenerationCoreAuthRuntimePromise ??= import("./image-generation-core.auth.runtime.js");
	return imageGenerationCoreAuthRuntimePromise;
}
async function resolveApiKeyForProvider(...args) {
	return (await loadImageGenerationCoreAuthRuntime()).resolveApiKeyForProvider(...args);
}
//#endregion
export { resolveApiKeyForProvider as n, OPENAI_DEFAULT_IMAGE_MODEL as t };
