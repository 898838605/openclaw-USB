import { t as formatDocsLink } from "../../links-dQIIPEtq.js";
import { t as formatCliCommand } from "../../command-format-ut6bcRZg.js";
import { l as normalizeE164 } from "../../utils-D5swhEXt.js";
import { n as normalizeAccountId, t as DEFAULT_ACCOUNT_ID } from "../../account-id-Bj7l9NI7.js";
import { o as SignalConfigSchema } from "../../zod-schema.providers-whatsapp-CSmjq_Ez.js";
import { r as buildChannelConfigSchema } from "../../config-schema-BV5tVmUb.js";
import { a as chunkText } from "../../chunk-BbwYgLMX.js";
import { n as deleteAccountFromConfigSection, r as setAccountEnabledInConfigSection } from "../../config-helpers-B2gAJDxw.js";
import { n as formatPairingApproveHint } from "../../helpers-dXse5DzJ.js";
import "../../text-runtime-BMYQWTAu.js";
import { r as emptyPluginConfigSchema } from "../../config-schema-DDtADzVW.js";
import { s as migrateBaseNameToDefaultAccount, t as applyAccountNameToChannelSection } from "../../setup-helpers-CuZobs-u.js";
import { c as getChatChannelMeta } from "../../core-DHPyYUWl.js";
import { t as createPluginRuntimeStore } from "../../runtime-store-CvOKxtAs.js";
import { n as resolveAllowlistProviderRuntimeGroupPolicy, r as resolveDefaultGroupPolicy } from "../../runtime-group-policy-2_c3RVKt.js";
import { t as resolveChannelMediaMaxBytes } from "../../media-limits-D2Qvb5jA.js";
import { t as PAIRING_APPROVED_MESSAGE } from "../../pairing-message-Do4-RkMj.js";
import { c as collectStatusIssuesFromLastError, d as createDefaultChannelRuntimeState, n as buildBaseChannelStatusSummary, t as buildBaseAccountStatusSnapshot } from "../../status-helpers-EbdaWWKh.js";
import { t as detectBinary } from "../../detect-binary-1fORvNsg.js";
import "../../setup-tools-ZacQ_yTv.js";
import "../../reply-runtime-Ke_lK6wQ.js";
import "../../media-runtime-Dq0g9QyA.js";
import "../../channel-status-CP7FoGmw.js";
import { i as resolveSignalAccount, n as listSignalAccountIds, r as resolveDefaultSignalAccountId, t as listEnabledSignalAccounts } from "../../accounts-CnGj3bey.js";
import { d as looksLikeSignalTargetId, f as normalizeSignalMessagingTarget } from "../../identity-C8dFIGIB.js";
import { n as sendReactionSignal, t as removeReactionSignal } from "../../reaction-runtime-api-CuwtcNuO.js";
import { n as resolveSignalReactionLevel, t as signalMessageActions } from "../../message-actions-BNTthAxp.js";
import "../../config-api-ty-mUvII.js";
import { r as installSignalCli } from "../../install-signal-cli-8BQWEoEK.js";
import { t as monitorSignalProvider } from "../../monitor-BGEQlW7T.js";
import { t as sendMessageSignal } from "../../send-BVQYiTiG.js";
import { t as probeSignal } from "../../probe-BVvxxbbA.js";
//#region extensions/signal/src/runtime.ts
const { setRuntime: setSignalRuntime, clearRuntime: clearSignalRuntime } = createPluginRuntimeStore({
	pluginId: "signal",
	errorMessage: "Signal runtime not initialized"
});
//#endregion
export { DEFAULT_ACCOUNT_ID, PAIRING_APPROVED_MESSAGE, SignalConfigSchema, applyAccountNameToChannelSection, buildBaseAccountStatusSnapshot, buildBaseChannelStatusSummary, buildChannelConfigSchema, chunkText, collectStatusIssuesFromLastError, createDefaultChannelRuntimeState, deleteAccountFromConfigSection, detectBinary, emptyPluginConfigSchema, formatCliCommand, formatDocsLink, formatPairingApproveHint, getChatChannelMeta, installSignalCli, listEnabledSignalAccounts, listSignalAccountIds, looksLikeSignalTargetId, migrateBaseNameToDefaultAccount, monitorSignalProvider, normalizeAccountId, normalizeE164, normalizeSignalMessagingTarget, probeSignal, removeReactionSignal, resolveAllowlistProviderRuntimeGroupPolicy, resolveChannelMediaMaxBytes, resolveDefaultGroupPolicy, resolveDefaultSignalAccountId, resolveSignalAccount, resolveSignalReactionLevel, sendMessageSignal, sendReactionSignal, setAccountEnabledInConfigSection, setSignalRuntime, signalMessageActions };
