import { t as definePluginEntry } from "../../plugin-entry-DUUsLt7Y.js";
import { n as buildFalImageGenerationProvider } from "../../image-generation-provider-1SPxKvNC.js";
import { t as createFalProvider } from "../../provider-registration-BOGTaO5c.js";
import { n as buildFalVideoGenerationProvider } from "../../video-generation-provider-BOZ9UFi0.js";
var fal_default = definePluginEntry({
	id: "fal",
	name: "fal Provider",
	description: "Bundled fal image and video generation provider",
	register(api) {
		api.registerProvider(createFalProvider());
		api.registerImageGenerationProvider(buildFalImageGenerationProvider());
		api.registerVideoGenerationProvider(buildFalVideoGenerationProvider());
	}
});
//#endregion
export { fal_default as default };
