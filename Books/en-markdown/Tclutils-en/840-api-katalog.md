# API Catalog: tclutils Modules

This catalog was derived from the shipped `.tm` source files. It shows **procedure signatures**, not necessarily complete contracts. For semantics, options, error codes and side effects, the respective implementation is authoritative.

The commands are written with their full namespace. An `args` signature means variable arguments; the allowed options have to be looked up in the respective module implementation.

Modules with procedures covered: **140**.

## `common`

Source: `lib/tm/tclutils/common-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::common::readFile {path args}
::tclutils::common::readBinaryFile {path}
::tclutils::common::writeFile {path data args}
::tclutils::common::splitLines {text}
::tclutils::common::splitDelimited {line delimiter}
::tclutils::common::parseOptions {defaults args}
::tclutils::common::ensureBoolean {value optionName}
::tclutils::common::ensurePositiveInteger {value what}
::tclutils::common::ensureOneOf {value allowed what}
```

## `tuagrep`

Source: `lib/tm/tclutils/tuagrep-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuagrep::match {line pattern args}
::tclutils::tuagrep::search {text pattern args}
::tclutils::tuagrep::file {filename pattern args}
::tclutils::tuagrep::files {fileList pattern args}
```

## `tuappinfo`

Source: `lib/tm/tclutils/tuappinfo-0.2.tm`. No export list found with the simple source pattern; visible procedures without a leading underscore are listed.

```tcl

```

## `tuarchitecture`

Source: `lib/tm/tclutils/tuarchitecture-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuarchitecture::parse {text}
```

## `tuawk`

Source: `lib/tm/tclutils/tuawk-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuawk::run {text rules args}
::tclutils::tuawk::file {path rules args}
```

## `tubase32`

Source: `lib/tm/tclutils/tubase32-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tubase32::encode {data args}
::tclutils::tubase32::decode {text args}
::tclutils::tubase32::encodeFile {path args}
::tclutils::tubase32::decodeFile {path args}
```

## `tubase64`

Source: `lib/tm/tclutils/tubase64-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tubase64::encode {data args}
::tclutils::tubase64::decode {text}
::tclutils::tubase64::encodeFile {path args}
::tclutils::tubase64::decodeFile {path}
```

## `tubin`

Source: `lib/tm/tclutils/tubin-0.3.tm`. Limited to `namespace export`.

```tcl
::tclutils::tubin::bytesToHex {bytes args}
::tclutils::tubin::hexToBytes {hex}
::tclutils::tubin::bytesToUnsignedList {bytes {offset 0} {length -1}}
::tclutils::tubin::u8 {bytes {offset 0}}
::tclutils::tubin::u16le {bytes {offset 0}} { ScanUnsigned $bytes $offset 2 s 0xffff 0 }
::tclutils::tubin::u32le {bytes {offset 0}} { ScanUnsigned $bytes $offset 4 i 0xffffffff 0 }
::tclutils::tubin::u64le {bytes {offset 0}} { ScanUnsigned $bytes $offset 8 w "" [expr {1 << 64}] }
::tclutils::tubin::u16be {bytes {offset 0}} { ScanUnsigned $bytes $offset 2 S 0xffff 0 }
::tclutils::tubin::u32be {bytes {offset 0}} { ScanUnsigned $bytes $offset 4 I 0xffffffff 0 }
::tclutils::tubin::u64be {bytes {offset 0}} { ScanUnsigned $bytes $offset 8 W "" [expr {1 << 64}] }
::tclutils::tubin::uintle {bytes {offset 0} {length 0}}
::tclutils::tubin::i8 {bytes {offset 0}} { Signed [u8    $bytes $offset]  8 }
::tclutils::tubin::i16le {bytes {offset 0}} { Signed [u16le $bytes $offset] 16 }
::tclutils::tubin::i16be {bytes {offset 0}} { Signed [u16be $bytes $offset] 16 }
::tclutils::tubin::i32le {bytes {offset 0}} { Signed [u32le $bytes $offset] 32 }
::tclutils::tubin::i32be {bytes {offset 0}} { Signed [u32be $bytes $offset] 32 }
::tclutils::tubin::i64le {bytes {offset 0}} { Signed [u64le $bytes $offset] 64 }
::tclutils::tubin::i64be {bytes {offset 0}} { Signed [u64be $bytes $offset] 64 }
::tclutils::tubin::f32le {bytes {offset 0}}
::tclutils::tubin::f64le {bytes {offset 0}}
::tclutils::tubin::uintbe {bytes {offset 0} {length 0}}
::tclutils::tubin::f32be {bytes {offset 0}}
::tclutils::tubin::f64be {bytes {offset 0}}
::tclutils::tubin::packU8 {value} { binary format c [CheckRange $value 0xff u8] }
::tclutils::tubin::packU16LE {value} { binary format s [CheckRange $value 0xffff u16] }
::tclutils::tubin::packU32LE {value} { binary format i [CheckRange $value 0xffffffff u32] }
::tclutils::tubin::packU64LE {value} { binary format w [CheckRange $value [expr {(1 << 64) - 1}] u64] }
::tclutils::tubin::packU16BE {value} { binary format S [CheckRange $value 0xffff u16] }
::tclutils::tubin::packU32BE {value} { binary format I [CheckRange $value 0xffffffff u32] }
::tclutils::tubin::packU64BE {value} { binary format W [CheckRange $value [expr {(1 << 64) - 1}] u64] }
::tclutils::tubin::ascii {bytes}
::tclutils::tubin::reader {subcmd args}
```

