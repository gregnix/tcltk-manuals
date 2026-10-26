---
CommandName: zlib
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - binary(n)
 - chan(n)
 - encoding(n)
 - Tcl_ZlibDeflate(3)
 - RFC1950 - RFC1952
Keywords:
 - compress
 - decompress
 - deflate
 - gzip
 - inflate
 - zlib
Copyright:
 - Copyright (c) 2008-2012 Donal K. Fellows
---

# NAME

zlib - Komprimierungs- und Dekomprimierungsoperationen

# ÜBERSICHT

::: {.synopsis} :::
[zlib]{.cmd} [subcommand]{.arg} [arg]{.arg} [...]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **zlib** stellt Zugriff auf die Komprimierungs- und Prüfsummenfunktionen der Zlib-Bibliothek von Jean-loup Gailly und Mark Adler bereit. Er verfügt über folgende Unterbefehle.

## Komprimierungs-Unterbefehle

**zlib compress** *string* ?*level*?
: Gibt die komprimierten Binärdaten im zlib-Format der Binärzeichenkette in *string* zurück. Ist *level* angegeben, legt es die zu verwendende Komprimierungsstufe fest (von 0, unkomprimiert, bis 9, maximal komprimiert).

**zlib decompress** *string* ?*bufferSize*?
: Gibt die unkomprimierte Version der rohen komprimierten Binärdaten in *string* zurück. Ist *bufferSize* angegeben, ist es ein Hinweis auf die Puffergröße, die zum Empfang der Daten verwendet werden soll.

**zlib deflate** *string* ?*level*?
: Gibt die rohen komprimierten Binärdaten der Binärzeichenkette in *string* zurück. Ist *level* angegeben, legt es die zu verwendende Komprimierungsstufe fest (von 0, unkomprimiert, bis 9, maximal komprimiert).

**zlib gunzip** *string* ?**-headerVar** *varName*?
: Gibt den unkomprimierten Inhalt der Binärzeichenkette *string* zurück, die im gzip-Format vorliegen muss. Ist **-headerVar** angegeben, speichert er ein Dictionary, das den Inhalt des gzip-Headers beschreibt, in der Variable *varName*. Die Schlüssel des Dictionarys, die vorhanden sein können, sind:

**comment**
: Das Kommentarfeld aus dem Header, falls vorhanden.

**crc**
: Ein boolescher Wert, der angibt, ob eine CRC des Headers berechnet wird.

**filename**
: Das Dateinamenfeld aus dem Header, falls vorhanden.

**os**
: Das Feld für den Betriebssystemtypcode aus dem Header (wenn nicht der QW-Unbekannt-Wert). Siehe RFC 1952 für die Bedeutung dieser Codes.

**size**
: Die Größe der unkomprimierten Daten.

**time**
: Das Zeitfeld aus dem Header, falls ungleich null; erwartet wird die Zeit, zu der die Datei mit dem Namen aus dem Feld **filename** geändert wurde. Geeignet für die Verwendung mit **clock format**.

**type**
: Der Typ der unkomprimierten Daten (**binary** oder **text**), falls bekannt.


**zlib gzip** *string* ?**-level** *level*? ?**-header** *dict*?
: Gibt den komprimierten Inhalt der Binärzeichenkette *string* im gzip-Format zurück. Ist **-level** angegeben, legt *level* die zu verwendende Komprimierungsstufe fest (von 0, unkomprimiert, bis 9, maximal komprimiert). Ist **-header** angegeben, ist *dict* ein Dictionary mit Werten für den gzip-Header. Folgende Schlüssel können definiert werden:

**comment**
: Fügt den angegebenen Kommentar dem Header der gzip-formatierten Daten hinzu.

**crc**
: Ein boolescher Wert, der angibt, ob eine CRC des Headers berechnet werden soll. Beachten Sie, dass bei Datenaustausch mit dem Programm **gzip** keine Header-CRC berechnet werden sollte.

**filename**
: Der Name der Datei, aus der die zu komprimierenden Daten stammen.

**os**
: Der Betriebssystemtypcode, der einer der in RFC 1952 beschriebenen Werte sein sollte.

**time**
: Die Zeit, zu der die Datei mit dem Schlüssel **filename** zuletzt geändert wurde. Entspricht dem Rückgabewert von **clock seconds** oder **file mtime**.

**type**
: Der Typ der komprimierten Daten, entweder **binary** oder **text**.


