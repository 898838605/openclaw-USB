import "./session-binding-service-7_9X79Yd.js";
import "./thread-bindings-policy-CksLUJN9.js";
import "./conversation-binding-B6iB0V05.js";
import "./binding-registry-B8HXLRqx.js";
import "./session-DJhdI8Qg.js";
import "./pairing-store-C3tDe-Lw.js";
import "./dm-policy-shared-DKaYtHuP.js";
import "./binding-targets-uoGsDs8V.js";
import "./binding-routing-CnmLSI34.js";
import "./pairing-labels-xt-XBu9p.js";
//#region src/channels/session-meta.ts
let inboundSessionRuntimePromise = null;
function loadInboundSessionRuntime() {
	inboundSessionRuntimePromise ??= import("./inbound.runtime-CYu9NIS8.js");
	return inboundSessionRuntimePromise;
}
async function recordInboundSessionMetaSafe(params) {
	const runtime = await loadInboundSessionRuntime();
	const storePath = runtime.resolveStorePath(params.cfg.session?.store, { agentId: params.agentId });
	try {
		await runtime.recordSessionMetaFromInbound({
			storePath,
			sessionKey: params.sessionKey,
			ctx: params.ctx
		});
	} catch (err) {
		params.onError?.(err);
	}
}
//#endregion
export { recordInboundSessionMetaSafe as t };
