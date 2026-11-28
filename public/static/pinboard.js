const core = await import("./pinboard-core.js" + new URL(import.meta.url).search);

const STORAGE_KEY = "pinboard:v1";
const RESULT = "article.result[data-tag]";
const SKIP = "button, .pin-btn, .knowl-box, .part-picker, .qed";
const PIN = '<svg viewBox="0 0 24 24" width="1em" height="1em" fill="currentColor" aria-hidden="true"><path d="M16 3H8v2l1 1v5l-3 3v2h5v5l1 1 1-1v-5h5v-2l-3-3V6l1-1z"/></svg>';

const main = document.querySelector("main");
const buttonKeys = new WeakMap();

function resultContent(article) {
  return article.querySelector(":scope > .draft-result") ?? article;
}

function texOf(node) {
  return node.querySelector('annotation[encoding="application/x-tex"]')?.textContent.trim() ?? "";
}

function formatMath(tex, display = false) {
  const hasDollar = tex.includes("$");
  if (display) return hasDollar ? "\\[\n" + tex + "\n\\]" : "$$\n" + tex + "\n$$";
  return hasDollar ? "\\(" + tex + "\\)" : "$" + tex + "$";
}

function figureText(img) {
  return "[Figure: " + img.alt + "](" + img.src + ")";
}

