# API catalog: tkutils modules

The catalog lists the procedure signatures of the public commands, in the
order of the source file `lib/tm/tkutils/<module>-<version>.tm`. It is
generated from the tkutils 0.49.0 sources. Options, return values, error
codes and side effects are in the chapters and in `docs/<module>.md`.

Public means: matched by `namespace export`. A signature with `args`
takes options or a variable number of arguments; a pair `{name value}`
is an argument with a default.

Modules with entries: **78** of 79. `tkutltools` has no commands of
its own; it loads the ten `tkutl*` helpers.

## `tkuaction`

Source: `lib/tm/tkutils/tkuaction-0.2.tm`.

```tcl
::tkutils::tkuaction::define {name args}
::tkutils::tkuaction::exists {name}
::tkutils::tkuaction::get {name {key ""}}
::tkutils::tkuaction::names {}
::tkutils::tkuaction::delete {name}
::tkutils::tkuaction::register {name widget}
::tkutils::tkuaction::unregister {name widget}
::tkutils::tkuaction::registerMenu {name menu {index end}}
::tkutils::tkuaction::unregisterMenu {name menu {index ""}}
::tkutils::tkuaction::addMenuItem {menu name}
::tkutils::tkuaction::setEnabled {name enabled {win ""}}
::tkutils::tkuaction::setChecked {name checked}
::tkutils::tkuaction::getEnabled {name {win ""}}
::tkutils::tkuaction::getChecked {name}
::tkutils::tkuaction::toggle {name}
::tkutils::tkuaction::invoke {name}
::tkutils::tkuaction::groupDefine {name actionList}
::tkutils::tkuaction::groupSet {name enabled {win ""}}
::tkutils::tkuaction::groupAdd {name action}
::tkutils::tkuaction::groupList {{name ""}}
::tkutils::tkuaction::reset {}
```

## `tkuballoon`

Source: `lib/tm/tkutils/tkuballoon-0.1.tm`.

```tcl
::tkutils::tkuballoon::configure {args}
::tkutils::tkuballoon::cget {option}
::tkutils::tkuballoon::enable {}
::tkutils::tkuballoon::disable {}
::tkutils::tkuballoon::add {w text args}
::tkutils::tkuballoon::clear {w}
```

## `tkubase64`

Source: `lib/tm/tkutils/tkubase64-0.2.tm`.

```tcl
::tkutils::tkubase64::widget {path args}
::tkutils::tkubase64::setInput {path text}
::tkutils::tkubase64::getInput {path}
::tkutils::tkubase64::getOutput {path}
::tkutils::tkubase64::encode {path}
::tkutils::tkubase64::decode {path}
```

## `tkubind`

Source: `lib/tm/tkutils/tkubind-0.1.tm`.

```tcl
::tkutils::tkubind::platform {{key ""}}
::tkutils::tkubind::accelerator {spec}
::tkutils::tkubind::isEditing {}
::tkutils::tkubind::key {spec script args}
::tkutils::tkubind::unbind {id}
::tkutils::tkubind::context {widget script}
::tkutils::tkubind::doubleClick {widget script}
::tkutils::tkubind::group {cmd args}
::tkutils::tkubind::getInfo {args}
::tkutils::tkubind::clear {}
```

## `tkucal`

Source: `lib/tm/tkutils/tkucal-0.1.tm`.

```tcl
::tkutils::tkucal::widget {path args}
::tkutils::tkucal::setMonth {path year month}
::tkutils::tkucal::getMonth {path}
::tkutils::tkucal::next {path}
::tkutils::tkucal::prev {path}
::tkutils::tkucal::today {path}
::tkutils::tkucal::getText {path}
```

## `tkucalc`

Source: `lib/tm/tkutils/tkucalc-0.2.tm`.

```tcl
::tkutils::tkucalc::evaluate {text}
::tkutils::tkucalc::widget {path args}
::tkutils::tkucalc::getHistory {path}
::tkutils::tkucalc::clearHistory {path}
::tkutils::tkucalc::clear {path}
```

## `tkucalendar`

Source: `lib/tm/tkutils/tkucalendar-0.2.tm`.

```tcl
::tkutils::tkucalendar::widget {path args}
::tkutils::tkucalendar::getDate {path}
::tkutils::tkucalendar::getFormatted {path}
::tkutils::tkucalendar::setDate {path iso}
::tkutils::tkucalendar::today {path}
::tkutils::tkucalendar::next {path}
::tkutils::tkucalendar::prev {path}
::tkutils::tkucalendar::getMonth {path}
```

## `tkucanvaspng`

Source: `lib/tm/tkutils/tkucanvaspng-0.2.tm`.

```tcl
::tkutils::tkucanvaspng::render {canvas args}
::tkutils::tkucanvaspng::write {file canvas args}
```

## `tkucontextmenu`

Source: `lib/tm/tkutils/tkucontextmenu-0.1.tm`.

```tcl
::tkutils::tkucontextmenu::create {path args}
::tkutils::tkucontextmenu::addItem {menu label args}
::tkutils::tkucontextmenu::addSeparator {menu}
::tkutils::tkucontextmenu::addSubmenu {menu label submenu}
::tkutils::tkucontextmenu::addCheckItem {menu label args}
::tkutils::tkucontextmenu::addRadioItem {menu label args}
::tkutils::tkucontextmenu::attach {menu widget args}
::tkutils::tkucontextmenu::detach {menu widget}
::tkutils::tkucontextmenu::show {menu x y}
::tkutils::tkucontextmenu::enable {menu label}
::tkutils::tkucontextmenu::disable {menu label}
::tkutils::tkucontextmenu::setCallback {menu label command}
::tkutils::tkucontextmenu::setUpdateHandler {menu handler}
::tkutils::tkucontextmenu::destroyMenu {menu}
::tkutils::tkucontextmenu::createStandardEdit {path args}
::tkutils::tkucontextmenu::createFromSpec {path spec}
```

