---
CommandName: tepam::doc_gen
ManualSection: n
Version: 0.1.3
TclPart: tcllib
TclDescription: Tcl's Enhanced Procedure and Argument Manager
Links:
 - tepam(n)
 - tepam::procedure(n)
Keywords:
 - automatic documentation
 - documentation
 - procedure documentation
Copyright:
 - Copyright (c) 2013, Andreas Drollinger
---

# NAME

tepam::doc_gen – TEPAM DOC-Generierung, Referenzhandbuch

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tepam]{.lit} [0.5]{.lit} 
[package]{.cmd} [require]{.sub} [tepam::doc_gen]{.lit} [0.1.3]{.optlit} 
[tepam::doc_gen::generate]{.cmd} [-format format]{.optarg} [-style style]{.optarg} [-header_footer]{.optarg} [-dest_file dest_file]{.optarg} [name]{.arg} 
[tepam::doc_gen::patch]{.cmd} [-format format]{.optarg} [-style style]{.optarg} [-search_pattern search_pattern]{.optarg} [-src_string src_string | -src_file src_file]{.optarg} [-dest_file dest_file]{.optarg} [name]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket erstellt Dokumentationen zu TEPAM-Prozeduren (Prozeduren, die mit **tepam::procedure** deklariert wurden). Die Dokumente werden im klassischen UNIX-Dokumentstil unter Verwendung der folgenden Dokumentabschnitte erstellt: Name, Synopsis, Description, Arguments und Example. **TEPAM Doc Gen** bietet Unterstützung für verschiedene Dokumentformate. Bei Bedarf kann die Unterstützung für weitere Formate hinzugefügt werden.

Das Paket **TEPAM Doc Gen** stellt die folgenden Befehle bereit:

**tepam::doc_gen::generate** ?-format *format*? ?-style *style*? ?-header_footer? ?-dest_file *dest_file*? *name*
: Dieser Befehl generiert die Dokumentation für eine angegebene Prozedur (*name*) in einem der unterstützten Formate (TXT, HTML, POD (Perl Doc), DT (TclLib DocTool)) oder in einem benutzerdefinierten Format. Das Format wird über ?format? angegeben. Das Flag ?-header_footer? fügt der Dokumentation Dateikopf und -fuß hinzu. Wenn ?dest_file? angegeben ist, wird die Dokumentation in einer Datei gespeichert (Dateikopf und -fuß werden in diesem Fall automatisch hinzugefügt) und der Dateiname zurückgegeben. Andernfalls gibt **generate** die Dokumentationszeichenfolge zurück.

**tepam::doc_gen::patch** ?-format *format*? ?-style *style*? ?-search_pattern *search_pattern*? ?-src_string *src_string* | -src_file *src_file*? ?-dest_file *dest_file*? ?name?
: Dieser Befehl fügt Prozedurdokumentationen an den Stellen in ein bestehendes Masterdokument ein, die durch Einfügeplatzhalter gekennzeichnet sind, welche dem Muster ?search_pattern? entsprechen. Das vorhandene Masterdokument wird entweder als Daten über das Argument (?src_string?) oder über eine Datei (?src_file?) bereitgestellt. Das endgültige Dokument wird von **patch** zurückgegeben, wenn keine Zieldatei definiert ist (?dest_file?). Andernfalls wird das Dokument in der angegebenen Datei gespeichert, und die Anzahl der Einfügeplatzhalter, die erfolgreich verarbeitet werden konnten, wird zurückgegeben. Standardmäßig werden alle Einfügeplatzhalter des Masterdokuments verarbeitet. Durch die Angabe des Arguments ?name? wird das Einfügen der Dokumentation auf eine bestimmte Prozedur beschränkt.


# ARGUMENTE

?-format *format*?
: Legt das Dokumentationsformat fest. **TEPAM Doc Gen** unterstützt die folgenden Formate:


**•**
: TXT – Textformat (Standard)

