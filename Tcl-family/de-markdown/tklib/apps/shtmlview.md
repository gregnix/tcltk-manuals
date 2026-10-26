---
CommandName: shtmlview
ManualSection: n
Version: 1.1.0
TclPart: tklib
TclDescription: Basic HTML and Markdown viewer
Keywords:
 - doctools
 - html
 - markdown
 - mkdoc
 - viewer
Copyright:
 - Copyright (c)
---

# NAME

shtmlview – Anwendung zur Anzeige von einfachem HTML und Markdown

# ÜBERSICHT

::: {.synopsis} :::
[shtmlview]{.cmd} 
[shtmlview]{.cmd} [--help]{.sub} 
[shtmlview]{.cmd} [--version]{.sub} 
[shtmlview]{.cmd} [--render]{.sub} [text]{.arg} 
[shtmlview]{.cmd} [--render]{.sub} [-]{.lit} 
[shtmlview]{.cmd} [filename]{.arg} 
:::

# BESCHREIBUNG

Die in diesem Dokument beschriebene Anwendung, **shtmlview**, ist ein einfacher Viewer für HTML-Dateien. Darüber hinaus werden Dokumente im *Markdown*-, *doctools*- oder *mkdoc*-Format unterstützt, wenn entsprechende Pakete zur Verfügung stehen. Siehe Abschnitt **ÜBER HTML HINAUS**.

## Befehlszeile

**shtmlview**
: ...siehe nächstes...

**shtmlview** **--help**
: Gibt Informationen zur Nutzung in die Standardfehlerausgabe aus.

**shtmlview** **--version**
: Gibt die Anwendungsversion auf der Standardausgabe aus.

**shtmlview** **--render** *text*
: Zeigt den eingegebenen Text in einem Anzeigefenster an. Der Text wird als Markdown behandelt, es sei denn, er beginnt mit einem erkannten HTML-Tag. In diesem Fall wird er als HTML interpretiert und entsprechend dargestellt.

**shtmlview** **--render** **-**
: Wie zuvor, mit dem Unterschied, dass der darzustellende Text aus der Standardeingabe gelesen wird.

**shtmlview** *filename*
: Liest die genannte Datei und zeigt sie in einem Anzeige-Widget an.


# ÜBER HTML HINAUS

Dokumente in einem anderen Format als HTML erfordern die Installation verschiedener Pakete, damit die Anwendung diese anzeigen kann.

**Markdown**
: 


**•**
: **Markdown**


**doctools**
: 


**•**
: **shtmlview::doctools**

**•**
: **dtplite**


**mkdoc**
: 


**•**
: **shtmlview::mkdoc**

**•**
: **mkdoc::mkdoc**


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und die darin beschriebene Anwendung enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *shtmlview* der [Tklib-Tracker](https://core.tcl-lang.org/tklib/ticket). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen an der Anwendung oder an der Dokumentation.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *shtmlview* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Dokumentanzeige

# COPYRIGHT

```
Copyright (c)
```