## `tkucsv`

Source: `lib/tm/tkutils/tkucsv-0.1.tm`.

```tcl
::tkutils::tkucsv::widget {path args}
::tkutils::tkucsv::setData {path csvText args}
::tkutils::tkucsv::loadFile {path filename args}
::tkutils::tkucsv::getRows {path}
```

## `tkudateentry`

Source: `lib/tm/tkutils/tkudateentry-0.1.tm`.

```tcl
::tkutils::tkudateentry::widget {path args}
::tkutils::tkudateentry::getText {path}
::tkutils::tkudateentry::getDate {path}
::tkutils::tkudateentry::setDate {path iso}
::tkutils::tkudateentry::today {path}
::tkutils::tkudateentry::clear {path}
```

## `tkudavaccount`

Source: `lib/tm/tkutils/tkudavaccount-0.1.tm`.

```tcl
::tkutils::tkudavaccount::widget {path args}
::tkutils::tkudavaccount::getConfig {path}
::tkutils::tkudavaccount::setConfig {path cfg}
::tkutils::tkudavaccount::clear {path}
::tkutils::tkudavaccount::focusUrl {path}
::tkutils::tkudavaccount::testConnection {path}
```

## `tkudavbrowser`

Source: `lib/tm/tkutils/tkudavbrowser-0.2.tm`.

```tcl
::tkutils::tkudavbrowser::widget {path args}
::tkutils::tkudavbrowser::treeWidget {path}
::tkutils::tkudavbrowser::setClient {path client}
::tkutils::tkudavbrowser::refresh {path args}
::tkutils::tkudavbrowser::setData {path cols}
::tkutils::tkudavbrowser::collections {path}
::tkutils::tkudavbrowser::selected {path}
::tkutils::tkudavbrowser::createCalendar {path displayname}
::tkutils::tkudavbrowser::createAddressbook {path displayname}
::tkutils::tkudavbrowser::deleteCollection {path {href ""}}
```

## `tkudhash`

Source: `lib/tm/tkutils/tkudhash-0.1.tm`.

```tcl
::tkutils::tkudhash::fromFile {path args}
::tkutils::tkudhash::distance {a b}
::tkutils::tkudhash::similar {a b {maxDist 10}}
::tkutils::tkudhash::similarFiles {pathA pathB {maxDist 10}}
```

## `tkudialog`

Source: `lib/tm/tkutils/tkudialog-0.3.tm`.

```tcl
::tkutils::tkudialog::choose {win id}
::tkutils::tkudialog::build {win args}
::tkutils::tkudialog::getText {win}
::tkutils::tkudialog::getDetail {win}
::tkutils::tkudialog::result {win}
::tkutils::tkudialog::copyText {win}
::tkutils::tkudialog::show {win args}
::tkutils::tkudialog::showInfo {message args}
::tkutils::tkudialog::showWarning {message args}
::tkutils::tkudialog::showError {message args}
::tkutils::tkudialog::confirm {message args}
::tkutils::tkudialog::input {args}
::tkutils::tkudialog::form {fieldspec args}
```

## `tkudiff`

Source: `lib/tm/tkutils/tkudiff-0.1.tm`.

```tcl
::tkutils::tkudiff::widget {path args}
::tkutils::tkudiff::setTexts {path oldText newText args}
::tkutils::tkudiff::loadFiles {path oldFile newFile args}
::tkutils::tkudiff::getOps {path}
```

## `tkueditor`

Source: `lib/tm/tkutils/tkueditor-0.4.tm`.

```tcl
::tkutils::tkueditor::widget {path args}
::tkutils::tkueditor::toolbarWidget {path}
::tkutils::tkueditor::statusbarWidget {path}
::tkutils::tkueditor::setStatus {path text}
::tkutils::tkueditor::refreshStatus {path}
::tkutils::tkueditor::setText {path text}
::tkutils::tkueditor::getText {path}
::tkutils::tkueditor::loadFile {path filename args}
::tkutils::tkueditor::saveFile {path args}
::tkutils::tkueditor::currentFile {path}
::tkutils::tkueditor::encoding {path args}
::tkutils::tkueditor::eol {path args}
::tkutils::tkueditor::find {path needle args}
::tkutils::tkueditor::findAll {path needle args}
::tkutils::tkueditor::findNext {path needle args}
::tkutils::tkueditor::replace {path needle repl args}
::tkutils::tkueditor::highlightAll {path needle args}
::tkutils::tkueditor::clearHighlight {path args}
::tkutils::tkueditor::gotoLine {path n}
::tkutils::tkueditor::cursor {path}
::tkutils::tkueditor::readonly {path args}
::tkutils::tkueditor::isModified {path}
::tkutils::tkueditor::menuWidget {path}
::tkutils::tkueditor::addMenuItem {path label command}
::tkutils::tkueditor::addMenuSeparator {path}
::tkutils::tkueditor::selectAll {path}
```

## `tkufiledialog`

Source: `lib/tm/tkutils/tkufiledialog-0.2.tm`.