**•**
: HTML

**•**
: POD – Perl Plain Old Documentation Format (PerlPOD)

**•**
: DT – TclLib DocTool-Format


: Im Abschnitt **UNTERSTÜTZUNG FÜR NEUE DOKUMENTFORMATE HINZUFÜGEN** wird erläutert, wie die Unterstützung für weitere Formate hinzugefügt werden kann.


?-style *style*?
: Die Dokumentation wird standardmäßig im Tcl-Stil generiert (z. B. **command arg1 arg2 ...**). Eine Dokumentation im C-Stil kann generiert werden, indem Sie dieses Argument auf „C“ setzen (z. B. **command(arg1,arg2,...)**).

?-dest_file *dest_file*?
: Wenn ?dest_file? definiert ist, wird die Dokumentation in die angegebene Zieldatei geschrieben. Andernfalls geben die Befehle **generate** und **patch** die Dokumentationszeichenfolge zurück.

*name* / ?name?
: Dies ist der Name der Prozedur, für die die Dokumentation erstellt werden soll. Für **generate** ist es ein obligatorisches Argument, für **patch** ein optionales.

**?-header_footer?**
: **Generate** fügt der generierten Prozedurdokumentation Dateikopf und -fuß nur dann hinzu, wenn eine Datei generiert wird. Mit dem Flag ?-header_footer? werden Kopf und Fuß auch dann generiert, wenn **generate** die Dokumentation als Zeichenkette zurückgibt.

?-src_string *src_string* | -src_file *src_file*?
: **Patch** fügt Prozedurdokumentationen in ein bestehendes Dokument ein, das entweder als Zeichenfolge an das Argument (?src_string?) oder als Datei (?src_file?) übergeben wird. Eines dieser beiden Argumente muss festgelegt werden.

?-search_pattern *search_pattern*?
: Das Argument ?search_pattern? definiert den in einem Dokument verwendeten Einfügeplatzhalter für die Dokumentation. Es handelt sich um einen regulären Ausdruck, der von **regexp** akzeptiert wird, und er muss einen in Klammern gesetzten Teilausdruck enthalten, der den Namen der Prozedur angibt, für die die Dokumentation eingefügt werden soll. Das Standardmuster für den Einfügeplatzhalter lautet *\\{!(.\*?)!\\}*, was bedeutet, dass der Name der Prozedur zwischen *{!* und *!}* eingebettet wird. Der Abschnitt **BEISPIELE** enthält ein Beispiel für ein benutzerdefiniertes Einfügeplatzhaltermuster.


# VORDEFINIERTE DOKUMENTFORMATE

**TEPAM Doc Gen** definiert die folgenden Dokumentformate vor:

## Txt – Textformat

Die Dokumentation wird in einem einfachen Textformat erstellt, wenn dieses Format ausgewählt wird. Das Format kann über die folgende Variable angepasst werden:

**tepam::doc_gen::Option(TXT,MaxLineLength)**
: Vorgabewert: 80 Diese Variable legt die Grenze für den Zeilenumbruch (Zeichenposition) fest.


## HTML – HTML-Format

**TEPAM Doc Gen** generiert CSS-formatierte HTML-Dateien. Die HTML-Dokumentation kann über die folgende Variable angepasst werden:

**tepam::doc_gen::Option(HTML,CssFile)**
: Vorgabewert: „*tepam_doc_stylesheet.css*“ Diese Variable legt die CSS-Stylesheet-Datei fest, auf die in den generierten HTML-Dateien verwiesen wird. Das CSS-Stylesheet kann angepasst werden, um die Formatierung der Dokumentation zu ändern. Ein guter Ausgangspunkt für die Erstellung eines angepassten CSS-Stylesheets ist die CSS-Datei, die dem Beispiel bzw. der Demo von **TEPAM Doc Gen** beiliegt. Die HTML-Dokumentation verwendet die folgenden CSS-Klassen-Styles:


