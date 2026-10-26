---
CommandName: dde
title: dde
ManualSection: n
Version: 1.4
TclPart: dde
TclDescription: Tcl Bundled Packages
Links:
 - tk(n)
 - winfo(n)
 - send(n)
Keywords:
 - application
 - dde
 - name
 - remote execution
Copyright:
 - Copyright (c) 1997 Sun Microsystems, Inc.
 - Copyright (c) 2001 ActiveState Corporation.
---

# Name

dde - Dynamic-Data-Exchange-Befehl ausführen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [dde]{.lit} [1.4]{.lit}
[dde]{.cmd} [servername]{.sub} [-force]{.optlit} [[-handler]{.lit} [proc]{.arg}]{.optarg} [--]{.optlit} [topic]{.optarg}
[dde]{.cmd version="8.6"} [execute]{.sub} [-async]{.optlit} [-binary]{.optlit} [service]{.arg} [topic]{.arg} [data]{.arg}
[dde]{.cmd version="8.6"} [poke]{.sub} [-binary]{.optlit} [service]{.arg} [topic]{.arg} [item]{.arg} [data]{.arg}
[dde]{.cmd} [request]{.sub} [-binary]{.optlit} [service]{.arg} [topic]{.arg} [item]{.arg}
[dde]{.cmd} [services]{.sub} [service]{.arg} [topic]{.arg}
[dde]{.cmd} [eval]{.sub} [-async]{.optlit} [topic]{.arg} [cmd]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl lässt eine Anwendung unter Microsoft Windows einen Dynamic-Data-Exchange-Befehl (DDE) senden. Dynamic Data Exchange ist ein Verfahren, mit dem Anwendungen Rohdaten austauschen. Jede DDE-Transaktion braucht einen *service name* und ein *topic*. Beides legt die Anwendung fest. Tcl verwendet den Dienstnamen **TclEval**, der Themenname ist der Name des Interpreters aus **dde servername**. Andere Anwendungen haben eigene Dienstnamen und Themen. Microsoft Excel verwendet zum Beispiel den Dienstnamen **Excel**.

# DDE-Befehle

Die folgenden Befehle sind eine Teilmenge des vollständigen Dynamic-Data-Exchange-Befehlssatzes.

**dde servername** ?**-force**? ?**-handler** *proc*? ?**--**? ?*topic*?
: **dde servername** registriert den Interpreter als DDE-Server mit dem Dienstnamen **TclEval** und dem durch *topic* angegebenen Themennamen. Fehlt *topic*, gibt **dde servername** den Namen des aktuellen Themas zurück oder die leere Zeichenkette, wenn der Interpreter nicht als Dienst registriert ist. Ist der angegebene Themenname schon vergeben, wird ein Suffix der Form „ #2“ oder „ #3“ angehängt, damit der Name eindeutig ist. Das Ergebnis des Befehls ist der tatsächlich verwendete Name. **-force** erzwingt die Registrierung genau des angegebenen Themennamens.

    Die Option **-handler** legt eine Tcl-Prozedur fest, die Aufrufe an den DDE-Server verarbeitet. Wurde das Paket in einen sicheren Interpreter geladen, muss eine **-handler**-Prozedur definiert sein. Die Prozedur erhält alle Argumente des entfernten Aufrufs.

**dde execute** ?**-async**? ?**-binary**? *service topic data*
: **dde execute** nimmt *data* und sendet sie an den durch *service* bezeichneten Server mit dem Thema *topic*. Typischerweise ist *service* der Name einer Anwendung und *topic* eine zu bearbeitende Datei. Das Feld *data* geht an die entfernte Anwendung. Typischerweise behandelt die Anwendung *data* als Skript und führt es aus. **-async** verlangt einen asynchronen Aufruf. Der Befehl gibt eine Fehlermeldung zurück, wenn das Skript nicht lief, außer **-async** ist gesetzt; dann kehrt der Befehl sofort ohne Fehler zurück. [Ohne **-binary** werden alle Daten in Unicode gesendet. DDE-Clients ohne das Zwischenablageformat CF\_UNICODE übersetzen das automatisch in die Systemkodierung. Mit **-binary** und dem Ergebnis von [encoding convertto][encoding] lassen sich Daten in jeder anderen Kodierung senden.]{version="8.6"}

