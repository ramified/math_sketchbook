"""Apply and verify the Chapter 3 migration in an in-memory SQLite database."""

from collections import Counter
import json
from pathlib import Path
import sqlite3
import subprocess


ROOT = Path(__file__).resolve().parent.parent
BACKUP = ROOT / "backup-before-chapter3-self-contained-2026-11-27.sql"
CHEBYSHEV = ROOT / "scripts/chebyshev-chapter-2026-11-27.sql"
MIGRATION = ROOT / "scripts/chapter3-self-contained-2026-11-27.sql"
RENDERER = ROOT / "scripts/check-chapter3-self-contained-2026-11-27.mjs"
REPORT = ROOT / "implement_plan/tasks/2026-11-27-chapter3-self-contained.md.report.md"

TEX_FIELDS = {
    "sections": ("title", "intro_tex"),
    "results": ("title", "statement_tex"),
    "proofs": ("body_tex",),
}
SNAPSHOT_FIELDS = {
    "sections": ("tag", "parent_id", "kind", "title", "intro_tex", "position"),
    "results": ("tag", "type", "title", "statement_tex", "section_id", "position",
                "visibility", "state", "replaced_by_id", "listed"),
    "proofs": ("result_id", "body_tex", "status", "generated_by", "generator_detail",
               "reviewed_by", "review_notes", "position"),
    "settings": ("value",),
}
ENTITIES = {"sections": "section", "results": "result", "proofs": "proof", "settings": "setting"}
CACHE_FIELDS = {
    "sections": "intro_html_cache",
    "results": "statement_html_cache",
    "proofs": "body_html_cache",
}


def apply_sql(db, path):
    db.executescript("BEGIN;\n" + path.read_text(encoding="utf-8-sig") + "\nCOMMIT;")


def baseline():
    db = sqlite3.connect(":memory:")
    db.row_factory = sqlite3.Row
    # The D1 export inserts some rows before it creates the referenced tables.
    apply_sql(db, BACKUP)
    db.execute("PRAGMA foreign_keys=ON")
    assert db.execute("PRAGMA foreign_key_check").fetchall() == []
    return db


def read_rows(db, table):
    pk = "key" if table == "settings" else "id"
    return {row[pk]: dict(row) for row in db.execute(f"SELECT * FROM {table}")}


def render(fields, data):
    payload = {
        "macroSource": data["settings"]["macros"]["value"],
        "bibliography": data["settings"]["bibliography"]["value"],
        "fields": fields,
        "sections": list(data["sections"].values()),
        "results": list(data["results"].values()),
    }
    result = subprocess.run(
        ["node", str(RENDERER)], cwd=ROOT, input=json.dumps(payload),
        capture_output=True, text=True, encoding="utf-8", check=False,
    )
    if result.returncode:
        raise RuntimeError(result.stderr)
    return json.loads(result.stdout)


def tag_for(table, row, data):
    if table == "proofs":
        return data["results"][row["result_id"]]["tag"]
    return row["tag"]