## `tublock`

Source: `lib/tm/tclutils/tublock-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tublock::parse {text}
```

## `tubookmark`

Source: `lib/tm/tclutils/tubookmark-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tubookmark::parse {html}
::tclutils::tubookmark::serialize {bookmarks args}
```

## `tuc4`

Source: `lib/tm/tclutils/tuc4-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuc4::parse {text}
```

## `tucal`

Source: `lib/tm/tclutils/tucal-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucal::render {year month args}
::tclutils::tucal::month {args}
::tclutils::tucal::now {args}
::tclutils::tucal::year {year args}
::tclutils::tucal::three {args}
```

## `tucat`

Source: `lib/tm/tclutils/tucat-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucat::text {text args}
::tclutils::tucat::file {path args}
::tclutils::tucat::files {paths args}
```

## `tuclass`

Source: `lib/tm/tclutils/tuclass-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuclass::parse {text}
```

## `tucmp`

Source: `lib/tm/tclutils/tucmp-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucmp::data {a b}
::tclutils::tucmp::files {file1 file2}
::tclutils::tucmp::equal {file1 file2}
::tclutils::tucmp::firstDifference {file1 file2}
```

## `tucode`

Source: `lib/tm/tclutils/tucode-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucode::lookup {value}
::tclutils::tucode::lookupChar {char}
::tclutils::tucode::render {from to args}
::tclutils::tucode::table {from to args}
::tclutils::tucode::ascii {args}
::tclutils::tucode::latin1 {args}
::tclutils::tucode::ansi {args}
::tclutils::tucode::groups {}
::tclutils::tucode::signs {args}
```

## `tucodepng`

Source: `lib/tm/tclutils/tucodepng-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucodepng::render {from to args}
::tclutils::tucodepng::write {file from to args}
::tclutils::tucodepng::ascii {args} { return [render 0 127 {*}$args] }
::tclutils::tucodepng::latin1 {args} { return [render 128 255 {*}$args] }
::tclutils::tucodepng::all {args} { return [render 0 255 {*}$args] }
```

## `tucolor`

Source: `lib/tm/tclutils/tucolor-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucolor::rgb {color}
::tclutils::tucolor::hex {color}
::tclutils::tucolor::names {}
::tclutils::tucolor::exists {name}
::tclutils::tucolor::nearest {color}
::tclutils::tucolor::toHsv {color}
::tclutils::tucolor::fromHsv {hsv}
```

## `tucolumn`

Source: `lib/tm/tclutils/tucolumn-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucolumn::table {text args}
::tclutils::tucolumn::fill {items args}
::tclutils::tucolumn::text {text args}
::tclutils::tucolumn::file {path args}
```

## `tucomm`

Source: `lib/tm/tclutils/tucomm-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucomm::compareLines {aLines bLines args}
::tclutils::tucomm::text {aText bText args}
::tclutils::tucomm::files {aFile bFile args}
::tclutils::tucomm::formatColumns {comparison args}
```

## `tucrc`

Source: `lib/tm/tclutils/tucrc-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucrc::hex32 {value}
::tclutils::tucrc::crc32 {data args}
::tclutils::tucrc::adler32 {data args}
::tclutils::tucrc::crc32File {path}
::tclutils::tucrc::adler32File {path}
```

## `tucsplit`

Source: `lib/tm/tclutils/tucsplit-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucsplit::splitText {text pattern args}
::tclutils::tucsplit::file {path pattern args}
```

## `tucsv`

Source: `lib/tm/tclutils/tucsv-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucsv::parseLine {line args}
::tclutils::tucsv::joinLine {fields args}
::tclutils::tucsv::parse {data args}
::tclutils::tucsv::text {rows args}
::tclutils::tucsv::file {path args}
::tclutils::tucsv::dicts {rows args}
::tclutils::tucsv::writeFile {path rows args}
```

## `tucut`

Source: `lib/tm/tclutils/tucut-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tucut::field {line delimiter index}
::tclutils::tucut::fields {line delimiter fieldSpec {joiner {}}}
::tclutils::tucut::chars {line charSpec}
::tclutils::tucut::line {line args}
::tclutils::tucut::text {text args}
::tclutils::tucut::file {path args}
```

## `tudate`

Source: `lib/tm/tclutils/tudate-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tudate::parse {str args}
::tclutils::tudate::iso {seconds args}
::tclutils::tudate::add {seconds count unit}
::tclutils::tudate::diff {a b args}
::tclutils::tudate::relative {seconds args}
::tclutils::tudate::today {}
::tclutils::tudate::zones {}
```

## `tudav`

Source: `lib/tm/tclutils/tudav-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tudav::client {url args}
::tclutils::tudav::configure {c args}
::tclutils::tudav::destroy {c}
```

## `tudeploy`

Source: `lib/tm/tclutils/tudeploy-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tudeploy::baseDirs {}
::tclutils::tudeploy::platformTag {}
::tclutils::tudeploy::roots {args}
::tclutils::tudeploy::addModulePaths {args}
::tclutils::tudeploy::require {packages args}
::tclutils::tudeploy::resourceDirs {name args}
::tclutils::tudeploy::sourceModule {pkg args}
```

## `tudhash`

Source: `lib/tm/tclutils/tudhash-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tudhash::fromGray {w h grayList}
::tclutils::tudhash::fromRGB {w h rgbList}
::tclutils::tudhash::distance {a b}
::tclutils::tudhash::similar {a b {maxDist 10}}
```

