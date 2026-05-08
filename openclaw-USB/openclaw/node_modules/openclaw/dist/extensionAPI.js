import { b as resolveAgentDir, x as resolveAgentWorkspaceDir } from "./agent-scope-B6RIBoEj.js";
import { n as DEFAULT_MODEL, r as DEFAULT_PROVIDER } from "./defaults-Cbe87E7A.js";
import { a as resolveSessionFilePath, d as resolveStorePath } from "./paths-DG09LE-n.js";
import { t as loadSessionStore } from "./store-load-DjtlQRVG.js";
import { i as saveSessionStore, o as updateSessionStore, s as updateSessionStoreEntry } from "./store-DvxAjGkI.js";
import "./sessions-DEgkNCWw.js";
import { p as resolveThinkingDefault } from "./model-selection-u8IQheQP.js";
import { t as resolveAgentTimeoutMs } from "./timeout-XT_E4tFL.js";
import { l as ensureAgentWorkspace } from "./workspace-Caf7L7oC.js";
import { n as resolveAgentIdentity } from "./identity-Cg93gos2.js";
import { t as runEmbeddedPiAgent } from "./pi-embedded-Bcz04p2i.js";
//#region src/extensionAPI.ts
if (process.env.VITEST !== "true" && process.env.OPENCLAW_SUPPRESS_EXTENSION_API_WARNING !== "1") process.emitWarning("openclaw/extension-api is deprecated. Migrate to api.runtime.agent.* or focused openclaw/plugin-sdk/<subpath> imports. See https://docs.openclaw.ai/plugins/sdk-migration", {
	code: "OPENCLAW_EXTENSION_API_DEPRECATED",
	detail: "This compatibility bridge is temporary. Bundled plugins should use the injected plugin runtime instead of importing host-side agent helpers directly. Migration guide: https://docs.openclaw.ai/plugins/sdk-migration"
});
//#endregion
export { DEFAULT_MODEL, DEFAULT_PROVIDER, ensureAgentWorkspace, loadSessionStore, resolveAgentDir, resolveAgentIdentity, resolveAgentTimeoutMs, resolveAgentWorkspaceDir, resolveSessionFilePath, resolveStorePath, resolveThinkingDefault, runEmbeddedPiAgent, saveSessionStore, updateSessionStore, updateSessionStoreEntry };