```tcl
::tkutils::tkufiledialog::open {args}
::tkutils::tkufiledialog::save {args}
::tkutils::tkufiledialog::directory {args}
```

## `tkufilelist`

Source: `lib/tm/tkutils/tkufilelist-0.2.tm`.

```tcl
::tkutils::tkufilelist::widget {path args}
::tkutils::tkufilelist::setDir {path dir}
::tkutils::tkufilelist::refresh {path}
::tkutils::tkufilelist::setFilter {path glob}
::tkutils::tkufilelist::dir {path}
::tkutils::tkufilelist::selectedEntry {path}
::tkutils::tkufilelist::selectedEntries {path}
```

## `tkufiletree`

Source: `lib/tm/tkutils/tkufiletree-0.2.tm`.

```tcl
::tkutils::tkufiletree::widget {path args}
::tkutils::tkufiletree::setRoot {path dir}
::tkutils::tkufiletree::refresh {path}
::tkutils::tkufiletree::refreshDir {path dir}
::tkutils::tkufiletree::up {path}
::tkutils::tkufiletree::selectedPath {path}
::tkutils::tkufiletree::treeview {path}
::tkutils::tkufiletree::root {path}
::tkutils::tkufiletree::reveal {path target}
```

## `tkufilterbar`

Source: `lib/tm/tkutils/tkufilterbar-0.2.tm`.

```tcl
::tkutils::tkufilterbar::widget {path args}
::tkutils::tkufilterbar::setColumns {path cols}
::tkutils::tkufilterbar::columns {path}
::tkutils::tkufilterbar::getFilters {path}
::tkutils::tkufilterbar::getFilter {path col}
::tkutils::tkufilterbar::setFilter {path col text}
::tkutils::tkufilterbar::clear {path}
::tkutils::tkufilterbar::focusFirst {path}
```

## `tkuform`

Source: `lib/tm/tkutils/tkuform-0.1.tm`.

```tcl
::tkutils::tkuform::widget {path fieldspec args}
::tkutils::tkuform::get {path name}
::tkutils::tkuform::setField {path name value}
::tkutils::tkuform::fieldNames {path}
::tkutils::tkuform::values {path}
::tkutils::tkuform::setValues {path dict}
::tkutils::tkuform::widgetOf {path name}
```

## `tkufuzzy`

Source: `lib/tm/tkutils/tkufuzzy-0.1.tm`.

```tcl
::tkutils::tkufuzzy::widget {path args}
::tkutils::tkufuzzy::setItems {path items}
::tkutils::tkufuzzy::filter {path pattern}
::tkutils::tkufuzzy::getMatches {path}
::tkutils::tkufuzzy::getSelection {path}
```

## `tkugeometry`

Source: `lib/tm/tkutils/tkugeometry-0.1.tm`.

```tcl
::tkutils::tkugeometry::key {w}
::tkutils::tkugeometry::save {w app args}
::tkutils::tkugeometry::restore {w app args}
::tkutils::tkugeometry::track {w app args}
```

## `tkuhexedit`

Source: `lib/tm/tkutils/tkuhexedit-0.2.tm`.

```tcl
::tkutils::tkuhexedit::widget {path args}
::tkutils::tkuhexedit::setData {path data}
::tkutils::tkuhexedit::getData {path}
::tkutils::tkuhexedit::loadFile {path filename}
::tkutils::tkuhexedit::saveFile {path {filename ""}}
::tkutils::tkuhexedit::render {path {startOffset 0}}
::tkutils::tkuhexedit::gotoOffset {path offset}
::tkutils::tkuhexedit::findText {path pattern {start 0}}
::tkutils::tkuhexedit::findHex {path hex {start 0}}
::tkutils::tkuhexedit::patchHex {path offset hex}
```

## `tkuical`

Source: `lib/tm/tkutils/tkuical-0.3.tm`.

```tcl
::tkutils::tkuical::widget {path args}
::tkutils::tkuical::treeWidget {path}
::tkutils::tkuical::loadText {path ics}
::tkutils::tkuical::loadFile {path file}
::tkutils::tkuical::setComponents {path comps}
::tkutils::tkuical::events {path}
::tkutils::tkuical::count {path}
::tkutils::tkuical::addEvent {path {summary ""}}
::tkutils::tkuical::removeEvent {path index}
::tkutils::tkuical::setField {path index field value}
::tkutils::tkuical::setEventProperty {path index name value {params {}}}
::tkutils::tkuical::addEventProperty {path index name value {params {}}}
::tkutils::tkuical::removeEventProperty {path index name}
::tkutils::tkuical::toText {path}
::tkutils::tkuical::save {path file}
```

## `tkuicon`

Source: `lib/tm/tkutils/tkuicon-0.1.tm`.

```tcl
::tkutils::tkuicon::hassvg {}
::tkutils::tkuicon::load {filename args}
::tkutils::tkuicon::create {iconName size args}
::tkutils::tkuicon::rescale {imgName newHeight}
::tkutils::tkuicon::available {}
::tkutils::tkuicon::clearCache {}
::tkutils::tkuicon::loadToolbarSet {size args}
```

## `tkuimage`

Source: `lib/tm/tkutils/tkuimage-0.2.tm`.

