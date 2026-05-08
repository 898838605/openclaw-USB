import { n as buildSubagentsHelp, u as stopWithText } from "./shared-Bkh9HdS5.js";
//#region src/auto-reply/reply/commands-subagents/action-help.ts
function handleSubagentsHelpAction() {
	return stopWithText(buildSubagentsHelp());
}
//#endregion
export { handleSubagentsHelpAction };
