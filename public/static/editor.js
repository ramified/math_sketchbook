// Editor page behaviour: live preview, proofs list, saving.
(() => {
  "use strict";
  let dirty = false;

  async function postJSON(url, data) {
    const r = await fetch(url, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(data) });
    let body = {};
    try {
      body = await r.json();
    } catch {
      /* ignore */
    }
    if (!r.ok) throw new Error(body.error || "HTTP " + r.status);
    return body;
  }

  function showWarnings(ul, warnings) {
    if (!ul) return;
    ul.innerHTML = "";
    for (const w of warnings || []) {
      const li = document.createElement("li");
      li.textContent = (w.line ? "line " + w.line + ": " : "") + w.message;
      ul.appendChild(li);
    }
  }

  // ---- live preview
  function wirePreview(textarea) {
    const pair = textarea.closest(".tex-pair");
    const preview = pair.querySelector(".preview");
    const warn = pair.querySelector(".preview-warnings");
    let timer = null;
    let seq = 0;
    const run = async () => {
      const mine = ++seq;
      try {
        const out = await postJSON("/api/edit/preview", { tex: textarea.value });
        if (mine !== seq) return;
        preview.innerHTML = out.html || '<p class="muted">(empty)</p>';
        showWarnings(warn, out.warnings);
      } catch (e) {
        if (mine === seq) showWarnings(warn, [{ message: "Preview failed: " + e.message }]);
      }
    };
    textarea.addEventListener("input", () => {
      dirty = true;
      clearTimeout(timer);
      timer = setTimeout(run, 350);
    });
    run();
  }

  // ---- result form helpers
  function sectionsData() {
    const el = document.getElementById("sections-data");
    return el ? JSON.parse(el.textContent) : [];
  }

  function fillPlaceAfter(form) {
    const sel = form.querySelector('select[name="place_after"]');
    const secSel = form.querySelector('select[name="section_id"]');
    if (!sel || !secSel) return;
    const self = Number(sel.dataset.self);
    const sec = sectionsData().find((s) => String(s.id) === secSel.value);
    const same = secSel.value === secSel.dataset.current;
    sel.innerHTML = "";
    const add = (value, label) => {
      const o = document.createElement("option");
      o.value = value;
      o.textContent = label;
      sel.appendChild(o);
    };
    add("keep", same ? "(keep current position)" : "(at the end of the section)");
    add("start", "At the beginning");
    for (const r of sec ? sec.results : []) if (r.id !== self) add(String(r.id), "After " + r.label);
  }

  function wireProof(fs) {
    fs.querySelectorAll("textarea[data-preview]").forEach(wirePreview);
    fs.querySelector("[data-remove]").addEventListener("click", () => {
      if (confirm("Remove this proof? (It stays in the history.)")) {
        fs.remove();
        dirty = true;
      }
    });
    fs.querySelectorAll("[data-move]").forEach((b) =>
      b.addEventListener("click", () => {
        const dir = Number(b.dataset.move);
        const sib = dir < 0 ? fs.previousElementSibling : fs.nextElementSibling;
        if (!sib) return;
        if (dir < 0) sib.before(fs);
        else sib.after(fs);
        dirty = true;
      }),
    );
  }

  function collect(form) {
    const val = (name) => {
      const el = form.querySelector('[name="' + name + '"]');
      return el ? el.value : undefined;
    };
    const place = val("place_after") ?? val("place_after_static");
    const data = { revision: Number(val("revision")), title: val("title") };
    data.place_after = place === "keep" || place === "start" || place === undefined ? place : Number(place);
    if (form.querySelector('[name="intro_tex"]')) {
      data.intro_tex = val("intro_tex");
      if (val("parent_id") !== undefined) data.parent_id = Number(val("parent_id"));
      return data;
    }
    data.type = val("type");
    data.section_id = Number(val("section_id"));
    const listedBox = form.querySelector('[name="listed"]');
    if (listedBox) data.listed = listedBox.checked;
    data.statement_tex = val("statement_tex");
    data.aliases = (val("aliases") || "").split(",").map((s) => s.trim()).filter(Boolean);
    data.proofs = [...form.querySelectorAll("#proofs > fieldset.proof-edit")].map((fs) => {
      const f = (n) => fs.querySelector('[name="' + n + '"]').value;
      return {
        id: fs.dataset.id ? Number(fs.dataset.id) : null,
        revision: fs.dataset.revision ? Number(fs.dataset.revision) : null,
        body_tex: f("body_tex"),
        status: f("status"),
        generated_by: f("generated_by"),
        generator_detail: f("generator_detail"),
        reviewed_by: f("reviewed_by"),
        review_notes: f("review_notes"),
      };
    });
    return data;
  }

  function wireEditForm(form) {
    const status = document.getElementById("save-status");
    const warnUl = document.getElementById("save-warnings");
    form.querySelectorAll(".tex-pair > textarea[data-preview]").forEach((t) => {
      if (!t.closest("fieldset.proof-edit")) wirePreview(t);
    });
    form.querySelectorAll("#proofs > fieldset.proof-edit").forEach(wireProof);
    const secSel = form.querySelector('select[name="section_id"]');
    if (secSel) {
      fillPlaceAfter(form);
      secSel.addEventListener("change", () => fillPlaceAfter(form));
    }
    const addBtn = document.getElementById("add-proof");
    if (addBtn) {
      addBtn.addEventListener("click", () => {
        const tpl = document.getElementById("proof-template");
        const fs = tpl.content.firstElementChild.cloneNode(true);
        document.getElementById("proofs").appendChild(fs);
        wireProof(fs);
        fs.querySelector("textarea").focus();
        dirty = true;
      });
    }
    form.addEventListener("input", () => (dirty = true));

    let saving = false;
    const lock = (on) => {
      // While a save is in flight, block edits so nothing typed meanwhile is lost by the reload.
      form.querySelectorAll("input, textarea, select, button").forEach((el) => {
        if (on) {
          el.dataset.wasDisabled = el.disabled ? "1" : "";
          el.disabled = true;
        } else if (!el.dataset.wasDisabled) el.disabled = false;
      });
    };
    const save = async () => {
      if (saving) return;
      saving = true;
      status.textContent = "Saving…";
      status.className = "";
      const payload = collect(form);
      lock(true);
      try {
        const out = await postJSON(form.dataset.saveUrl, payload);
        dirty = false;
        try {
          sessionStorage.setItem("grh-save-result", JSON.stringify({ warnings: out.warnings || [], publicUrl: form.dataset.publicUrl }));
        } catch {
          /* ignore */
        }
        location.href = location.pathname; // reload with fresh revision numbers (drops ?restore=)
      } catch (e) {
        status.textContent = "Not saved: " + e.message;
        status.className = "error";
        lock(false);
        saving = false;
      }
    };
    form.addEventListener("submit", (e) => {
      e.preventDefault();
      save();
    });
    document.addEventListener("keydown", (e) => {
      if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === "s") {
        e.preventDefault();
        save();
      }
    });

    // Message from the previous save (after reload).
    try {
      const prev = JSON.parse(sessionStorage.getItem("grh-save-result") || "null");
      sessionStorage.removeItem("grh-save-result");
      if (prev) {
        status.innerHTML = 'Saved and published ✓ <a href="' + prev.publicUrl + '" target="_blank" rel="noopener">view public page ↗</a>';
        status.className = "ok";
        showWarnings(warnUl, prev.warnings);
      }
    } catch {
      /* ignore */
    }
  }

  function wireCreateForms() {
    document.querySelectorAll("form[data-create]").forEach((form) => {
      form.addEventListener("submit", async (e) => {
        e.preventDefault();
        const data = {};
        new FormData(form).forEach((v, k) => (data[k] = /_id$/.test(k) ? Number(v) : v));
        try {
          const out = await postJSON(form.dataset.create, data);
          location.href = out.url;
        } catch (err) {
          alert("Could not create: " + err.message);
        }
      });
    });
  }

  function wireSettings() {
    document.querySelectorAll("form.setting-form").forEach((form) => {
      const status = form.querySelector(".save-status");
      form.addEventListener("input", () => (dirty = true));
      form.addEventListener("submit", async (e) => {
        e.preventDefault();
        status.textContent = "Saving…";
        try {
          await postJSON(form.dataset.saveUrl, {
            key: form.dataset.key,
            value: form.querySelector('[name="value"]').value,
            revision: Number(form.querySelector('[name="revision"]').value),
          });
          dirty = false;
          location.reload();
        } catch (err) {
          status.textContent = "Not saved: " + err.message;
          status.className = "save-status error";
        }
      });
    });
    const rb = document.getElementById("rebuild");
    if (rb) {
      rb.addEventListener("click", async () => {
        const st = document.getElementById("rebuild-status");
        st.textContent = "Working…";
        try {
          const out = await postJSON("/api/edit/rebuild", {});
          st.textContent = "Done: " + out.results + " results, " + out.proofs + " proofs.";
        } catch (err) {
          st.textContent = "Failed: " + err.message;
        }
      });
    }
  }

  document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("edit-form");
    if (form) wireEditForm(form);
    wireCreateForms();
    wireSettings();
  });
  window.addEventListener("beforeunload", (e) => {
    if (dirty) {
      e.preventDefault();
      e.returnValue = "";
    }
  });
})();