**dde poke** ?**-binary**? *service topic item data*
: **dde poke** übergibt *data* an den durch *service* bezeichneten Server, mit den angegebenen *topic* und *item*. Typischerweise ist *service* der Name einer Anwendung. *topic* ist anwendungsspezifisch, kann ein Befehl an den Server oder der Name einer zu bearbeitenden Datei sein. *item* ist ebenfalls anwendungsspezifisch und oft unbenutzt, darf aber nie leer sein. Das Feld *data* geht an die entfernte Anwendung. [Ohne **-binary** werden alle Daten in Unicode gesendet. DDE-Clients ohne das Zwischenablageformat CF\_UNICODE übersetzen das automatisch in die Systemkodierung. Mit **-binary** und dem Ergebnis von [encoding convertto][encoding] lassen sich Daten in jeder anderen Kodierung senden.]{version="8.6"}

**dde request** ?**-binary**? *service topic item*
: **dde request** holt typischerweise den Wert von etwas, etwa den Wert einer Zelle in Microsoft Excel oder den Text einer Auswahl in Microsoft Word. *service* ist typischerweise der Name einer Anwendung, *topic* typischerweise der Dateiname, *item* anwendungsspezifisch. Der Befehl gibt den in der Anwendung definierten Wert von *item* zurück. Normalerweise gilt das als Zeichenkette mit abschließendem Nullbyte. Mit **-binary** kommt das Ergebnis als Bytefeld zurück.

**dde services** *service topic*
: **dde services** gibt eine Liste der Dienst-Thema-Paare zurück, die auf dem Rechner gerade existieren. Sind *service* und *topic* beide leere Zeichenketten ({}), kommen alle derzeit verfügbaren Paare zurück. Ist *service* leer und *topic* nicht, kommen alle Dienste mit diesem Thema zurück. Ist *service* nicht leer und *topic* leer, kommen alle Themen dieses Dienstes zurück. Sind beide nicht leer und das Paar existiert, wird es zurückgegeben, sonst eine leere Zeichenkette.

**dde eval** ?**-async**? *topic cmd* ?*arg arg ...*?
: **dde eval** wertet einen Befehl und seine Argumente im durch *topic* bezeichneten Interpreter aus. Der DDE-Dienst muss **TclEval** sein. **-async** verlangt einen asynchronen Aufruf. Der Befehl gibt eine Fehlermeldung zurück, wenn das Skript nicht lief, außer **-async** ist gesetzt; dann kehrt der Befehl sofort ohne Fehler zurück. Dieser Befehl kann unter Windows **send** ersetzen.


# DDE und Tcl

Ein Tcl-Interpreter hat immer den Dienstnamen **TclEval**. Jeder Interpreter aller laufenden Tcl-Anwendungen braucht einen eindeutigen Namen aus **dde servername**. Ein Interpreter ist nur dann ein DDE-Thema, wenn **dde servername** den Themennamen gesetzt hat. **dde services TclEval {}** gibt daher eine Liste von Dienst-Thema-Paaren zurück, in der jeder gerade laufende Interpreter ein Thema ist.

Verarbeitet Tcl einen Befehl **dde execute**, läuft die Execute-Datenmenge als Skript in dem Interpreter, den das Thema des Befehls **dde execute** nennt.

Verarbeitet Tcl einen Befehl **dde request**, gibt er den Wert der im DDE-Befehl genannten Variable im Interpreter des DDE-Themas zurück. Tcl reserviert die Variable **\$TCLEVAL\$EXECUTE\$RESULT** für den internen Gebrauch; **dde request** auf diese Variable liefert unvorhersehbare Ergebnisse.

Eine fremde Anwendung, die ein Skript in Tcl ausführen will, soll das Skript sein Ergebnis in einer Variable speichern lassen, **dde execute** ausführen und danach mit **dde request** den Wert der Variable holen.

Bei DDE muss die Ereignisschleife mit [update] oder [vwait] geleert werden. Das geschieht bei [wish] von selbst, außer ein blockierender Befehl wird aufgerufen (etwa [exec] ohne **&**, das den Prozess in den Hintergrund legt). Wird die Ereignisschleife nicht geleert, können DDE-Befehle hängen, bis sie geleert wird. Das kann eine Verklemmung erzeugen.

# Beispiel

Dies bittet Internet Explorer (der schon laufen muss), eine bestimmte Website zu öffnen:

```
package require dde
dde execute -async iexplore WWW_OpenURL http://www.tcl-lang.org/
```


[encoding]: encoding.md
[exec]: exec.md
[update]: update.md
[vwait]: vwait.md
[wish]: ../tk/wish.md