## `tudiagram`

Source: `lib/tm/tclutils/tudiagram-0.5.tm`. Limited to `namespace export`.

```tcl
::tclutils::tudiagram::create {args}
::tclutils::tudiagram::setMeta {d args}
::tclutils::tudiagram::addNode {d id args}
::tclutils::tudiagram::addEdge {d from to args}
::tclutils::tudiagram::addGroup {d id args}
::tclutils::tudiagram::validate {d}
::tclutils::tudiagram::layout {d}
```

## `tudict`

Source: `lib/tm/tclutils/tudict-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tudict::getOr {dict default args}
::tclutils::tudict::paths {dict {prefix {}}}
::tclutils::tudict::flatten {dict {sep .}}
::tclutils::tudict::mergeDeep {args}
::tclutils::tudict::invert {dict}
```

## `tudiff`

Source: `lib/tm/tclutils/tudiff-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tudiff::text {oldText newText args}
::tclutils::tudiff::files {oldFile newFile args}
::tclutils::tudiff::unifiedText {oldText newText args}
::tclutils::tudiff::unified {oldFile newFile args}
::tclutils::tudiff::contextText {oldText newText args}
::tclutils::tudiff::context {oldFile newFile args}
::tclutils::tudiff::directory {oldDir newDir args}
```

## `tuer`

Source: `lib/tm/tclutils/tuer-0.3.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuer::parse {text}
```

## `tuevent`

Source: `lib/tm/tclutils/tuevent-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuevent::create {}
::tclutils::tuevent::subscribe {bus event handler}
::tclutils::tuevent::unsubscribe {bus event handler}
::tclutils::tuevent::emit {bus event args}
::tclutils::tuevent::handlers {bus event}
::tclutils::tuevent::events {bus}
::tclutils::tuevent::clear {bus {event ""}}
::tclutils::tuevent::destroy {bus}
```

## `tuexe`

Source: `lib/tm/tclutils/tuexe-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuexe::find {names args}
::tclutils::tuexe::all {names args}
::tclutils::tuexe::exists {names args}
```

## `tuexpand`

Source: `lib/tm/tclutils/tuexpand-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuexpand::expand {text args}
::tclutils::tuexpand::unexpand {text args}
::tclutils::tuexpand::file {path args}
```

## `tufetch`

Source: `lib/tm/tclutils/tufetch-0.4.tm`. Limited to `namespace export`.

```tcl
::tclutils::tufetch::get {url args}
::tclutils::tufetch::download {url path args}
```

## `tufile`

Source: `lib/tm/tclutils/tufile-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tufile::detect {path}
::tclutils::tufile::type {path}
::tclutils::tufile::mime {path}
::tclutils::tufile::describe {path}
::tclutils::tufile::checkExtension {path}
```

## `tufind`

Source: `lib/tm/tclutils/tufind-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tufind::all {args}
::tclutils::tufind::files {args}
::tclutils::tufind::directories {args}
::tclutils::tufind::walk {root patterns callback args}
```

## `tuflow`

Source: `lib/tm/tclutils/tuflow-0.3.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuflow::parse {text args}
::tclutils::tuflow::toSvg {text args}
::tclutils::tuflow::toPng {text args}
::tclutils::tuflow::writeSvg {text file args}
::tclutils::tuflow::writePng {text file args}
```

## `tufmt`

Source: `lib/tm/tclutils/tufmt-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tufmt::reflow {text args}
::tclutils::tufmt::reflowFile {path args}
```

## `tufold`

Source: `lib/tm/tclutils/tufold-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tufold::foldLine {line args}
::tclutils::tufold::text {input args}
::tclutils::tufold::file {path args}
```

## `tufuzzy`

Source: `lib/tm/tclutils/tufuzzy-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tufuzzy::distance {a b args}
::tclutils::tufuzzy::searchDistance {pattern text args}
::tclutils::tufuzzy::similarity {a b args}
::tclutils::tufuzzy::subsequence {pattern text args}
::tclutils::tufuzzy::bestMatch {pattern candidates args}
```

## `tugantt`

Source: `lib/tm/tclutils/tugantt-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tugantt::parse {text}
::tclutils::tugantt::toSvg {model args}
::tclutils::tugantt::toPng {model args}
::tclutils::tugantt::writeSvg {model file args}
::tclutils::tugantt::writePng {model file args}
```

## `tugit`

Source: `lib/tm/tclutils/tugit-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tugit::parse {text}
```

## `tugrep`

Source: `lib/tm/tclutils/tugrep-0.1.3.tm`. Limited to `namespace export`.

```tcl
::tclutils::tugrep::match {line pattern args}
::tclutils::tugrep::search {text pattern args}
::tclutils::tugrep::file {filename pattern args}
::tclutils::tugrep::files {fileList pattern args}
```

## `tuhash`

Source: `lib/tm/tclutils/tuhash-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuhash::sha256 {data args}
::tclutils::tuhash::sha1 {data args}
::tclutils::tuhash::md5 {data args}
::tclutils::tuhash::sha256File {path} { return [_sha256 [::tclutils::common::readBinaryFile $path]] }
::tclutils::tuhash::sha1File {path} { return [_sha1   [::tclutils::common::readBinaryFile $path]] }
::tclutils::tuhash::md5File {path} { return [_md5    [::tclutils::common::readBinaryFile $path]] }
```

## `tuhead`

