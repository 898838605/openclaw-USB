import { t as definePluginEntry } from "../../plugin-entry-DUUsLt7Y.js";
import { i as resolveAnthropicVertexConfigApiKey } from "../../region-zm4pn72t.js";
//#region extensions/anthropic-vertex/setup-api.ts
var setup_api_default = definePluginEntry({
	id: "anthropic-vertex",
	name: "Anthropic Vertex Setup",
	description: "Lightweight Anthropic Vertex setup hooks",
	register(api) {
		api.registerProvider({
			id: "anthropic-vertex",
			label: "Anthropic Vertex",
			auth: [],
			resolveConfigApiKey: ({ env }) => resolveAnthropicVertexConfigApiKey(env)
		});
	}
});
//#endregion
export { setup_api_default as default };