```tcl
::tkutils::tkuimage::fit {imgW imgH boxW boxH {mode contain}}
::tkutils::tkuimage::load {file {dst ""}}
::tkutils::tkuimage::fromData {bytes {dst ""}}
::tkutils::tkuimage::scale {src w h {dst ""}}
::tkutils::tkuimage::thumbnail {src maxSize {dst ""}}
::tkutils::tkuimage::view {path args}
::tkutils::tkuimage::openFile {path file}
::tkutils::tkuimage::getImage {path}
::tkutils::tkuimage::zoomLevel {path}
::tkutils::tkuimage::zoomIn {path}
::tkutils::tkuimage::zoomOut {path}
::tkutils::tkuimage::zoom1 {path}
::tkutils::tkuimage::fitView {path}
```

## `tkuini`

Source: `lib/tm/tkutils/tkuini-0.3.tm`.

```tcl
::tkutils::tkuini::widget {path args}
::tkutils::tkuini::sectionWidget {path}
::tkutils::tkuini::treeWidget {path}
::tkutils::tkuini::loadText {path ini}
::tkutils::tkuini::loadFile {path file}
::tkutils::tkuini::setData {path d}
::tkutils::tkuini::selectSection {path section}
::tkutils::tkuini::data {path}
::tkutils::tkuini::sections {path}
::tkutils::tkuini::currentSection {path}
::tkutils::tkuini::count {path}
::tkutils::tkuini::setKey {path section key value}
::tkutils::tkuini::removeKey {path section key}
::tkutils::tkuini::addSection {path section}
::tkutils::tkuini::removeSection {path section}
::tkutils::tkuini::toText {path}
::tkutils::tkuini::save {path file}
```

## `tkujson`

Source: `lib/tm/tkutils/tkujson-0.1.tm`.

```tcl
::tkutils::tkujson::widget {path args}
::tkutils::tkujson::setJson {path jsonText}
::tkutils::tkujson::loadFile {path filename}
::tkutils::tkujson::getTree {path}
```

## `tkukeynav`

Source: `lib/tm/tkutils/tkukeynav-0.1.tm`.

```tcl
::tkutils::tkukeynav::next {w}
::tkutils::tkukeynav::prev {w}
::tkutils::tkukeynav::enable {w args}
::tkutils::tkukeynav::disable {w}
::tkutils::tkukeynav::form {container args}
```

## `tkulabeled`

Source: `lib/tm/tkutils/tkulabeled-0.1.tm`.

```tcl
::tkutils::tkulabeled::add {path type args}
::tkutils::tkulabeled::value {path args}
::tkutils::tkulabeled::control {path}
::tkutils::tkulabeled::labelwidget {path}
::tkutils::tkulabeled::configure {path args}
```

## `tkulauncher`

Source: `lib/tm/tkutils/tkulauncher-0.4.tm`.

```tcl
::tkutils::tkulauncher::widget {path args}
::tkutils::tkulauncher::available {entry}
::tkutils::tkulauncher::resolve {entry}
::tkutils::tkulauncher::load {file}
::tkutils::tkulauncher::reload {path}
::tkutils::tkulauncher::editConfig {path}
::tkutils::tkulauncher::openLocation {path}
::tkutils::tkulauncher::saveEntries {items file}
::tkutils::tkulauncher::showCalendar {path}
::tkutils::tkulauncher::showCalculator {path}
::tkutils::tkulauncher::editEntries {path}
::tkutils::tkulauncher::systemTitle {id}
::tkutils::tkulauncher::resolveSystem {id args}
::tkutils::tkulauncher::systemItems {args}
::tkutils::tkulauncher::systemIds {}
```

## `tkulayoutcanvas`

Source: `lib/tm/tkutils/tkulayoutcanvas-0.1.tm`.

```tcl
::tkutils::tkulayoutcanvas::widget {path args}
::tkutils::tkulayoutcanvas::configure {path args}
::tkutils::tkulayoutcanvas::cget {path opt}
::tkutils::tkulayoutcanvas::getCanvas {path}
::tkutils::tkulayoutcanvas::getBlocks {path}
::tkutils::tkulayoutcanvas::setBlocks {path blocks}
::tkutils::tkulayoutcanvas::select {path id}
::tkutils::tkulayoutcanvas::mergePreset {path preset args}
::tkutils::tkulayoutcanvas::redraw {path}
```

## `tkuldif`

Source: `lib/tm/tkutils/tkuldif-0.3.tm`.

```tcl
::tkutils::tkuldif::widget {path args}
::tkutils::tkuldif::treeWidget {path}
::tkutils::tkuldif::loadText {path ldif}
::tkutils::tkuldif::loadFile {path file}
::tkutils::tkuldif::setEntries {path entries}
::tkutils::tkuldif::entries {path}
::tkutils::tkuldif::count {path}
::tkutils::tkuldif::addEntry {path {dn "cn=New"}}
::tkutils::tkuldif::removeEntry {path index}
::tkutils::tkuldif::addAttr {path entryIndex attr value}
::tkutils::tkuldif::setAttr {path entryIndex pairIndex attr value}
::tkutils::tkuldif::removeAttr {path entryIndex pairIndex}
::tkutils::tkuldif::toText {path}
::tkutils::tkuldif::save {path file}
```

## `tkuload`

Source: `lib/tm/tkutils/tkuload-0.3.tm`.

```tcl
::tkuload::build {parent spec}
::tkuload::buildFromFile {parent path}
::tkuload::slot {ui name}
::tkuload::widgetByName {ui name}
::tkuload::setValue {ui name value}
::tkuload::getValue {ui name}
::tkuload::fill {ui data}
::tkuload::collect {ui {names ""}}
```

## `tkumarquee`