Source: `lib/tm/tclutils/tuhead-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuhead::text {text {count 10}}
::tclutils::tuhead::file {path {count 10}}
```

## `tuhexdump`

Source: `lib/tm/tclutils/tuhexdump-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuhexdump::data {bytesData args}
::tclutils::tuhexdump::file {filename args}
```

## `tuhexedit`

Source: `lib/tm/tclutils/tuhexedit-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuhexedit::readBytes {filename offset length}
::tclutils::tuhexedit::writeBytes {filename offset bytes {createBackup 1}}
::tclutils::tuhexedit::backup {filename {backupName ""}}
::tclutils::tuhexedit::findHex {filename hex}
::tclutils::tuhexedit::findString {filename text {encoding utf-8}}
::tclutils::tuhexedit::patch {filename offset hex args}
::tclutils::tuhexedit::dump {filename args}
```

## `tuholiday`

Source: `lib/tm/tclutils/tuholiday-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuholiday::easter {year}
::tclutils::tuholiday::holidays {year args}
::tclutils::tuholiday::isHoliday {iso args}
```

## `tuhttps`

Source: `lib/tm/tclutils/tuhttps-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuhttps::caFile {}
::tclutils::tuhttps::socketCmd {args}
::tclutils::tuhttps::with {prefix script}
```

## `tuical`

Source: `lib/tm/tclutils/tuical-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuical::parse {ics}
::tclutils::tuical::toIcs {comps}
::tclutils::tuical::components {comp {type ""}}
::tclutils::tuical::properties {comp {name ""}}
::tclutils::tuical::property {comp name}
::tclutils::tuical::find {comps type}
::tclutils::tuical::events {comps}
```

## `tuico`

Source: `lib/tm/tclutils/tuico-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuico::write {outFile entries}
::tclutils::tuico::info {icoFile}
::tclutils::tuico::extract {icoFile size {outFile ""}}
```

## `tuiconv`

Source: `lib/tm/tclutils/tuiconv-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuiconv::encodings {}
::tclutils::tuiconv::convert {data from to}
::tclutils::tuiconv::readFile {filename encodingName}
::tclutils::tuiconv::writeFile {filename text encodingName}
::tclutils::tuiconv::convertFile {infile outfile from to}
```

## `tuimage`

Source: `lib/tm/tclutils/tuimage-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuimage::type {bytes}
::tclutils::tuimage::mime {bytes}
::tclutils::tuimage::dimensions {bytes}
::tclutils::tuimage::inspect {bytes}
::tclutils::tuimage::dataUri {mimetype bytes}
::tclutils::tuimage::fromDataUri {uri}
```

## `tuini`

Source: `lib/tm/tclutils/tuini-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuini::parse {ini}
::tclutils::tuini::toIni {data}
::tclutils::tuini::sections {data}
::tclutils::tuini::keys {data {section ""}}
::tclutils::tuini::get {data section key {default ""}}
::tclutils::tuini::has {data section key}
::tclutils::tuini::setValue {data section key value}
```

## `tujoin`

Source: `lib/tm/tclutils/tujoin-0.1.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tujoin::lines {leftLines rightLines args}
::tclutils::tujoin::texts {leftText rightText args}
::tclutils::tujoin::files {leftPath rightPath args}
```

## `tujourney`

Source: `lib/tm/tclutils/tujourney-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tujourney::parse {text}
::tclutils::tujourney::toSvg {model args}
::tclutils::tujourney::toPng {model args}
::tclutils::tujourney::writeSvg {model file args}
::tclutils::tujourney::writePng {model file args}
```

## `tujson`

Source: `lib/tm/tclutils/tujson-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tujson::escape {text}
::tclutils::tujson::quote {text}
::tclutils::tujson::minify {json}
::tclutils::tujson::validate {json}
::tclutils::tujson::pretty {json args}
::tclutils::tujson::parse {json}
::tclutils::tujson::fromJson {json}
::tclutils::tujson::parseTyped {json}
::tclutils::tujson::filePretty {infile outfile args}
::tclutils::tujson::fileMinify {infile outfile}
::tclutils::tujson::toJson {typed args}
::tclutils::tujson::str {s} { return [list string $s] }
::tclutils::tujson::num {n}
::tclutils::tujson::bool {b}
::tclutils::tujson::null {} { return [list null {}] }
::tclutils::tujson::obj {pairs} { return [list object $pairs] }
::tclutils::tujson::arr {elems} { return [list array $elems] }
```

## `tukanban`

Source: `lib/tm/tclutils/tukanban-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tukanban::parse {text}
::tclutils::tukanban::toSvg {model args}
::tclutils::tukanban::toPng {model args}
::tclutils::tukanban::writeSvg {model file args}
::tclutils::tukanban::writePng {model file args}
```

## `tulayout`

Source: `lib/tm/tclutils/tulayout-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tulayout::pageSize {paper {orientation portrait}}
::tclutils::tulayout::mmToPx {mm scale}
::tclutils::tulayout::pxToMm {px scale}
::tclutils::tulayout::snap {mm args}
::tclutils::tulayout::mergeBlocks {base preset args}
::tclutils::tulayout::mergeLayout {target preset args}
```

## `tuldif`

Source: `lib/tm/tclutils/tuldif-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuldif::parse {ldif}
::tclutils::tuldif::toLdif {entries}
::tclutils::tuldif::dn {entry}
::tclutils::tuldif::get {entry attr}
::tclutils::tuldif::attributes {entry}
::tclutils::tuldif::toDict {entry}
```

