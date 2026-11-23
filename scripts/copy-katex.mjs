// Copy KaTeX's stylesheet and fonts from node_modules into public/katex (served as static files).
import { cpSync, mkdirSync, rmSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const src = join(root, "node_modules", "katex", "dist");
const dest = join(root, "public", "katex");
rmSync(dest, { recursive: true, force: true });
mkdirSync(dest, { recursive: true });
cpSync(join(src, "katex.min.css"), join(dest, "katex.min.css"));
cpSync(join(src, "fonts"), join(dest, "fonts"), { recursive: true });
console.log("KaTeX assets copied to public/katex");