Source: `lib/tm/tkutils/tkumarquee-0.1.tm`.

```tcl
::tkutils::tkumarquee::enable {c args}
::tkutils::tkumarquee::disable {c}
::tkutils::tkumarquee::region {c}
::tkutils::tkumarquee::active {c}
```

## `tkumd`

Source: `lib/tm/tkutils/tkumd-0.1.tm`.

```tcl
::tkutils::tkumd::widget {path args}
::tkutils::tkumd::setMarkdown {path markdown}
::tkutils::tkumd::loadFile {path filename}
::tkutils::tkumd::getHeadings {path}
```

## `tkumdview`

Source: `lib/tm/tkutils/tkumdview-0.1.tm`.

```tcl
::tkutils::tkumdview::widget {path args}
::tkutils::tkumdview::tocWidget {path}
::tkutils::tkumdview::textWidget {path}
::tkutils::tkumdview::getMarkdown {path}
::tkutils::tkumdview::headings {path}
::tkutils::tkumdview::toHtml {path}
::tkutils::tkumdview::loadFile {path filename}
::tkutils::tkumdview::setMarkdown {path md}
```

## `tkumonthcanvas`

Source: `lib/tm/tkutils/tkumonthcanvas-0.5.tm`.

```tcl
```

## `tkunotes`

Source: `lib/tm/tkutils/tkunotes-0.4.tm`.

```tcl
::tkutils::tkunotes::widget {path args}
::tkutils::tkunotes::store {path}
::tkutils::tkunotes::count {path}
::tkutils::tkunotes::current {path}
::tkutils::tkunotes::treeWidget {path}
::tkutils::tkunotes::refresh {path}
::tkutils::tkunotes::select {path id}
::tkutils::tkunotes::addRoot {path title content {tags {}}}
::tkutils::tkunotes::addChild {path parentId title content {tags {}}}
::tkutils::tkunotes::delete {path id {cascade 1}}
::tkutils::tkunotes::search {path query}
::tkutils::tkunotes::move {path id newParentId}
::tkutils::tkunotes::load {path file}
::tkutils::tkunotes::save {path {file ""}}
::tkutils::tkunotes::expandAll {path}
::tkutils::tkunotes::collapseAll {path}
::tkutils::tkunotes::tags {path}
::tkutils::tkunotes::byTag {path tag}
::tkutils::tkunotes::addTag {path id tag}
::tkutils::tkunotes::removeTag {path id tag}
::tkutils::tkunotes::subtree {path id}
::tkutils::tkunotes::saveSubtree {path id file}
```

## `tkunumentry`

Source: `lib/tm/tkutils/tkunumentry-0.1.tm`.

```tcl
::tkutils::tkunumentry::widget {path args}
::tkutils::tkunumentry::getValue {path}
::tkutils::tkunumentry::setValue {path value}
::tkutils::tkunumentry::clear {path}
```

## `tkuopts`

Source: `lib/tm/tkutils/tkuopts-0.1.tm`.

```tcl
::tkutils::tkuopts::merge {mod defaults argv}
```

## `tkupath`

Source: `lib/tm/tkutils/tkupath-0.3.tm`.

```tcl
::tkutils::tkupath::widget {path args}
::tkutils::tkupath::setPath {path p}
::tkutils::tkupath::getPath {path}
```

## `tkupdfinspect`

Source: `lib/tm/tkutils/tkupdfinspect-0.1.tm`.

```tcl
::tkutils::tkupdfinspect::widget {path args}
::tkutils::tkupdfinspect::treeWidget {path}
::tkutils::tkupdfinspect::textWidget {path}
::tkutils::tkupdfinspect::currentFile {path}
::tkutils::tkupdfinspect::summary {path}
::tkutils::tkupdfinspect::loadFile {path filename}
```

## `tkupreview`

Source: `lib/tm/tkutils/tkupreview-0.2.tm`.

```tcl
::tkutils::tkupreview::widget {path}
::tkutils::tkupreview::text {path title content}
::tkutils::tkupreview::markdown {path title content}
::tkutils::tkupreview::message {path msg}
::tkutils::tkupreview::html {path title content}
::tkutils::tkupreview::json {path title content}
::tkutils::tkupreview::xml {path title content}
::tkutils::tkupreview::ini {path title content}
::tkutils::tkupreview::hex {path title data}
::tkutils::tkupreview::csv {path title content args}
::tkutils::tkupreview::photo {path title img}
::tkutils::tkupreview::sqlite {path title file}
::tkutils::tkupreview::image {path title file}
::tkutils::tkupreview::pdf {path title file}
::tkutils::tkupreview::clear {path}
::tkutils::tkupreview::kind {path}
```

## `tkurender`

Source: `lib/tm/tkutils/tkurender-0.2.tm`.

```tcl
::tkurender::isContainer {type}
::tkurender::optspecOf {type}
::tkurender::labelOf {type}
::tkurender::pkgFor {type}
::tkurender::pkgAvail {type}
::tkurender::newModel {}
::tkurender::addNode {type parent {internal 0}}
::tkurender::deleteNode {id}
::tkurender::nodeType {id}
::tkurender::nodeOpt {id o}
::tkurender::setOpt {id o v}
::tkurender::nodeGeom {id k}
::tkurender::setGeom {id k v}
::tkurender::nodeLayout {id}
::tkurender::setLayout {id v}
::tkurender::nodeName {id}
::tkurender::setName {id v}
::tkurender::setStretch {id which v}
::tkurender::renderChildren {mid tkparent pv}
::tkurender::serialize {}
::tkurender::deserialize {spec}
```

