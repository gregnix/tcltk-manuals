# createpdf-test.tcl -- prüft, wie createpdf Stichwörter aus der Seite
# ableitet (-index-terms auto|keywords|all), an zwei erzeugten Seiten:
# einer wie aus HTML (ohne YAML-Kopf, Aufbau wie die Nemethi-Pakete) und
# einer TIP-700-Seite mit Kopf und Keywords; dazu einen HTML-Ordner, den
# createpdf selbst umwandelt (Links, Bild, Definitionsliste, Tabelle,
# Titel, temporärer Ordner). Der HTML-Teil braucht tdom, sonst entfällt er.
#
#   tclsh scripts/tests/createpdf-test.tcl
#
# Braucht dieselben Pakete wie createpdf (docir, mdstack, pdf4tcl,
# pdf4tcllib; siehe scripts/createpdf/README.md); fehlen sie, wird der
# Test übersprungen (Status 0, Meldung). Ende mit Status 0, wenn alles
# stimmt.

set here [file dirname [file normalize [info script]]]
set repo [file dirname [file dirname $here]]
set createpdf [file join $repo scripts createpdf createpdf.tcl]

set fehler 0
proc ok {cond text} {
    if {[uplevel 1 [list expr $cond]]} {
        puts "ok    $text"
    } else {
        puts "FEHLER $text"
        incr ::fehler
    }
}

if {[catch {
    package require mdstack::parser
    package require docir::pdf
} err]} {
    puts "übersprungen: Pakete für createpdf fehlen ($err)"
    exit 0
}

if {[info exists env(TMPDIR)] && $env(TMPDIR) ne ""} {
    set tmp [file join $env(TMPDIR) createpdf-test-[pid]]
} else {
    set tmp [file join /tmp createpdf-test-[pid]]
}
file delete -force $tmp
file mkdir [file join $tmp seiten]

proc schreiben {path text} {
    set h [open $path w]
    fconfigure $h -encoding utf-8 -translation lf
    puts -nonewline $h $text
    close $h
}
proc lesen {path} {
    set h [open $path r]
    fconfigure $h -encoding utf-8
    set t [read $h]
    close $h
    return $t
}