## `tulist`

Source: `lib/tm/tclutils/tulist-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tulist::unique {list}
::tclutils::tulist::flatten {list {depth 1}}
::tclutils::tulist::chunk {list size}
::tclutils::tulist::zip {args}
::tclutils::tulist::sum {list}
::tclutils::tulist::avg {list}
::tclutils::tulist::min {list}
::tclutils::tulist::max {list}
```

## `tulog`

Source: `lib/tm/tclutils/tulog-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tulog::new {args}
::tclutils::tulog::assert {exprStr {msg ""}}
```

## `tumath`

Source: `lib/tm/tclutils/tumath-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tumath::clamp {x lo hi}
::tclutils::tumath::inRange {x lo hi}
::tclutils::tumath::percent {part whole}
::tclutils::tumath::sign {x}
::tclutils::tumath::gcd {a b}
::tclutils::tumath::lcm {a b}
::tclutils::tumath::factorial {n}
::tclutils::tumath::roundTo {x ndigits}
```

## `tumd`

Source: `lib/tm/tclutils/tumd-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tumd::frontmatter {markdown}
::tclutils::tumd::headings {markdown}
::tclutils::tumd::toc {markdown}
::tclutils::tumd::toHtml {markdown}
```

## `tumindmap`

Source: `lib/tm/tclutils/tumindmap-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tumindmap::parse {text}
```

## `tummdb`

Source: `lib/tm/tclutils/tummdb-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tummdb::metadata {h}
::tclutils::tummdb::lookup {h ip}
```

## `tumonthpng`

Source: `lib/tm/tclutils/tumonthpng-0.5.tm`. Limited to `namespace export`.

```tcl
::tclutils::tumonthpng::render {year month args}
::tclutils::tumonthpng::write {file year month args}
::tclutils::tumonthpng::renderQuarter {year month args}
::tclutils::tumonthpng::renderYear {year args}
::tclutils::tumonthpng::writeQuarter {file year month args}
::tclutils::tumonthpng::writeYear {file year args}
```

## `tunl`

Source: `lib/tm/tclutils/tunl-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tunl::text {text args}
::tclutils::tunl::file {path args}
```

## `tunotes`

Source: `lib/tm/tclutils/tunotes-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tunotes::create {storeVar title content {tags {}} {parentId ""}}
::tclutils::tunotes::update {storeVar id title content {tags {}} {parentId KEEP}}
::tclutils::tunotes::delete {storeVar id {cascade 1}}
::tclutils::tunotes::move {storeVar id newParentId}
::tclutils::tunotes::get {store id}
::tclutils::tunotes::exists {store id}
::tclutils::tunotes::roots {store}
::tclutils::tunotes::children {store parentId}
```

## `tunotesdb`

Source: `lib/tm/tclutils/tunotesdb-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tunotesdb::init {db}
::tclutils::tunotesdb::create {db title content {tagList {}} {parentId ""}}
::tclutils::tunotesdb::update {db id title content {tagList {}} {parentId KEEP}}
::tclutils::tunotesdb::get {db id}
::tclutils::tunotesdb::exists {db id}
::tclutils::tunotesdb::delete {db id {cascade 1}}
::tclutils::tunotesdb::move {db id newParentId}
```

## `tunum`

Source: `lib/tm/tclutils/tunum-0.4.tm`. Limited to `namespace export`.

```tcl
::tclutils::tunum::parse {s args}
::tclutils::tunum::isNumber {s}
::tclutils::tunum::format {x args}
::tclutils::tunum::sum {values args}
```

## `tunumany`

Source: `lib/tm/tclutils/tunumany-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tunumany::parse {str args}
```

## `tunumfmt`

Source: `lib/tm/tclutils/tunumfmt-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tunumfmt::toHuman {number args}
::tclutils::tunumfmt::fromHuman {str args}
::tclutils::tunumfmt::text {text args}
::tclutils::tunumfmt::file {path args}
```

## `tuod`

Source: `lib/tm/tclutils/tuod-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuod::bytes {bytesData args}
::tclutils::tuod::data {bytesData args}
::tclutils::tuod::file {filename args}
```

## `tuodf`

Source: `lib/tm/tclutils/tuodf-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuodf::createText {odtFile paragraphs args}
::tclutils::tuodf::part {odtFile name}
::tclutils::tuodf::parts {odtFile}
::tclutils::tuodf::paragraphs {odtFile}
::tclutils::tuodf::text {odtFile}
```

## `tuopen`

Source: `lib/tm/tclutils/tuopen-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuopen::command {target args}
::tclutils::tuopen::launch {target args}
::tclutils::tuopen::editCommand {target args}
::tclutils::tuopen::edit {target args}
::tclutils::tuopen::openDir {target args}
```

## `tupacket`

Source: `lib/tm/tclutils/tupacket-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupacket::parse {text}
::tclutils::tupacket::toSvg {model args}
::tclutils::tupacket::toPng {model args}
::tclutils::tupacket::writeSvg {model file args}
::tclutils::tupacket::writePng {model file args}
```

## `tupagespec`

Source: `lib/tm/tclutils/tupagespec-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupagespec::parse {spec total args}
::tclutils::tupagespec::count {spec total}
::tclutils::tupagespec::compact {pages}
```

## `tupaste`

Source: `lib/tm/tclutils/tupaste-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupaste::lines {lineLists args}
::tclutils::tupaste::texts {textList args}
::tclutils::tupaste::files {paths args}
```

## `tupatch`

