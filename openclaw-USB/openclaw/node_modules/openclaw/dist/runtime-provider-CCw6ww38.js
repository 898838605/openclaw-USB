import { t as resolveMemoryBackendConfig } from "./backend-config-wQqNBgw7.js";
import "./memory-core-host-runtime-files-B9ni7xK2.js";
import { n as getMemorySearchManager, t as closeAllMemorySearchManagers } from "./memory-AcDH_HMC.js";
//#region extensions/memory-core/src/runtime-provider.ts
const memoryRuntime = {
	async getMemorySearchManager(params) {
		const { manager, error } = await getMemorySearchManager(params);
		return {
			manager,
			error
		};
	},
	resolveMemoryBackendConfig(params) {
		return resolveMemoryBackendConfig(params);
	},
	async closeAllMemorySearchManagers() {
		await closeAllMemorySearchManagers();
	}
};
//#endregion
export { memoryRuntime as t };