def check():
    db = baseline()
    db.execute("UPDATE settings SET value='0' WHERE key='needs_rebuild'")
    db.commit()
    previous = {table: read_rows(db, table) for table in ENTITIES}
    apply_sql(db, MIGRATION)
    assert db.execute("PRAGMA foreign_keys").fetchone()[0] == 1
    assert db.execute("PRAGMA foreign_key_check").fetchall() == []
    assert [row[0] for row in db.execute("PRAGMA integrity_check")] == ["ok"]
    assert db.execute(
        "SELECT refs.id FROM refs JOIN proofs ON proofs.id=refs.source_proof_id "
        "WHERE refs.source_result_id<>proofs.result_id"
    ).fetchall() == []
    data = {table: read_rows(db, table) for table in ENTITIES}
    assert data["settings"]["needs_rebuild"]["value"] == "1"
    sql_state = list(db.iterdump())
    try:
        apply_sql(db, MIGRATION)
    except sqlite3.IntegrityError as error:
        assert "ok = 1" in str(error), error
        assert not db.in_transaction
    else:
        raise AssertionError("The migration guard let a second run through")
    assert sql_state == list(db.iterdump()), "Blocked rerun changed database state"

    stale = baseline()
    stale.execute("UPDATE results SET statement_tex='' WHERE tag='8JU7'")
    stale.commit()
    try:
        apply_sql(stale, MIGRATION)
    except sqlite3.IntegrityError as error:
        assert "ok = 1" in str(error), error
    else:
        raise AssertionError("The migration guard accepted a missing old statement substring")
    assert not stale.in_transaction

    changed = {}
    for table in ENTITIES:
        changed[table] = {
            key: row for key, row in data[table].items()
            if row != previous[table].get(key) and key != "needs_rebuild"
        }
        for key, row in changed[table].items():
            old = previous[table].get(key)
            expected = (old["revision"] if old else 0) + 1
            assert row["revision"] == expected, (table, key, row["revision"])
            if table in CACHE_FIELDS:
                assert row[CACHE_FIELDS[table]] is None, (table, key)
            snap, = db.execute(
                "SELECT snapshot_json FROM revisions WHERE entity=? AND entity_key=? AND revision=?",
                (ENTITIES[table], str(key), expected),
            ).fetchone()
            assert json.loads(snap) == {field: row[field] for field in SNAPSHOT_FIELDS[table]}
    assert all(set(previous[t]) <= set(data[t]) for t in ENTITIES)
    report = REPORT.read_text(encoding="utf-8")
    fence = chr(96) * 3
    for table, names in TEX_FIELDS.items():
        for row in changed[table].values():
            assert f"{fence}tex\n{row[names[-1]].rstrip()}\n{fence}" in report

    def section_chapter(section_id):
        section = data["sections"][section_id]
        parent = section["parent_id"]
        return section["tag"] if parent is None else section_chapter(parent)

    def chapter_of(table, row):
        if table == "sections":
            return section_chapter(row["id"])
        if table == "proofs":
            row = data["results"][row["result_id"]]
        return section_chapter(row["section_id"])

    tag_chapters = {
        row["tag"]: chapter_of(table, row)
        for table in ("sections", "results") for row in data[table].values()
    }
    fields = [
        {"table": table, "key": key, "field": field, "tex": row[field]}
        for table, names in TEX_FIELDS.items() for key, row in data[table].items()
        for field in names
        if field in ("statement_tex", "body_tex") or key in changed[table] or chapter_of(table, row) == "8JU2"
    ]
    rendered = render(fields, data)
    bib_keys = [entry["key"] for entry in rendered["entries"]]
    assert len(bib_keys) == len(set(bib_keys)), bib_keys
    for entry in rendered["entries"]:
        assert not entry["warnings"], entry
    primary_keys = {"McCurley1984", "BennettEtAl2018", "ThornerZaman2024", "Montgomery1971",
                    "Behrend1946"}
    assert primary_keys <= set(bib_keys)
    chapter_refs = []
    chapter_citations = Counter()
    checked_graph_rows = 0
    chapter_fields = 0
    assert len(fields) == len(rendered["outputs"])
    for field, parsed in zip(fields, rendered["outputs"], strict=True):
        table, key, name = field["table"], field["key"], field["field"]
        row = data[table][key]
        tag = tag_for(table, row, data)
        label = (table, key, tag, name)
        chapter = chapter_of(table, row)
        if key in changed[table] or chapter == "8JU2":
            assert set(parsed["citations"]) <= set(bib_keys), (label, parsed["citations"])
            assert set(parsed["refs"]) == set(parsed["parsedRefs"]), (label, parsed)
            assert set(parsed["refs"]) <= set(tag_chapters), (label, parsed["refs"])
        if key in changed[table]:
            assert not parsed["warnings"], (label, parsed["warnings"])
        if name in ("statement_tex", "body_tex"):
            result_id = row["result_id"] if table == "proofs" else key
            proof_id = key if table == "proofs" else None
            stored = {
                ref[0] for ref in db.execute(
                    "SELECT target_tag FROM refs WHERE source_result_id=? AND source_proof_id IS ?",
                    (result_id, proof_id),
                )
            }
            assert stored == set(parsed["refs"]), (label, sorted(stored), parsed["refs"])
            checked_graph_rows += 1
        if chapter != "8JU2":
            continue
        chapter_fields += 1
        assert r"x_{\rm wt}" not in field["tex"], label
        chapter_citations.update(parsed["citations"])
        assert set(parsed["citations"]) <= primary_keys or tag == "8JVG", (label, parsed["citations"])
        for target in parsed["refs"]:
            if tag_chapters[target] != "8JV5":
                continue
            assert tag == "8JVG" or (tag == "8JU2" and name == "intro_tex" and target == "8JV5")
            chapter_refs.append((tag, target))

    assert sorted(chapter_refs) == [
        ("8JU2", "8JV5"), ("8JVG", "8JUF"), ("8JVG", "8JV5"), ("8JVG", "C4S2"),
    ]
    numbering = rendered["numbering"]
    expected_numbers = {
        "7HA2": "1", "UTUF": "2", "8JU2": "3", "8JV5": "4", "8JV6": "3.1",
        "8JV7": "3.2", "8JV8": "3.3", "8JU5": "3.4", "8JV9": "3.1.1", "8JVA": "3.1.2",
        "8JVB": "3.1.3", "8JVN": "3.1.4", "8JVC": "3.2.1", "8JVP": "3.2.2",
        "8JVQ": "3.2.3", "8JU9": "3.2.4", "8JVD": "3.2.5", "8JVM": "",
        "C3R2": "", "8JU7": "3.3.1", "C3T2": "3.3.2", "8JVK": "3.3.3",
        "8JVE": "3.3.4", "8JVF": "3.3.5", "8JVG": "3.3.6", "8JVH": "3.4.1",
        "8JUE": "", "8JUW": "3.4.2", "8JUD": "3.4.3", "8JVJ": "3.4.4",
        "8JU3": "4.1", "C4S2": "4.1.1", "8JV2": "4.1.2", "8JU8": "",
        "8JU4": "4.2", "C4W2": "4.2.1", "8JUA": "4.2.2", "8JUB": "", "8JUC": "",
        "8JU6": "4.3", "8JUF": "4.3.1", "8JUG": "",
    }
    assert {tag: numbering[tag] for tag in expected_numbers} == expected_numbers
    assert not db.execute("SELECT 1 FROM proofs WHERE result_id=(SELECT id FROM results WHERE tag='8JVK')").fetchone()
    assert db.execute("SELECT 1 FROM proofs JOIN results ON proofs.result_id=results.id WHERE tag='C4W2' AND proofs.id=138").fetchone()

    print("PASS atomic apply, rerun rollback, old-substring guard, FK and integrity checks")
    print("PASS revision increments, snapshots, cache clearing and rebuild flag")
    print(f"PASS {len(expected_numbers)} numbering and unlisted-status checks via src/book.ts")
    print(f"PASS {checked_graph_rows} statement and proof refs checks against renderTex")
    print(f"PASS Chapter 3 scan of {chapter_fields} TeX fields, with Chapter 4 links {sorted(chapter_refs)}")
    print(f"PASS Chapter 3 citation keys {sorted(chapter_citations)}")
    all_changed_fields = sum(len(rows) * len(TEX_FIELDS[t]) for t, rows in changed.items() if t in TEX_FIELDS)
    print(f"PASS renderTex and KaTeX on {all_changed_fields} TeX fields of changed rows "
          f"and {len(bib_keys)} bibliography entries, using the stored macros")
    print("PASS full text of each changed statement, proof and introduction in the report")


if __name__ == "__main__":
    check()
