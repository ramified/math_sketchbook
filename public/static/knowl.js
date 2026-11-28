// Click-to-expand references ("knowls"), in the spirit of PreTeXt.
// A click on a.ref inserts the referenced result below the paragraph containing the link; a second click (or ×, or
// Escape) collapses it. Boxes nest to any depth. Ctrl/Cmd/Shift/middle click still opens the full page.
(() => {
  "use strict";
  const cache = new Map(); // tag -> Promise<string>
  const boxes = new WeakMap(); // link -> box element
  const draftPreference = "show-drafts";

  function openHashDraft(revealedDrafts = false) {
    let id;
    try {
      id = decodeURIComponent(location.hash.slice(1));
    } catch {
      return;
    }
    const target = document.getElementById(id);
    const draft = target?.querySelector(":scope > details.draft-result");
    if (!draft) return;
    const scroll = !draft.open || (revealedDrafts && target.classList.contains("draft-hidden"));
    draft.open = true;
    if (scroll && target.getClientRects().length) target.scrollIntoView({ block: "start" });
  }

  function wireDrafts() {
    const root = document.documentElement;
    const toggle = document.getElementById("show-drafts");
    if (toggle) {
      try {
        toggle.checked = localStorage.getItem(draftPreference) === "1";
      } catch {
        /* storage unavailable */
      }
      root.classList.toggle(draftPreference, toggle.checked);
      toggle.addEventListener("change", () => {
        try {
          localStorage.setItem(draftPreference, toggle.checked ? "1" : "0");
        } catch {
          /* storage unavailable */
        }
        root.classList.toggle(draftPreference, toggle.checked);
        if (toggle.checked) openHashDraft(true);
      });
      openHashDraft();
      window.addEventListener("hashchange", () => openHashDraft());
    }

    const folds = document.getElementById("page-folds");
    folds?.querySelectorAll("[data-fold-action]").forEach((button) => {
      button.addEventListener("click", () => {
        const articles = root.classList.contains(draftPreference) ? "article.result" : "article.result:not(.draft-hidden)";
        const expand = button.dataset.foldAction === "expand";
        folds.querySelectorAll(`:scope > details.intro-fold, :scope > ${articles} > details.draft-result`)
          .forEach((fold) => (fold.open = expand));
      });
    });

    if (document.body.classList.contains("drafts-unfolded")) new MutationObserver((records) => {
      const selector = "details.draft-block";
      for (const record of records) for (const node of record.addedNodes) {
        if (!(node instanceof Element)) continue;
        if (node.matches(selector)) node.open = true;
        node.querySelectorAll(selector).forEach((draft) => (draft.open = true));
      }
    }).observe(document.body, { childList: true, subtree: true });
  }

  function load(tag) {
    if (!cache.has(tag)) {
      const p = fetch("/api/knowl/" + encodeURIComponent(tag), { headers: { Accept: "text/html" } }).then((r) => {
        if (!r.ok) throw new Error("HTTP " + r.status);
        return r.text();
      });
      p.catch(() => cache.delete(tag)); // allow retry
      cache.set(tag, p);
    }
    return cache.get(tag);
  }

  function blockOf(link) {
    let el = link.parentElement;
    while (el && el !== document.body) {
      if (el.matches("li, dd, dt, td")) return { el, inside: true };
      const d = getComputedStyle(el).display;
      if (d !== "inline" && d !== "inline-block" && d !== "contents") return { el, inside: false };
      el = el.parentElement;
    }
    return { el: link, inside: false };
  }

  function close(link, refocus) {
    const box = boxes.get(link);
    if (!box) return;
    box.remove();
    boxes.delete(link);
    link.setAttribute("aria-expanded", "false");
    link.classList.remove("knowl-open");
    if (refocus) link.focus();
  }

  function render(box, tag, link) {
    const content = box.querySelector(".knowl-content");
    content.innerHTML = '<p class="knowl-loading">Loading…</p>';
    load(tag).then(
      (html) => {
        content.innerHTML = html;
      },
      () => {
        content.innerHTML = '<p class="knowl-error">Could not load this reference. <button type="button" class="knowl-retry">Retry</button></p>';
        content.querySelector(".knowl-retry").addEventListener("click", () => render(box, tag, link));
      },
    );
  }

  function open(link) {
    const tag = link.dataset.tag;
    // Cycle: the same result is already open further up this chain -> point to it instead of nesting again.
    let anc = link.closest(".knowl-box");
    while (anc) {
      if (anc.dataset.tag === tag) {
        anc.scrollIntoView({ behavior: "smooth", block: "nearest" });
        anc.classList.remove("knowl-flash");
        void anc.offsetWidth;
        anc.classList.add("knowl-flash");
        return;
      }
      anc = anc.parentElement && anc.parentElement.closest(".knowl-box");
    }
    const box = document.createElement("div");
    box.className = "knowl-box";
    box.dataset.tag = tag;
    box.setAttribute("role", "region");
    box.setAttribute("aria-label", link.textContent.trim());
    box.innerHTML =
      '<div class="knowl-bar"><a class="knowl-page" href="/tag/' + encodeURIComponent(tag) + '">open page ↗</a>' +
      '<button type="button" class="knowl-close" aria-label="Collapse">×</button></div><div class="knowl-content"></div>';
    box.querySelector(".knowl-close").addEventListener("click", () => close(link, true));
    const { el, inside } = blockOf(link);
    if (inside) el.appendChild(box);
    else el.after(box);
    boxes.set(link, box);
    link.setAttribute("aria-expanded", "true");
    link.classList.add("knowl-open");
    render(box, tag, link);
  }

  document.addEventListener("click", (e) => {
    const link = e.target instanceof Element && e.target.closest("a.ref[data-tag]");
    if (!link) return;
    if (e.button !== 0 || e.ctrlKey || e.metaKey || e.shiftKey || e.altKey) return;
    e.preventDefault();
    if (boxes.has(link) && boxes.get(link).isConnected) close(link, false);
    else open(link);
  });

  document.addEventListener("keydown", (e) => {
    if (e.key !== "Escape") return;
    const active = document.activeElement;
    // Focus still on the link that opened a box: close that box.
    if (active && active.matches && active.matches("a.ref[data-tag]") && boxes.has(active)) {
      close(active, true);
      return;
    }
    const box = active && active.closest && active.closest(".knowl-box");
    if (!box) return;
    const btn = box.querySelector(".knowl-close");
    if (btn) btn.click();
  });

  // Mark refs as expandable for assistive technology.
  const mark = (root) => root.querySelectorAll("a.ref[data-tag]:not([aria-expanded])").forEach((a) => a.setAttribute("aria-expanded", "false"));
  document.addEventListener("DOMContentLoaded", () => mark(document));
  document.addEventListener("DOMContentLoaded", wireDrafts);
  new MutationObserver(() => mark(document)).observe(document.documentElement, { childList: true, subtree: true });
})();