**•**
: *h1.tepam_page_title* – Titel der Seite. Wird von **generate** nur verwendet, wenn eine Datei erstellt wird oder wenn Kopf und Fuß generiert werden (Flag ?-header_footer? gesetzt).

**•**
: *div.tepam_command_help* – Dokumentationscontainer. Die gesamte Dokumentation der Prozeduren befindet sich in diesem Container.

**•**
: *p.tepam_section_title* – Abschnittstitel (z. B. *Name*, *Synopsis*, *Description*, …)

**•**
: *p.tepam_sub_section_title* – Titel eines Unterabschnitts (dient zur Trennung der Dokumentation mehrerer Unterprozeduren)

**•**
: *p.tepam_name* – Abschnitt „Name“

**•**
: *p.tepam_synopsis* – Abschnitt „Synopsis“

**•**
: *p.tepam_description* – Einzelner Beschreibungsabsatz

**•**
: *ul.tepam_description_list* – Element einer HTML-Aufzählungsliste (ungeordnete Liste) innerhalb des Beschreibungsabschnitts

**•**
: *dt.tepam_argument* – Ein Element einer HTML-Beschreibungsliste, das zur Auflistung der Argumente der Prozeduren dient

**•**
: *p.tepam_argument_description* – Absatz zur Beschreibung des Arguments

**•**
: *p.tepam_argument_attribute* – Zeile mit einem Argumentattribut

**•**
: *pre.tepam_example* – Beispielabschnitt


## Pod – Perl-Dokumentationsformat

Die Dokumentation wird im Perl Plain Old Documentation-Format (PerlPOD) erstellt, wenn dieses Format ausgewählt wurde.

## Dt – tcllib doctools-Format

Die Dokumentation wird im Tcllib-DocTools-Format erstellt, wenn dieses Format ausgewählt ist.

# UNTERSTÜTZUNG FÜR NEUE DOKUMENTFORMATE HINZUFÜGEN

Die Unterstützung für ein neues Dokumentformat kann hinzugefügt werden, indem im Namespace **tepam::doc_gen** eine Reihe von Prozeduren definiert wird, die die verschiedenen Komponenten des Dokuments generieren.

Das folgende Dokumentationslisting enthält Token, die sich auf die verschiedenen Prozeduren zur Dokumentenerstellung beziehen:

```
      <01>
 <03> <20s>   NAME<20e>
      <30s>       message_box - Displays text in a message box<30e>
      <20s>   SYNOPSYS<20e>
      <40s>       message_box [-mtype <mtype>] <text><40e>
      <20s>   DESCRIPTION<20e>
      <21s>     message_box<21e>
      <54s>       message_box [-mtype <mtype>] <text><54e>
      <50s>       This procedure allows displaying a text in an message box. The following
                  message types are supported:<50e>
 <51> <53s>       * Info<53e>
      <53s>       * Warning<53e>
      <53s>       * Error<53e>                                           <52>
      <50s>       If the text parameter is use multiple times the different texts are
                  concatenated to create the message text.<50e>
      <20s>   ARGUMENTS<20e>
 <60> <62s>       [-mtype <mtype>]<62e>
 <63> <65s>          Message type<65e>
      <66s>          Default: "Warning"<66e>
      <66s>          Multiple: yes<66e>
      <66s>          Choices: Info, Warning, Error<66e>                  <64>
      <62s>       <text><62e>
 <63> <65s>          One or multiple text lines to display<65e>
      <66s>          Type: string<66e>
      <66s>          Multiple: yes<66e>                                  <64><61>
      <20s>   EXAMPLE<20e>
 <70> <72s>       message_box "Please save first the document"<72e>
      <73s>       -> 1<73e>                                              <71><04>
      <02>
```

Es gibt zwei Arten von Prozeduren zur Dokumentenerstellung:

**Prozeduren zur Inhaltserzeugung (z. B. <40s>...<40e>)**
: Diese Prozeduren generieren Dokumentinhalt auf der Grundlage des Textes, der als Prozedurargument übergeben wird. Die obige Auflistung enthält zwei Token für diese Prozeduren, die den Anfang und das Ende des generierten Inhalts kennzeichnen.

**Prozeduren zur Steuerungserzeugung (z. B. <03>)**
: Diese Prozeduren erzeugen Steuerkonstrukte, beispielsweise den Prolog- und Epilog-Code für Listen, Abschnitte usw. Diese Prozeduren haben keine Argumente. Die folgende Gruppe von Prozeduren muss definiert werden, um ein neues Dokumentformat zu unterstützen:

*01* - **gen(\$Format,Header)** {*Text*}
: Wird nur aufgerufen, wenn **doc_gen** eine Datei erzeugt oder mit dem Flag ?-header_footer? aufgerufen wird. Die Prozedur erstellt den Dateikopf. Der übergebene Parameter ist der Name der Prozedur, für die die Dokumentation erstellt werden soll.

*02* - **gen(\$Format,Footer)** {*Text*}
: Wird nur aufgerufen, wenn **doc_gen** eine Datei erzeugt oder mit dem Flag ?-header_footer? aufgerufen wird. Die Prozedur erstellt den Dateifuß.

*03* - **gen(\$Format,Begin)** {}
: Erzeugt den Prolog (Präambel) der Dokumentation

*04* - **gen(\$Format,End)** {}
: Erzeugt den Epilog der Dokumentation

*20* - **gen(\$Format,SectionTitle)** {*Text*}
: Erzeugt eine Abschnittsüberschrift (z. B. *Name*, *Synopsis*, *Description*, …). Der Rohtext der Überschrift wird als Parameter übergeben.

*21* - **gen(\$Format,SubSectionTitle)** {*Text*}
: Erzeugt eine Überschrift für einen Unterabschnitt. Unterabschnitte werden verwendet, wenn für mehrere Unterbefehle eine einzige Dokumentation erstellt wird, um diese voneinander abzugrenzen. Der Rohtext der Überschrift wird als Parameter übergeben.

*30* - **gen(\$Format,Name)** {*Text*}
: Erzeugt den Abschnitt „Name“ (ohne Titel). Der Rohtext des Abschnitts wird als Parameter übergeben.

*40* - **gen(\$Format,Synopsis)** {*Text*}
: Erzeugt den Abschnitt „Synopsis“ (ohne Titel). Der als Parameter übergebene Abschnittstext ist vorformatiert (die Argumentzeichenfolgen werden von **gen(\$Format,ArgumentString)** generiert).

*50* - **gen(\$Format,Description)** {*Text*}
: Erzeugt einen Beschreibungsabsatz. Der Rohtext des Absatzes wird als Parameter übergeben.

*51* - **gen(\$Format,DescriptionListBegin)** {}
: Erzeugt den Prolog einer Aufzählungsliste (ungeordneten Liste) innerhalb des Beschreibungsabschnitts. Dieser Prolog ist in der Regel der Startcode einer Listenstruktur.

*52* - **gen(\$Format,DescriptionListEnd)** {}
: Erzeugt den Epilog einer Aufzählungsliste (ungeordneten Liste) innerhalb des Beschreibungsabschnitts. Dieser Epilog ist in der Regel der Abschlusscode einer Listenstruktur.

*53* - **gen(\$Format,DescriptionListItem)** {*Text*}
: Erzeugt einen Texteintrag in einer ungeordneten Beschreibungsliste (Aufzählungsliste). Der Rohtext des Eintrags wird als Parameter übergeben.

