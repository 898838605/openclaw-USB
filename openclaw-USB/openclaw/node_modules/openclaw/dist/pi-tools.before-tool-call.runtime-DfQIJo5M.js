import { c as logToolLoopAction } from "./diagnostic-DbrcADVi.js";
import { n as getDiagnosticSessionState } from "./diagnostic-session-state-7K8_m5as.js";
import { n as recordToolCall, r as recordToolCallOutcome, t as detectToolCallLoop } from "./tool-loop-detection-DzUPSHZn.js";
//#region src/agents/pi-tools.before-tool-call.runtime.ts
const beforeToolCallRuntime = {
	getDiagnosticSessionState,
	logToolLoopAction,
	detectToolCallLoop,
	recordToolCall,
	recordToolCallOutcome
};
//#endregion
export { beforeToolCallRuntime };
