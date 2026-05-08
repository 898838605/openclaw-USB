import { n as resolvePreferredOpenClawTmpDir } from "./tmp-openclaw-dir-BT06rvao.js";
import "./temp-path-y0jrf-U9.js";
import { t as movePathToTrash$1 } from "./browser-trash-C_LPVXeM.js";
import "./browser-config-Bbo6q35Y.js";
import os from "node:os";
//#region extensions/browser/src/browser/trash.ts
async function movePathToTrash(targetPath) {
	return await movePathToTrash$1(targetPath, { allowedRoots: [os.homedir(), resolvePreferredOpenClawTmpDir()] });
}
//#endregion
export { movePathToTrash as t };
