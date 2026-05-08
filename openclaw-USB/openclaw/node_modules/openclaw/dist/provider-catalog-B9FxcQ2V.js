import { n as buildManifestModelProviderConfig } from "./provider-catalog-shared-CYN2NIkQ.js";
import { t as modelCatalog } from "./openclaw.plugin-Bpef8q3v.js";
//#region extensions/together/provider-catalog.ts
function buildTogetherProvider() {
	return buildManifestModelProviderConfig({
		providerId: "together",
		catalog: modelCatalog.providers.together
	});
}
//#endregion
export { buildTogetherProvider as t };
