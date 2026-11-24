import { html, raw, type SafeHtml } from "../html.ts";

export interface LayoutOpts {
  title: string;
  bookTitle: string;
  body: SafeHtml;
  editor?: boolean; // load editor assets
  description?: string;
}

const ASSET_VERSION = "4"; // bump when public/static files change, so browsers fetch the new ones

export function layout(o: LayoutOpts): string {
  return "<!doctype html>\n" + html`<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${o.title.replace(/\$/g, "")}</title>
${o.description ? html`<meta name="description" content="${o.description}">` : ""}
<link rel="stylesheet" href="/katex/katex.min.css">
<link rel="stylesheet" href="/static/style.css?v=${ASSET_VERSION}">
${o.editor ? html`<link rel="stylesheet" href="/static/editor.css?v=${ASSET_VERSION}">` : ""}
<script src="/static/knowl.js?v=${ASSET_VERSION}" defer></script>
<script src="/static/proofparts.js?v=${ASSET_VERSION}" defer></script>
${o.editor ? html`<script src="/static/editor.js?v=${ASSET_VERSION}" defer></script>` : ""}
</head>
<body class="${o.editor ? "editor-mode" : ""}">
<header class="site-header">
  <a class="site-title" href="/">${o.bookTitle}</a>
  <nav>${o.editor ? html`<a href="/edit">Editor home</a> <a href="/">Public site</a>` : html`<a href="/">Contents</a> <a href="/bibliography">Bibliography</a>`}</nav>
</header>
<main class="${o.editor ? "wide" : ""}">
${o.body}
</main>
<footer class="site-footer">
  ${o.editor ? "" : raw(`<a href="/edit">Editor login</a>`)}
</footer>
</body>
</html>`.value;
}