## `tkuscrolledframe`

Source: `lib/tm/tkutils/tkuscrolledframe-0.1.tm`.

```tcl
::tkutils::tkuscrolledframe::widget {path args}
::tkutils::tkuscrolledframe::content {path}
::tkutils::tkuscrolledframe::scrollableframe {path}
::tkutils::tkuscrolledframe::scrollarea {path}
::tkutils::tkuscrolledframe::configure {path args}
::tkutils::tkuscrolledframe::see {path w {corner nw}}
::tkutils::tkuscrolledframe::seerect {path x1 y1 x2 y2 {corner nw}}
::tkutils::tkuscrolledframe::xview {path args}
::tkutils::tkuscrolledframe::yview {path args}
::tkutils::tkuscrolledframe::autosize {path dimensions}
::tkutils::tkuscrolledframe::autofillx {path boolean}
::tkutils::tkuscrolledframe::autofilly {path boolean}
```

## `tkusearchbar`

Source: `lib/tm/tkutils/tkusearchbar-0.1.tm`.

```tcl
::tkutils::tkusearchbar::widget {path args}
::tkutils::tkusearchbar::getText {path}
::tkutils::tkusearchbar::setText {path text}
::tkutils::tkusearchbar::clear {path}
::tkutils::tkusearchbar::getFilter {path}
::tkutils::tkusearchbar::setFilter {path value}
::tkutils::tkusearchbar::setFilters {path filters}
::tkutils::tkusearchbar::focusSearch {path}
```

## `tkusqlite`

Source: `lib/tm/tkutils/tkusqlite-0.1.tm`.

```tcl
::tkutils::tkusqlite::widget {path args}
::tkutils::tkusqlite::openFile {path dbfile}
::tkutils::tkusqlite::tables {path}
::tkutils::tkusqlite::showTable {path table}
::tkutils::tkusqlite::getRows {path}
::tkutils::tkusqlite::closeDb {path}
```

## `tkustatus`

Source: `lib/tm/tkutils/tkustatus-0.2.tm`.

```tcl
::tkutils::tkustatus::widget {path args}
::tkutils::tkustatus::setText {path text}
::tkutils::tkustatus::getText {path}
::tkutils::tkustatus::addField {path id args}
::tkutils::tkustatus::setField {path id text}
::tkutils::tkustatus::fieldText {path id}
::tkutils::tkustatus::progress {path {value ""}}
::tkutils::tkustatus::flash {path text {ms 2000}}
```

## `tkustrings`

Source: `lib/tm/tkutils/tkustrings-0.1.tm`.

```tcl
::tkutils::tkustrings::widget {path args}
::tkutils::tkustrings::setData {path data args}
::tkutils::tkustrings::loadFile {path filename args}
::tkutils::tkustrings::getStrings {path}
```

## `tkusysinfo`

Source: `lib/tm/tkutils/tkusysinfo-0.1.tm`.

```tcl
::tkutils::tkusysinfo::widget {path args}
::tkutils::tkusysinfo::screen {win}
::tkutils::tkusysinfo::refresh {path}
::tkutils::tkusysinfo::data {path}
::tkutils::tkusysinfo::report {path args}
::tkutils::tkusysinfo::json {path}
::tkutils::tkusysinfo::save {path file args}
```

## `tkutab`

Source: `lib/tm/tkutils/tkutab-0.2.tm`.

```tcl
::tkutils::tkutab::widget {path args}
::tkutils::tkutab::add {path label}
::tkutils::tkutab::close {path f}
::tkutils::tkutab::current {path}
::tkutils::tkutab::setLabel {path f label}
::tkutils::tkutab::tabs {path}
::tkutils::tkutab::count {path}
```

## `tkutablelist`

Source: `lib/tm/tkutils/tkutablelist-0.5.tm`.

```tcl
::tkutils::tkutablelist::widget {path args}
::tkutils::tkutablelist::footerWidget {path}
::tkutils::tkutablelist::footerSet {path values}
::tkutils::tkutablelist::footerSum {path args}
::tkutils::tkutablelist::tableWidget {path}
::tkutils::tkutablelist::insert {path row {id ""}}
::tkutils::tkutablelist::setRows {path rows args}
::tkutils::tkutablelist::rowId {path index}
::tkutils::tkutablelist::findId {path id}
::tkutils::tkutablelist::selectedIds {path}
::tkutils::tkutablelist::selectIds {path ids}
::tkutils::tkutablelist::rows {path}
::tkutils::tkutablelist::clear {path}
::tkutils::tkutablelist::size {path}
::tkutils::tkutablelist::getRow {path index}
::tkutils::tkutablelist::setRow {path index row}
::tkutils::tkutablelist::deleteRow {path index}
::tkutils::tkutablelist::cellText {path row col}
::tkutils::tkutablelist::setCell {path row col value}
::tkutils::tkutablelist::setColumns {path titles}
::tkutils::tkutablelist::columns {path}
::tkutils::tkutablelist::configureColumn {path col args}
::tkutils::tkutablelist::configureRow {path row args}
::tkutils::tkutablelist::configureCell {path cell args}
::tkutils::tkutablelist::insertChild {path parent values {index end}}
::tkutils::tkutablelist::expand {path {row ""}}
::tkutils::tkutablelist::collapse {path {row ""}}
::tkutils::tkutablelist::selection {path}
::tkutils::tkutablelist::selectedRows {path}
::tkutils::tkutablelist::selectRows {path indices}
::tkutils::tkutablelist::sortBy {path col {order -increasing}}
::tkutils::tkutablelist::loadCsv {path csv args}
::tkutils::tkutablelist::fromNotes {path store args}
::tkutils::tkutablelist::editEndCommand {path cmd}
::tkutils::tkutablelist::selectCommand {path args}
::tkutils::tkutablelist::doubleCommand {path args}
::tkutils::tkutablelist::toCsv {path args}
::tkutils::tkutablelist::saveCsv {path file args}
```