*54* - **gen(\$Format,DescriptionSynopsis)** {*Text*}
: Erzeugt die Synopsis-Zeile am Anfang des Beschreibungsabschnitts. Der Befehl kann eine leere Zeichenkette zurückgeben, wenn an dieser Stelle keine Synopsis-Zeile erforderlich ist. Einige Formate (z. B. Tcl DocTools) erfordern, dass die Synopsis-Zeile im Beschreibungsabschnitt definiert wird, um daraus automatisch den Synopsis-Abschnitt zu erstellen. Der als Parameter übergebene Abschnittstext ist vorformatiert (die Argumentzeichenfolgen werden von **gen(\$Format,ArgumentString)** generiert).

*60* - **gen(\$Format,ArgumentListBegin)** {}
: Erzeugt den Prolog der Argumentliste (Definitionsliste ohne Aufzählungszeichen). Dieser Prolog ist in der Regel der Startcode einer Definitionsliste.

*61* - **gen(\$Format,ArgumentListEnd)** {}
: Erzeugt den Epilog der Argumentliste. Dieser Epilog ist in der Regel die Abschlusszeichenfolge einer Listenstruktur.

*62* - **gen(\$Format,ArgumentListItem)** {Name IsOptional IsNamed Type}
: Erzeugt eine Argumentzeile innerhalb der Argumentliste. Dieser Befehl kann auf **gen(\$Format,ArgumentDetailBegin)** zurückgreifen, da die Parameter identisch sind.

*63* - **gen(\$Format,ArgumentDetailBegin)** {}
: Erzeugt den Prolog (Präambel) der Argumentdetails.

*64* - **gen(\$Format,ArgumentDetailEnd)** {}
: Erzeugt den Epilog der Argumentdetails

*65* - **gen(\$Format,ArgumentDescription)** {*Text*}
: Erzeugt die Argumentbeschreibung (ein Absatz).

*66* - **gen(\$Format,ArgumentAttribute)** {*Text*}
: Erzeugt die Zeichenkette für ein einzelnes Argumentattribut. Der Befehl wird für jedes Attribut einzeln aufgerufen.

*70* - **gen(\$Format,ExampleBegin)** {}
: Erzeugt den Prolog (Präambel) des Beispielabschnitts

*71* - **gen(\$Format,ExampleEnd)** {}
: Erzeugt den Epilog des Beispielabschnitts

*72* - **gen(\$Format,ExampleCommandLine)** {*Text*}
: Erzeugt im Beispielabschnitt eine einzelne Befehlszeile. Der Befehl wird für jede einzelne Befehlszeile aufgerufen.

*73* - **gen(\$Format,ExampleResultLine)** {*Text*}
: Erzeugt eine Befehlsergebniszeile

*80* - **gen(\$Format,ArgumentString)** {Name IsOptional IsNamed Type}
: Erzeugt den Teil der Befehlszeile oder der Synopsis, der sich auf ein bestimmtes Argument bezieht. Die erzeugte Zeichenkette muss angeben, ob ein Argument optional und benannt ist und ob es sich um ein Flag handelt. Dieser Prozedur werden die folgenden Parameter übergeben:


*Name*
: Name des Arguments

*IsOptional*
: Falls wahr (=**1**), ist das Argument optional, was durch die generierte Zeichenfolge kenntlich gemacht werden sollte (beispielsweise durch Einfügen des Arguments in Klammern {\[\]} oder in Fragezeichen '?'):


```
gen(TXT,ArgumentString) mtype 1 0 string -> "[mtype]"
```

*IsNamed*
: Wenn dieser Wert wahr ist (=**1**), handelt es sich bei einem Argument um ein benanntes Argument (Option). Die generierte Zeichenfolge sollte in diesem Fall den Namen des Arguments bzw. der Option enthalten, gefolgt vom Argument selbst:


```
gen(TXT,ArgumentString) mtype 0 1 string -> "-mtype <mtype>"
```

: Benannte Argumente können ebenfalls optional sein:


```
gen(TXT,ArgumentString) mtype 1 1 string -> "[-mtype <mtype>]"
```

