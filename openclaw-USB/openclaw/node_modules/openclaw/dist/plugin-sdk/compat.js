import { n as normalizeAccountId } from "../account-id-Bj7l9NI7.js";
import { a as onDiagnosticEvent } from "../diagnostic-events-CjwOn-Qj.js";
import { n as resolvePreferredOpenClawTmpDir } from "../tmp-openclaw-dir-BT06rvao.js";
import { l as ToolPolicySchema } from "../zod-schema.agent-runtime-BgmaoJWM.js";
import { L as requireOpenAllowFrom, a as DmConfigSchema, b as ReplyRuntimeConfigSchemaShape, h as MarkdownConfigSchema, i as ContextVisibilityModeSchema, l as GroupPolicySchema, n as BlockStreamingCoalesceSchema, o as DmPolicySchema } from "../zod-schema.core-B8hU4HYi.js";
import { a as buildNestedDmConfigSchema, i as buildJsonChannelConfigSchema, n as buildCatchallMultiAccountChannelSchema, r as buildChannelConfigSchema, t as AllowFromListSchema } from "../config-schema-BV5tVmUb.js";
import { n as registerContextEngine } from "../registry-CxcGD4Pv.js";
import { r as loadBundledPluginPublicSurfaceModuleSync } from "../facade-loader-CEuC9fQG.js";
import { t as KeyedAsyncQueue } from "../keyed-async-queue-BNki7ByP.js";
import { i as writeOAuthCredentials, n as buildApiKeyCredential, r as upsertApiKeyProfile, t as applyAuthProfileConfig } from "../provider-auth-helpers-CvYCN4Y4.js";
import "../common-CA61yuMe.js";
import { i as stringEnum, r as optionalStringEnum } from "../typebox-DIdLAS7E.js";
import "../temp-path-y0jrf-U9.js";
import { i as resolveToolsBySender, n as resolveChannelGroupRequireMention, r as resolveChannelGroupToolsPolicy, t as resolveChannelGroupPolicy } from "../group-policy-lsreEzCY.js";
import { a as createHybridChannelConfigBase, c as createScopedChannelConfigBase, d as createTopLevelChannelConfigBase, i as createHybridChannelConfigAdapter, l as createScopedDmSecurityResolver, m as mapAllowFromEntries, o as createScopedAccountConfigAccessors, s as createScopedChannelConfigAdapter, u as createTopLevelChannelConfigAdapter } from "../channel-config-helpers-C3YAiGHo.js";
import { t as buildAccountScopedDmSecurityPolicy } from "../helpers-dXse5DzJ.js";
import "../identity-Cg93gos2.js";
import { n as delegateCompactionToRuntime, t as buildMemorySystemPromptAddition } from "../delegate-BC5Lg42Y.js";
import "../text-runtime-BMYQWTAu.js";
import { r as emptyPluginConfigSchema } from "../config-schema-DDtADzVW.js";
import "../setup-helpers-CuZobs-u.js";
import { n as resolveControlCommandGate } from "../command-gating-C19Zl5i4.js";
import { a as buildHistoryContextFromMap, c as clearHistoryEntriesIfEnabled, d as recordPendingHistoryEntryIfEnabled, i as buildHistoryContextFromEntries, l as evictOldHistoryKeys, n as HISTORY_CONTEXT_MARKER, o as buildPendingHistoryContextFromMap, r as buildHistoryContext, s as clearHistoryEntries, t as DEFAULT_GROUP_HISTORY_LIMIT, u as recordPendingHistoryEntry } from "../history-BGbRi2qs.js";
import { n as createReplyPrefixOptions$1, t as createReplyPrefixContext$1 } from "../reply-prefix-CZ-A30s9.js";
import { t as createTypingCallbacks$1 } from "../typing-C76apqf2.js";
import { n as resolveChannelSourceReplyDeliveryMode$1, t as createChannelReplyPipeline$1 } from "../channel-reply-pipeline-CBbtFicQ.js";
import { t as createAccountStatusSink } from "../channel-lifecycle.core-BcJ10WSB.js";
import { t as createPluginRuntimeStore } from "../runtime-store-CvOKxtAs.js";
import { a as mapAllowlistResolutionInputs, n as formatNormalizedAllowFromEntries, t as formatAllowFromLowercase } from "../allow-from-CXjiWuE7.js";
import "../channel-config-schema-AjrRhQKW.js";
import { C as createOpenProviderGroupPolicyWarningCollector, D as projectConfigWarningCollector, E as projectConfigAccountIdWarningCollector, O as projectWarningCollector, S as createOpenProviderConfiguredRouteWarningCollector, T as projectAccountWarningCollector, _ as createAllowlistProviderOpenWarningCollector, a as buildOpenGroupPolicyConfigureRouteAllowlistWarning, b as createConditionalWarningCollector, c as collectAllowlistProviderGroupPolicyWarnings, d as collectOpenGroupPolicyRestrictSendersWarnings, f as collectOpenGroupPolicyRouteAllowlistWarnings, g as createAllowlistProviderGroupPolicyWarningCollector, h as composeWarningCollectors, i as normalizeAllowFromList, l as collectAllowlistProviderRestrictSendersWarnings, m as composeAccountWarningCollectors, n as createDangerousNameMatchingMutableAllowlistWarningCollector, o as buildOpenGroupPolicyRestrictSendersWarning, p as collectOpenProviderGroupPolicyWarnings, r as createRestrictSendersChannelSecurity, s as buildOpenGroupPolicyWarning, t as coerceNativeSetting, u as collectOpenGroupPolicyConfiguredRouteWarnings, v as createAllowlistProviderRestrictSendersWarningCollector, w as projectAccountConfigWarningCollector, x as createOpenGroupPolicyRestrictSendersWarningCollector, y as createAllowlistProviderRouteAllowlistWarningCollector } from "../channel-policy-BSjzQfzH.js";
import { a as resolveSenderScopedGroupPolicy, i as evaluateSenderGroupAccessForPolicy, t as evaluateGroupRouteAccessForPolicy } from "../group-access-DdKWV2ji.js";
import { a as resolveDmGroupAccessWithCommandGate, c as resolveOpenDmAllowlistAccess, n as readStoreAllowFromForDmPolicy, o as resolveDmGroupAccessWithLists, s as resolveEffectiveAllowFromLists, t as DM_GROUP_ACCESS_REASON } from "../dm-policy-shared-DKaYtHuP.js";
import "../reply-history-CD-4tmwr.js";
import { i as nullChannelDirectorySelf, n as createEmptyChannelDirectoryAdapter, r as emptyChannelDirectoryList, t as createChannelDirectoryAdapter } from "../directory-runtime-CiTSiN-o.js";
import { a as listDirectoryEntriesFromSources, c as listDirectoryUserEntriesFromAllowFrom, d as listResolvedDirectoryEntriesFromSources, f as listResolvedDirectoryGroupEntriesFromMapKeys, i as createResolvedDirectoryEntriesLister, l as listDirectoryUserEntriesFromAllowFromAndMapKeys, m as toDirectoryEntries, n as collectNormalizedDirectoryIds, o as listDirectoryGroupEntriesFromMapKeys, p as listResolvedDirectoryUserEntriesFromAllowFrom, r as createInspectedDirectoryEntriesLister, s as listDirectoryGroupEntriesFromMapKeysAndAllowFrom, t as applyDirectoryQueryAndLimit, u as listInspectedDirectoryEntriesFromSources } from "../directory-config-helpers-CwsUV5uO.js";
import { t as createRuntimeDirectoryLiveAdapter } from "../runtime-forwarders-yJMo07fK.js";
import { t as inspectReadOnlyChannelAccount } from "../read-only-account-inspect-CavDAahS.js";
import "../setup-wizard-helpers-BBdrHBUV.js";
import "../channel-targets-DBxH_Wuc.js";
import "../channel-pairing-D3GB9vDi.js";
import "../status-helpers-EbdaWWKh.js";
import "../webhook-ingress-JdhSKqxC.js";
//#region src/plugin-sdk/bluebubbles-policy.ts
function loadFacadeModule() {
	return loadBundledPluginPublicSurfaceModuleSync({
		dirName: "bluebubbles",
		artifactBasename: "api.js"
	});
}
const resolveBlueBubblesGroupRequireMention = ((...args) => loadFacadeModule()["resolveBlueBubblesGroupRequireMention"](...args));
const resolveBlueBubblesGroupToolPolicy = ((...args) => loadFacadeModule()["resolveBlueBubblesGroupToolPolicy"](...args));
//#endregion
//#region src/plugin-sdk/bluebubbles.ts
function loadBlueBubblesFacadeModule() {
	return loadBundledPluginPublicSurfaceModuleSync({
		dirName: "bluebubbles",
		artifactBasename: "api.js"
	});
}
function collectBlueBubblesStatusIssues(accounts) {
	return loadBlueBubblesFacadeModule().collectBlueBubblesStatusIssues(accounts);
}
//#endregion
//#region src/plugin-sdk/compat.ts
/**
* @deprecated Legacy compat surface for external plugins that still depend on
* older broad plugin-sdk imports. Use focused openclaw/plugin-sdk subpaths
* instead.
*/
if (process.env.VITEST !== "true" && process.env.OPENCLAW_SUPPRESS_PLUGIN_SDK_COMPAT_WARNING !== "1") process.emitWarning("openclaw/plugin-sdk/compat is deprecated for new plugins. Migrate to focused openclaw/plugin-sdk/<subpath> imports. See https://docs.openclaw.ai/plugins/sdk-migration", {
	code: "OPENCLAW_PLUGIN_SDK_COMPAT_DEPRECATED",
	detail: "Bundled plugins must use scoped plugin-sdk subpaths. External plugins may keep compat temporarily while migrating. Migration guide: https://docs.openclaw.ai/plugins/sdk-migration"
});
/** @deprecated Use `openclaw/plugin-sdk/channel-reply-pipeline`. */
const createChannelReplyPipeline = createChannelReplyPipeline$1;
/** @deprecated Use `openclaw/plugin-sdk/channel-reply-pipeline`. */
const createReplyPrefixContext = createReplyPrefixContext$1;
/** @deprecated Use `openclaw/plugin-sdk/channel-reply-pipeline`. */
const createReplyPrefixOptions = createReplyPrefixOptions$1;
/** @deprecated Use `openclaw/plugin-sdk/channel-reply-pipeline`. */
const createTypingCallbacks = createTypingCallbacks$1;
/** @deprecated Use `openclaw/plugin-sdk/channel-reply-pipeline`. */
const resolveChannelSourceReplyDeliveryMode = resolveChannelSourceReplyDeliveryMode$1;
//#endregion
export { AllowFromListSchema, BlockStreamingCoalesceSchema, ContextVisibilityModeSchema, DEFAULT_GROUP_HISTORY_LIMIT, DM_GROUP_ACCESS_REASON, DmConfigSchema, DmPolicySchema, GroupPolicySchema, HISTORY_CONTEXT_MARKER, KeyedAsyncQueue, MarkdownConfigSchema, ReplyRuntimeConfigSchemaShape, ToolPolicySchema, applyAuthProfileConfig, applyDirectoryQueryAndLimit, buildAccountScopedDmSecurityPolicy, buildApiKeyCredential, buildCatchallMultiAccountChannelSchema, buildChannelConfigSchema, buildHistoryContext, buildHistoryContextFromEntries, buildHistoryContextFromMap, buildJsonChannelConfigSchema, buildMemorySystemPromptAddition, buildNestedDmConfigSchema, buildOpenGroupPolicyConfigureRouteAllowlistWarning, buildOpenGroupPolicyRestrictSendersWarning, buildOpenGroupPolicyWarning, buildPendingHistoryContextFromMap, clearHistoryEntries, clearHistoryEntriesIfEnabled, coerceNativeSetting, collectAllowlistProviderGroupPolicyWarnings, collectAllowlistProviderRestrictSendersWarnings, collectBlueBubblesStatusIssues, collectNormalizedDirectoryIds, collectOpenGroupPolicyConfiguredRouteWarnings, collectOpenGroupPolicyRestrictSendersWarnings, collectOpenGroupPolicyRouteAllowlistWarnings, collectOpenProviderGroupPolicyWarnings, composeAccountWarningCollectors, composeWarningCollectors, createAccountStatusSink, createAllowlistProviderGroupPolicyWarningCollector, createAllowlistProviderOpenWarningCollector, createAllowlistProviderRestrictSendersWarningCollector, createAllowlistProviderRouteAllowlistWarningCollector, createChannelDirectoryAdapter, createChannelReplyPipeline, createConditionalWarningCollector, createDangerousNameMatchingMutableAllowlistWarningCollector, createEmptyChannelDirectoryAdapter, createHybridChannelConfigAdapter, createHybridChannelConfigBase, createInspectedDirectoryEntriesLister, createOpenGroupPolicyRestrictSendersWarningCollector, createOpenProviderConfiguredRouteWarningCollector, createOpenProviderGroupPolicyWarningCollector, createPluginRuntimeStore, createReplyPrefixContext, createReplyPrefixOptions, createResolvedDirectoryEntriesLister, createRestrictSendersChannelSecurity, createRuntimeDirectoryLiveAdapter, createScopedAccountConfigAccessors, createScopedChannelConfigAdapter, createScopedChannelConfigBase, createScopedDmSecurityResolver, createTopLevelChannelConfigAdapter, createTopLevelChannelConfigBase, createTypingCallbacks, delegateCompactionToRuntime, emptyChannelDirectoryList, emptyPluginConfigSchema, evaluateGroupRouteAccessForPolicy, evaluateSenderGroupAccessForPolicy, evictOldHistoryKeys, formatAllowFromLowercase, formatNormalizedAllowFromEntries, inspectReadOnlyChannelAccount, listDirectoryEntriesFromSources, listDirectoryGroupEntriesFromMapKeys, listDirectoryGroupEntriesFromMapKeysAndAllowFrom, listDirectoryUserEntriesFromAllowFrom, listDirectoryUserEntriesFromAllowFromAndMapKeys, listInspectedDirectoryEntriesFromSources, listResolvedDirectoryEntriesFromSources, listResolvedDirectoryGroupEntriesFromMapKeys, listResolvedDirectoryUserEntriesFromAllowFrom, mapAllowFromEntries, mapAllowlistResolutionInputs, normalizeAccountId, normalizeAllowFromList, nullChannelDirectorySelf, onDiagnosticEvent, optionalStringEnum, projectAccountConfigWarningCollector, projectAccountWarningCollector, projectConfigAccountIdWarningCollector, projectConfigWarningCollector, projectWarningCollector, readStoreAllowFromForDmPolicy, recordPendingHistoryEntry, recordPendingHistoryEntryIfEnabled, registerContextEngine, requireOpenAllowFrom, resolveBlueBubblesGroupRequireMention, resolveBlueBubblesGroupToolPolicy, resolveChannelGroupPolicy, resolveChannelGroupRequireMention, resolveChannelGroupToolsPolicy, resolveChannelSourceReplyDeliveryMode, resolveControlCommandGate, resolveDmGroupAccessWithCommandGate, resolveDmGroupAccessWithLists, resolveEffectiveAllowFromLists, resolveOpenDmAllowlistAccess, resolvePreferredOpenClawTmpDir, resolveSenderScopedGroupPolicy, resolveToolsBySender, stringEnum, toDirectoryEntries, upsertApiKeyProfile, writeOAuthCredentials };
