# Error Messages

Typical `-errorcode` patterns (excerpt). Complete: the respective
`docs/<modul>.md`.

| Code | Meaning |
|---|---|
| `{TCLUTILS COMMON OPTION …}` | unknown option (`parseOptions`) |
| `{TCLUTILS COMMON VALUE …}` | value not in the allowed set |
| `{TCLUTILS COMMON BOOLEAN …}` | option requires a boolean |
| `{TCLUTILS COMMON INTEGER …}` | option requires a positive integer |
| `{TCLUTILS TUSETTINGS APP}` | app name empty or containing path characters |
| `{TCLUTILS TUSETTINGS KIND}` | unknown kind for `dir` |
| `{TCLUTILS TUSETTINGS SYNTAX}` | INI not parsable |
| `{TCLUTILS TUSETTINGS VALUE}` | value or key not suitable for INI |
| `{TCLUTILS TUHTTPS NOTLS}` | package `tls` missing |
| `{TCLUTILS TUHTTPS CAFILE}` | `-cafile` is not a readable file |
| `{TCLUTILS TUHTTPS NOCA}` | tls < 2.0 and no CA bundle found |
| `{TCLUTILS TUFETCH CAFILE}` | `-cafile` is not a readable file (only on the native path with tls) |
| `{TCLUTILS TUFETCH NOMETHOD}` | no transport (also: tls 1.x without CA bundle, no curl/wget) |
| `{TCLUTILS TUFETCH CONNECT}` | connection/DNS/certificate failed |
| `{TCLUTILS TUFETCH HTTP <Klasse> <Status>}` | HTTP status outside 2xx, e.g. `HTTP 4XX 404` |
| `{TCLUTILS TUFETCH URL}` | URL neither `http://` nor `https://` |
| `{TCLUTILS TUFETCH TIMEOUT}` | timeout |
| `{TCLUTILS TUFETCH REDIRECT}` | too many redirects |
| `{TCLUTILS TUCSV QUOTE}` | CSV field with an open quote (`-strict 1`) |
| `{TCLUTILS TUJSON PARSE offset}` | JSON invalid at this position |
| `{TCLUTILS TUJSON TYPE}` | `toJson` with an unknown kind |
| `{TCLUTILS TUINI SYNTAX}` | INI not parsable, including an open section |
| `{TCLUTILS TUBASE64 MAXLEN}` | `-maxlen` not an integer from 0 up |
| `{TCLUTILS TUHASH ENCODING}` | `-encoding` neither `utf-8` nor `binary` |
| `{TCLUTILS TUUUID INVALID}` | `version` without UUID form |
| `{TCLUTILS TUUUID VERSION}` | `generate -version` neither 4 nor 7 |
| `{TCLUTILS TUDICT ARG}` | `getOr` without a key |
| `{TCLUTILS TUDIFF OPTION MAXCELLS}` | `-maxcells` not a positive integer |
| `{TCLUTILS TUDIFF TOO_LARGE}` | old lines times new lines above `-maxcells` |
| `{TCLUTILS TUXML NAME <name>}` | element name invalid |
| `{TCLUTILS TUXML ATTR <name>}` | attribute name invalid |
| `{TCLUTILS TUSQLITE EMPTY}` | `insert` without a column |
| `{TCLUTILS TUTDBC EMPTY}` | `tutdbc::insert` without a column |
| `{TCLUTILS TUMMDB FORMAT}` | file is not a MaxMind DB |
| `{TCLUTILS TUMMDB HANDLE}` | unknown handle for `metadata` or `lookup` |
| `{TCLUTILS TUICAL SYNTAX}` | iCalendar line without `:`, or `END` without `BEGIN` |
| `{TCLUTILS TUICAL ARG}` | `newComponent` with an odd property list |
| `{TCLUTILS TUVCARD SYNTAX}` | vCard line without `:` |
| `{TCLUTILS TUNOTES NOTFOUND}` | note or parent missing |
| `{TCLUTILS TUHOLIDAY YEAR}` | `easter` without a year |
| `{TCLUTILS TUHOLIDAY REGION}` | `-region` is not `de` |
| `{TCLUTILS TUDIAGRAM DUPID}` | node id already exists |
| `{TCLUTILS TUDIAGRAM DIR}` | direction neither `LR`, `TB`, `RL` nor `BT` |
| `{TCLUTILS TUDIAGRAM ARG}` | node shape outside the eight names |
| `{TCLUTILS TUFLOW BADID}` | invalid node id, e.g. with an appended `-…` |
| `{TCLUTILS TUFLOW EMPTY}` | flowchart without nodes |
| `{TCLUTILS TUFLOW UNSUPPORTED}` | `parse` on a kind that only `toSvg` draws |
| `{TCLUTILS TUPIE EMPTY}` | pie chart without a sector |
| `{TCLUTILS TUPIE VALUE}` | negative value, or sectors do not sum to a positive value |
| `{TCLUTILS TUC4 EMPTY}` | C4 without elements |
| `{TCLUTILS TUSTR ARG}` | `isPrintable` not with exactly one character; `truncate` with a negative length |
| `{TCLUTILS TUPATH RELATIVE}` | `relative`: one path absolute, the other relative |
| `{TCLUTILS TUPATH ARGS}` | `commonPath` without a path |
| `{TCLUTILS TUPATH NOTLINK}` | `readlink` on something that is not a symbolic link |
| `{TCLUTILS TUDATE PARSE}` | `tudate::parse` cannot read the date |
| `{TCLUTILS TUDATE UNIT}` | `tudate::add` with an unknown unit |
| `{TCLUTILS TUNUM DECIMALS}` | `format -decimals` not an integer from 0 up |
| `{TCLUTILS TUNUM LOCALE}` | `parse` locale not `auto`/`de-strict`, or `format` locale not `de` |
| `{TCLUTILS TUPDFTEXT FILE}` | PDF file not readable |
| `{TCLUTILS TUPDFTEXT FORMAT}` | no `%PDF-` header, no objects or no pages |
| `{TCLUTILS TUPDFTEXT ENCRYPTED}` | PDF encrypted |
| `{TCLUTILS TUPDFTEXT NOTEXT}` | no page has text |
| `{TCLUTILS TUPDFTEXT OPTION}` | unknown option or missing value |
| `{TCLUTILS TUTESTRUN OPTION …}` | unknown runner option |
| `{TCLUTILS TUTASK CANCELLED}` | task cancelled or pool destroyed |
| `{TCLUTILS TUTASK TIMEOUT}` | `-timeout` of `await`/`wait` expired |
| `{TCLUTILS TUTASK NOTASK}` | `await` outside a coroutine |
| `{TCLUTILS TUTASK NOTDONE}` | `result` of a running task |
| `{TCLUTILS TUTASK OPTION}` | wrong argument (`spawn`, `timer`, `pipe`, `-timeout`) |
| `{TCLUTILS TUTASK NOTHREAD}` | `pool` without package `Thread` |
| `{TCLUTILS TUTASK EMPTY}` | `wait -mode first` on an empty group |
| `{TCLUTILS TUTASK INIT}` | `-init` of the pool failed |
| `{TCLUTILS TUTASK INSIDE}` | `destroy` from within the task itself |
| `{TCLUTILS TUTASK PROTOCOL}` | coroutine resumed unexpectedly |
| `{TCLUTILS TUTASK LIMIT COMMANDS}` | command limit of the sandbox |
| `{TCLUTILS TUTASK LIMIT TIME}` | time limit of the sandbox |
| `{TCLUTILS TUPKGFINDER OPTION}` | unknown option / wrong count |
| `{TCLUTILS TUPDF FORMAT}` | no `%PDF-` header, or `endobj` missing |
| `{TCLUTILS TUPDF ARG}` | object number is not an integer |
| `{TCLUTILS TUPDF NOTFOUND}` | object number not in the text after inflating |
| `{TCLUTILS TUNL START\|INCREMENT\|WIDTH}` | `tunl`: start or step not an integer, width not an integer from 1 up |
| `{TCLUTILS TUTR RANGE}` | `tutr`: descending range such as `c-a` |
| `{TCLUTILS TUTR SET2}` | `tutr`: empty second set without `-delete` |
| `{TCLUTILS TUTABLE COLUMNS}` | `tutable`: row with more cells than headers |
| `{TCLUTILS TUTABLE HEADERS}` | `tutable`: empty header list |
| `{TCLUTILS TUAWK OPTION}` | `tuawk`: unknown option or option without value |
| `{TCLUTILS TUAGREP MAXDIST}` | `tuagrep`: `-maxdist` not an integer from 0 up |
| `{TCLUTILS TUSPLIT BYTES}` | `tusplit::splitBytes`: characters above `\xFF` |
| `{TCLUTILS <MODUL> BYTES}` | bytes expected, characters above 255 found (`tuhexdump`, `tuod`, `tustrings`, `tucmp`, `tuhexedit`, `tuxxhash`) |
| `{TCLUTILS TUHEXEDIT OFFSET\|RANGE\|ENCODING}` | invalid offset; writing past the end of the file; character not encodable |
| `{TCLUTILS TUHEXDUMP OFFSET\|LENGTH}` | `-offset` or `-length` invalid |
| `{TCLUTILS TUCODE LOOKUP}` | `tucode::lookup`: empty or outside the table |
| `{TCLUTILS TUPNG CRC}` | PNG chunk with a wrong or missing CRC |
| `{TCLUTILS TUCOLOR HSV}` | `fromHsv`: h not 0..360 or s/v not 0..100 |
| `{TCLUTILS TUTABLEPNG PADDING\|SPACING}` | not an integer from 0 up |
| `{TCLUTILS TUMONTHPNG YEAR\|FIRSTWEEKDAY}` | year not 1..9999; first weekday not 1..7 |
| `{TCLUTILS TUPNGPAD TRIM\|SQUARE\|SIZE}` | invalid value of the option |
| `{TCLUTILS TULAYOUT OPTION}` | `tulayout`: unknown option or option without value |
| `{TCLUTILS TUAPPINFO OPTION\|VALUE}` | `tuappinfo`: unknown option; invalid value |
| `{TCLUTILS TUDEPLOY VALUE}` | `-tmadd` or `-fail` not a boolean |
| `{TCLUTILS TUXXHASH OPTION\|ENCODING}` | `tuxxhash`: unknown option; `-encoding` not `utf-8`/`binary` |
| `{TCLUTILS TULDIF CHANGETYPE}` | LDIF change record (`changetype:`) is not read |
| `{TCLUTILS TURRULE UNSUPPORTED}` | RRULE part that `turrule` does not evaluate |
| `{TCLUTILS TURRULE BYDAY\|VALUE}` | unknown weekday abbreviation; invalid value |
| `{TCLUTILS TUBASE32 LENGTH\|BITS}` | Base32: impossible length; padding bits not 0 |
| `{TCLUTILS TUDIAGRAM THEME}` | unknown diagram theme |
| `{TCLUTILS TUJOURNEY VALUE}` | rating not a number 1..5 |
| `{TCLUTILS TUPROVIDER FTP NOPKG}` | FTP backend without tcllib ftp |

`can't find package tclutils::…` — check the module path / `TCLUTILS_TM`
(chapter [Installation](020-installation.md)). Wording of the
`tutask` messages: chapter [Tasks with tutask](085-tutask.md).

## Summary

- Error codes have the form `{TCLUTILS <MODUL> <GRUND>}`.
- Prefix traps (`trap {TCLUTILS TUFETCH}`) catch whole groups.