# Seite wie aus HTML: Titelblock, Inhalt mit Links, Definitionslisten
schreiben [file join $tmp seiten fooWidget.md] {# The `foo::foo` Command

## For Foo Version 1.0

### by

## Jane Doe

---

## Contents

- [Some Topic](#some-topic)
- [The `foo::bar` Command](#the-foo-bar-command)
- [How to Use It?](#how-to-use-it)

---

## Some Topic

A [Koroutine]{.index} and the word *Topic*.

## The `foo::bar` Command

Text.

### How to Use It?

Text.

## genOutAttr - generate attributes on outbound tags

**ROW INDICES**
: Row indices.

`-arrowstyle style`
: Arrow style.

`-itembackground color`  or  `-itembg color`
: Item background.

`-labelbg color`  
 `-labelfont fontName`
: Two options, one definition (hard line break).

`pathName cellconfigure cellIndex ?option? ?value option value ...?`
: Cell options.

`pathName header option ?arg arg ...?`
: Header commands.

`pathName header bbox headerIndex`
: Bounding box.

`pathName set_value x`
: Underscore.

*pathName* **bind** ?*arg...*?
: Bold name, italic arguments.

BWidget::**place** *path* *w* *h*
: Namespace before the bold name.

**- + ~ !**
: Only operators.

**Options for all entries and labels of the widget**
: A long label.

**Koroutine**
: Marked above already.

`-arrowstyle style`
: The same option again.

**NAME**
: Common label.

See [Some Topic](#some-topic) and [Some Topic].
}

# TIP-700-Seite mit Kopf und Keywords
file mkdir [file join $tmp seiten2]
schreiben [file join $tmp seiten2 after.md] {---
CommandName: after
Keywords:
 - delay
Copyright:
 - Copyright (c) 2026 Test
---

# Name

after - Execute a command after a time delay

# Description

**-option** *value*
: Some option.

## Subsection

Text.
}

proc bauen {dir name args} {
    global createpdf tmp
    set out [file join $tmp $name]
    set rc [catch {exec [info nameofexecutable] $createpdf $dir -o $out.pdf \
        -md $out.md -index-tsv $out.tsv -no-license {*}$args 2>@1} msg]
    if {$rc} { puts $msg }
    return [list $rc [lesen $out.md] [lesen $out.tsv]]
}
proc terme {tsv} {
    set out {}
    foreach line [split $tsv \n] {
        if {$line eq "" || [string match "#*" $line]} continue
        lappend out [lindex [split $line \t] 0]
    }
    return $out
}

# --- auto (Vorgabe): Seite ohne Kopf ----------------------------------
lassign [bauen [file join $tmp seiten] auto] rc md tsv
ok {$rc == 0} "auto: createpdf läuft"
set t [terme $tsv]
foreach erwartet {
    fooWidget {Some Topic} foo::bar genOutAttr {ROW INDICES} -arrowstyle
    -itembackground -itembg -labelbg -labelfont cellconfigure header {header bbox} set_value
    bind BWidget::place Koroutine
} {
    ok {$erwartet in $t} "auto: Begriff „$erwartet“"
}
foreach nicht {
    {For Foo Version 1.0} by {Jane Doe} Contents {How to Use It?}
    pathName {pathName cellconfigure} cellIndex style option
    {Options for all entries and labels of the widget} NAME Options
    - + ~ ! {} place
} {
    ok {$nicht ni $t} "auto: kein Begriff „$nicht“"
}
ok {[regexp -all {\[-arrowstyle\]\{\.index\}} $md] == 1} "auto: -arrowstyle einmal markiert (Dublette)"
ok {[regexp -all {\[Koroutine\]\{\.index\}} $md] == 1} "auto: markiertes Wort nicht noch einmal"
ok {[string first {`pathName` [cellconfigure]{.index} `cellIndex ?option? ?value option value ...?`} $md] >= 0} \
    "auto: Begriff aus dem Code-Span gelöst, Rest bleibt Code"
ok {[string first {*pathName* **[bind]{.index}** ?*arg...*?} $md] >= 0} "auto: fetter Name zwischen Argumenten"
ok {[string first {[BWidget::place]{.index} *path*} $md] >= 0} "auto: Namensraum und fetter Name zusammen"
ok {[string first {[set\_value]{.index}} $md] >= 0} "auto: Unterstrich maskiert"
ok {[string first {## [Some Topic]{.index}} $md] >= 0} "auto: Überschrift markiert"
ok {[string first {(#some-topic-index)} $md] >= 0 && [string first {(#some-topic)} $md] < 0} \
    "auto: Link auf die Überschrift umgestellt"
ok {[string first {(#the-foo-bar-index-command)} $md] >= 0} "auto: Link auf „The foo::bar Command“ umgestellt"
ok {[string first {(#how-to-use-it)} $md] >= 0} "auto: Link auf unveränderte Überschrift bleibt"
# Seitenzahlen: alle Begriffe haben eine Seite
set seiten 1
foreach line [split $tsv \n] {
    if {$line eq "" || [string match "#*" $line]} continue
    if {![regexp {^[^\t]+\t[0-9]+(,[0-9]+)*$} $line]} { set seiten 0 }
}
ok $seiten "auto: jede Zeile der TSV hat Seiten"

# --- keywords: nur der Seitenname -------------------------------------
lassign [bauen [file join $tmp seiten] keywords -index-terms keywords] rc md tsv
ok {$rc == 0 && [terme $tsv] eq {fooWidget Koroutine}} "keywords: nur Seitenname und markiertes Wort ([terme $tsv])"
ok {[string first {(#some-topic)} $md] >= 0} "keywords: Links unverändert"

# --- Seite mit Kopf: auto wie keywords, all leitet ab -----------------
lassign [bauen [file join $tmp seiten2] k2 -index-terms keywords] rc mdK tsvK
lassign [bauen [file join $tmp seiten2] a2] rc mdA tsvA
ok {$mdK eq $mdA && [terme $tsvK] eq [terme $tsvA]} "auto: Seite mit YAML-Kopf unverändert ([terme $tsvA])"
lassign [bauen [file join $tmp seiten2] all2 -index-terms all] rc md tsv
set t [terme $tsv]
ok {"-option" in $t && "Subsection" in $t && "delay" in $t} "all: Seite mit Kopf bekommt Begriffe ($t)"

# --- Aufruf ------------------------------------------------------------
set rc [catch {exec [info nameofexecutable] $createpdf [file join $tmp seiten] \
    -index-terms foo 2>@1} msg]
ok {$rc != 0} "-index-terms foo: Aufruffehler"

# --- HTML-Ordner -------------------------------------------------------
if {[catch {package require docir::htmlSource} err]} {
    puts "übersprungen: HTML-Teil ($err)"
} else {
    set h [file join $tmp html]
    file mkdir $h
    schreiben [file join $h index.html] {<!DOCTYPE html>
<html><head><title>Testpaket
  1.0 &amp; mehr</title></head>
<body>
<h1>Das Testpaket</h1>
<h2>Erste Optionen</h2>
<p>Siehe <a href="zweite.html#opt-farbe">die Farbe</a> und
<a href="zweite.html">die zweite Seite</a>.</p>
<p><img src="bild.png" alt="Bild"></p>
<dl>
  <dt><code>-breite</code> <i>pixel</i></dt>
  <dd>Breite des Fensters.</dd>
</dl>
<table>
  <tr><th>Spalte</th><th>Wert</th></tr>
  <tr><td>a</td><td>1</td></tr>
</table>
</body></html>
}
    schreiben [file join $h zweite.html] {<!DOCTYPE html>
<html><head><title>Zweite</title></head>
<body>
<h1>Zweite Seite</h1>
<h2>Farben</h2>
<dl>
  <dt id="opt-farbe"><code>-farbe</code> <i>name</i></dt>
  <dd>Farbe. Zurück zum <a href="index.html">Anfang</a>.</dd>
</dl>
</body></html>
}
    # 1x1-PNG
    set fh [open [file join $h bild.png] wb]
    puts -nonewline $fh [binary decode base64 \
        iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==]
    close $fh
    # eigenes TMPDIR: danach muss es leer sein
    set tdir [file join $tmp tmpdir]
    file mkdir $tdir
    set out [file join $tmp html-out]
    set env(TMPDIR) $tdir
    set rc [catch {exec [info nameofexecutable] $createpdf $h -o $out.pdf \
        -md $out.md -index-tsv $out.tsv 2>@1} msg]
    unset env(TMPDIR)
    if {$rc} { puts $msg }
    ok {$rc == 0} "html: createpdf liest den HTML-Ordner"
    ok {[string match "*HTML: 2 pages converted*" $msg]} "html: zwei Seiten umgewandelt"
    ok {[llength [glob -nocomplain -directory $tdir *]] == 0} "html: temporärer Ordner entfernt"
    set md [lesen $out.md]
    set tsv [lesen $out.tsv]
    set t [terme $tsv]
    ok {[string first "# title\tTestpaket 1.0 & mehr" $tsv] >= 0} "html: Titel aus <title>"
    ok {[string first "# index\n" $md] == 0} "html: index.html ist das erste Kapitel"
    foreach erwartet {index zweite -breite -farbe {Erste Optionen} Farben} {
        ok {$erwartet in $t} "html: Begriff „$erwartet“ abgeleitet"
    }
    ok {[string first "](#farben" $md] >= 0} "html: Link auf die Definition führt zur Überschrift davor"
    ok {[string first "\[die zweite Seite\](#zweite)" $md] >= 0} "html: Link auf die Seite führt zum Kapitel"
    ok {[string first "\[Anfang\](#index)" $md] >= 0} "html: Link zurück zum Kapitel index"
    ok {[string first ".md" $md] < 0 && [string first ".html" $md] < 0} "html: keine Links auf Dateien"
    ok {[regexp {!\[Bild\]\(<[^>]*bild\.png>\)} $md]} "html: Bild eingebunden"
    ok {[regexp {\| *Spalte *\| *Wert *\|} $md]} "html: Tabelle"
    set fh [open $out.pdf rb]; set pdf [read $fh]; close $fh
    ok {[string first /Image $pdf] >= 0} "html: Bild im PDF"

    # -keep-md behält die Seiten; -no-html liest nur Markdown
    set keep [file join $tmp keep]
    set rc [catch {exec [info nameofexecutable] $createpdf $h -o $out.pdf \
        -keep-md $keep -no-license 2>@1} msg]
    ok {$rc == 0 && [file isfile [file join $keep zweite.md]] && [file isfile [file join $keep bild.png]]} \
        "html: -keep-md behält Seiten und Bilder"
    set rc [catch {exec [info nameofexecutable] $createpdf $h -o $out.pdf -no-html 2>@1} msg]
    ok {$rc != 0 && [string match "*no .md files*" $msg]} "html: -no-html liest kein HTML"
    # gemischter Ordner: Markdown wie bisher, Hinweis auf -html
    file copy [file join $keep zweite.md] [file join $h zweite.md]
    set rc [catch {exec [info nameofexecutable] $createpdf $h -o $out.pdf \
        -no-license 2>@1} msg]
    ok {$rc == 0 && [string match "*-html reads*" $msg] && [string match "*1 pages of manual*" $msg]} \
        "html: gemischter Ordner liest Markdown, Hinweis auf -html"
    set rc [catch {exec [info nameofexecutable] $createpdf $h -o $out.pdf \
        -html -no-license 2>@1} msg]
    ok {$rc == 0 && [string match "*2 pages of manual*" $msg]} "html: -html erzwingt HTML"
    set rc [catch {exec [info nameofexecutable] $createpdf $h -html -no-html 2>@1} msg]
    ok {$rc != 0} "html: -html und -no-html zusammen: Aufruffehler"
}

file delete -force $tmp
puts [expr {$fehler ? "$fehler Fehler" : "alles gut"}]
exit [expr {$fehler ? 1 : 0}]
