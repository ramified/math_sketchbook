import assert from "node:assert/strict";
import { test } from "node:test";
import { loadBook, typeName } from "../src/book.ts";
import { RESULT_TYPES } from "../src/types.ts";

test("Motivation is a result type with a display name", () => {
  assert.ok(RESULT_TYPES.includes("motivation"));
  assert.equal(typeName("motivation"), "Motivation");
});

test("appendices are numbered independently and follow ordinary chapters", async () => {
  const sections = [
    { id: 1, tag: "CH01", kind: "chapter", parent_id: null, position: 1, appendix: 0 },
    { id: 2, tag: "APXA", kind: "chapter", parent_id: null, position: 2, appendix: 1 },
    { id: 3, tag: "CH02", kind: "chapter", parent_id: null, position: 3, appendix: 0 },
    { id: 4, tag: "SEC1", kind: "section", parent_id: 1, position: 1, appendix: 0 },
    { id: 5, tag: "APXS", kind: "section", parent_id: 2, position: 1, appendix: 0 },
    { id: 6, tag: "SEC2", kind: "section", parent_id: 3, position: 1, appendix: 0 },
  ].map((row) => ({ ...row, title: "" }));
  const results = [
    { id: 1, tag: "DRFT", position: 1, visibility: "draft" },
    { id: 2, tag: "LEM1", position: 2, visibility: "published" },
  ].map((row) => ({ ...row, section_id: 5, type: "lemma", title: "", state: "active", listed: 1, understanding: "partial" }));
  const db = {
    prepare(sql: string) {
      const resultsForQuery = sql.includes("FROM sections") ? sections : results;
      return { results: [...resultsForQuery].sort((a, b) => a.position - b.position || a.id - b.id) };
    },
    async batch(statements: unknown[]) {
      return statements;
    },
  } as unknown as D1Database;

  const book = await loadBook(db, true);
  assert.deepEqual(book.chapters.map(({ number }) => number), ["1", "2", "A"]);
  assert.equal(book.byTag.get("APXA")?.label, "Appendix A");
  assert.deepEqual(book.chapters.flatMap(({ id }) => book.sectionsOf.get(id)!.map(({ number }) => number)), ["1.1", "2.1", "A.1"]);
  assert.equal(book.byTag.get("LEM1")?.number, "A.1.1");
  assert.equal(book.byTag.get("LEM1")?.understanding, "partial");
  assert.equal(book.byTag.get("APXS")?.understanding, undefined);
  assert.equal(book.byTag.get("DRFT")?.number, "A.1.?");
});
