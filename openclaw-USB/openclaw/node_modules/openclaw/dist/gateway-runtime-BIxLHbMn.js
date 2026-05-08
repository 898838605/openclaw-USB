import "./net-DdbfRcEU.js";
import "./auth-Cuq36U9C.js";
import "./client-DZ1aRkVL.js";
import "./protocol-MvVoNN0Z.js";
import "./operator-approvals-client-DL5z4qmE.js";
import "./gateway-rpc-DA7yLrkf.js";
import "./node-command-policy-BBL6v-iE.js";
import "./nodes.helpers-CzaiEDDD.js";
import "./startup-auth-BTdz7sXq.js";
//#region src/gateway/channel-status-patches.ts
function createConnectedChannelStatusPatch(at = Date.now()) {
	return {
		connected: true,
		lastConnectedAt: at,
		lastEventAt: at
	};
}
function createTransportActivityStatusPatch(at = Date.now()) {
	return { lastTransportActivityAt: at };
}
//#endregion
export { createTransportActivityStatusPatch as n, createConnectedChannelStatusPatch as t };