## `tkutags`

Source: `lib/tm/tkutils/tkutags-0.1.tm`.

```tcl
::tkutils::tkutags::widget {path args}
::tkutils::tkutags::getTags {path}
::tkutils::tkutags::setTags {path tags}
::tkutils::tkutags::addTag {path tag}
::tkutils::tkutags::removeTag {path tag}
::tkutils::tkutags::clear {path}
```

## `tkutical`

Source: `lib/tm/tkutils/tkutical-0.4.tm`.

```tcl
::tkutils::tkutical::widget {path args}
::tkutils::tkutical::refresh {path}
::tkutils::tkutical::setView {path view}
::tkutils::tkutical::getView {path}
::tkutils::tkutical::setDate {path iso}
::tkutils::tkutical::getDate {path}
::tkutils::tkutical::setMonth {path year month}
::tkutils::tkutical::getMonth {path}
::tkutils::tkutical::next {path}
::tkutils::tkutical::prev {path}
::tkutils::tkutical::today {path}
::tkutils::tkutical::selectMode {path mode}
::tkutils::tkutical::getSelection {path}
::tkutils::tkutical::setSelection {path dates}
::tkutils::tkutical::clearSelection {path}
::tkutils::tkutical::canvasWidget {path}
::tkutils::tkutical::setEvents {path events}
::tkutils::tkutical::getEvents {path}
```

## `tkutimeentry`

Source: `lib/tm/tkutils/tkutimeentry-0.1.tm`.

```tcl
::tkutils::tkutimeentry::widget {path args}
::tkutils::tkutimeentry::getTime {path}
::tkutils::tkutimeentry::setTime {path str}
```

## `tkutlclip`

Source: `lib/tm/tkutils/tkutlclip-0.3.tm`.

```tcl
::tkutils::tkutlclip::asText {tbl rows args}
::tkutils::tkutlclip::copySelection {tbl args}
::tkutils::tkutlclip::copyAll {tbl args}
::tkutils::tkutlclip::installBindings {tbl args}
```

## `tkutldrag`

Source: `lib/tm/tkutils/tkutldrag-0.1.tm`.

```tcl
::tkutils::tkutldrag::enable {tbl args}
::tkutils::tkutldrag::disable {tbl}
::tkutils::tkutldrag::order {tbl {parent root}}
```

## `tkutlfilter`

Source: `lib/tm/tkutils/tkutlfilter-0.1.tm`.

```tcl
::tkutils::tkutlfilter::filter {tbl query args}
::tkutils::tkutlfilter::clear {tbl}
::tkutils::tkutlfilter::query {tbl}
::tkutils::tkutlfilter::later {tbl ms query args}
```

## `tkutlfind`

Source: `lib/tm/tkutils/tkutlfind-0.3.tm`.

```tcl
::tkutils::tkutlfind::find {tbl query args}
::tkutils::tkutlfind::matches {tbl}
::tkutils::tkutlfind::next {tbl}
::tkutils::tkutlfind::prev {tbl}
::tkutils::tkutlfind::clear {tbl}
```

## `tkutlfmt`

Source: `lib/tm/tkutils/tkutlfmt-0.3.tm`.

```tcl
::tkutils::tkutlfmt::column {tbl col type args}
::tkutils::tkutlfmt::columns {tbl spec}
```

## `tkutlfooter`

Source: `lib/tm/tkutils/tkutlfooter-0.4.tm`.

```tcl
::tkutils::tkutlfooter::attach {tbl foot args}
::tkutils::tkutlfooter::detach {tbl foot}
::tkutils::tkutlfooter::setvals {foot values}
::tkutils::tkutlfooter::update {tbl foot}
::tkutils::tkutlfooter::autosum {tbl foot args}
```

## `tkutlgroup`

Source: `lib/tm/tkutils/tkutlgroup-0.1.tm`.

```tcl
::tkutils::tkutlgroup::group {tbl rows keyCol args}
::tkutils::tkutlgroup::ungroup {tbl}
```

## `tkutlsort`

Source: `lib/tm/tkutils/tkutlsort-0.3.tm`.

```tcl
::tkutils::tkutlsort::column {tbl col type args}
::tkutils::tkutlsort::columns {tbl spec args}
```

## `tkutlstate`

Source: `lib/tm/tkutils/tkutlstate-0.4.tm`.

```tcl
::tkutils::tkutlstate::save {tbl}
::tkutils::tkutlstate::restore {tbl state}
::tkutils::tkutlstate::saveToFile {tbl path}
::tkutils::tkutlstate::restoreFromFile {tbl path}
::tkutils::tkutlstate::saveVia {tbl key setPrefix}
::tkutils::tkutlstate::restoreVia {tbl key getPrefix}
::tkutils::tkutlstate::autosave {tbl key setPrefix args}
::tkutils::tkutlstate::cancelAutosave {tbl}
::tkutils::tkutlstate::lastError {tbl}
```

