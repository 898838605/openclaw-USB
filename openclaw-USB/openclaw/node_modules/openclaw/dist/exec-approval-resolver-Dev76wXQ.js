import { t as isApprovalNotFoundError } from "./approval-errors-Dq9h789-.js";
import "./error-runtime-CsFsTc-x.js";
import { t as resolveApprovalOverGateway } from "./approval-gateway-runtime-Bkfr_ZaF.js";
//#region extensions/matrix/src/exec-approval-resolver.ts
async function resolveMatrixApproval(params) {
	await resolveApprovalOverGateway({
		cfg: params.cfg,
		approvalId: params.approvalId,
		decision: params.decision,
		senderId: params.senderId,
		gatewayUrl: params.gatewayUrl,
		clientDisplayName: `Matrix approval (${params.senderId?.trim() || "unknown"})`
	});
}
//#endregion
export { isApprovalNotFoundError, resolveMatrixApproval };
