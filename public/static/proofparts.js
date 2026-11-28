// Proof parts: a proof whose paragraphs start with an emphasized label such as "(i)", "(ii)", ... (written as
// \emph{(i)} at the start of a paragraph) gets a picker "All · (i) · (ii) · ..." that shows one part and hides the
// others. Clicking "(ii)" in the statement's list jumps to that part of the proof. Works inside knowls too.
(() => {
  "use strict";
  const LABEL_RE = /^\((?:[ivxlc]+|[a-z]|\d+)\)$/;

  /** The part label if `el` is a paragraph starting with <em>(label)</em>, else null. */
  function partLabel(el) {
    if (el.tagName !== "P") return null;
    let first = el.firstChild;
    while (first && first.nodeType === Node.TEXT_NODE && !first.textContent.trim()) first = first.nextSibling;
    if (!first || first.nodeType !== Node.ELEMENT_NODE || first.tagName !== "EM") return null;
    const t = first.textContent.trim();
    return LABEL_RE.test(t) ? t : null;
  }

  function show(body, label) {
    body.querySelectorAll(":scope > .proof-part").forEach((p) => {
      p.hidden = label !== null && p.dataset.part !== label;
    });
    body.querySelectorAll(":scope > .part-picker button").forEach((b) => {
      const on = (b.dataset.part || null) === label;
      b.setAttribute("aria-pressed", on ? "true" : "false");
    });
  }

  function enhance(body) {
    if (body.dataset.partsDone) return;
    body.dataset.partsDone = "1";
    const kids = [...body.children];
    const marks = kids.map(partLabel);
    const labels = marks.filter(Boolean);
    if (labels.length < 2 || new Set(labels).size !== labels.length) return;

    let group = null;
    for (let i = 0; i < kids.length; i++) {
      const el = kids[i];
      if (el.classList.contains("qed")) continue;
      if (marks[i]) {
        group = document.createElement("div");
        group.className = "proof-part";
        group.dataset.part = marks[i];
        el.before(group);
      }
      if (group) group.appendChild(el);
    }

    const picker = document.createElement("div");
    picker.className = "part-picker";
    picker.setAttribute("role", "group");
    picker.setAttribute("aria-label", "Show part of the proof");
    const mk = (text, part) => {
      const b = document.createElement("button");
      b.type = "button";
      b.textContent = text;
      if (part) b.dataset.part = part;
      b.addEventListener("click", () => show(body, part || null));
      picker.appendChild(b);
    };
    mk("All", null);
    labels.forEach((l) => mk(l, l));
    body.prepend(picker);
    show(body, null);

    // Statement labels (i), (ii), ... jump to the matching part.
    const result = body.parentElement.parentElement;
    if (!result?.matches("article.result, .draft-result")) return;
    result.querySelectorAll(":scope > .statement li.labeled > .item-label").forEach((lab) => {
      const l = lab.textContent.trim();
      if (!labels.includes(l) || lab.dataset.partLink) return;
      lab.dataset.partLink = "1";
      lab.classList.add("part-link");
      lab.setAttribute("role", "button");
      lab.setAttribute("tabindex", "0");
      lab.title = "Show the proof of " + l;
      const go = () => {
        const details = body.closest("details");
        if (details) details.open = true;
        show(body, l);
        body.scrollIntoView({ behavior: "smooth", block: "nearest" });
      };
      lab.addEventListener("click", go);
      lab.addEventListener("keydown", (e) => {
        if (e.key === "Enter" || e.key === " ") {
          e.preventDefault();
          go();
        }
      });
    });
  }

  const scan = () => document.querySelectorAll(".proof-body:not([data-parts-done])").forEach(enhance);
  document.addEventListener("DOMContentLoaded", scan);
  let queued = false;
  new MutationObserver(() => {
    if (queued) return;
    queued = true;
    requestAnimationFrame(() => {
      queued = false;
      scan();
    });
  }).observe(document.documentElement, { childList: true, subtree: true });
})();