*Type*
: Gibt den Typ des Arguments an. Wenn der Typ auf **none** gesetzt ist, handelt es sich bei dem Argument um ein Flag, das durch die generierte Zeichenfolge gekennzeichnet werden muss. Beispiel:


```
gen(TXT,ArgumentString) close 1 1 none -> "[-close]"
```

# BEISPIELE

## Tepam::doc_gen::generate

Das Paket **TEPAM Doc Gen** lässt sich erkunden, indem die Dokumentation des Befehls **tepam::doc_gen::generate** erzeugt wird. Das folgende Beispiel erzeugt das Dokument im Textformat (Standardformat):

```
tepam::doc_gen::generate tepam::doc_gen::generate
```

Das folgende Beispiel erzeugt die Dokumentation im HTML-Format:

```
tepam::doc_gen::generate -format HTML tepam::doc_gen::generate
```

Das Flag ?header_footer? fügt zusätzlich Dateikopf und -fuß hinzu:

```
tepam::doc_gen::generate -format HTML -header_footer tepam::doc_gen::generate
```

Die Dokumentation kann direkt in einer Datei gespeichert werden. Dateikopf und -fuß werden auf diese Weise automatisch generiert:

```
tepam::doc_gen::generate -format HTML -dest_file doc_gen.html tepam::doc_gen::generate
```

Die generierte HTML-Datei verweist auf eine CSS-Stylesheet-Datei (Vorgabewert: tepam_doc_stylesheet.css). Um die HTML-Datei korrekt anzuzeigen, muss diese CSS-Stylesheet-Datei in das Verzeichnis der generierten HTML-Datei kopiert werden.

Das Tcl-DOC-Tools-Format kann als Zwischenformat zur Erzeugung anderer Formate, beispielsweise HTML, verwendet werden:

```
# Generate the documentation in Tcl Doc Tool format
set dt [tepam::doc_gen::generate -format DT -header_footer tepam::doc_gen::generate]

# Create a new doc tools object (HTML format)
package require doctools
::doctools::new myDoc -format html

# Open the HTML file, and write the HTML formatted documentation
set fHtml [open doc_gen.dt.html w]
puts $fHtml [myDoc format $dt]
close $fHtml
```

## Tepam::doc_gen::patch

Während **generate** nur eine begrenzte Anzahl von Möglichkeiten zur Anpassung der Dokumentstruktur bietet, gewährt **patch** mehr Flexibilität. So können beispielsweise mehrere Dokumentationen für unterschiedliche Prozeduren sowie Metainformationen hinzugefügt werden.

Die folgende Auflistung veranschaulicht die Funktionsweise des Befehls **patch**. Zunächst wird eine Zeichenkette mit einem HTML-Masterdokument definiert, die zwei Platzhalter für Prozedurdokumentation enthält (*{\*\<ProcedureName>\*}*). Diese Platzhalter werden von **patch** durch die generierte Dokumentation der betreffenden Prozeduren ersetzt. Da vom Standard abweichende Platzhalter verwendet werden, wird **patch** mit einer expliziten Platzhaltermusterdefinition (Argument *search_pattern*) aufgerufen.

```
# Define the HTML master document
set HtmlMasterDoc {\
<html>
  <head>
    <title>tepam::doc_gen</title>
    <link rel="stylesheet" href="tepam_doc_stylesheet.css">
    <meta content="documentation" name="keywords"></meta>
  </head>
  <body>
    <h1>tepam::doc_gen</h1>
      <h2>Generate</h2>
{*tepam::doc_gen::generate*}
      <h2>Patch</h2>
{*tepam::doc_gen::patch*}
  </body>
<html>\
}

# Patch the master document: This will replace the placeholders by the
# procedure documentation divisions:
tepam::doc_gen::patch -format HTML -search_pattern {\{\*(.*?)\*\}} \
                      -src_string $HtmlMasterDoc -dest_file tepam_doc_gen.html
```

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2013, Andreas Drollinger
```
