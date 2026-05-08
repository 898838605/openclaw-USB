import { n as buildManifestModelProviderConfig } from "./provider-catalog-shared-CYN2NIkQ.js";
import { t as modelCatalog } from "./openclaw.plugin-CZ0TgSby.js";
//#region extensions/mistral/provider-catalog.ts
function buildMistralProvider() {
	return buildManifestModelProviderConfig({
		providerId: "mistral",
		catalog: modelCatalog.providers.mistral
	});
}
//#endregion
export { buildMistralProvider as t };
