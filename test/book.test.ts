import assert from "node:assert/strict";
import { test } from "node:test";
import { typeName } from "../src/book.ts";
import { RESULT_TYPES } from "../src/types.ts";

test("Motivation is a result type with a display name", () => {
  assert.ok(RESULT_TYPES.includes("motivation"));
  assert.equal(typeName("motivation"), "Motivation");
});
