---
CommandName: package
title: package
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - msgcat(n)
 - packagens(n)
 - pkgMkIndex(n)
Keywords:
 - package
 - version
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# Name

package - Paketladen und Versionskontrolle

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [files]{.sub} [package]{.arg}
[package]{.cmd} [forget]{.sub} [package package]{.optdot}
[package]{.cmd} [ifneeded]{.sub} [package]{.arg} [version]{.arg} [script]{.optarg}
[package]{.cmd} [names]{.sub}
[package]{.cmd} [present]{.sub} [package]{.arg} [requirement...]{.optarg}
[package]{.cmd} [present]{.sub} [-exact]{.lit} [package]{.arg} [version]{.arg}
[package]{.cmd} [provide]{.sub} [package]{.arg} [version]{.optarg}
[package]{.cmd} [require]{.sub} [package]{.arg} [requirement...]{.optarg}
[package]{.cmd} [require]{.sub} [-exact]{.lit} [package]{.arg} [version]{.arg}
[package]{.cmd} [unknown]{.sub} [command]{.optarg}
[package]{.cmd} [vcompare]{.sub} [version1]{.arg} [version2]{.arg}
[package]{.cmd} [versions]{.sub} [package]{.arg}
[package]{.cmd} [vsatisfies]{.sub} [version]{.arg} [requirement...]{.arg}
[package]{.cmd} [prefer]{.sub} [latest|stable]{.optlit}
:::

# Beschreibung

Der Befehl verwaltet eine einfache Datenbank der für den aktuellen Interpreter verfügbaren Pakete und wie sie geladen werden. Mehrere Versionen pro Paket werden unterstützt; die passende Version wird anhand der Anforderungen der Anwendung geladen. Versionskonflikte werden erkannt und gemeldet. In normalen Tcl-Skripten werden meist nur **package require** und **package provide** verwendet; die übrigen Unterbefehle dienen vor allem Systemskripten zur Pflege der Paketdatenbank.

Das Verhalten wird durch das erste Argument bestimmt. Zulässige Formen:

[package]{.cmd} [files]{.sub} [package]{.arg}
: Listet alle Dateien auf, die zu *package* gehören. Auto-geladene Dateien sind nicht enthalten, nur direkt beim Paketinitialisieren per **source** geladene. Die Reihenfolge entspricht der **source**-Reihenfolge.

[package]{.cmd} [forget]{.sub} [package package]{.optdot}
: Entfernt alle Informationen zu jedem angegebenen Paket aus diesem Interpreter, einschließlich **package ifneeded** und **package provide**.

[package]{.cmd} [ifneeded]{.sub} [package]{.arg} [version]{.arg} [script]{.optarg}
: Typischerweise nur in System-Konfigurationsskripten. Kennzeichnet, dass *version* von *package* bei Bedarf verfügbar ist und per *script* geladen werden kann. *script* wird für spätere **package require** gespeichert; üblicherweise richtet *script* Auto-Loading ein (oder [load]/[source]) und ruft **package provide** auf. Für ein Paket können mehrere Versionen eingetragen sein. Existiert bereits ein Eintrag für *package* und *version*, ersetzt *script* den alten. Ohne *script*: Rückgabe des aktuellen Skripts für diese Version, oder leerer String wenn kein **package ifneeded** gesetzt wurde.

[package]{.cmd} [names]{.sub}
: Liste aller Paketnamen, für die eine Version bereitgestellt wurde (**package provide**) oder ein **package ifneeded**-Skript existiert. Reihenfolge beliebig.

[package]{.cmd} [present]{.sub} [-exact]{.optlit} [package]{.arg} [requirement...]{.optarg}
: Wie **package require**, lädt das Paket aber nicht, wenn es noch nicht geladen ist.

[package]{.cmd} [provide]{.sub} [package]{.arg} [version]{.optarg}
: Kennzeichnet, dass *version* von *package* im Interpreter vorhanden ist. Wird typischerweise im **ifneeded**-Skript und beim endgültigen Laden des Pakets aufgerufen. Fehler, wenn eine andere Version bereits per **package provide** gemeldet wurde. Ohne *version*: aktuell bereitgestellte Versionsnummer, oder leerer String wenn nie **package provide** für *package* aufgerufen wurde.

[package]{.cmd} [require]{.sub} [package]{.arg} [requirement...]{.optarg}
: Wird von Tcl-Code aufgerufen, der eine bestimmte Paketversion braucht. Bei Erfolg: geladene Versionsnummer; sonst Fehler.

    Eine passende Version erfüllt mindestens eine *requirement* (Abschnitt [Anforderung]). Bei mehreren passenden Versionen wird die höchste gewählt, zusätzlich beeinflusst durch **package prefer**.

    Modus **stable**: höchste stabile passende Version; falls keine, höchste instabile. Modus **latest**: höchste passende Version unabhängig von Stabilität.

    Ist *package* bereits bereitgestellt (**package provide**), muss die Version die *requirement*s erfüllen — sofortige Rückkehr. Sonst Suche in der **package ifneeded**-Datenbank; bei Treffer Auswertung des Skripts der höchsten passenden Version im globalen Namespace (inkl. **package provide**). Fehlt ein passender Eintrag und ist **package unknown** gesetzt, wird dieser ausgewertet; danach erneute Prüfung. Scheitern aller Schritte: Fehler.