Source: `lib/tm/tclutils/tupatch-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupatch::parse {patchText}
::tclutils::tupatch::text {sourceText patchText args}
::tclutils::tupatch::fromFile {sourceFile patchText args}
```

## `tupath`

Source: `lib/tm/tclutils/tupath-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupath::normalize {path}
::tclutils::tupath::clean {path}
::tclutils::tupath::isAbsolute {path}
::tclutils::tupath::components {path}
::tclutils::tupath::join {args}
```

## `tupdf`

Source: `lib/tm/tclutils/tupdf-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupdf::version {pdfFile}
::tclutils::tupdf::objects {pdfFile}
::tclutils::tupdf::object {pdfFile id}
::tclutils::tupdf::trailer {pdfFile}
::tclutils::tupdf::zugferd {pdfFile}
::tclutils::tupdf::metadata {pdfFile}
::tclutils::tupdf::summary {pdfFile}
```

## `tupdftext`

Source: `lib/tm/tclutils/tupdftext-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupdftext::pages {file args}
::tclutils::tupdftext::text {file args}
::tclutils::tupdftext::summary {file}
```

## `tupie`

Source: `lib/tm/tclutils/tupie-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupie::parse {text}
::tclutils::tupie::toSvg {model args}
::tclutils::tupie::toPng {model args}
::tclutils::tupie::writeSvg {model file args}
::tclutils::tupie::writePng {model file args}
```

## `tupkgfinder`

Source: `lib/tm/tclutils/tupkgfinder-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupkgfinder::paths {}
::tclutils::tupkgfinder::versions {packageName}
::tclutils::tupkgfinder::pkgInfo {packageName}
::tclutils::tupkgfinder::which {packageName}
::tclutils::tupkgfinder::findFileSystem {pattern args}
::tclutils::tupkgfinder::report {packageName}
```

## `tupng`

Source: `lib/tm/tclutils/tupng-0.5.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupng::encodeRGB {image args}
::tclutils::tupng::encodeRGBA {image args}
::tclutils::tupng::encodeGray {image args}
::tclutils::tupng::encodeIndexed {palette image args}
```

## `tupngdraw`

Source: `lib/tm/tclutils/tupngdraw-0.13.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupngdraw::new {args}
```

## `tupngpad`

Source: `lib/tm/tclutils/tupngpad-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupngpad::bbox {rgba w h}
::tclutils::tupngpad::trim {rgba w h}
::tclutils::tupngpad::padTo {rgba w h tw th args}
::tclutils::tupngpad::batch {files outdir args}
```

## `tupostgrest`

Source: `lib/tm/tclutils/tupostgrest-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupostgrest::new {baseUrl args}
::tclutils::tupostgrest::token {client jwt}
::tclutils::tupostgrest::request {client method path args}
::tclutils::tupostgrest::get {client table args}
::tclutils::tupostgrest::insert {client table row args}
::tclutils::tupostgrest::update {client table patch args}
::tclutils::tupostgrest::delete {client table args}
::tclutils::tupostgrest::rpc {client fn {args_ {}}}
```

## `tupr`

Source: `lib/tm/tclutils/tupr-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tupr::text {text args}
::tclutils::tupr::file {path args}
```

## `tuprovider`

Source: `lib/tm/tclutils/tuprovider-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuprovider::register {scheme class}
::tclutils::tuprovider::schemes {}
::tclutils::tuprovider::open {scheme args}
```

## `tuquadrant`

Source: `lib/tm/tclutils/tuquadrant-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuquadrant::parse {text}
::tclutils::tuquadrant::toSvg {model args}
::tclutils::tuquadrant::toPng {model args}
::tclutils::tuquadrant::writeSvg {model file args}
::tclutils::tuquadrant::writePng {model file args}
```

## `turadar`

Source: `lib/tm/tclutils/turadar-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::turadar::parse {text}
::tclutils::turadar::toSvg {model args}
::tclutils::turadar::toPng {model args}
::tclutils::turadar::writeSvg {model file args}
::tclutils::turadar::writePng {model file args}
```

## `turegistry`

Source: `lib/tm/tclutils/turegistry-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::turegistry::create {}
::tclutils::turegistry::put {reg key value}
::tclutils::turegistry::get {reg key args}
::tclutils::turegistry::has {reg key}
::tclutils::turegistry::keys {reg {pattern *}}
::tclutils::turegistry::remove {reg key}
::tclutils::turegistry::destroy {reg}
```

## `turequirement`

Source: `lib/tm/tclutils/turequirement-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::turequirement::parse {text}
```

## `turev`

Source: `lib/tm/tclutils/turev-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::turev::line {str}
::tclutils::turev::text {text}
::tclutils::turev::file {path}
```

## `turrule`

Source: `lib/tm/tclutils/turrule-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::turrule::parse {rr}
::tclutils::turrule::occurrences {args}
::tclutils::turrule::eventsInRange {ics fromIso toIso}
```

## `tusankey`

Source: `lib/tm/tclutils/tusankey-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusankey::parse {text}
::tclutils::tusankey::toSvg {model args}
::tclutils::tusankey::toPng {model args}
::tclutils::tusankey::writeSvg {model file args}
::tclutils::tusankey::writePng {model file args}
```

## `tused`

Source: `lib/tm/tclutils/tused-0.1.3.tm`. Limited to `namespace export`.

