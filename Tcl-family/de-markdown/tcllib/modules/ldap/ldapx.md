---
CommandName: ldapx
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: LDAP extended object interface
Keywords:
 - directory access
 - internet
 - ldap
 - ldap client
 - ldif
 - protocol
 - rfc 2251
 - rfc 2849
Copyright:
 - Copyright (c) 2006-2018 Pierre David <pdav@users.sourceforge.net>
---

# NAME

ldapx – Erweiterte LDAP-Objektschnittstelle

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [ldapx]{.lit} [1.3]{.optlit} 
[e]{.ins} [reset]{.sub} 
[e]{.ins} [dn]{.sub} [newdn]{.optarg} 
[e]{.ins} [rdn]{.sub} 
[e]{.ins} [superior]{.sub} 
[e]{.ins} [print]{.sub} 
[se]{.ins} [isempty]{.sub} 
[se]{.ins} [get]{.sub} [attr]{.arg} 
[se]{.ins} [get1]{.sub} [attr]{.arg} 
[se]{.ins} [set]{.sub} [attr]{.arg} [values]{.arg} 
[se]{.ins} [set1]{.sub} [attr]{.arg} [value]{.arg} 
[se]{.ins} [add]{.sub} [attr]{.arg} [values]{.arg} 
[se]{.ins} [add1]{.sub} [attr]{.arg} [value]{.arg} 
[se]{.ins} [del]{.sub} [attr]{.arg} [values]{.optarg} 
[se]{.ins} [del1]{.sub} [attr]{.arg} [value]{.arg} 
[se]{.ins} [getattr]{.sub} 
[se]{.ins} [getall]{.sub} 
[se]{.ins} [setall]{.sub} [avpairs]{.arg} 
[se]{.ins} [backup]{.sub} [other]{.optarg} 
[se]{.ins} [swap]{.sub} 
[se]{.ins} [restore]{.sub} [other]{.optarg} 
[se]{.ins} [apply]{.sub} [centry]{.arg} 
[ce]{.ins} [change]{.sub} [new]{.optarg} 
[ce]{.ins} [diff]{.sub} [new]{.arg} [old]{.optarg} 
[la]{.ins} [error]{.sub} [newmsg]{.optarg} 
[la]{.ins} [connect]{.sub} [url]{.arg} [binddn]{.optarg} [bindpw]{.optarg} [starttls]{.optarg} 
[la]{.ins} [disconnect]{.sub} 
[la]{.ins} [traverse]{.sub} [base]{.arg} [filter]{.arg} [attrs]{.arg} [entry]{.arg} [body]{.arg} 
[la]{.ins} [search]{.sub} [base]{.arg} [filter]{.arg} [attrs]{.arg} 
[la]{.ins} [read]{.sub} [base]{.arg} [filter]{.arg} [entry]{.arg} ... [entry]{.arg} 
[la]{.ins} [commit]{.sub} [entry]{.arg} ... [entry]{.arg} 
[li]{.ins} [channel]{.sub} [chan]{.arg} 
[li]{.ins} [error]{.sub} [newmsg]{.optarg} 
[li]{.ins} [read]{.sub} [entry]{.arg} 
[li]{.ins} [write]{.sub} [entry]{.arg} 
:::

# BESCHREIBUNG

Das Paket **ldapx** bietet eine erweiterte Tcl-Schnittstelle zu LDAP-Verzeichnissen und LDIF-Dateien. Das Paket **ldapx** baut auf dem Paket **ldap** auf, um einen Zugriff auf LDAP auf niedriger Ebene zu ermöglichen.

