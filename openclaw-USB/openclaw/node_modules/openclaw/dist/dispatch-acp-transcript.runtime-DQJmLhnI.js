import { p as resolveSessionAgentId } from "./agent-scope-B6RIBoEj.js";
import { d as resolveStorePath } from "./paths-DG09LE-n.js";
import { t as loadSessionStore } from "./store-load-DjtlQRVG.js";
import { d as resolveSessionStoreEntry } from "./store-DvxAjGkI.js";
import "./sessions-DEgkNCWw.js";
import { n as resolveAcpSessionCwd } from "./session-identifiers-Dsj04UzU.js";
import { o as persistAcpTurnTranscript } from "./attempt-execution-Sysxsxi3.js";
//#region src/auto-reply/reply/dispatch-acp-transcript.runtime.ts
async function persistAcpDispatchTranscript(params) {
	const promptText = params.promptText.trim();
	const finalText = params.finalText.trim();
	if (!promptText && !finalText) return;
	const sessionAgentId = resolveSessionAgentId({
		sessionKey: params.sessionKey,
		config: params.cfg
	});
	const storePath = resolveStorePath(params.cfg.session?.store, { agentId: sessionAgentId });
	const sessionStore = loadSessionStore(storePath, { skipCache: true });
	const sessionEntry = resolveSessionStoreEntry({
		store: sessionStore,
		sessionKey: params.sessionKey
	}).existing;
	const sessionId = sessionEntry?.sessionId;
	if (!sessionId) throw new Error(`unknown ACP session key: ${params.sessionKey}`);
	await persistAcpTurnTranscript({
		body: promptText,
		transcriptBody: promptText,
		finalText,
		sessionId,
		sessionKey: params.sessionKey,
		sessionEntry,
		sessionStore,
		storePath,
		sessionAgentId,
		threadId: params.threadId,
		sessionCwd: resolveAcpSessionCwd(params.meta) ?? process.cwd(),
		config: params.cfg
	});
}
//#endregion
export { persistAcpDispatchTranscript };