function toMarkdown(node) {
  const block = (text) => "\n\n" + text.trim() + "\n\n";
  const children = (el, skip = null) => [...el.childNodes].reduce((text, child) => {
    if (child === skip) return text;
    const part = convert(child);
    return text + (child.nodeType === Node.TEXT_NODE && text.endsWith("\n") ? part.trimStart() : part);
  }, "");
  const listItem = (marker, text) => marker + text.replace(/\n(?=[^\n])/g, "\n" + " ".repeat(marker.length));

  function convert(el) {
    if (el.nodeType === Node.TEXT_NODE) return el.textContent.replace(/\s+/g, " ");
    if (el.nodeType !== Node.ELEMENT_NODE || el.matches(SKIP) || el.matches(".draft-block > summary")) return "";
    if (el.matches(".katex-display")) return block(formatMath(texOf(el), true));
    if (el.matches(".katex")) return formatMath(texOf(el));
    if (el.matches(".math-error.display")) return block(formatMath(el.textContent.trim(), true));
    if (el.matches(".math-error")) return formatMath(el.textContent.trim());

    switch (el.tagName) {
      case "IMG": return figureText(el);
      case "BR": return "\n";
      case "EM": case "I": return "*" + children(el) + "*";
      case "STRONG": case "B": return "**" + children(el) + "**";
      case "UL": case "OL":
        return block([...el.querySelectorAll(":scope > li")].map((li, i) => {
          const labeled = li.matches(".labeled");
          const marker = el.tagName === "OL" && !labeled ? (i + 1) + ". " : "- ";
          const label = labeled ? li.querySelector(":scope > .item-label") : null;
          const labelText = label ? convert(label).trim() + " " : "";
          const content = children(li, label).trim();
          const startsWithBlock = /^(?:\$\$\n|\\\[\n|- |\d+\. )/.test(content);
          return listItem(marker, labelText + (startsWithBlock ? "\n\n" : "") + content);
        }).join("\n"));
      case "DL":
        return block([...el.querySelectorAll(":scope > dt")].map((dt) => {
          const dd = dt.nextElementSibling;
          return listItem("- ", children(dt).trim() + ": " + (dd?.matches("dd") ? children(dd).trim() : ""));
        }).join("\n"));
      default:
        return el.matches("p, div, blockquote, figure, figcaption, section, article, pre, h1, h2, h3, h4, h5, h6")
          ? block(children(el))
          : children(el);
    }
  }

  return node ? convert(node).split("\n").map((line) => line.trimEnd()).join("\n").replace(/\n{3,}/g, "\n\n").trim() : "";
}

function cleanClone(el) {
  const clone = el.cloneNode(true);
  clone.querySelectorAll(SKIP).forEach((node) => node.remove());
  clone.querySelectorAll(".proof-part, div.pin-host").forEach((node) => node.replaceWith(...node.childNodes));
  for (const node of [clone, ...clone.querySelectorAll("[hidden], [id], .pin-host, .knowl-open, .part-link")]) {
    node.removeAttribute("hidden");
    node.removeAttribute("id");
    node.classList.remove("pin-host");
    if (node.classList.contains("knowl-open")) {
      node.classList.remove("knowl-open");
      node.setAttribute("aria-expanded", "false");
    }
    if (node.classList.contains("part-link")) {
      node.classList.remove("part-link");
      for (const attr of ["role", "tabindex", "title"]) node.removeAttribute(attr);
    }
  }
  return clone;
}

function resultSnapshot(clone) {
  clone = resultContent(clone);
  const head = clone.querySelector(":scope > .result-head");
  head.querySelectorAll("a").forEach((a) => a.replaceWith(...a.childNodes));
  const headings = [...head.querySelectorAll(".result-label, .result-title")];
  const statement = clone.querySelector(":scope > .statement");
  const html = [statement?.innerHTML ?? ""];
  const text = [toMarkdown(statement)];

  for (const proof of clone.querySelectorAll(":scope > details.proof[open], :scope > section.proof")) {
    const body = proof.querySelector(":scope > .proof-body");
    if (!body) continue;
    const label = proof.querySelector(".proof-label")?.textContent.trim().replace(/\.$/, "") ?? "Proof";
    const details = document.createElement("details");
    details.className = "pin-proof";
    const summary = document.createElement("summary");
    summary.textContent = label;
    text.push(("*" + label + ".*\n\n" + toMarkdown(body)).trimEnd());
    details.append(summary, ...body.childNodes);
    html.push(details.outerHTML);
  }

  return {
    labelHtml: headings.map((node) => node.innerHTML.trim()).filter(Boolean).join(" "),
    label: headings.map(toMarkdown).filter(Boolean).join(" "),
    html: html.join(""),
    text: text.filter(Boolean).join("\n\n"),
  };
}

function snapshot(el, kind, result, tag, key) {
  const item = { key, kind, tag, href: tag ? "/tag/" + tag : location.pathname };
  const clone = cleanClone(el);
  if (kind === "result") return { ...item, ...resultSnapshot(clone) };

  const prefix = (kind === "formula" ? "Formula" : "Figure") +
    (result && el.closest(".proof") ? " in the proof of " : " in ");
  const title = result
    ? resultContent(result).querySelector(":scope > .result-head .result-label")
    : main.querySelector("h1");
  const heading = title && cleanClone(title);
  heading?.querySelectorAll(".tag-link").forEach((link) => link.remove());
  heading?.querySelectorAll("a").forEach((a) => a.replaceWith(...a.childNodes));
  return {
    ...item,
    labelHtml: prefix + (heading?.innerHTML.trim() || "this page"),
    label: prefix + (toMarkdown(heading) || "this page"),
    html: clone.outerHTML,
    text: kind === "formula" ? formatMath(texOf(clone), true) : figureText(clone.querySelector("img")),
  };
}

function addPin(el, kind) {
  const result = el.closest(RESULT);
  const tag = result?.dataset.tag ?? null;
  const head = kind === "result" ? resultContent(el).querySelector(":scope > .result-head") : null;
  const img = kind === "figure" ? el.querySelector("img[src]") : null;
  if ((kind === "result" && !head) || (kind === "figure" && !img)) return;

  const key = kind === "result" ? "r:" + tag : kind === "figure" ? "g:" + img.getAttribute("src")
    : "f:" + (tag ?? location.pathname) + ":" + texOf(el);

  let host = head ?? el;
  const tagLink = head?.querySelector(":scope > .tag-link");
  if (tagLink) {
    host = document.createElement("span");
    host.className = "pin-tagwrap";
    tagLink.before(host);
    host.append(tagLink);
  }
  if (kind === "formula") {
    host = document.createElement("div");
    el.before(host);
    host.append(el);
  }
  if (kind !== "result") host.classList.add("pin-host");
  el.dataset.pinDone = "1";

  const button = document.createElement("button");
  button.type = "button";
  button.className = "pin-btn";
  button.innerHTML = PIN;
  buttonKeys.set(button, key);
  syncButton(button, state.items.some((item) => item.key === key));
  button.addEventListener("click", () => update((current) => {
    if (current.items.some((item) => item.key === key)) {
      return { ...current, items: current.items.filter((item) => item.key !== key) };
    }
    return { ...current, items: [...current.items, snapshot(el, kind, result, tag, key)], open: true };
  }));
  host.append(button);
}

function syncButton(button, pinned) {
  button.setAttribute("aria-pressed", String(pinned));
  button.title = pinned ? "Unpin" : "Pin";
  button.setAttribute("aria-label", button.title);
}

function scan() {
  main.querySelectorAll(RESULT + ":not([data-pin-done])").forEach((el) => addPin(el, "result"));
  main.querySelectorAll(".math-display:not([data-pin-done])").forEach((el) => {
    if (el.querySelector(".katex-display")) addPin(el, "formula");
  });
  main.querySelectorAll("figure.tex-figure:not([data-pin-done])").forEach((el) => addPin(el, "figure"));
}

const board = document.createElement("aside");
board.className = "pinboard";
board.setAttribute("aria-label", "Pinboard");
board.innerHTML = `
  <header class="pinboard-head"><strong></strong><button type="button">Hide</button></header>
  <div class="pin-cards"></div>
  <footer class="pinboard-footer">
    <textarea rows="2" placeholder="Where I'm stuck…" aria-label="Where I'm stuck"></textarea>
    <div class="pin-actions"><button type="button" class="pin-copy">Copy for AI</button><button type="button" class="pin-clear">Clear</button></div>
    <div class="pin-fallback" hidden>
      <label>Press Ctrl+C to copy.<textarea rows="2" readonly></textarea></label>
    </div>
  </footer>`;
const tab = document.createElement("button");
tab.type = "button";
tab.className = "pin-tab";
tab.innerHTML = PIN + "<span></span>";
board.hidden = tab.hidden = true;
document.body.append(board, tab);

const heading = board.querySelector(".pinboard-head strong");
const hide = board.querySelector(".pinboard-head button");
const cards = board.querySelector(".pin-cards");
const cardEntries = new Map();
const question = board.querySelector("textarea");
const copy = board.querySelector(".pin-copy");
const clear = board.querySelector(".pin-clear");
const fallback = board.querySelector(".pin-fallback");
const fallbackText = fallback.querySelector("textarea");
const tabCount = tab.querySelector("span");

let state;
let lastSaved;

function validState(value) {
  return value && typeof value.open === "boolean" && typeof value.question === "string" &&
    Array.isArray(value.items) && value.items.every((item) => item &&
      ["result", "formula", "figure"].includes(item.kind) &&
      (item.tag === null || typeof item.tag === "string") &&
      ["key", "labelHtml", "label", "href", "html", "text"].every((field) => typeof item[field] === "string"));
}

function refresh() {
  let raw = null;
  let next;
  try {
    raw = localStorage.getItem(STORAGE_KEY);
    if (state && raw === lastSaved) return;
    next = JSON.parse(raw);
  } catch {
    // A storage error or malformed value is an empty board.
  }
  lastSaved = raw;
  render(validState(next) ? next : { open: false, question: "", items: [] });
}

function update(change) {
  refresh();
  const next = change(state);
  const raw = JSON.stringify(next);
  try {
    localStorage.setItem(STORAGE_KEY, raw);
  } catch (err) {
    alert(err.name === "QuotaExceededError" ? "The pinboard is full. Remove some pins first." : "The pinboard could not be saved.");
    render(state);
    return;
  }
  lastSaved = raw;
  render(next);
}

function cardFor(item) {
  const card = document.createElement("article");
  card.className = "pin-card";
  card.innerHTML = '<header class="pin-card-head"><a></a><button type="button" aria-label="Remove pin">×</button></header><div class="pin-card-body"></div>';
  card.querySelector(".pin-card-body").innerHTML = item.html;
  card.querySelector("button").addEventListener("click", () => update((current) =>
    ({ ...current, items: current.items.filter((pin) => pin.key !== item.key) })));
  const link = card.querySelector("a");
  link.href = item.href;
  link.innerHTML = item.labelHtml;
  link.addEventListener("click", (event) => {
    if (event.button !== 0 || event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
    const tag = cardEntries.get(item.key)?.item.tag;
    const target = tag && document.getElementById(tag);
    if (!target?.getClientRects().length) return;
    event.preventDefault();
    const draft = target.querySelector(":scope > .draft-result");
    if (draft) draft.open = true;
    target.scrollIntoView({ behavior: "smooth", block: "start" });
    target.classList.remove("knowl-flash");
    void target.offsetWidth;
    target.classList.add("knowl-flash");
  });
  return card;
}

function reconcileCards(items, keys) {
  let changed = false;
  for (const [key, { card }] of cardEntries) {
    if (keys.has(key)) continue;
    card.remove();
    cardEntries.delete(key);
    changed = true;
  }

  let previous = null;
  for (const item of items) {
    const entry = cardEntries.get(item.key);
    let card = entry?.card;
    if (!entry || item.html !== entry.item.html || item.labelHtml !== entry.item.labelHtml) {
      const replacement = cardFor(item);
      card?.replaceWith(replacement);
      card = replacement;
      changed = true;
    } else if (item.href !== entry.item.href) {
      card.querySelector(".pin-card-head > a").href = item.href;
    }
    const next = previous ? previous.nextElementSibling : cards.firstElementChild;
    if (card !== next) {
      cards.insertBefore(card, next);
      changed = true;
    }
    cardEntries.set(item.key, { item, card });
    previous = card;
  }
  return changed;
}

function resizeQuestion() {
  if (board.hidden) return;
  question.style.height = "auto";
  question.style.height = question.scrollHeight + question.offsetHeight - question.clientHeight + "px";
}

function resizeFormulas() {
  if (board.hidden) return;
  const displays = [...cards.querySelectorAll(".katex-display")];
  for (const display of displays) display.style.fontSize = "";
  const scales = displays.map(({ scrollWidth, clientWidth }) =>
    // 2% slack so sub-pixel rounding does not leave a 1px scrollbar
    clientWidth && scrollWidth > clientWidth ? Math.max(0.6, 0.98 * clientWidth / scrollWidth) : 1);
  displays.forEach((display, i) => {
    if (scales[i] < 1) display.style.fontSize = scales[i] * 100 + "%";
  });
}

function render(next) {
  const wasHidden = board.hidden;
  let cardsChanged = false;
  if (state?.items !== next.items) {
    const keys = new Set(next.items.map((item) => item.key));
    main.querySelectorAll(".pin-btn").forEach((button) => syncButton(button, keys.has(buttonKeys.get(button))));
    cardsChanged = reconcileCards(next.items, keys);
    if (cardsChanged) fallback.hidden = true;
  }
  state = next;
  const count = state.items.length;
  board.hidden = !count || !state.open;
  tab.hidden = !count || state.open;
  document.body.classList.toggle("pinboard-open", !board.hidden);
  heading.textContent = "Pinned (" + count + ")";
  tabCount.textContent = count;
  tab.setAttribute("aria-label", "Show pinboard (" + count + ")");
  if (question.value !== state.question) question.value = state.question;
  resizeQuestion();
  if (cardsChanged || wasHidden) resizeFormulas();
}

let copiedTimer;
copy.addEventListener("click", async () => {
  clearTimeout(copiedTimer);
  copy.disabled = true;
  copy.textContent = "Copy for AI";
  fallback.hidden = true;
  const { items, question } = state;
  let macros = "";
  try {
    const response = await fetch("/api/macros");
    if (response.ok) macros = await response.text();
  } catch {
    // Copy the pins even when the macros are unavailable.
  }
  const prompt = core.buildPrompt({
    bookTitle: document.querySelector(".site-title").textContent.trim(),
    items: items.map(({ label, href, text }) => ({ label, url: location.origin + href, text })),
    question,
    macroDefs: core.splitMacroDefs(macros),
  });
  try {
    await navigator.clipboard.writeText(prompt);
    copy.textContent = "Copied ✓";
    copiedTimer = setTimeout(() => { copy.textContent = "Copy for AI"; }, 1500);
  } catch {
    fallback.hidden = false;
    fallbackText.value = prompt;
    fallbackText.focus();
    fallbackText.select();
  } finally {
    copy.disabled = false;
  }
});

hide.addEventListener("click", () => {
  update((current) => ({ ...current, open: false }));
  if (!tab.hidden) tab.focus();
});
tab.addEventListener("click", () => {
  update((current) => ({ ...current, open: true }));
  if (!board.hidden) hide.focus();
});
clear.addEventListener("click", () => {
  if (confirm("Remove all pins?")) update((current) => ({ ...current, items: [] }));
});
question.addEventListener("input", () => {
  const value = question.value;
  update((current) => ({ ...current, question: value }));
});
cards.addEventListener("toggle", resizeFormulas, true);
new MutationObserver((records) => {
  if (records.some(({ target }) => target !== cards)) resizeFormulas();
}).observe(cards, { childList: true, subtree: true });
document.fonts?.ready.then(resizeFormulas);
window.addEventListener("resize", () => {
  resizeQuestion();
  resizeFormulas();
});
window.addEventListener("storage", (event) => {
  if (event.key === STORAGE_KEY || event.key === null) refresh();
});

refresh();
scan();
let queued = false;
new MutationObserver(() => {
  if (queued) return;
  queued = true;
  requestAnimationFrame(() => {
    queued = false;
    scan();
  });
}).observe(main, { childList: true, subtree: true });
