import { d as resolveStorePath } from "./paths-DG09LE-n.js";
import { s as updateSessionStoreEntry } from "./store-DvxAjGkI.js";
import "./sessions-DEgkNCWw.js";
//#region src/agents/pi-embedded-subscribe.handlers.compaction.runtime.ts
async function reconcileSessionStoreCompactionCountAfterSuccess(params) {
	const { sessionKey, agentId, configStore, observedCompactionCount, now = Date.now() } = params;
	if (!sessionKey || observedCompactionCount <= 0) return;
	return (await updateSessionStoreEntry({
		storePath: resolveStorePath(configStore, { agentId }),
		sessionKey,
		update: async (entry) => {
			const currentCount = Math.max(0, entry.compactionCount ?? 0);
			const nextCount = Math.max(currentCount, observedCompactionCount);
			if (nextCount === currentCount) return null;
			return {
				compactionCount: nextCount,
				updatedAt: Math.max(entry.updatedAt ?? 0, now)
			};
		}
	}))?.compactionCount;
}
//#endregion
export { reconcileSessionStoreCompactionCountAfterSuccess };