**zlib inflate** *string* ?*bufferSize*?
: Gibt die unkomprimierte Version der rohen komprimierten Binärdaten in *string* zurück. Ist *bufferSize* angegeben, ist es ein Hinweis auf die Puffergröße, die zum Empfang der Daten verwendet werden soll.


## Kanal-Unterbefehl

**zlib push** *mode channel* ?*options ...*?
: Legt eine komprimierende oder dekomprimierende Transformation auf den Kanal *channel* auf. Die Transformation kann mit **chan pop** wieder entfernt werden. Das Argument *mode* bestimmt, welche Art von Transformation aufgelegt wird; Folgendes wird unterstützt:

**compress**
: Die Transformation komprimiert und erzeugt zlib-formatierte Daten auf *channel*, der beschreibbar sein muss.

**decompress**
: Die Transformation dekomprimiert und liest zlib-formatierte Daten von *channel*, der lesbar sein muss.

**deflate**
: Die Transformation komprimiert und erzeugt rohe komprimierte Daten auf *channel*, der beschreibbar sein muss.

**gunzip**
: Die Transformation dekomprimiert und liest gzip-formatierte Daten von *channel*, der lesbar sein muss.

**gzip**
: Die Transformation komprimiert und erzeugt gzip-formatierte Daten auf *channel*, der beschreibbar sein muss.

**inflate**
: Die Transformation dekomprimiert und liest rohe komprimierte Daten von *channel*, der lesbar sein muss.

    Folgende Optionen können beim Erstellen einer Transformation über die „*options ...*“ des Befehls **zlib push** gesetzt werden:

**-dictionary** *binData*
: Legt das zu verwendende Komprimierungswörterbuch auf *binData* fest, wenn komprimierende oder dekomprimierende Transformationen angewendet werden. Nicht gültig für Transformationen, die mit gzip-formatierten Daten arbeiten. Das Wörterbuch sollte aus Zeichenketten (Bytefolgen) bestehen, die später in den zu komprimierenden Daten wahrscheinlich vorkommen, wobei die am häufigsten verwendeten Zeichenketten vorzugsweise ans Ende des Wörterbuchs gesetzt werden sollten. Tcl bietet keinen Mechanismus zur Auswahl eines geeigneten Wörterbuchs für eine bestimmte Datenfolge.

**-header** *dictionary*
: Übergibt eine Beschreibung des zu erstellenden gzip-Headers im gleichen Format, das **zlib gzip** versteht.

**-level** *compressionLevel*
: Legt fest, wie stark die Daten komprimiert werden. Muss eine Ganzzahl von 0 (unkomprimiert) bis 9 (maximal komprimiert) sein.

**-limit** *readaheadLimit*
: Die maximale Anzahl von Bytes, die beim Dekomprimieren vorausgelesen werden.

    Diese Option ist **obsolet** geworden. Sie wurde ursprünglich eingeführt, um zu verhindern, dass Tcl in Mehrfachstream-Kanälen über das Ende eines komprimierten Streams hinaus liest, damit die anschließenden Daten für weiteres Lesen unberührt bleiben — auf Kosten der Geschwindigkeit.
    Tcl gibt jetzt automatisch alle Bytes, die über das Ende eines komprimierten Streams hinaus gelesen wurden, an den Kanal zurück, sodass sie für nachfolgende Leser als ungelesen erscheinen.


Sowohl komprimierende als auch dekomprimierende Kanaltransformationen fügen zusätzliche Konfigurationsoptionen hinzu, die über **chan configure** abgerufen werden können. Die Optionen sind:

**-checksum** *checksum*
: Diese schreibgeschützte Option liefert die aktuelle Prüfsumme für die unkomprimierten Daten, die die Komprimierungs-Engine bisher gesehen hat. Gültig für komprimierende und dekomprimierende Transformationen, aber nicht für die rohen inflate- und deflate-Formate. Der Komprimierungsalgorithmus hängt davon ab, welches Format erzeugt oder verarbeitet wird.

**-dictionary** *binData*
: Diese lese-schreibbare Option liest oder setzt das anfängliche Komprimierungswörterbuch auf *binData*, wenn komprimierende oder dekomprimierende Transformationen angewendet werden. Nicht gültig für Transformationen, die mit gzip-formatierten Daten arbeiten, und sollte bei komprimierenden Transformationen normalerweise nur beim Auflegen der Transformation gesetzt werden. Beachten Sie, dass damit nicht das aktuell aktive Komprimierungswörterbuch mitten im Stream abgefragt werden kann, da diese Information von der zugrunde liegenden Bibliothek nicht bereitgestellt wird.

