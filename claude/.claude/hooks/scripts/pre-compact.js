const fs = require("fs");
const path = require("path");
const os = require("os");

const contextFile = path.join(os.homedir(), ".claude", "session-context.json");
const compactLog = path.join(os.homedir(), ".claude", "compact-log.json");
const cwd = process.cwd();

// Load existing session context
let context = {};
if (fs.existsSync(contextFile)) {
  try {
    context = JSON.parse(fs.readFileSync(contextFile, "utf8"));
  } catch (e) {}
}

const sessionData = context[cwd] || {};
const snapshot = {
  timestamp: new Date().toISOString(),
  project: cwd,
  packageManager: sessionData.packageManager || "unknown",
  editCount: sessionData.editCount || 0,
  notes: sessionData.notes || "",
};
// --- Memory snapshot: capture recent-memory state before compaction ---
// Find project memory directories and snapshot recent-memory.md
const claudeProjects = path.join(os.homedir(), ".claude", "projects");
if (fs.existsSync(claudeProjects)) {
  try {
    const dirs = fs.readdirSync(claudeProjects);
    for (const dir of dirs) {
      const memDir = path.join(claudeProjects, dir, "memory");
      const recentMem = path.join(memDir, "recent-memory.md");
      if (fs.existsSync(recentMem)) {
        // Read current recent-memory
        const content = fs.readFileSync(recentMem, "utf8");
        // Write a pre-compact snapshot with timestamp
        const snapshotDir = path.join(memDir, ".snapshots");
        fs.mkdirSync(snapshotDir, { recursive: true });
        const ts = new Date().toISOString().replace(/[:.]/g, "-");
        const snapFile = path.join(snapshotDir, `pre-compact-${ts}.md`);
        fs.writeFileSync(snapFile, `<!-- Pre-compact snapshot: ${snapshot.timestamp} -->\n<!-- Project: ${cwd} -->\n<!-- Edit count: ${snapshot.editCount} -->\n${content}`);
        // Keep only last 10 snapshots
        const snaps = fs.readdirSync(snapshotDir).filter(f => f.startsWith("pre-compact-")).sort();
        while (snaps.length > 10) {
          fs.unlinkSync(path.join(snapshotDir, snaps.shift()));
        }
        snapshot.memorySnapshot = snapFile;
        break;
      }
    }
  } catch (e) {}
}
// --- Log the compact event ---
let logs = [];
if (fs.existsSync(compactLog)) {
  try {
    logs = JSON.parse(fs.readFileSync(compactLog, "utf8"));
  } catch (e) {
    logs = [];
  }
}

logs.push(snapshot);
if (logs.length > 50) logs = logs.slice(-50);

fs.mkdirSync(path.dirname(compactLog), { recursive: true });
fs.writeFileSync(compactLog, JSON.stringify(logs, null, 2));

console.log(JSON.stringify({ contextSaved: true, editCount: snapshot.editCount, memorySnapshot: !!snapshot.memorySnapshot }));