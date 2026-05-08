import { d as resolveStorePath } from "./paths-DG09LE-n.js";
import { a as updateLastRoute, n as readSessionUpdatedAt, r as recordSessionMetaFromInbound } from "./store-DvxAjGkI.js";
import "./sessions-DEgkNCWw.js";
import { a as createReplyDispatcherWithTyping, c as withReplyDispatcher, o as dispatchReplyFromConfig, s as settleReplyDispatcher } from "./dispatch-8E8vi2HV.js";
import { l as saveMediaBuffer } from "./store-LePoapNA.js";
import { r as fetchRemoteMedia } from "./fetch-DFxHf7Qx.js";
import { n as resolveChannelGroupRequireMention, t as resolveChannelGroupPolicy } from "./group-policy-lsreEzCY.js";
import { a as chunkText, c as resolveTextChunkLimit, i as chunkMarkdownTextWithMode, o as chunkTextWithMode, r as chunkMarkdownText, s as resolveChunkMode, t as chunkByNewline } from "./chunk-BbwYgLMX.js";
import { t as loadChannelOutboundAdapter } from "./load-VgIJvjV1.js";
import { i as resolveAgentRoute, t as buildAgentSessionKey } from "./resolve-route-BNuWCNW8.js";
import { i as resolveHumanDelayConfig, r as resolveEffectiveMessagesConfig } from "./identity-Cg93gos2.js";
import { n as shouldHandleTextCommands } from "./commands-text-routing-BSsv-TYL.js";
import "./commands-registry-cUCFmu0M.js";
import { i as matchesMentionWithExplicit, n as buildMentionRegexes, r as matchesMentionPatterns } from "./mentions-C-BcpmMD.js";
import { t as finalizeInboundContext } from "./inbound-context-CGEt-zdB.js";
import { t as dispatchReplyWithBufferedBlockDispatcher } from "./provider-dispatcher-DCbApMuG.js";
import { t as convertMarkdownTables } from "./tables-D6uEYc48.js";
import { i as shouldComputeCommandAuthorized, r as isControlCommandMessage, t as hasControlCommand } from "./command-detection-vz15pP6e.js";
import { a as resolveEnvelopeFormatOptions, r as formatInboundEnvelope, t as formatAgentEnvelope } from "./envelope-DBMBeEVg.js";
import { n as resolveInboundDebounceMs, t as createInboundDebouncer } from "./inbound-debounce-DW1WQGAi.js";
import { i as shouldAckReaction, n as removeAckReactionAfterReply, r as removeAckReactionHandleAfterReply, t as createAckReactionHandle } from "./ack-reactions-hnjiGJrg.js";
import { t as resolveCommandAuthorizedFromAuthorizers } from "./command-gating-C19Zl5i4.js";
import { n as resolveInboundMentionDecision, t as implicitMentionKindWhen } from "./mention-gating-DRT0ANJG.js";
import { n as setChannelConversationBindingMaxAgeBySessionKey, t as setChannelConversationBindingIdleTimeoutBySessionKey } from "./conversation-bindings-BeHdfuLy.js";
import { t as recordInboundSession } from "./session-DJhdI8Qg.js";
import { a as buildChannelTurnContext, i as runResolvedChannelTurn, n as runChannelTurn, r as runPreparedChannelTurn, t as dispatchAssembledChannelTurn } from "./kernel-CZIS5l1m.js";
import { t as resolveMarkdownTableMode } from "./markdown-tables-CtsSO9pl.js";
import { n as recordChannelActivity, t as getChannelActivity } from "./channel-activity-BdX2_9eU.js";
import { t as buildPairingReply } from "./pairing-messages-os97WTVG.js";
import { a as readChannelAllowFromStore, d as upsertChannelPairingRequest } from "./pairing-store-C3tDe-Lw.js";
import { t as createChannelRuntimeContextRegistry } from "./channel-runtime-contexts-DYAmiSzk.js";
//#region src/plugins/runtime/runtime-channel.ts
function createRuntimeChannel() {
	return {
		text: {
			chunkByNewline,
			chunkMarkdownText,
			chunkMarkdownTextWithMode,
			chunkText,
			chunkTextWithMode,
			resolveChunkMode,
			resolveTextChunkLimit,
			hasControlCommand,
			resolveMarkdownTableMode,
			convertMarkdownTables
		},
		reply: {
			dispatchReplyWithBufferedBlockDispatcher,
			createReplyDispatcherWithTyping,
			resolveEffectiveMessagesConfig,
			resolveHumanDelayConfig,
			dispatchReplyFromConfig,
			withReplyDispatcher,
			settleReplyDispatcher,
			finalizeInboundContext,
			formatAgentEnvelope,
			/** @deprecated Prefer `BodyForAgent` + structured user-context blocks (do not build plaintext envelopes for prompts). */
			formatInboundEnvelope,
			resolveEnvelopeFormatOptions
		},
		routing: {
			buildAgentSessionKey,
			resolveAgentRoute
		},
		pairing: {
			buildPairingReply,
			readAllowFromStore: ({ channel, accountId, env }) => readChannelAllowFromStore(channel, env, accountId),
			upsertPairingRequest: ({ channel, id, accountId, meta, env, pairingAdapter }) => upsertChannelPairingRequest({
				channel,
				id,
				accountId,
				meta,
				env,
				pairingAdapter
			})
		},
		media: {
			fetchRemoteMedia,
			saveMediaBuffer
		},
		activity: {
			record: recordChannelActivity,
			get: getChannelActivity
		},
		session: {
			resolveStorePath,
			readSessionUpdatedAt,
			recordSessionMetaFromInbound,
			recordInboundSession,
			updateLastRoute
		},
		mentions: {
			buildMentionRegexes,
			matchesMentionPatterns,
			matchesMentionWithExplicit,
			implicitMentionKindWhen,
			resolveInboundMentionDecision
		},
		reactions: {
			createAckReactionHandle,
			shouldAckReaction,
			removeAckReactionAfterReply,
			removeAckReactionHandleAfterReply
		},
		groups: {
			resolveGroupPolicy: resolveChannelGroupPolicy,
			resolveRequireMention: resolveChannelGroupRequireMention
		},
		debounce: {
			createInboundDebouncer,
			resolveInboundDebounceMs
		},
		commands: {
			resolveCommandAuthorizedFromAuthorizers,
			isControlCommandMessage,
			shouldComputeCommandAuthorized,
			shouldHandleTextCommands
		},
		outbound: { loadAdapter: loadChannelOutboundAdapter },
		turn: {
			run: runChannelTurn,
			runResolved: runResolvedChannelTurn,
			buildContext: buildChannelTurnContext,
			runPrepared: runPreparedChannelTurn,
			dispatchAssembled: dispatchAssembledChannelTurn
		},
		threadBindings: {
			setIdleTimeoutBySessionKey: ({ channelId, targetSessionKey, accountId, idleTimeoutMs }) => setChannelConversationBindingIdleTimeoutBySessionKey({
				channelId,
				targetSessionKey,
				accountId,
				idleTimeoutMs
			}),
			setMaxAgeBySessionKey: ({ channelId, targetSessionKey, accountId, maxAgeMs }) => setChannelConversationBindingMaxAgeBySessionKey({
				channelId,
				targetSessionKey,
				accountId,
				maxAgeMs
			})
		},
		runtimeContexts: createChannelRuntimeContextRegistry()
	};
}
//#endregion
export { createRuntimeChannel as t };
