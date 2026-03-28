/**
 * Ensures the user-supplied string is a single read-only statement we are willing to run.
 * Not a full SQL parser — avoids mutating statements and obvious multi-statement abuse.
 */
export function assertReadOnlySelect(sql: string): void {
  let s = sql.trim();
  if (!s) {
    throw new Error("SQL must not be empty.");
  }

  s = s.replace(/;\s*$/u, "").trim();
  if (s.includes(";")) {
    throw new Error("Only one statement is allowed (remove extra semicolons).");
  }

  while (true) {
    const before = s;
    s = s.replace(/^\s*--[^\n]*/u, "").trim();
    s = s.replace(/^\s*\/\*[\s\S]*?\*\//u, "").trim();
    if (s === before) {
      break;
    }
  }

  const upper = s.toUpperCase();
  if (upper.startsWith("SELECT")) {
    if (/\bINTO\s+(OUTFILE|DUMPFILE)\b/u.test(s)) {
      throw new Error("SELECT ... INTO OUTFILE / DUMPFILE is not allowed.");
    }
    return;
  }

  if (upper.startsWith("WITH")) {
    if (/\b(INSERT|UPDATE|DELETE|REPLACE)\b/i.test(s)) {
      throw new Error(
        "Only read-only queries are allowed (no INSERT/UPDATE/DELETE/REPLACE)."
      );
    }
    if (!/\bSELECT\b/i.test(s)) {
      throw new Error("WITH must be used with a SELECT (read-only) query.");
    }
    if (/\bINTO\s+(OUTFILE|DUMPFILE)\b/u.test(s)) {
      throw new Error("SELECT ... INTO OUTFILE / DUMPFILE is not allowed.");
    }
    return;
  }

  throw new Error('Only SELECT or WITH ... SELECT is allowed (after optional comments).');
}