**-flush** *type*
: Diese nur-schreibbare Operation leert den aktuellen Zustand des Komprimierers in den zugrunde liegenden Kanal. Nur gültig für komprimierende Transformationen. *type* muss entweder **sync** oder **full** sein — für ein normales bzw. aufwendiges Leeren. Leeren verschlechtert das Komprimierungsverhältnis, erleichtert aber einem Dekomprimierer die Wiederherstellung eines größeren Teils der Datei bei Datenbeschädigung.

**-header** *dictionary*
: Diese schreibgeschützte Option, nur gültig für dekomprimierende Transformationen, die gzip-formatierte Daten verarbeiten, gibt das Dictionary zurück, das den aus dem Datenstrom gelesenen Header beschreibt.

**-limit** *readaheadLimit*
: Diese lese-schreibbare Option steuert bei dekomprimierenden Kanälen die maximale Anzahl vorausgelesener Bytes aus der zugrunde liegenden Datenquelle. Siehe oben für weitere Informationen.


## Streaming-Unterbefehl

**zlib stream** *mode* ?*options*?
: Erstellt einen Streaming-Komprimierungs- oder Dekomprimierungsbefehl basierend auf *mode* und gibt den Namen des Befehls zurück. Eine Beschreibung der Funktionsweise finden Sie unter **STREAMING-INSTANZBEFEHL** weiter unten. Folgende Modi und *options* werden unterstützt:

**zlib stream compress** ?**-dictionary** *bindata*? ?**-level** *level*?
: Der Stream komprimiert und erzeugt Ausgabe im zlib-Format, mit der Komprimierungsstufe *level* (falls angegeben; eine Ganzzahl von 0 bis 9) und dem Komprimierungswörterbuch *bindata* (falls angegeben).

**zlib stream decompress** ?**-dictionary** *bindata*?
: Der Stream dekomprimiert Eingabe im zlib-Format und erzeugt unkomprimierte Ausgabe. Ist *bindata* angegeben, ist es ein bei Bedarf zu verwendendes Komprimierungswörterbuch.

**zlib stream deflate** ?**-dictionary** *bindata*? ?**-level** *level*?
: Der Stream komprimiert und erzeugt rohe Ausgabe, mit der Komprimierungsstufe *level* (falls angegeben; eine Ganzzahl von 0 bis 9) und dem Komprimierungswörterbuch *bindata* (falls angegeben). Beachten Sie, dass die rohen komprimierten Daten keine Metadaten darüber enthalten, welches Komprimierungswörterbuch — falls überhaupt — verwendet wurde; das ist ein Merkmal der zlib-formatierten Daten.

**zlib stream gunzip**
: Der Stream dekomprimiert Eingabe im gzip-Format und erzeugt unkomprimierte Ausgabe.

**zlib stream gzip** ?**-header** *header*? ?**-level** *level*?
: Der Stream komprimiert und erzeugt Ausgabe im gzip-Format, mit der Komprimierungsstufe *level* (falls angegeben; eine Ganzzahl von 0 bis 9) und dem Header-Deskriptor-Dictionary *header* (falls angegeben; Schlüssel siehe **zlib gzip**).

**zlib stream inflate** ?**-dictionary** *bindata*?
: Der Stream dekomprimiert rohe komprimierte Eingabe und erzeugt unkomprimierte Ausgabe. Ist *bindata* angegeben, ist es ein zu verwendendes Komprimierungswörterbuch. Beachten Sie, dass keine Prüfungen vorhanden sind, ob das Komprimierungswörterbuch korrekt ist.



## Prüfsummen-Unterbefehle

**zlib adler32** *string* ?*initValue*?
: Berechnet eine Prüfsumme der Binärzeichenkette *string* mit dem Adler-32-Algorithmus. Ist *initValue* angegeben, initialisiert er damit die Prüfsummen-Engine.

**zlib crc32** *string* ?*initValue*?
: Berechnet eine Prüfsumme der Binärzeichenkette *string* mit dem CRC-32-Algorithmus. Ist *initValue* angegeben, initialisiert er damit die Prüfsummen-Engine.


# STREAMING-INSTANZBEFEHL

Streaming-Komprimierungs-Instanzbefehle werden vom Befehl **zlib stream** erzeugt. Sie werden verwendet, indem ihr Unterbefehl **put** ein- oder mehrmals aufgerufen wird, um Daten zu laden, und ihr Unterbefehl **get** ein- oder mehrmals, um die transformierten Daten zu extrahieren.

