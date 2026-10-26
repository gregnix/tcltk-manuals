# Pitfalls

---

- `lappend auto_path` instead of `tcl::tm::path add` for `.tm` trees.
- Starting the suite without the runner while loading `site-tcl` with
  the same version ahead of the workspace.
- `package require tclutils::tutestrun` against an old install — `source`
  the runner from the tree.
- Registering the HTTPS policy per module yourself and never undoing it —
  use `tuhttps`.
- `tusettings` values with a line break or leading spaces — an INI
  limit, error `TUSETTINGS VALUE`.
- Calling `tusettings::load …` without the full namespace —
  `invalid command name`; correct is `::tclutils::tusettings::load`.
- Reading `TUFETCH CAFILE` as "no CA" — it means: `-cafile` is not
  readable. If no CA at all is available under tls 1.x: `TUHTTPS NOCA` or
  `TUFETCH NOMETHOD`.
- Trying to write to a ZIP provider — the caps are `get list stat`.
- Rounding amounts with `format %.2f` — the result depends on the C
  runtime; use `tunum::format`.
- `tuuniq` on an unsorted list — it removes only neighbors,
  `a b b a` stays `a b a`.
- `tucut` for CSV with quotes — it cuts at the delimiter;
  fields containing a comma belong to `tucsv`.
- `tujson::parse` and then checking for `null` or `false` — `null` is empty,
  `true` is `1`, `false` is `0`. `parseTyped` keeps the kind.
- Writing to a ZIP provider and waiting for an `-errorcode` —
  the message is `does not support 'put'`, without a code.
- Taking `string length` as the visible character count — `tustr::graphemes`.
  `truncate` and `padLeft` still calculate with `string length`.
- `tustr::slugify` for a German title — only ASCII remains, "Größe"
  becomes `gr-e`. The anchor from `tumd` for the same title is `gre`.
- Reading an indented Markdown list as nested — `tumd`
  turns it into a flat list.
- Passing the stored value to `tunotes::create` — the change requires
  the variable name. `get` and `search` receive the value.
- Reading `tunotes::search` as a regular expression — it is `string match`,
  an asterisk in the query is a pattern character.
- Expecting state-specific public holidays from `tuholiday` — only the
  nationwide set `de`, plus Easter Sunday and Whit Sunday.
- `tuflow::parse` on a `pie` — `{TCLUTILS TUFLOW UNSUPPORTED}`.
  Drawing goes through `toSvg`.
- `tudiagram::addEdge` on unknown ids and expecting an error —
  the edge is attached to the model. `validate` reports `NONODE` and does not throw.
- Reading `flowchart TD` as direction `TD` in the model — it becomes `TB`.
- `tunum::parse -locale de-strict` and a period as decimal separator —
  `956.06` becomes `95606.0`.
- Reading `tudate::diff -unit days` across daylight saving time as calendar days —
  seconds divided by 86400; March 15 to April 15, 2024 gives 30.
- Expecting German from `tudate::relative` — the texts are `today`,
  `tomorrow`, `yesterday`.
- Reading `tudict::getOr` like `dict get` — the default comes before the
  path: `getOr $d vorgabe schlüssel …`.
- `tudict::flatten` on a value like `a b` — an even length counts as a
  dict, `{name {a b}}` becomes `name.a b`.
- `tuhash` on file bytes with the text default — `sha256` encodes UTF-8;
  `sha256File` hashes the bytes of the file.
- Expecting invalid Base64 to be an error — `decode` of `!!!` is empty,
  without `-errorcode`.
- Recognizing SQL NULL from `tusqlite::rows` by the sentinel — the cell comes
  back empty. `insert` sets NULL with `null`.
- With TDBC `allrows -as dicts`, reading a missing column as empty —
  NULL columns drop out of the dict. `tutdbc::rows` puts them back in as
  empty. `0` stays `0`.
- Expecting `tummdb::close` on an unknown handle to be an error —
  the call returns the empty string. `metadata` throws
  `HANDLE`.
- `tupdftext` on a scan — `{TCLUTILS TUPDFTEXT NOTEXT}`, not a
  silent empty string. `-notext empty` returns the empty page.
- `tupdf::object` on a number that is missing after inflating —
  `{TCLUTILS TUPDF NOTFOUND}`. The message names an object stream.
- Expecting `tuodf::text` without a line break after an empty final
  paragraph — the paragraphs are joined with `\n`, the text ends with it.
- Overlooking a second copy of the same version in the module path —
  `tupkgfinder::shadows`.
- Calling `$t wait` outside a task in a Tk handler —
  nested `vwait`; in the handler only `spawn`.
- `await` outside a coroutine — `TUTASK NOTASK`; wrap it in `spawn` or
  `run`.
- Limiting a sandbox with `-commands` only — `while 1 {}` keeps running;
  set `-time` as well.
- Expecting under Unix that `tutask::pipe` also ends grandchild processes on
  cancel — only the direct processes of the pipeline.
- Never collecting a task error — on `destroy` it arrives through `bgerror`.
- Expecting tkutils code in tclutils.

---

## Fixed in 0.66.0

These pitfalls apply up to 0.65.0. They are fixed in 0.66.0:

- `$g wait -mode first` outside a task and destroying the group
  immediately — in 0.65.0 a later `bgerror` "invalid command name …::my";
  needed up to 0.65.0: `after idle [list $g destroy]`.
- `pool` fails in the constructor (`NOTHREAD`, `-size 0`) — in 0.65.0
  an additional `bgerror` `can't read "jobs": no such variable`.
- `-init` of the pool fails — in 0.65.0 the job stays in the
  queue (`queued 1 jobs 1`).
- `tclutils::common` older than 0.2 on the path — `tutask` 0.1 loads
  anyway, `group` and `pool` fail only when called. `tutask` 0.2
  requires `common` 0.2.
- `run -timeout`, `$t wait -timeout` or `$g wait -timeout` outside
  a task with `abc` or `-5` — up to 0.65.0 silently accepted, there was
  no timeout. From 0.66.0 on `TUTASK OPTION` as with `await`.

---

## Summary

- Most pitfalls concern module paths, HTTPS policy and rounding.
- New in 0.65.0: pitfalls around `tutask` (Tk handlers, groups, sandbox,
  processes). Four of them and the silent acceptance of invalid `-timeout`
  values are fixed in 0.66.0.

---

*Next chapter: [Modules (Orientation)](810-anhang-module.md)*
