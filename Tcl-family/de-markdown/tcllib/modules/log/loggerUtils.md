---
CommandName: logger::utils
title: logger::utils
ManualSection: n
Version: 1.3.2
TclPart: tcllib
TclDescription: Object Oriented logging facility
Keywords:
 - appender
 - logger
Copyright:
 - Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
---

# Name

logger::utils – Dienstprogramme für den Logger

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [logger::utils]{.lit} [1.3.2]{.optlit}
[::logger::utils::createFormatCmd]{.cmd} [formatString]{.arg}
[::logger::utils::createLogProc]{.cmd} [-procName]{.lit} [procName]{.arg} [options...]{.optarg}
[::logger::utils::applyAppender]{.cmd} [-appender]{.lit} [appenderType]{.arg} [options...]{.optarg}
[::logger::utils::autoApplyAppender]{.cmd} [command]{.arg} [command-string]{.arg} [log]{.arg} [op]{.arg} [args...]{.arg}
:::

# Beschreibung

Dieses Paket fügt vorlagenbasierte *Appender* hinzu.

**::logger::utils::createFormatCmd** *formatString*
: Dieser Befehl wandelt *formatString* in eine erweiterbare Befehlszeichenfolge um. Die folgenden Zeichenfolgen sind die bekannten Ersetzungen (aus log4perl), die in *formatString* vorkommen dürfen:

    %c
    : Kategorie des Protokollierungsereignisses

    %C
    : Vollqualifizierter Name des Protokollierungsereignisses

    %d
    : Aktuelles Datum im Format JJJJ/MM/TT hh:mm:ss

    %H
    : Hostname

    %m
    : Zu protokollierende Meldung

    %M
    : Methode, mit der das Protokoll-Ereignis ausgelöst wurde

    %p
    : Priorität des Protokollierungsereignisses

    %P
    : PID des aktuellen Prozesses


**::logger::utils::createLogProc** **-procName** *procName* ?*options*...?
: Dieser Befehl ...

    **-procName** procName
    : Der Name der zu erstellenden Prozedur.

    **-conversionPattern** pattern
    : Die im *Muster* zulässigen Ersetzungen finden Sie unter **::logger::utils::createFormatCmd**.

    **-category** category
    : Die Kategorie (Dienstleistung).

    **-priority** priority
    : Die Priorität (Stufe).

    **-outputChannel** channel
    : Kanal (standardmäßig stdout)


**::logger::utils::applyAppender** **-appender** *appenderType* ?*options*...?
: Dieser Befehl erstellt einen Appender für die angegebenen Logger-Dienste. Wenn kein Dienst angegeben wird, wird der Appender als Standard-Appender für die angegebenen Ebenen hinzugefügt. Wenn keine Ebenen angegeben werden, werden alle Ebenen angenommen.

    **-service** loggerservices
    : siehe unten ...

    **-serviceCmd** loggerserviceCmds
    : Name der zu ändernden Logger-Instanz. **-serviceCmd** benötigt als Eingabe den Rückgabewert von [logger::init][logger].

    **-appender** appenderType
    : Typ des zu verwendenden Appenders. Entweder **console** oder **colorConsole**.

    **-appenderArgs** appenderArgs
    : Zusätzliche Argumente, die auf den Appender angewendet werden sollen. Das Argument der Option ist eine Liste aus Optionen und deren Argumenten.

        Zum Beispiel

        ```
        logger::utils::applyAppender -serviceCmd $log -appender console -appenderArgs {-conversionPattern {\[%M\] \[%p\] - %m}}
        ```

        Es gelten die üblichen Tcl-Quoting-Regeln.

    **-levels** levelList
    : Die Liste der Ebenen, auf die dieser Appender angewendet werden soll. Wird keine Liste angegeben, werden alle Ebenen berücksichtigt.


    Beispiele:

    ```
       % set log [logger::init testLog]
       ::logger::tree::testLog
       % logger::utils::applyAppender -appender console -serviceCmd $log
       % ${log}::error "this is an error"
       [2005/08/22 10:14:13] [testLog] [global] [error] this is an error
    ```

**::logger::utils::autoApplyAppender** *command* *command-string* *log* *op* *args*...
: Dieser Befehl ist dafür vorgesehen, über **trace leave** zu Aufrufen von [logger::init][logger] hinzugefügt zu werden. Er prüft den vorkonfigurierten Status (über **::logger::utils::applyAppender**), um Appender für neu erstellte Logger-Instanzen automatisch anzulegen. Er gibt sein Argument *log* zurück.

    Beispiele:

    ```
      logger::utils::applyAppender -appender console
      set log [logger::init applyAppender-3]
      ${log}::error "this is an error"
    ```


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *logger* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge

# Copyright

```
Copyright (c) 2005 Aamer Akhter <aakhter@cisco.com>
```


[logger]: logger.md
