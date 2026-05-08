import { t as formatDocsLink } from "./links-dQIIPEtq.js";
import { r as theme } from "./theme-CVJvORNs.js";
import { t as addGatewayServiceCommands } from "./register-service-commands-D2owExYy.js";
import "./install-CXhYILAB.js";
import "./lifecycle-BOeDLV2k.js";
import "./status-DpHQPGcm.js";
//#region src/cli/daemon-cli/register.ts
function registerDaemonCli(program) {
	addGatewayServiceCommands(program.command("daemon").description("Manage the Gateway service (launchd/systemd/schtasks)").addHelpText("after", () => `\n${theme.muted("Docs:")} ${formatDocsLink("/cli/gateway", "docs.openclaw.ai/cli/gateway")}\n`), { statusDescription: "Show service install status + probe connectivity/capability" });
}
//#endregion
export { registerDaemonCli as t };
