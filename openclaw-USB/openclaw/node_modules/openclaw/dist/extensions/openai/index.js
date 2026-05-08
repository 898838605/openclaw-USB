import { a as buildProviderToolCompatFamilyHooks } from "../../provider-tools-Dn1X46Br.js";
import { t as definePluginEntry } from "../../plugin-entry-DUUsLt7Y.js";
import { r as resolvePluginConfigObject } from "../../plugin-config-runtime-B7vWGSXR.js";
import { t as buildOpenAICodexCliBackend } from "../../cli-backend-dq1s5wO6.js";
import { t as buildOpenAIImageGenerationProvider } from "../../image-generation-provider--0LsE-UD.js";
import { n as openaiMediaUnderstandingProvider, t as openaiCodexMediaUnderstandingProvider } from "../../media-understanding-provider-DIiRvRye.js";
import { t as openAiMemoryEmbeddingProviderAdapter } from "../../memory-embedding-adapter-BRmFEkxr.js";
import { t as buildOpenAICodexProviderPlugin } from "../../openai-codex-provider-XmhNDY2Y.js";
import { t as buildOpenAIProvider } from "../../openai-provider-Dz7_Zsc2.js";
import { a as resolveOpenAISystemPromptContribution, i as resolveOpenAIPromptOverlayMode } from "../../prompt-overlay-B88Tecxd.js";
import { t as buildOpenAIRealtimeTranscriptionProvider } from "../../realtime-transcription-provider-P9-tysI0.js";
import { t as buildOpenAIRealtimeVoiceProvider } from "../../realtime-voice-provider-Bs3Q4Qlt.js";
import { t as buildOpenAISpeechProvider } from "../../speech-provider-ByU1ltmT.js";
import { t as buildOpenAIVideoGenerationProvider } from "../../video-generation-provider-CazhQKDI.js";
//#region extensions/openai/index.ts
var openai_default = definePluginEntry({
	id: "openai",
	name: "OpenAI Provider",
	description: "Bundled OpenAI provider plugins",
	register(api) {
		const openAIToolCompatHooks = buildProviderToolCompatFamilyHooks("openai");
		const buildProviderWithPromptContribution = (provider) => ({
			...provider,
			...openAIToolCompatHooks,
			resolveSystemPromptContribution: (ctx) => {
				const pluginConfig = resolvePluginConfigObject(ctx.config, "openai") ?? (ctx.config ? void 0 : api.pluginConfig);
				return resolveOpenAISystemPromptContribution({
					config: ctx.config,
					legacyPluginConfig: pluginConfig,
					mode: resolveOpenAIPromptOverlayMode(pluginConfig),
					modelProviderId: provider.id,
					modelId: ctx.modelId,
					trigger: ctx.trigger
				});
			}
		});
		api.registerCliBackend(buildOpenAICodexCliBackend());
		api.registerProvider(buildProviderWithPromptContribution(buildOpenAIProvider()));
		api.registerProvider(buildProviderWithPromptContribution(buildOpenAICodexProviderPlugin()));
		api.registerMemoryEmbeddingProvider(openAiMemoryEmbeddingProviderAdapter);
		api.registerImageGenerationProvider(buildOpenAIImageGenerationProvider());
		api.registerRealtimeTranscriptionProvider(buildOpenAIRealtimeTranscriptionProvider());
		api.registerRealtimeVoiceProvider(buildOpenAIRealtimeVoiceProvider());
		api.registerSpeechProvider(buildOpenAISpeechProvider());
		api.registerMediaUnderstandingProvider(openaiMediaUnderstandingProvider);
		api.registerMediaUnderstandingProvider(openaiCodexMediaUnderstandingProvider);
		api.registerVideoGenerationProvider(buildOpenAIVideoGenerationProvider());
	}
});
//#endregion
export { openai_default as default };