```tcl
::tclutils::tused::replace {text pattern replacement args}
::tclutils::tused::substitute {line pattern replacement args}
::tclutils::tused::delete {text pattern args}
::tclutils::tused::process {text rules}
::tclutils::tused::processFile {infile outfile rules args}
::tclutils::tused::script {text scriptText}
```

## `tuseq`

Source: `lib/tm/tclutils/tuseq-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuseq::range {args}
::tclutils::tuseq::text {args}
```

## `tusequence`

Source: `lib/tm/tclutils/tusequence-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusequence::parse {text}
::tclutils::tusequence::toSvg {model args}
::tclutils::tusequence::toPng {model args}
::tclutils::tusequence::writeSvg {model file args}
::tclutils::tusequence::writePng {model file args}
```

## `tusettings`

Source: `lib/tm/tclutils/tusettings-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusettings::dir {kind app args}
::tclutils::tusettings::file {app {name settings}}
::tclutils::tusettings::load {app args}
::tclutils::tusettings::save {app settings args}
::tclutils::tusettings::value {settings section key {default ""}}
```

## `tushuf`

Source: `lib/tm/tclutils/tushuf-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tushuf::lines {lineList args}
::tclutils::tushuf::text {text args}
::tclutils::tushuf::file {path args}
```

## `tusize`

Source: `lib/tm/tclutils/tusize-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusize::bytes {path}
::tclutils::tusize::human {n args}
::tclutils::tusize::entries {dir}
```

## `tusort`

Source: `lib/tm/tclutils/tusort-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusort::sortList {items args}
::tclutils::tusort::text {text args}
::tclutils::tusort::file {path args}
```

## `tusparql`

Source: `lib/tm/tclutils/tusparql-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusparql::query {endpoint sparql args}
::tclutils::tusparql::ask {endpoint sparql args}
```

## `tusplit`

Source: `lib/tm/tclutils/tusplit-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusplit::splitLines {text args}
::tclutils::tusplit::splitBytes {data args}
::tclutils::tusplit::file {path args}
::tclutils::tusplit::lines {path n args}
::tclutils::tusplit::bytes {path n args}
```

## `tusqlite`

Source: `lib/tm/tclutils/tusqlite-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusqlite::null {}
::tclutils::tusqlite::quoteId {name}
::tclutils::tusqlite::insert {db table data}
::tclutils::tusqlite::rows {db sql}
::tclutils::tusqlite::value {db sql {default ""}}
```

## `tustat`

Source: `lib/tm/tclutils/tustat-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tustat::file {path}
::tclutils::tustat::files {paths}
::tclutils::tustat::render {statDict args}
```

## `tustate`

Source: `lib/tm/tclutils/tustate-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tustate::parse {text}
```

## `tustr`

Source: `lib/tm/tclutils/tustr-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tustr::isEmpty {s} { return [expr {$s eq ""}] }
::tclutils::tustr::truncate {s maxlen {ellipsis "..."}}
::tclutils::tustr::padLeft {s width {char " "}}
::tclutils::tustr::padRight {s width {char " "}}
::tclutils::tustr::center {s width {char " "}}
```

## `tustrings`

Source: `lib/tm/tclutils/tustrings-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tustrings::extract {data args}
::tclutils::tustrings::file {filename args}
```

## `tusvg`

Source: `lib/tm/tclutils/tusvg-0.3.tm`. Limited to `namespace export`.

```tcl
::tclutils::tusvg::new {args}
```

## `tutable`

Source: `lib/tm/tclutils/tutable-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutable::render {headers rows args}
```

## `tutablepng`

Source: `lib/tm/tclutils/tutablepng-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutablepng::render {rows args}
::tclutils::tutablepng::write {file rows args}
```

## `tutac`

Source: `lib/tm/tclutils/tutac-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutac::lines {lineList}
::tclutils::tutac::text {text}
::tclutils::tutac::file {path}
```

## `tutail`

Source: `lib/tm/tclutils/tutail-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutail::text {text {count 10}}
::tclutils::tutail::file {path {count 10}}
```

## `tutask`

Source: `lib/tm/tclutils/tutask-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutask::await {starter args}
::tclutils::tutask::timer {ms {value ""}}
::tclutils::tutask::sleep {ms}
::tclutils::tutask::onwrite {varName}
::tclutils::tutask::pipe {cmdlist args}
::tclutils::tutask::spawn {args}
::tclutils::tutask::current {}
::tclutils::tutask::run {args}
```

## `tutdbc`

Source: `lib/tm/tclutils/tutdbc-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutdbc::null {}
::tclutils::tutdbc::quoteId {name}
::tclutils::tutdbc::rows {conn sql {binds {}}}
::tclutils::tutdbc::value {conn sql {binds {}} {default ""}}
::tclutils::tutdbc::execute {conn sql {binds {}}}
::tclutils::tutdbc::insert {conn table data}
::tclutils::tutdbc::transaction {conn script}
```

## `tutee`

Source: `lib/tm/tclutils/tutee-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutee::write {data paths args}
::tclutils::tutee::writeFile {inputFile paths args}
::tclutils::tutee::copyChannel {inChan outChans args}
```

## `tuterm`

Source: `lib/tm/tclutils/tuterm-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuterm::style {args}
::tclutils::tuterm::wrap {text args}
::tclutils::tuterm::off {attr}
::tclutils::tuterm::names {{what all}}
::tclutils::tuterm::strip {text}
::tclutils::tuterm::enable {args}
::tclutils::tuterm::auto {}
::tclutils::tuterm::enableVT {}
::tclutils::tuterm::disableVT {}
```