## `tkutltree`

Source: `lib/tm/tkutils/tkutltree-0.3.tm`.

```tcl
::tkutils::tkutltree::fromData {tbl data args}
::tkutils::tkutltree::toData {tbl args}
::tkutils::tkutltree::clear {tbl args}
::tkutils::tkutltree::lazy {tbl loadCmd args}
::tkutils::tkutltree::reveal {tbl index}
::tkutils::tkutltree::findId {tbl id}
```

## `tkutodo`

Source: `lib/tm/tkutils/tkutodo-0.2.tm`.

```tcl
::tkutils::tkutodo::widget {path args}
::tkutils::tkutodo::treeWidget {path}
::tkutils::tkutodo::setTodos {path comps}
::tkutils::tkutodo::loadText {path ics}
::tkutils::tkutodo::todos {path}
::tkutils::tkutodo::count {path}
::tkutils::tkutodo::toggle {path {index ""}}
```

## `tkutoolbar`

Source: `lib/tm/tkutils/tkutoolbar-0.2.tm`.

```tcl
::tkutils::tkutoolbar::widget {path args}
::tkutils::tkutoolbar::addButton {path id label command args}
::tkutils::tkutoolbar::addToggle {path id label varName args}
::tkutils::tkutoolbar::addDropdown {path id label args}
::tkutils::tkutoolbar::addSeparator {path}
::tkutils::tkutoolbar::addWidget {path id w {side left}}
::tkutils::tkutoolbar::setEnabled {path id enabled}
::tkutils::tkutoolbar::buttonWidget {path id}
::tkutils::tkutoolbar::items {path}
::tkutils::tkutoolbar::configureButton {path id args}
::tkutils::tkutoolbar::setCallback {path id command}
::tkutils::tkutoolbar::setDisplayMode {path mode}
::tkutils::tkutoolbar::getDisplayMode {path}
::tkutils::tkutoolbar::addAction {path name {id ""}}
```

## `tkutree`

Source: `lib/tm/tkutils/tkutree-0.2.tm`.

```tcl
::tkutils::tkutree::widget {path args}
::tkutils::tkutree::insert {path parent text args}
::tkutils::tkutree::loadTree {path nodes {parent ""}}
::tkutils::tkutree::clear {path}
::tkutils::tkutree::selection {path}
::tkutils::tkutree::itemText {path id}
::tkutils::tkutree::itemValues {path id}
::tkutils::tkutree::children {path {id ""}}
::tkutils::tkutree::treeview {path}
```

## `tkuunits`

Source: `lib/tm/tkutils/tkuunits-0.1.tm`.

```tcl
::tkutils::tkuunits::units {}
::tkutils::tkuunits::toPixels {value unit {w .}}
::tkutils::tkuunits::fromPixels {px {w .}}
::tkutils::tkuunits::convert {value from to {w .}}
```

## `tkuvalidate`

Source: `lib/tm/tkutils/tkuvalidate-0.1.tm`.

```tcl
::tkutils::tkuvalidate::attach {w validator args}
::tkutils::tkuvalidate::check {w}
::tkutils::tkuvalidate::valid {w}
::tkutils::tkuvalidate::clear {w}
::tkutils::tkuvalidate::allValid {widgets}
```

## `tkuvcard`

Source: `lib/tm/tkutils/tkuvcard-0.3.tm`.

```tcl
::tkutils::tkuvcard::widget {path args}
::tkutils::tkuvcard::treeWidget {path}
::tkutils::tkuvcard::loadText {path vcf}
::tkutils::tkuvcard::loadFile {path file}
::tkutils::tkuvcard::setCards {path cards}
::tkutils::tkuvcard::cards {path}
::tkutils::tkuvcard::count {path}
::tkutils::tkuvcard::addCard {path {fn "New Contact"}}
::tkutils::tkuvcard::removeCard {path index}
::tkutils::tkuvcard::addProperty {path cardIndex name value {type ""}}
::tkutils::tkuvcard::removeProperty {path cardIndex propIndex}
::tkutils::tkuvcard::setProperty {path cardIndex propIndex name value {type ""}}
::tkutils::tkuvcard::toText {path}
::tkutils::tkuvcard::save {path file}
```

## `tkuwheel`

Source: `lib/tm/tkutils/tkuwheel-0.2.tm`.

```tcl
::tkutils::tkuwheel::redirect {target w args}
::tkutils::tkuwheel::unbind {w args}
```

## `tkuwinico`

Source: `lib/tm/tkutils/tkuwinico-0.1.tm`.

```tcl
::tkutils::tkuwinico::defaultSizes {}
::tkutils::tkuwinico::fromSvg {svgFile outFile args}
::tkutils::tkuwinico::fromPhoto {photo outFile args}
::tkutils::tkuwinico::fromPhotos {photos outFile}
```

## `tkuxml`

Source: `lib/tm/tkutils/tkuxml-0.1.tm`.

```tcl
::tkutils::tkuxml::widget {path args}
::tkutils::tkuxml::setXml {path xml}
::tkutils::tkuxml::loadFile {path filename}
::tkutils::tkuxml::getRoot {path}
```

## `tkuzip`

Source: `lib/tm/tkutils/tkuzip-0.1.tm`.

```tcl
::tkutils::tkuzip::widget {path args}
::tkutils::tkuzip::openFile {path zipfile}
::tkutils::tkuzip::getEntries {path}
::tkutils::tkuzip::selectedMember {path}
```
