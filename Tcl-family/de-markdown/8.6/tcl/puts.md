---
CommandName: puts
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - fileevent(n)
 - Tcl_StandardChannels(3)
Keywords:
 - channel
 - newline
 - output
 - write
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

puts - In einen Kanal schreiben

# ÜBERSICHT

::: {.synopsis} :::
[puts]{.cmd} [-nonewline]{.optlit} [channelId]{.optarg} [string]{.arg} 
:::

# BESCHREIBUNG

Schreibt die von *string* angegebenen Zeichen in den von *channelId* bezeichneten Kanal.

*ChannelId* muss ein Bezeichner für einen offenen Kanal sein, etwa ein Tcl-Standardkanal (**stdout** oder **stderr**), der Rückgabewert eines Aufrufs von **open** oder **socket** oder das Ergebnis eines von einer Tcl-Erweiterung bereitgestellten Befehls zur Kanalerstellung. Der Kanal muss zum Schreiben geöffnet worden sein.

Wird kein *channelId* angegeben, ist der Standardwert **stdout**. **Puts** gibt nach *string* normalerweise ein Zeilenumbruchzeichen aus; dies kann durch die Option **-nonewline** unterdrückt werden.

Zeilenumbruchzeichen in der Ausgabe werden von **puts** je nach aktuellem Wert der Option **-translation** des Kanals in plattformspezifische Zeilenendesequenzen umgewandelt (auf PCs werden Zeilenumbrüche üblicherweise durch Wagenrücklauf-Zeilenvorschub-Sequenzen ersetzt). Siehe die Manpage **fconfigure** für eine Erläuterung, wie **fconfigure** die Ausgabe verändert.

Tcl puffert Ausgabe intern, sodass mit **puts** geschriebene Zeichen möglicherweise nicht sofort in der Ausgabedatei oder auf dem Gerät erscheinen; Tcl verzögert die Ausgabe normalerweise, bis der Puffer voll ist oder der Kanal geschlossen wird. Mit dem Befehl **flush** können Sie die Ausgabe sofort sichtbar machen.

Ist der Ausgabepuffer voll, blockiert der Befehl **puts** normalerweise, bis das Betriebssystem alle gepufferten Daten zur Ausgabe angenommen hat. Befindet sich *channelId* im nicht blockierenden Modus, blockiert **puts** nicht, auch wenn das Betriebssystem die Daten nicht annehmen kann. Stattdessen puffert Tcl die Daten weiter und schreibt sie im Hintergrund so schnell, wie die zugrunde liegende Datei oder das Gerät sie aufnehmen kann. Die Anwendung muss die Tcl-Ereignisschleife verwenden, damit nicht blockierende Ausgabe funktioniert; andernfalls erfährt Tcl nie, dass die Datei oder das Gerät bereit für weitere Ausgabedaten ist. Für einen Kanal im nicht blockierenden Modus kann beliebig viel Daten gepuffert werden, was viel Speicher verbrauchen kann. Um Speicherverschwendung zu vermeiden, sollte nicht blockierende E/A normalerweise ereignisgesteuert mit dem Befehl **fileevent** verwendet werden (rufen Sie **puts** nicht auf, es sei denn, Sie wurden kürzlich per ein Datei-Event darüber informiert, dass der Kanal bereit für weitere Ausgabedaten ist).

# BEISPIELE

Eine kurze Meldung auf die Konsole (oder dorthin, wohin **stdout** geleitet ist) schreiben:

```
puts "Hello, World!"
```

Eine Meldung in mehreren Teilen ausgeben:

```
puts -nonewline "Hello, "
puts "World!"
```

Eine Meldung auf den Standardfehlerkanal ausgeben:

```
puts stderr "Hello, World!"
```

Eine Protokollmeldung an eine Datei anhängen:

```
set chan [open my.log a]
set timestamp [clock format [clock seconds]]
puts $chan "$timestamp - Hello, World!"
close $chan
```