## `tutestrun`

Source: `lib/tm/tclutils/tutestrun-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutestrun::run {dir libs args}
```

## `tutimeline`

Source: `lib/tm/tclutils/tutimeline-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutimeline::parse {text}
::tclutils::tutimeline::toSvg {model args}
::tclutils::tutimeline::toPng {model args}
::tclutils::tutimeline::writeSvg {model file args}
::tclutils::tutimeline::writePng {model file args}
```

## `tutr`

Source: `lib/tm/tclutils/tutr-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutr::translate {text set1 set2}
::tclutils::tutr::delete {text set1}
::tclutils::tutr::squeeze {text set1}
::tclutils::tutr::file {path set1 set2 args}
```

## `tutreemap`

Source: `lib/tm/tclutils/tutreemap-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutreemap::parse {text}
::tclutils::tutreemap::toSvg {model args}
::tclutils::tutreemap::toPng {model args}
::tclutils::tutreemap::writeSvg {model file args}
::tclutils::tutreemap::writePng {model file args}
```

## `tutsort`

Source: `lib/tm/tclutils/tutsort-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tutsort::pairs {tokens}
::tclutils::tutsort::text {text}
::tclutils::tutsort::file {path}
```

## `tuuniq`

Source: `lib/tm/tclutils/tuuniq-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuuniq::uniqList {items args}
::tclutils::tuuniq::adjacentCount {items args}
::tclutils::tuuniq::count {items args}
::tclutils::tuuniq::text {text args}
::tclutils::tuuniq::file {path args}
::tclutils::tuuniq::countText {text args}
::tclutils::tuuniq::countFile {path args}
```

## `tuurl`

Source: `lib/tm/tclutils/tuurl-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuurl::encode {str args}
::tclutils::tuurl::decode {str args}
::tclutils::tuurl::buildQuery {d args}
::tclutils::tuurl::parseQuery {q args}
```

## `tuuuid`

Source: `lib/tm/tclutils/tuuuid-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuuuid::v4 {}
::tclutils::tuuuid::v7 {}
::tclutils::tuuuid::nil {}
::tclutils::tuuuid::generate {args}
::tclutils::tuuuid::validate {uuid}
::tclutils::tuuuid::version {uuid}
```

## `tuvalidate`

Source: `lib/tm/tclutils/tuvalidate-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuvalidate::email {s}
::tclutils::tuvalidate::url {s}
::tclutils::tuvalidate::ipv4 {s}
::tclutils::tuvalidate::port {s}
::tclutils::tuvalidate::alpha {s} { return [regexp {^[A-Za-z]+$} $s] }
::tclutils::tuvalidate::alnum {s} { return [regexp {^[A-Za-z0-9]+$} $s] }
::tclutils::tuvalidate::numeric {s} { return [string is double -strict $s] }
::tclutils::tuvalidate::integer {s} { return [string is integer -strict $s] }
```

## `tuvcard`

Source: `lib/tm/tclutils/tuvcard-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuvcard::parse {vcf}
::tclutils::tuvcard::toVcf {cards}
::tclutils::tuvcard::properties {card {name ""}}
::tclutils::tuvcard::property {card name}
::tclutils::tuvcard::get {card name}
::tclutils::tuvcard::names {card}
::tclutils::tuvcard::fullName {card}
```

## `tuwc`

Source: `lib/tm/tclutils/tuwc-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuwc::text {data}
::tclutils::tuwc::file {filename}
```

## `tuxargs`

Source: `lib/tm/tclutils/tuxargs-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuxargs::batches {items args}
::tclutils::tuxargs::apply {items commandPrefix args}
::tclutils::tuxargs::command {items commandPrefix args}
```

## `tuxml`

Source: `lib/tm/tclutils/tuxml-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuxml::escape {text args}
::tclutils::tuxml::unescape {text}
::tclutils::tuxml::declaration {{encoding UTF-8}}
::tclutils::tuxml::attrs {attributes}
::tclutils::tuxml::tag {name {attributes {}}}
::tclutils::tuxml::element {name attributes content}
::tclutils::tuxml::textElement {name attributes text}
```

## `tuxxhash`

Source: `lib/tm/tclutils/tuxxhash-0.2.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuxxhash::xxh32 {data args}
::tclutils::tuxxhash::xxh32file {path {seed 0}}
```

## `tuxychart`

Source: `lib/tm/tclutils/tuxychart-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuxychart::parse {text}
::tclutils::tuxychart::toSvg {model args}
::tclutils::tuxychart::toPng {model args}
::tclutils::tuxychart::writeSvg {model file args}
::tclutils::tuxychart::writePng {model file args}
```

## `tuzip`

Source: `lib/tm/tclutils/tuzip-0.1.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuzip::entries {zipfile}
::tclutils::tuzip::names {zipfile}
::tclutils::tuzip::readMember {zipfile member}
::tclutils::tuzip::extract {zipfile member outfile}
::tclutils::tuzip::create {zipfile files args}
::tclutils::tuzip::createMembers {zipfile members args}
```

## `tuzipfs`

Source: `lib/tm/tclutils/tuzipfs-0.3.tm`. Limited to `namespace export`.

```tcl
::tclutils::tuzipfs::available {}
::tclutils::tuzipfs::requireAvailable {}
::tclutils::tuzipfs::root {}
::tclutils::tuzipfs::mounts {}
::tclutils::tuzipfs::mount {archive {mountName ""}}
::tclutils::tuzipfs::unmount {mountpoint}
```

