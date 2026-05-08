import { r as describeImagesWithModel, t as describeImageWithModel } from "./image-runtime-Dp3baQw5.js";
import "./media-understanding-D-m_ASUa.js";
//#region extensions/openrouter/media-understanding-provider.ts
const openrouterMediaUnderstandingProvider = {
	id: "openrouter",
	capabilities: ["image"],
	defaultModels: { image: "auto" },
	describeImage: describeImageWithModel,
	describeImages: describeImagesWithModel
};
//#endregion
export { openrouterMediaUnderstandingProvider as t };
