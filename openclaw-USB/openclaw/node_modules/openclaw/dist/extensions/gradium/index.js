import { t as definePluginEntry } from "../../plugin-entry-DUUsLt7Y.js";
import { t as buildGradiumSpeechProvider } from "../../speech-provider-BGnakG9Z.js";
//#region extensions/gradium/index.ts
var gradium_default = definePluginEntry({
	id: "gradium",
	name: "Gradium Speech",
	description: "Bundled Gradium speech provider",
	register(api) {
		api.registerSpeechProvider(buildGradiumSpeechProvider());
	}
});
//#endregion
export { gradium_default as default };