Der LDAP-Zugriff ist kompatibel mit RFC 2251 (*http://www.rfc-editor.org/rfc/rfc2251.txt*). Der LDIF-Zugriff ist kompatibel mit RFC 2849 (*http://www.rfc-editor.org/rfc/rfc2849.txt*).

# ÜBERBLICK

Das Paket **ldapx** stellt Objekte zur Verfügung, die über eine benutzerfreundliche Programmierschnittstelle die Interaktion mit LDAP-Verzeichnissen und LDIF-Dateien ermöglichen. Es implementiert drei Klassen als **snit**::type.

Die erste Klasse, **entry**, dient zur Speicherung einzelner Einträge. Es stehen zwei verschiedene Formate zur Verfügung: Das erste ist das *Standard*-Format, das einen Eintrag so darstellt, wie er aus dem Verzeichnis gelesen wurde. Das zweite Format ist das *Änderungs*-Format, das die Unterschiede zwischen zwei Standardeinträgen speichert.

Bei diesen Einträgen muss eine Anwendung, die einen Eintrag in einem Verzeichnis ändern möchte, einen (Standard-)Eintrag aus dem Verzeichnis lesen, eine neue Kopie in einem neuen (Standard-)Eintrag erstellen, die neue Kopie ändern und anschließend die Unterschiede zwischen den beiden Einträgen in einem neuen (Änderungs-)Eintrag berechnen, der dann im Verzeichnis festgeschrieben werden kann.

Da solche Änderungen so häufig vorgenommen werden, können Standardeinträge eine eigene Kopie der Originaldaten enthalten. Bei Vorhandensein einer solchen Kopie liest die oben beschriebene Anwendung einen (Standard-)Eintrag aus dem Verzeichnis, sichert die Originaldaten, ändert den Eintrag und berechnet die Unterschiede zwischen dem Eintrag und seiner Sicherungskopie. Diese Unterschiede werden anschließend im Verzeichnis festgeschrieben.

Es werden Methoden bereitgestellt, um Differenzen zwischen zwei Einträgen zu berechnen, Differenzen auf einen Eintrag anzuwenden, um einen neuen Eintrag zu erhalten, sowie um Attribute in Standardeinträgen abzufragen oder zu setzen.

Die zweite Klasse ist die Klasse **ldap**. Sie stellt eine Methode **connect** bereit, die die Verbindung zum Verzeichnis herstellt und den bind durchführt, mit einheitlichem Zugriff auf LDAP und LDAPS über eine URL (ldap:// oder ldaps://). Die Kontrollstruktur **traverse** führt für jeden im Verzeichnis gefundenen Eintrag einen Rumpf aus. Die Methode **commit** wendet einige Änderungen (dargestellt als **entry**-Objekte) auf das Verzeichnis an. Da einige Attribute als UTF-8-Zeichenketten dargestellt werden, steuert die Option **-utf8**, welche Attribute konvertiert werden müssen und welche nicht.

Die letzte Klasse ist die Klasse **ldif**. Sie stellt eine Methode bereit, mit der ein Standard-Tcl-*Kanal* einem LDIF-Objekt zugeordnet werden kann. Anschließend lesen oder schreiben die Methoden **read** und **write** Einträge aus diesem Kanal bzw. in diesen Kanal. Diese Klasse kann Standard- oder Änderungseinträge verwenden, je nach Typ der LDIF-Datei, die entweder Standardeinträge oder Änderungseinträge enthalten kann (jedoch nicht beides gleichzeitig). Die Option **-utf8** funktioniert genau wie bei der Klasse **ldap**.

# KLASSE ENTRY

## Instanzdaten von Entry

Eine Instanz der Klasse **entry** enthält die folgenden Daten:

**dn**
: Dies ist der DN des Eintrags, der (in der LDAP-Terminologie) den RDN (relativer DN) und den Superior-Teil (übergeordneter Teil) umfasst.

**format**
: Das Format kann *uninitialized* (Eintrag noch nicht verwendet), *standard* oder *change* sein. Die meisten Methoden überprüfen das Format des Eintrags, das mit der Methode **reset** zurückgesetzt werden kann.

**attrvals**
: In einem *Standard*-Eintrag werden hier die Attribute und die zugehörigen Werte gespeichert. Viele Methoden ermöglichen den Zugriff auf diese Informationen. Attributnamen werden stets in Kleinbuchstaben umgewandelt.

**backup**
: In einem *Standard*-Eintrag kann die Sicherungskopie eine Kopie des DN sowie aller Attribute und Werte enthalten. Die Methoden **backup** und **restore** bearbeiten diese Daten, und die Methode **diff** kann diese Sicherungskopie verwenden.

**change**
: In einem *Änderungs*-Eintrag stellen diese Daten die Änderungen dar. Solche Änderungen werden durch spezielle Methoden wie **apply** oder **commit** verarbeitet. Das detaillierte Format sollte nicht direkt von Programmen verwendet werden. Intern werden Änderungen als Liste von Elementen dargestellt, wobei jedes Element eines der folgenden Formate aufweist (die den entsprechenden LDAP-Operationen entsprechen):


**\[1\]**
: {**add** {attr1 {val1...valn} attr2 {...} ...}} Hinzufügen eines neuen Eintrags.

**\[2\]**
: {**mod** {modop {attr1 ?val1...valn?} attr2 ...} {modop ...} ...} Änderung eines oder mehrerer Attribute und/oder Werte, wobei \<modop> **modadd**, **moddel** oder **modrepl** sein kann (siehe die LDAP-Operation modify).

**\[3\]**
: {**del**} Löschen eines alten Eintrags.

**\[4\]**
: {**modrdn** newrdn deleteoldrdn ?newsuperior?} Umbenennung eines Eintrags.


## Entry-Optionen

Diese Klasse definiert keine Option.

## Methoden für alle Arten von Einträgen

*e* **reset**
: Diese Methode setzt den Eintrag in einen nicht initialisierten Zustand zurück.

*e* **dn** ?*newdn*?
: Diese Methode gibt den aktuellen DN des Eintrags zurück. Ist das optionale *newdn* angegeben, ersetzt es den aktuellen DN des Eintrags.

*e* **rdn**
: Diese Methode gibt den RDN-Teil des DN des Eintrags zurück.

*e* **superior**
: Diese Methode gibt den übergeordneten Teil des DN des Eintrags zurück.

*e* **print**
: Diese Methode gibt den Eintrag als druckfertige Zeichenkette zurück.


## Methoden ausschließlich für Standardeinträge

Bei allen Methoden werden Attributnamen in Kleinbuchstaben umgewandelt.

*se* **isempty**
: Diese Methode gibt den Wert 1 zurück, wenn der Eintrag leer ist (d. h. keine Attribute enthält).

*se* **get** *attr*
: Diese Methode gibt alle Werte des Attributs *attr* zurück oder eine leere Liste, wenn das Attribut nicht gefunden wird.

*se* **get1** *attr*
: Diese Methode gibt den ersten Wert des Attributs zurück.

*se* **set** *attr* *values*
: Diese Methode legt die Werte (list *values*) des Attributs *attr* fest. Wenn die Liste leer ist, löscht diese Methode alle

*se* **set1** *attr* *value*
: Diese Methode setzt die Werte des Attributs *attr* auf den einzigen Wert *value*. Etwaige bisherige Werte werden durch den neuen Wert ersetzt.

*se* **add** *attr* *values*
: Diese Methode fügt alle Elemente der list *values* den Werten des Attributs *attr* hinzu.

*se* **add1** *attr* *value*
: Diese Methode fügt dem Attribut *attr* einen einzelnen Wert hinzu, der durch den Parameter *value* vorgegeben wird.

*se* **del** *attr* ?*values*?
: Ist die optionale list *values* angegeben, löscht diese Methode alle angegebenen Werte aus dem Attribut *attr*. Ist das Argument *values* nicht angegeben, löscht diese Methode alle Werte.

*se* **del1** *attr* *value*
: Diese Methode löscht einen einzelnen Wert *value* aus dem Attribut *attr*.

*se* **getattr**
: Diese Methode gibt alle Attributnamen zurück.

*se* **getall**
: Diese Methode gibt alle Attribute und Werte des Eintrags zurück, zusammengefasst in einer Liste von Paaren \<Attribut, Liste der Werte>.

*se* **setall** *avpairs*
: Diese Methode legt alle Attribute und Werte auf einmal fest. Das Format des Arguments *avpairs* entspricht dem, das die Methode **getall** zurückgibt.

*se* **backup** ?*other*?
: Diese Methode speichert in einem anderen Standard-Eintragsobjekt *other* eine Kopie des aktuellen DN sowie der Attribute und Werte. Wenn das optionale Argument *other* nicht angegeben wird, erfolgt die Kopie im aktuellen Eintrag (an einer bestimmten Stelle, siehe Abschnitt **ÜBERBLICK**).

*se* **swap**
: Diese Methode tauscht den aktuellen und den Sicherungskontext des Eintrags aus.

*se* **restore** ?*other*?
: Wenn das optionale Argument *other* angegeben wird, das dann ein *Standard*-Eintrag sein muss, stellt diese Methode den aktuellen Eintrag in den Eintrag *other* wieder her. Wenn das Argument *other* nicht angegeben wird, stellt diese Methode den aktuellen Eintrag aus seiner internen Sicherungskopie wieder her (siehe Abschnitt **ÜBERBLICK**).

*se* **apply** *centry*
: Diese Methode wendet die im Argument *centry* definierten Änderungen an, das ein *Änderungs*-Eintrag sein muss.


## Methoden nur für Änderungseinträge

*ce* **change** ?*new*?
: Ist das optionale Argument *new* angegeben, ändert diese Methode die Änderungsliste (das genaue Format finden Sie im Unterabschnitt **Instanzdaten von Entry**). In beiden Fällen gibt sie die aktuelle Änderungsliste zurück. Warnung: Die von dieser Methode zurückgegebenen Werte sollten ausschließlich von speziellen Methoden wie **apply** oder **commit** verwendet werden.

*ce* **diff** *new* ?*old*?
: Diese Methode berechnet die Unterschiede zwischen den Einträgen *new* und *old* in Form einer Änderungsliste und speichert diese Liste im aktuellen *Änderungs*-Eintrag. Wenn das optionale Argument *old* nicht angegeben wird, wird der Unterschied anhand des Eintrags und seiner internen Sicherungskopie berechnet (siehe Abschnitt **ÜBERBLICK**). Der Rückgabewert ist die berechnete Änderungsliste.


## Beispiel für Entry

```
    package require ldapx

    #
    # Create an entry and fill it as a standard entry with
    # attributes and values
    #
    ::ldapx::entry create e
    e dn "uid=joe,ou=people,o=mycomp"
    e set1 "uid"             "joe"
    e set  "objectClass"     {person anotherObjectClass}
    e set1 "givenName"       "Joe"
    e set1 "sn"              "User"
    e set  "telephoneNumber" {+31415926535 +2182818}
    e set1 "anotherAttr"     "This is a beautiful day, isn't it?"

    puts stdout "e\n[e print]"

    #
    # Create a second entry as a backup of the first, and
    # make some changes on it.
    # Entry is named automatically by snit.
    #

    set b [::ldapx::entry create %AUTO%]
    e backup $b

    puts stdout "$b\n[$b print]"

    $b del  "anotherAttr"
    $b del1 "objectClass" "anotherObjectClass"

    #
    # Create a change entry, a compute differences between first
    # and second entry.
    #

    ::ldapx::entry create c
    c diff e $b

    puts stdout "$c\n[$c print]"

    #
    # Apply changes to first entry. It should be the same as the
    # second entry, now.
    #

    e apply c

    ::ldapx::entry create nc
    nc diff e $b

    puts stdout "nc\n[nc print]"

    #
    # Clean-up
    #

    e destroy
    $b destroy
    c destroy
    nc destroy
```

# KLASSE LDAP

## LDAP-Instanzdaten

Eine Instanz der Klasse **ldap** enthält die folgenden Daten:

**channel**
: Dies ist der Kanal, den das Paket **ldap** für die Kommunikation mit dem LDAP-Server verwendet.

**lastError**
: Diese Variable enthält die Fehlermeldung, die in der letzten Methode der Klasse **ldap** aufgetreten ist (diese Zeichenkette wird in fast allen Methoden geändert). Mit der Methode **error** können Sie diese Meldung abrufen.


## LDAP-Optionen

Die Optionen werden auf **ldap**-Instanzen mithilfe der Methode **configure** konfiguriert.

Die erste Option wird für TLS-Parameter verwendet:

**-tlsoptions** *list*
: Legt die TLS-Optionen fest, die beim Verbinden mit dem LDAP-Server verwendet werden (siehe die Methode **connect**). Eine Liste der gültigen Optionen finden Sie in der Dokumentation zum Paket **LDAP**. Der Standardwert ist **-request 1 -require 1 -ssl2 no -ssl3 no -tls1 yes -tls1.1 yes -tls1.2 yes**. Beispiel:


```
$l configure -tlsoptions {-request yes -require yes}
```

Bei Suchvorgängen wird eine Reihe von Optionen der Klasse **ldap** verwendet (Methoden **traverse**, **search** und **read**, siehe unten).

**-scope** **base**|**one**|**sub**
: Legt den Suchbereich der LDAP-Suche auf **base**, **one** oder **sub** fest, für eine Suche nur im Basisobjekt, auf einer Ebene oder im ganzen Teilbaum. Standard ist **sub**.

**-derefaliases** **never**|**seach**|**find**|**always**
: Legt fest, wie Aliase dereferenziert werden: **never** bedeutet, dass Aliase nie dereferenziert werden, **always**, dass Aliase immer dereferenziert werden, **search**, dass Aliase beim Suchen dereferenziert werden, oder **find**, dass Aliase nur  beim Auffinden  des  Basisobjekts der Suche dereferenziert werden. Standard ist **never**.

**-sizelimit** integer
: Legt die maximale Anzahl der Einträge fest, die bei einer Suche abgerufen werden. Der Wert **0** bedeutet keine Begrenzung. Standard ist **0**.

**-timelimit** integer
: Legt das Zeitlimit für den Abschluss einer Suche fest. Der Wert **0** bedeutet keine Begrenzung. Standard ist **0**.

**-attrsonly** **0**|**1**
: Legt fest, ob nur Attributnamen abgerufen werden sollen (Wert **1**). Standardmäßig (Wert **0**) werden auch Attributwerte abgerufen. Standard ist **0**. Die letzte Option wird verwendet, wenn Einträge abgerufen oder Änderungen im Verzeichnis festgeschrieben werden:

**-utf8** pattern-yes pattern-no
: Legt fest, welche Attributwerte in UTF-8 kodiert sind. Diese Angabe hängt vom LDAP-Schema der Anwendung ab, da einige Attribute, wie beispielsweise jpegPhoto, nicht in UTF-8 kodiert sind. Diese Option hat die Form einer Liste mit zwei regulären Ausdrücken, die für den Befehl **regexp** geeignet sind (mit den Ankerzeichen ^ und \$). Der erste legt fest, welche Attributnamen in UTF-8 kodiert werden sollen, und der zweite wählt unter diesen die Attributnamen aus, die nicht in UTF-8 kodiert werden. So lässt sich sagen: alle Attribute konvertieren, außer jpegPhoto. Die Standardeinstellung lautet {{.\*} {}}, was bedeutet: Alle Attribute werden ausnahmslos konvertiert.


## LDAP-Methoden

*la* **error** ?*newmsg*?
: Diese Methode gibt die Fehlermeldung zurück, die beim letzten Aufruf einer Methode der Klasse **ldap** aufgetreten ist. Wenn das optionale Argument *newmsg* übergeben wird, wird dieses zur letzten Fehlermeldung.

*la* **connect** *url* ?*binddn*? ?*bindpw*? ?*starttls*?
: Diese Methode stellt über die angegebene URL (die die Form *ldap://host:port* oder *ldaps://host:port* haben kann) eine Verbindung zum LDAP-Server her. Wenn ein optionales *binddn*-Argument zusammen mit dem *bindpw*-Argument angegeben wird, führt **connect** mit dem angegebenen DN und Passwort einen bind beim LDAP-Server durch. Erhält das Argument *starttls* einen wahren Wert (**1**, **yes** usw.) und verwendet die URL das Schema *ldap://*, wird vor dem LDAP-bind eine TLS-Aushandlung auf der neu erstellten Verbindung gestartet. Standardwert: **no**. Diese Methode gibt 1 zurück, wenn die Verbindung erfolgreich hergestellt wurde, oder 0, wenn ein Fehler aufgetreten ist (verwenden Sie die Methode **error**, um die Fehlermeldung abzurufen).

*la* **disconnect**
: Diese Methode trennt die Verbindung zum LDAP-Server (und führt gegebenenfalls ein unbind durch).

*la* **traverse** *base* *filter* *attrs* *entry* *body*
: Diese Methode ist eine neue Kontrollstruktur. Sie durchsucht das LDAP-Verzeichnis ab dem angegebenen Base DN (Argument *base*) und wählt Einträge anhand des Arguments *filter* aus. Für jeden gefundenen Eintrag ruft diese Methode die durch das Argument *attrs* festgelegten Attribute ab (oder alle Attribute, wenn es sich um eine leere Liste handelt), speichert diese in der Instanz *entry* der Klasse **entry** und führt das durch das Argument *body* definierte Skript aus. Mit den Optionen lässt sich die Suche verfeinern. Achtung: Wenn diese Methode verwendet wird, darf das Skript *body* keine weitere LDAP-Suche durchführen (Methoden **traverse**, **search** oder **read**).

*la* **search** *base* *filter* *attrs*
: Diese Methode durchsucht das Verzeichnis auf dieselbe Weise wie die Methode **traverse**. Alle gefundenen Einträge werden in neu angelegten Instanzen der Klasse **entry** gespeichert, die als Liste zurückgegeben werden. Die neu angelegten Instanzen sollten zerstört werden, sobald sie nicht mehr benötigt werden.

*la* **read** *base* *filter* *entry* ... *entry*
: Diese Methode liest einen oder mehrere Einträge unter Verwendung derselben Suchkriterien wie die Methoden **traverse** und **search**. Alle Attribute werden in den Einträgen gespeichert. Diese Methode bietet eine schnelle Möglichkeit, einige Einträge auszulesen. Sie gibt die Anzahl der im Verzeichnis gefundenen Einträge zurück (die größer sein kann als die Anzahl der ausgelesenen Einträge). Wird diese Methode ohne ein *entry*-Argument aufgerufen, gibt sie lediglich die Anzahl der gefundenen Einträge zurück, ohne Daten zu liefern.

*la* **commit** *entry* ... *entry*
: Diese Methode schreibt die in den Argumenten *entry* gespeicherten Änderungen fest. Jedes *entry* kann entweder ein *Änderungs*-Eintrag oder ein *Standard*-Eintrag mit Sicherungskopie sein. Hinweis: Künftig sollte diese Methode die von OpenLDAP 2.3 und höher bereitgestellte LDAP-Transaktionserweiterung verwenden.


## LDAP-Beispiel

```
    package require ldapx

    #
    # Connects to the LDAP directory using StartTLS
    #

    ::ldapx::ldap create l
    l configure -tlsoptions {-cadir /etc/ssl/certs -request yes -require yes}
    set url "ldap://server.mycomp.com"
    if {! [l connect $url "cn=admin,o=mycomp" "mypasswd" yes]} then {
	puts stderr "error: [l error]"
	exit 1
    }

    #
    # Search all entries matching some criterion
    #

    l configure -scope one
    ::ldapx::entry create e
    set n 0
    l traverse "ou=people,o=mycomp" "(sn=Joe*)" {sn givenName} e {
	puts "dn: [e dn]"
	puts "  sn:        [e get1 sn]"
	puts "  givenName: [e get1 givenName]"
	incr n
    }
    puts "$n entries found"
    e destroy

    #
    # Add a telephone number to some entries
    # Note this modification cannot be done in the "traverse" operation.
    #

    set lent [l search "ou=people,o=mycomp" "(sn=Joe*)" {}]
    ::ldapx::entry create c
    foreach e $lent {
	$e backup
	$e add1 "telephoneNumber" "+31415926535"
	c diff $e
	if {! [l commit c]} then {
	    puts stderr "error: [l error]"
	    exit 1
	}
	$e destroy
    }
    c destroy

    l disconnect
    l destroy
```

# KLASSE LDIF

## LDIF-Instanzdaten

Eine Instanz der Klasse **ldif** enthält die folgenden Daten:

**channel**
: Dies ist der Tcl-Kanal, über den der Inhalt von LDIF-Dateien gelesen oder gespeichert wird. Die Zuordnung zwischen einer Instanz und einem Kanal erfolgt über die Methode **channel**. Es ist nicht erforderlich, diese Zuordnung aufzuheben, wenn der Vorgang mit der LDIF-Datei beendet ist.

**format**
: LDIF-Dateien können entweder *Standard*-Einträge oder *Änderungs*-Einträge enthalten, jedoch nicht beides. Diese Variable enthält das erkannte Format der Datei (beim Lesen) bzw. das Format der in die Datei geschriebenen Einträge (beim Schreiben).

**lastError**
: Diese Variable enthält die Fehlermeldung, die in der letzten Methode der Klasse **ldif** aufgetreten ist (diese Zeichenkette wird in fast allen Methoden geändert). Mit der Methode **error** können Sie diese Meldung abrufen.

**version**
: Dies ist die Version der LDIF-Datei. Es wird ausschließlich Version 1 unterstützt: Die Methode **read** kann nur Dateien der Version 1 lesen, und die Methode **write** erstellt ausschließlich Dateien der Version 1.


## LDIF-Optionen

Diese Klasse definiert zwei Optionen:

**-ignore** list-of-attributes
: Diese Option dient dazu, bestimmte Attributnamen beim Lesen zu ignorieren. Um beispielsweise OpenLDAP-Replikdateien (replog) einzulesen, müssen die Attribute **replica** und **time** ignoriert werden, da sie nicht dem RFC 2849-Standard für LDIF-Dateien entsprechen. Standardmäßig ist die Liste leer: Es wird kein Attribut ignoriert.

**-utf8** pattern-yes pattern-no
: Legt fest, welche Attributwerte in UTF-8 kodiert sind. Diese Angabe hängt vom LDAP-Schema der Anwendung ab, da einige Attribute, wie beispielsweise jpegPhoto, nicht in UTF-8 kodiert sind. Diese Option hat die Form einer Liste mit zwei regulären Ausdrücken, die für den Befehl **regexp** geeignet sind (mit den Ankerzeichen ^ und \$). Der erste legt fest, welche Attributnamen in UTF-8 kodiert werden sollen, und der zweite wählt unter diesen die Attributnamen aus, die nicht in UTF-8 kodiert werden. So lässt sich sagen: alle Attribute konvertieren, außer jpegPhoto. Die Standardeinstellung lautet {{.\*} {}}, was bedeutet: Alle Attribute werden ausnahmslos konvertiert.


## LDIF-Methoden

*li* **channel** *chan*
: Diese Methode ordnet den Tcl-Kanal mit dem Namen *chan* der LDIF-Instanz zu. Dabei wird der Typ des LDIF-Objekts auf *uninitialized* zurückgesetzt.

*li* **error** ?*newmsg*?
: Diese Methode gibt die Fehlermeldung zurück, die beim letzten Aufruf einer Methode der Klasse **ldif** aufgetreten ist. Wenn das optionale Argument *newmsg* übergeben wird, wird dieses zur letzten Fehlermeldung.

*li* **read** *entry*
: Diese Methode liest den nächsten Eintrag aus der LDIF-Datei und speichert ihn im Objekt *entry* der Klasse **entry**. Bei dem Eintrag kann es sich um einen *Standard*- oder einen *Änderungs*-Eintrag handeln.

*li* **write** *entry*
: Diese Methode schreibt den im Argument *entry* angegebenen Eintrag in die LDIF-Datei.


## LDIF-Beispiel

```
    package require ldapx

    # This examples reads a LDIF file containing entries,
    # compare them to a LDAP directory, and writes on standard
    # output an LDIF file containing changes to apply to the
    # LDAP directory to match exactly the LDIF file.

    ::ldapx::ldif create liin
    liin channel stdin

    ::ldapx::ldif create liout
    liout channel stdout

    ::ldapx::ldap create la
    if {! [la connect "ldap://server.mycomp.com"]} then {
	puts stderr "error: [la error]"
	exit 1
    }
    la configure -scope one

    # Reads LDIF file

    ::ldapx::entry create e1
    ::ldapx::entry create e2
    ::ldapx::entry create c

    while {[liin read e1] != 0} {
	set base [e1 superior]
	set id [e1 rdn]
	if {[la read $base "($id)" e2] == 0} then {
	    e2 reset
	}

	c diff e1 e2
	if {[llength [c change]] != 0} then {
	    liout write c
	}
    }

    la disconnect
    la destroy
    e1 destroy
    e2 destroy
    c destroy
    liout destroy
    liin destroy
```

# LITERATUR

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *ldap* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2006-2018 Pierre David <pdav@users.sourceforge.net>
```