[package]{.cmd} [require]{.sub} [-exact]{.lit} [package]{.arg} [version]{.arg}
: Nur die angegebene *version* ist akzeptabel. Äquivalent zu **package require** *package version*-*version*.

[package]{.cmd} [unknown]{.sub} [command]{.optarg}
: „Letzter Ausweg“ bei **package require**, wenn in **package ifneeded** nichts Passendes steht. Mit *command*: Präfix eines Befehls; Tcl hängt Paketname und Anforderungen an (z. B. **foo bar** + **package require test 2.4** → **foo bar test 2.4**). Ohne Anforderungen nur der Name. Ohne *command*: aktuelles **package unknown**-Skript oder leerer String. *command* als leerer String entfernt das Skript.

[package]{.cmd} [vcompare]{.sub} [version1]{.arg} [version2]{.arg}
: Vergleicht zwei Versionsnummern. Rückgabe -1 (früher), 0 (gleich), 1 (später).

[package]{.cmd} [versions]{.sub} [package]{.arg}
: Liste aller Versionsnummern von *package* mit **package ifneeded**-Einträgen.

[package]{.cmd} [vsatisfies]{.sub} [version]{.arg} [requirement...]{.arg}
: 1 wenn *version* mindestens eine Anforderung erfüllt, sonst 0. Anforderungen: Abschnitt [Anforderung].

[package]{.cmd} [prefer]{.sub} [latest|stable]{.optlit}
: Ohne Argument: **latest** oder **stable** — aktueller Auswahlmodus für **package require**.

    **latest**: Modus auf „latest“ setzen.

    **stable**: Wenn bereits **stable**, bleibt es; von **latest** zurück auf **stable** ist wirkungslos — Modus bleibt **latest**.

    Anderes Argument: Fehler „invalid argument“.

    Neuer Interpreter: initial **stable**, außer Umgebungsvariable **TCL\_PKG\_PREFER\_LATEST** ist gesetzt (beliebiger Wert) oder das Tcl-Paket selbst ist instabil — dann initial und dauerhaft **latest**.


# Versionsnummern

Versionsnummern bestehen aus einer oder mehreren durch Punkte getrennten Dezimalzahlen (z. B. 2, 1.162, 3.1.13.1). Die erste Zahl ist die Hauptversionsnummer; größere Zahlen = spätere Versionen, links mehr Signifikanz. Fehlende Felder = Nullen: 1.3 = 1.3.0 = 1.3.0.0, früher als 1.3.1. Die Buchstaben „a“ (alpha) und „b“ (beta) dürfen je einmal einen Punkt ersetzen und fügen semantisch einen negativen Anteil ein („a“ = -2, „b“ = -1); nur einmal, gegenseitig ausschließend. 1.3a1 → 1.3.-2.1, 1.3b1 → 1.3.-1.1. Negative Zahlen sind in Spezifizierern nicht direkt erlaubt. Ohne „a“/„b“: **stable**; mit Buchstaben: **unstable**. Spätere Versionen gelten als aufwärtskompatibel zur früheren, solange die Hauptversionsnummer gleich ist. Änderung der Hauptversion: inkompatible Änderungen.

# Paket-Indizes

Empfohlen: **package require** und **package provide** in Skripten, [pkg\_mkIndex][pkgMkIndex] für Indexdateien — Pakete laden dann automatisch bei **package require**. Siehe [pkg\_mkIndex][pkgMkIndex].

# Anforderung

Eine *requirement*-Zeichenkette prüft, ob eine kompatible Paketversion vorhanden ist. Die meisten Befehle akzeptieren eine Liste von Anforderungen; die höchste passende Version wird gewählt.

Formen:

*min*
: „min-bounded“ (untere Grenze).

*min***-**
: „min-unbound“ (nur untere Grenze, offen nach oben).

*min***-***max*
: „bounded“ (Intervall).


wobei *min* und *max* gültige Versionsnummern sind. Legacy-Syntax ist Spezialfall der erweiterten Syntax. Regeln:

1. Die *version* muss mindestens eine *requirement* erfüllen.

2. „bounded“: erfüllt wenn

    \[a\]
    : *min* gleich *max* genau dann, wenn *version* gleich *min* ist.

    \[b\]
    : sonst genau dann, wenn *version* ≥ *min* und *version* < *max* (intern beide mit „a0“ aufgefüllt). Vergleich zu *min* inklusiv, zu *max* exklusiv.


3. „min-bounded“: „bounded“ mit implizitem *max* = nächste höhere Hauptversion von *min*.

4. „min-unbound“: *version* ≥ *min* (*min* intern mit „a0“ aufgefüllt), keine Obergrenze.


# Beispiele

Tk und http am Skriptanfang anfordern:

```
package require Tk
package require http
```

Snack optional laden:

```
if {[catch {package require Snack}]} {
    # Error thrown - package not found.
    # Set up a dummy interface to work around the absence
} else {
    # We have the package, configure the app to use it
}
```


[load]: load.md
[pkgMkIndex]: pkgMkIndex.md
[source]: source.md
