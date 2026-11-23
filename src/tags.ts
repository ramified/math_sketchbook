// Permanent tags: 4 characters, avoiding the easily confused 0/O and 1/I/L.
export const TAG_ALPHABET = "23456789ABCDEFGHJKMNPQRSTUVWXYZ"; // 31 symbols -> ~920k tags
export const TAG_RE = /^[2-9A-HJKMNP-Z]{4}$/;
// Aliases start with a lowercase letter, so they can never be mistaken for a tag.
export const ALIAS_RE = /^[a-z][a-z0-9-]{1,63}$/;

export function isTag(s: string): boolean {
  return TAG_RE.test(s);
}

export function isAlias(s: string): boolean {
  return ALIAS_RE.test(s);
}

export function randomTag(): string {
  const n = TAG_ALPHABET.length;
  const limit = 256 - (256 % n); // rejection sampling for a uniform distribution
  let out = "";
  while (out.length < 4) {
    const buf = new Uint8Array(8);
    crypto.getRandomValues(buf);
    for (const b of buf) if (b < limit && out.length < 4) out += TAG_ALPHABET[b % n];
  }
  return out;
}