Die vollständige Menge der von einem Streaming-Instanzbefehl *stream* unterstützten Unterbefehle lautet:

*stream* **add** ?*option...*? *data*
: Eine Abkürzung für „*stream* **put** ?*option...*? *data*“ gefolgt von „*stream* **get**“.

*stream* **checksum**
: Gibt die Prüfsumme der unkomprimierten Daten zurück, die dieser Stream bisher gesehen hat.

*stream* **close**
: Löscht diesen Stream und gibt alle zugehörigen Ressourcen frei.

*stream* **eof**
: Gibt einen booleschen Wert zurück, der angibt, ob das Ende des Streams (wie durch die komprimierten Daten selbst bestimmt) erreicht wurde. Nicht alle Formate unterstützen die Erkennung des Streamendes.

*stream* **finalize**
: Abkürzung für „*stream* **put -finalize {}**“.

*stream* **flush**
: Abkürzung für „*stream* **put -flush {}**“.

*stream* **fullflush**
: Abkürzung für „*stream* **put -fullflush {}**“.

*stream* **get** ?*count*?
: Gibt bis zu *count* Bytes aus den internen Puffern von *stream* mit angewendeter Transformation zurück. Fehlt *count*, wird der gesamte Pufferinhalt zurückgegeben.

*stream* **header**
: Gibt das Dictionary mit der gzip-Header-Beschreibung zurück, das aus dem Stream extrahiert wurde. Nur unterstützt für Streams, die mit dem *mode*-Parameter **gunzip** erstellt wurden.

*stream* **put** ?*option...*? *data*
: Hängt den Inhalt der Binärzeichenkette *data* an die internen Puffer von *stream* an und wendet dabei die Transformation an. Folgende *option*en werden unterstützt (oder ein eindeutiges Präfix davon), die die Art der Transformation beeinflussen:

**-dictionary** *binData*
: Legt das zu verwendende Komprimierungswörterbuch auf *binData* fest, wenn komprimierende oder dekomprimierende Transformationen angewendet werden.

**-finalize**
: Markiert den Stream als abgeschlossen und stellt sicher, dass alle Bytes vollständig komprimiert oder dekomprimiert wurden. Bei gzip-Streams wird damit auch sichergestellt, dass der Footer in den Stream geschrieben wird. Der Stream muss danach zurückgesetzt werden, bevor weitere Daten geschrieben werden können; gelesen werden kann er weiterhin mit dem Unterbefehl **get**.

    Diese Option schließt sich gegenseitig mit den Optionen **-flush** und **-fullflush** aus.

**-flush**
: Stellt sicher, dass ein Dekomprimierer, der die vom aktuellen (komprimierenden) Stream erzeugten Bytes verarbeitet, alle bisher komprimierten Bytes ausgeben kann — mit einem gewissen Leistungseinbußen.
    Diese Option schließt sich gegenseitig mit den Optionen **-finalize** und **-fullflush** aus.

**-fullflush**
: Stellt sicher, dass nicht nur ein Dekomprimierer alle bisher erzeugten Bytes verarbeiten kann (wie bei **-flush** oben), sondern auch von diesem Punkt aus neu starten kann, wenn er feststellt, dass der Stream teilweise beschädigt ist. Dies verursacht erhebliche Leistungseinbußen.
    Diese Option schließt sich gegenseitig mit den Optionen **-finalize** und **-flush** aus.

*stream* **reset**
: Setzt jeden Stream, einschließlich finalisierter oder EOF-erreichte, in einen Zustand zurück, in dem er weitere Daten verarbeiten kann. Verwirft alle intern gepufferten Daten.


# BEISPIELE

Um eine Tcl-Zeichenkette zu komprimieren, sollte sie zuerst in eine bestimmte Zeichensatzkodierung umgewandelt werden, da der Befehl **zlib** immer auf Binärzeichenketten arbeitet.

```
set binData [encoding convertto utf-8 $string]
set compData [zlib compress $binData]
```

Beim Rückwandeln ist es ebenfalls wichtig, die Zeichensatzkodierung rückgängig zu machen:

```
set binData [zlib decompress $compData]
set string [encoding convertfrom utf-8 $binData]
```

Die Komprimierung von oben kann auch mit Streams durchgeführt werden, was besonders hilfreich ist, wenn die Daten schrittweise aufgebaut werden sollen:

```
set strm [zlib stream compress]
$strm put [encoding convertto utf-8 $string]
# ...
$strm finalize
set compData [$strm get]
$strm close
```
