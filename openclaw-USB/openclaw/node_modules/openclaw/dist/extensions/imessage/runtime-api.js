import { t as DEFAULT_ACCOUNT_ID } from "../../account-id-Bj7l9NI7.js";
import { i as IMessageConfigSchema } from "../../zod-schema.providers-whatsapp-CSmjq_Ez.js";
import { r as buildChannelConfigSchema } from "../../config-schema-BV5tVmUb.js";
import { p as formatTrimmedAllowFromEntries } from "../../channel-config-helpers-C3YAiGHo.js";
import { c as getChatChannelMeta } from "../../core-DHPyYUWl.js";
import { t as createPluginRuntimeStore } from "../../runtime-store-CvOKxtAs.js";
import { t as resolveChannelMediaMaxBytes } from "../../media-limits-D2Qvb5jA.js";
import { t as PAIRING_APPROVED_MESSAGE } from "../../pairing-message-Do4-RkMj.js";
import { c as collectStatusIssuesFromLastError, r as buildComputedAccountStatusSnapshot } from "../../status-helpers-EbdaWWKh.js";
import "../../media-runtime-Dq0g9QyA.js";
import { t as chunkTextForOutbound } from "../../text-chunking-UnppYSLN.js";
import "../../channel-status-CP7FoGmw.js";
import { s as resolveIMessageAccount } from "../../media-contract-Ds3LbwYy.js";
import { f as looksLikeIMessageTargetId, p as normalizeIMessageMessagingTarget } from "../../conversation-id-70qw2--W.js";
import { n as resolveIMessageGroupToolPolicy, t as resolveIMessageGroupRequireMention } from "../../group-policy-B4BB6xHv.js";
import "../../config-api-Dy51-0qV.js";
import { t as probeIMessage } from "../../probe-CANnyStt.js";
import { n as sendMessageIMessage, t as monitorIMessageProvider } from "../../monitor-DlbXeUxF.js";
//#region extensions/imessage/src/config-accessors.ts
function resolveIMessageConfigAllowFrom(params) {
	return (resolveIMessageAccount(params).config.allowFrom ?? []).map((entry) => String(entry));
}
function resolveIMessageConfigDefaultTo(params) {
	const defaultTo = resolveIMessageAccount(params).config.defaultTo;
	if (defaultTo == null) return;
	return defaultTo.trim() || void 0;
}
//#endregion
//#region extensions/imessage/src/runtime.ts
const { setRuntime: setIMessageRuntime } = createPluginRuntimeStore({
	pluginId: "imessage",
	errorMessage: "iMessage runtime not initialized"
});
//#endregion
export { DEFAULT_ACCOUNT_ID, IMessageConfigSchema, PAIRING_APPROVED_MESSAGE, buildChannelConfigSchema, buildComputedAccountStatusSnapshot, chunkTextForOutbound, collectStatusIssuesFromLastError, formatTrimmedAllowFromEntries, getChatChannelMeta, looksLikeIMessageTargetId, monitorIMessageProvider, normalizeIMessageMessagingTarget, probeIMessage, resolveChannelMediaMaxBytes, resolveIMessageConfigAllowFrom, resolveIMessageConfigDefaultTo, resolveIMessageGroupRequireMention, resolveIMessageGroupToolPolicy, sendMessageIMessage, setIMessageRuntime };
