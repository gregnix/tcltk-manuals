---
CommandName: LIBEXPECT
title: LIBEXPECT
ManualSection: 3
Version: 12 December 1991
TclPart:
TclDescription:
Copyright:
---

# Name

libexpect - Bibliothek für programmierten Dialog mit interaktiven Programmen

# Beschreibung

Diese Bibliothek enthält Funktionen, mit denen Expect als Tcl-Erweiterung oder unmittelbar aus C oder C++ verwendet werden kann, ohne Tcl. Expect als Tcl-Erweiterung hinzuzufügen, ist sehr kurz und einfach. Das kommt zuerst.

# Übersicht

::: {.synopsis} :::
**#include expect\_tcl.h**
[Expect\_Init]{.ccmd} [interp]{.cargs}

[cc]{.cmd} [files...]{.sub} [-lexpect5.20]{.lit} [-ltcl7.5]{.lit} [-lm]{.lit}
:::

Hinweis: Die Bibliotheksversionen können in der tatsächlichen Ausgabe abweichen.

Die Funktion Expect\_Init fügt dem genannten Interpreter expect-Befehle hinzu. Vorhandene Befehle werden nicht überschrieben. Aliase, die mit "exp\_" beginnen, werden für expect-Befehle aber immer angelegt. "send" kann zum Beispiel als "exp\_send" verwendet werden.

Expect-Befehle werden nur über Tcl\_Eval aufgerufen. Bestimmte Hilfsfunktionen dürfen unmittelbar aufgerufen werden. Die Hilfsfunktionen sind unten zusammengefasst. Das kann nützlich sein, um eine eigene main zu bauen. Die Datei exp\_main\_exp.c in der Expect-Distribution ist eine main als Vorbild. Ein weiteres Vorbild ist tclAppInit.c in der Tcl-Distribution. Ein Vorbild für die Arbeit mit Tk steht in exp\_main\_tk.c in der Expect-Distribution.

```
int exp_cmdlinecmds;
int exp_interactive;
FILE *exp_cmdfile;
char *exp_cmdfilename;
int exp_tcl_debugger_available;

void	exp_parse_argv(Tcl_Interp *,int argc,char **argv);
int	exp_interpreter(Tcl_Interp *);
void	exp_interpret_cmdfile(Tcl_Interp *,FILE *);
void	exp_interpret_cmdfilename(Tcl_Interp *,char *);
void	exp_interpret_rcfiles(Tcl_Interp *,int my_rc,int sys_rc);
char *	exp_cook(char *s,int *len);
void	(*exp_app_exit)EXP_PROTO((Tcl_Interp *);
void	exp_exit(Tcl_Interp *,int status);
void	exp_exit_handlers(Tcl_Interp *);
void	exp_error(Tcl_Interp,char *,...);
```

**exp\_cmdlinecmds** ist 1, wenn Expect mit Befehlen auf der Programm-Befehlszeile aufgerufen wurde, zum Beispiel mit "-c". **exp\_interactive** ist 1, wenn Expect mit der Markierung -i aufgerufen wurde oder wenn keine Befehle und kein Skript aufgerufen werden. **exp\_cmdfile** ist ein Strom, aus dem Expect Befehle liest. **exp\_cmdfilename** ist der Name einer Datei, die Expect öffnet und aus der es Befehle liest. **exp\_tcl\_debugger\_available** ist 1, wenn der Debugger scharf gemacht wurde.

**exp\_parse\_argv** liest die Darstellung der Befehlszeile. Je nachdem, was gefunden wird, werden die anderen hier aufgeführten Variablen passend eingerichtet. **exp\_interpreter** fragt den Benutzer interaktiv nach Befehlen und wertet sie aus. **exp\_interpret\_cmdfile** liest den angegebenen Strom und wertet gefundene Befehle aus. **exp\_interpret\_cmdfilename** öffnet die genannte Datei und wertet gefundene Befehle aus. **exp\_interpret\_rcfiles** liest die .rc-Dateien und wertet sie aus. Ist my\_rc null, wird ~/.expectrc übersprungen. Ist sys\_rc null, wird die systemweite expectrc-Datei übersprungen. **exp\_cook** gibt einen statischen Puffer zurück, der das Argument enthält, wobei Zeilenumbrüche durch Folgen aus Wagenrücklauf und Zeilenvorschub ersetzt sind. Der Hauptzweck ist, Meldungen zu erzeugen, ohne darauf zu achten, ob das Terminal im Rohmodus oder im kanonischen Modus steht. Ist die Länge null, wird sie über strlen berechnet. **exp\_error** ist eine printf-ähnliche Funktion, die das Ergebnis nach interp->result schreibt.

# Übersicht

::: {.synopsis} :::
**#include <expect.h>**

[int]{.ret} [exp\_spawnl]{.ccmd} [file, arg0 \[, arg1, ..., argn\] (char \*)0]{.cargs}

[int]{.ret} [exp\_spawnv]{.ccmd} [file,argv]{.cargs}

[int]{.ret} [exp\_spawnfd]{.ccmd} [fd]{.cargs}

[FILE \*]{.ret} [exp\_popen]{.ccmd} [command]{.cargs}

[extern void (\*exp\_child\_exec\_prelude)(); extern void]{.ret} [exp\_close\_tcl\_files]{.ccmd} []{.cargs}

[cc]{.cmd} [files...]{.sub} [-lexpect]{.lit} [-ltcl]{.lit} [-lm]{.lit}
:::

char \*file; char \*arg0, \*arg1, ... \*argn; char \*file, \*argv\[ \]; int fd; char \*command; extern int exp\_pid; extern int exp\_ttyinit; extern int exp\_ttycopy; extern int exp\_console; extern char \*exp\_stty\_init; extern void (\*exp\_close\_in\_child)();

# Beschreibung

**exp\_spawnl** und **exp\_spawnv** spalten einen neuen Prozess ab, sodass der aktuelle Prozess dessen stdin, stdout und stderr schreiben und lesen kann. *file* ist der Name einer Datei, die ausgeführt werden soll. Die Zeiger *arg* sind nullterminierte Zeichenketten. Nach dem Stil von execve() ist *arg0*, oder *argv\[0\]*, üblicherweise ein Doppel des Dateinamens.

Es gibt vier Schnittstellen. **exp\_spawnl** ist nützlich, wenn die Zahl der Argumente zur Übersetzungszeit bekannt ist. **exp\_spawnv** ist nützlich, wenn die Zahl der Argumente zur Übersetzungszeit nicht bekannt ist. **exp\_spawnfd** ist nützlich, wenn ein offener Dateideskriptor schon als Quelle vorliegt. **exp\_popen** wird weiter unten erklärt.

Wird der Prozess erfolgreich angelegt, kommt ein Dateideskriptor zurück, der stdin, stdout und stderr des Prozesses entspricht. Mit fdopen() kann dem Dateideskriptor ein Strom zugeordnet werden. Darauf sollte fast sicher setbuf() folgen, um die Ein-/Ausgabe zu entpuffern.

Das Schließen des Dateideskriptors erkennt der Prozess gewöhnlich als EOF. Ist ein solcher Prozess beendet, sollte mit wait auf ihn gewartet werden, damit der Prozessplatz im Kern frei wird. Manche Systeme erlauben, das zu unterlassen, wenn das Signal SIGCHLD übergangen wird.

**exp\_popen** ist eine weitere Schnittstelle, nach dem Vorbild von popen(). Die Funktion nimmt eine Befehlszeile der Bourne-Shell und gibt einen Strom zurück, der stdin, stdout und stderr des Prozesses entspricht. Die Umsetzung von **exp\_popen** unten zeigt **exp\_spawnl**.

```
FILE *
exp_popen(program)
char *program;
{
	FILE *fp;
	int ec;

	if (0 > (ec = exp_spawnl("sh","sh","-c",program,(char *)0)))
		return(0);
	if (NULL == (fp = fdopen(ec,"r+")) return(0);
	setbuf(fp,(char *)0);
	return(fp);
}
```

Nachdem ein Prozess gestartet ist, wird die Variable **exp\_pid** auf die Prozesskennung des neuen Prozesses gesetzt. Die Variable **exp\_pty\_slave\_name** wird auf den Namen der Slave-Seite der Pty gesetzt.

Die spawn-Funktionen verwenden eine Pty, um mit dem Prozess zu kommunizieren. In der Vorgabe wird die Pty wie das tty des Benutzers eingerichtet, wenn das möglich ist, also wenn die Umgebung ein steuerndes Terminal hat. Diese Einrichtung lässt sich überspringen, indem exp\_ttycopy auf 0 gesetzt wird.

Ist exp\_ttyinit ungleich null, wird die Pty weiter auf einige systemweite Vorgaben eingerichtet. Die Vorgabe entspricht im Allgemeinen "stty sane".

Die tty-Einstellung lässt sich weiter ändern, indem die Variable **exp\_stty\_init** gesetzt wird. Diese Variable wird im Stil von stty-Argumenten gelesen. exp\_stty\_init = "sane"; wiederholt zum Beispiel die Vorgabeeinrichtung.

Auf manchen Systemen lässt sich die Konsolenausgabe auf Ptys umleiten. Wird das unterstützt, erhält der nächste spawn die Konsolenausgabe, wenn die Variable **exp\_console** auf 1 gesetzt wird.

Zwischen dem Start eines Prozesses und der Übergabe der Steuerung an das neue Programm können die spawn-Funktionen die Umgebung aufräumen, indem sie Dateideskriptoren schließen. In der Vorgabe werden nur Dateideskriptoren geschlossen, die intern zu Expect gehören, und solche mit der Markierung "close-on-exec".

Weitere Dateideskriptoren lassen sich schließen, indem eine passende Funktion angelegt und exp\_close\_in\_child zugewiesen wird. Die Funktion wird nach dem fork und vor dem exec aufgerufen. Das ändert auch das Verhalten des Befehls spawn in Expect.

Wird auch Tcl verwendet, kann die Funktion exp\_close\_tcl\_files bequem sein. Die Funktion schließt alle Dateien zwischen den vorgegebenen Standard-Dateideskriptoren und dem höchsten Deskriptor, den Tcl kennt. Expect tut das.

Die Funktion exp\_child\_exec\_prelude ist die letzte Funktion, die im Kind vor dem eigentlichen exec aufgerufen wird. Die Funktion lässt sich neu definieren, etwa um die uid oder die Signale zu verändern.

# Eigene PTY zuteilen

```
extern int exp_autoallocpty;
extern int exp_pty[2];
```

Die spawn-Funktionen verwenden eine Pty, um mit dem Prozess zu kommunizieren. In der Vorgabe wird bei jedem Start eines Prozesses automatisch eine Pty zugeteilt. Sollen die Ptys selbst zugeteilt werden, wird vor dem Aufruf einer spawn-Funktion **exp\_autoallocpty** auf 0 gesetzt, **exp\_pty\[0\]** auf den Dateideskriptor der Master-Pty und **exp\_pty\[1\]** auf den Dateideskriptor der Slave-Pty. Die expect-Bibliothek nimmt dann keine Pty-Einrichtung vor, exp\_stty\_init wird zum Beispiel nicht verwendet. Der Dateideskriptor der Slave-Pty wird automatisch geschlossen, wenn der Prozess gestartet wird. Nach dem Start des Prozesses läuft die weitere Kommunikation über den Dateideskriptor der Master-Pty.

**exp\_spawnl** und **exp\_spawnv** bilden das Suchen der Shell nach einer ausführbaren Datei in einer Verzeichnisliste nach. Die Verzeichnisliste kommt aus der Umgebung.

# Expect-Verarbeitung

Aus einem Prozess, den **exp\_spawnl** oder **exp\_spawnv** gestartet hat, lässt sich mit read() lesen. Bequemere Funktionen stehen bereit. Es folgen:

```
int
exp_expectl(fd,type1,pattern1,[re1,],value1,type2,...,exp_end);
int fd;
enum exp_type type;
char *pattern1, *pattern2, ...;
regexp *re1, *re2, ...;
int value1, value2, ...;

int
exp_fexpectl(fp,type1,pattern1,[re1,]value1,type2,...,exp_end);
FILE *fp;
enum exp_type type;
char *pattern1, *pattern2, ...;
regexp *re1, *re2, ...;
int value1, value2, ...;

enum exp_type {
exp_end,
exp_glob,
exp_exact,
exp_regexp,
exp_compiled,
exp_null,
};

struct exp_case {
char *pattern;
regexp *re;
enum exp_type type;
int value;
};

int
exp_expectv(fd,cases);
int fd;
struct exp_case *cases;

int
exp_fexpectv(fp,cases);
FILE *fp;
struct exp_case *cases;

extern int exp_timeout;
extern char *exp_match;
extern char *exp_match_end;
extern char *exp_buffer;
extern char *exp_buffer_end;
extern int exp_match_max;
extern int exp_full_buffer;
extern int exp_remove_nulls;
```

Die Funktionen warten, bis die Ausgabe eines Prozesses auf eines der Muster passt, eine angegebene Zeitspanne vergangen ist oder ein EOF gesehen wird.

Das erste Argument jeder Funktion ist entweder ein Dateideskriptor oder ein Strom. Die folgenden Argumentgruppen beschreiben Muster und zugehörige ganze Zahlen, die zurückgegeben werden, wenn das Muster passt.

Das Argument type ist einer von mehreren Werten. exp\_end zeigt, dass keine weiteren Muster folgen. exp\_glob zeigt, dass das Muster eine Zeichenkette im Glob-Stil ist. exp\_exact zeigt, dass das Muster eine genaue Zeichenkette ist. exp\_regexp zeigt, dass das Muster eine Zeichenkette im Regexp-Stil ist. exp\_compiled zeigt, dass das Muster eine Zeichenkette im Regexp-Stil ist und dass seine kompilierte Form ebenfalls angegeben wird. exp\_null zeigt, dass das Muster eine Null ist. Zur Fehlersuche muss danach auch ein Zeichenkettenmuster folgen.

Wird die kompilierte Form bei den Funktionen **exp\_expectl** und **exp\_fexpectl** nicht angegeben, wird jede intern vorgenommene Musterkompilierung verworfen, nachdem die Funktion zurückgekehrt ist. Die Funktionen **exp\_expectv** und **exp\_fexpectv** kompilieren Muster automatisch und verwerfen sie nicht. Stattdessen werden sie verworfen, indem für jedes Muster free aufgerufen wird. Verwerfen ist nur beim letzten Verwenden der Fälle nötig.

Passende Regexp-Teilmuster werden in der kompilierten regexp gespeichert. Enthält "re" eine kompilierte regexp, steht die passende Zeichenkette in re->startp\[0\]. Die passenden Teilzeichenketten, nach den Klammern im ursprünglichen Muster, stehen in re->startp\[1\], re->startp\[2\] und so weiter bis re->startp\[9\]. Die zugehörigen Enden der Zeichenketten sind re->endp\[x\], wobei x derselbe Index ist wie beim Anfang der Zeichenkette.

Der Typ exp\_null passt, wenn in der Eingabe eine Null erscheint. Die Variable exp\_remove\_nulls muss auf 0 gesetzt werden, damit Nullen nicht automatisch entfernt werden. In der Vorgabe ist exp\_remove\_nulls 1, und Nullen werden automatisch entfernt.

**exp\_expectv** und **exp\_fexpectv** sind nützlich, wenn die Zahl der Muster nicht im Voraus bekannt ist. Dann stehen die Gruppen in einem Feld. Das Ende des Feldes bezeichnet eine struct exp\_case mit dem Typ exp\_end. Im Rest dieser Erörterung werden diese Funktionen allgemein *expect* genannt.

Passt ein Muster, kommt die zugehörige ganze Zahl zurück. Die Werte müssen nicht eindeutig sein, sollten aber positiv sein, damit sie nicht mit EXP\_EOF, EXP\_TIMEOUT oder EXP\_FULLBUFFER verwechselt werden. Bei EOF oder Zeitüberschreitung kommt der Wert **EXP\_EOF** oder **EXP\_TIMEOUT** zurück. Die Vorgabezeitspanne ist 10 Sekunden und lässt sich durch Setzen der Variable **exp\_timeout** ändern. Der Wert -1 schaltet eine Zeitüberschreitung aus. Der Wert 0 lässt die expect-Funktion nach einem read() sofort zurückkehren, also pollen. Davor muss aber eine Funktion wie select, poll oder eine Rückruffunktion einer Ereignisverwaltung stehen, damit Daten zum Lesen da sind.

Ist die Variable exp\_full\_buffer 1, kommt EXP\_FULLBUFFER zurück, wenn exp\_buffer voll wird und kein Muster gepasst hat.

Kehrt die expect-Funktion zurück, zeigt **exp\_buffer** auf den Puffer der Zeichen, die für den Vergleich betrachtet wurden. **exp\_buffer\_end** zeigt auf die Stelle ein Zeichen hinter dem letzten Zeichen in exp\_buffer. Ist eine Übereinstimmung entstanden, zeigt **exp\_match** in **exp\_buffer** auf den Anfang der Übereinstimmung. **exp\_match\_end** zeigt auf das Zeichen hinter dem Ende der Übereinstimmung.

Kommt neue Eingabe, wird sie mit jedem Muster in der aufgeführten Reihenfolge verglichen. Das Fehlen einer Übereinstimmung lässt sich prüfen, indem das letzte Muster etwas ist, das sicher erscheint, etwa eine Eingabeaufforderung. Gibt es keine Eingabeaufforderung, ist auf **EXP\_TIMEOUT** zu prüfen, so wie bei der Arbeit von Hand. Weitere Überlegungen und Vorgehensweisen zum Angeben von Mustern für **expect** stehen in der Dokumentation des Programms **expect** selbst. Weitere Angaben stehen unter SEE ALSO weiter unten.

Muster sind die üblichen regulären Ausdrücke im C-Shell-Stil. Das folgende Fragment sucht zum Beispiel eine erfolgreiche Anmeldung, etwa aus einem Telnet-Dialog.

```
	switch (exp_expectl(
		exp_glob,"connected",CONN,
		exp_glob,"busy",BUSY,
		exp_glob,"failed",ABORT,
		exp_glob,"invalid password",ABORT,
		exp_end)) {
	case CONN:	/* logged in successfully */
		break;
	case BUSY:	/* couldn't log in at the moment */
		break;
	case EXP_TIMEOUT:
	case ABORT:	/* can't log in at any moment! */
		break;
	default: /* problem with expect */
	}
```

Sternchen, wie im Beispiel oben, sind eine nützliche Kurzform, um Zeichen am Zeilenende und anderes Detail wegzulassen. Muster müssen die ganze Ausgabe des aktuellen Prozesses treffen, seit dem vorigen read auf dem Deskriptor oder Strom. Mehr als 2000 Bytes Ausgabe können frühere Bytes zum „Vergessen“ zwingen. Das lässt sich durch Setzen der Variable **exp\_match\_max** ändern. Übermäßig große Werte können den Mustervergleich verlangsamen.

# Lauf im Hintergrund

```
extern int exp_disconnected;
int exp_disconnect();
```

Ein Prozess lässt sich in den Hintergrund legen, nachdem er zu laufen begonnen hat. Ein typischer Gebrauch ist, Passwörter zu lesen und dann im Hintergrund zu schlafen, bevor die Passwörter für die eigentliche Arbeit verwendet werden.

Um einen Prozess in den Hintergrund zu legen, wird fork aufgerufen, im Kindprozess exp\_disconnect() und im Elternprozess exit(). Das löst den Prozess vom steuernden Terminal. Soll ein Prozess auf andere Weise in den Hintergrund, muss die Variable exp\_disconnected auf 1 gesetzt werden. Prozesse, die danach gestartet werden, starten dann richtig.

# Mehrfachzugriff

In der Vorgabe blockieren die expect-Funktionen in einem read auf einem einzigen Dateideskriptor. Soll auf Muster von mehreren Dateideskriptoren gewartet werden, dienen select, poll oder eine Ereignisverwaltung. Daran ist abzulesen, welcher Dateideskriptor zum Lesen bereit ist.

Ist ein Dateideskriptor zum Lesen bereit, können die expect-Funktionen genau ein read ausführen, indem timeout auf 0 gesetzt wird.

# Steuerung des Slave

```
void
exp_slave_control(fd,enable)
int fd;
int enable;
```

Das Einfangen der Pty geschieht gewöhnlich automatisch durch die expect-Funktionen. Soll zum Beispiel ein ioctl unmittelbar auf dem Slave-Gerät abgesetzt werden, wird das Einfangen vorübergehend ausgeschaltet.

Das Einfangen der Pty lässt sich mit exp\_slave\_control steuern. Das erste Argument ist der Dateideskriptor des gestarteten Prozesses. Das zweite Argument ist 0, wenn das Einfangen ausgeschaltet werden soll, und 1, wenn es eingeschaltet werden soll.

# Fehler

Alle Funktionen zeigen Fehler, indem sie -1 zurückgeben und errno setzen.

Fehler, die auftreten, nachdem die spawn-Funktionen abgespalten haben, etwa der Versuch, ein nicht vorhandenes Programm zu starten, werden auf stderr des Prozesses geschrieben und vom ersten **expect** gelesen.

# Signale

```
extern int exp_reading;
extern jmp_buf exp_readenv;
```

**expect** verwendet alarm() für die Zeitüberschreitung. Werden während **expect** Alarme erzeugt, läuft die Zeit vorzeitig ab.

Intern ruft **expect** read() auf, das von Signalen unterbrochen werden kann. Werden Signalbehandler definiert, lässt sich das interne read von **expect** neu starten oder abbrechen. Die Variable **exp\_reading** ist wahr genau dann, wenn das read von **expect** unterbrochen wurde. longjmp(exp\_readenv,EXP\_ABORT) bricht das read ab. longjmp(exp\_readenv,EXP\_RESTART) startet das read neu.

# Protokoll

```
extern int exp_loguser;
extern int exp_logfile_all
extern FILE *exp_logfile;
```

Ist **exp\_loguser** ungleich null, sendet **expect** jede Ausgabe des gestarteten Prozesses nach stdout. Interaktive Programme senden ihre Eingabe gewöhnlich zurück, deshalb genügt das meist, um beide Seiten des Gesprächs zu zeigen. Ist **exp\_logfile** ebenfalls ungleich null, wird dieselbe Ausgabe in den Strom geschrieben, den **exp\_logfile** bezeichnet. Ist **exp\_logfile\_all** ungleich null, wird **exp\_logfile** geschrieben, unabhängig vom Wert von **exp\_loguser**.

# Fehlersuche

Die Bibliothek ist leicht zu verwenden. Das eigenständige Programm expect ist aber sehr viel leichter zu verwenden als die Arbeit mit dem C-Compiler und seinem üblichen Kreis aus Bearbeiten, Übersetzen und Fehlersuchen. Anders als bei typischen C-Programmen besteht die Fehlersuche meist nicht darin, den C-Compiler zur Annahme der Programme zu bringen, sondern den Dialog richtig zu bekommen. Skripte von expect nach C zu übertragen, ist gewöhnlich nicht nötig. Die Geschwindigkeit interaktiver Dialoge ist zum Beispiel so gut wie nie das Problem. Zuerst sollte das eigenständige Programm 'expect' versucht werden. Für die meisten ist es eine passendere Lösung als die Bibliothek.

Soll trotzdem in C nach Fehlern gesucht werden, helfen die folgenden Werkzeuge.

```
extern int exp_is_debugging;
extern FILE *exp_debugfile;
```

Expect-Dialoge wirken sehr naheliegend. Dialoge in einem Programm festzuhalten, kann viele Überraschungen in der Schnittstelle eines Programms zeigen. Deshalb gibt es verschiedene Hilfen zur Fehlersuche. Die oben genannten Variablen steuern sie, in der Vorgabe alle 0.

Interne Angaben zur Fehlersuche von **expect** gehen nach stderr, wenn **exp\_is\_debugging** ungleich null ist. Die Angaben umfassen jedes empfangene Zeichen und jeden Versuch, die aktuelle Eingabe mit den Mustern zu vergleichen. Nicht druckbare Zeichen werden zusätzlich in eine druckbare Form übersetzt. Ein Control-C erscheint zum Beispiel als Zirkumflex, gefolgt von einem C. Ist **exp\_logfile** ungleich null, werden diese Angaben auch in diesen Strom geschrieben.

Ist **exp\_debugfile** ungleich null, werden alle gewöhnlichen Angaben und alle Angaben zur Fehlersuche in diesen Strom geschrieben, unabhängig vom Wert von **exp\_is\_debugging**.

# Einschränkungen

Die Stromfassungen der Funktionen **expect** sind viel langsamer als die Fassungen mit Dateideskriptor, weil sich eine unbekannte Zahl von Bytes nicht übertragbar lesen lässt, ohne dass eine Zeitüberschreitung droht. Die Zeichen werden deshalb einzeln gelesen. Die Fassungen von **expect** mit Dateideskriptor sind deshalb vorzuziehen, auch wenn automatisierte interaktive Programme gewöhnlich keine hohe Geschwindigkeit verlangen.

Beides zusammen geht: Schreiben mit den üblichen Stromfunktionen und Lesen mit den Dateideskriptor-Fassungen von **expect**, solange keine anderen Eingabefunktionen für Ströme dazwischen gemischt werden, etwa fgetc. Dazu wird jedes Mal fileno(stream) als Dateideskriptor übergeben. Glücklicherweise gibt es wenig Grund, beim Lesen von interaktiven Programmen etwas anderes als die Funktionen **expect** zu verwenden.

Zu exp\_popen gibt es kein passendes exp\_pclose, anders als bei popen und pclose. Eine Verbindung zu schließen, braucht nur zwei Funktionen, fclose() und danach das Warten auf die pid. Diese beiden Schritte liegen aber nicht selten weit auseinander, sodass die Funktion wenig Wert zu haben scheint.

Läuft das auf einem Cray unter Unicos, das ist das, was aus Erfahrung sicher ist, muss das kompilierte Programm als root oder setuid laufen. Das Problem ist, dass der Cray nur root-Prozessen erlaubt, Ptys zu öffnen. Die Vorsicht sollte so groß wie möglich sein. Werden die Rechte nicht gebraucht, steht setuid(0) nur unmittelbar vor dem Aufruf einer spawn-Funktion, und unmittelbar danach wird es zurückgesetzt.

Gewöhnlich braucht **spawn** wenig Zeit. Dauert spawn auffällig lange, trifft es vermutlich auf festgefahrene Ptys. Auf Ptys laufen mehrere Prüfungen, damit es keine Verwicklung mit fehlgeleiteten Prozessen gibt. Das dauert 10 Sekunden je festgefahrener Pty. Läuft expect mit der Option -d, zeigt sich, ob **expect** viele Ptys in merkwürdigen Zuständen trifft. Lassen sich die Prozesse nicht beenden, an denen diese Ptys hängen, bleibt als einziger Ausweg ein Neustart.

# Bugs

Die Funktionen **exp\_fexpect** arbeiten unter HP-UX gar nicht. Das scheint ein Fehler in getc zu sein. Es gilt der Rat weiter oben, die Funktionen **exp\_expect** zu verwenden. Die brauchen getc nicht. Wird der Fehler behoben, und die letzte Ausgabe ist geprüft, soll das dem Autor mitgeteilt werden.

# Siehe auch

Eine Alternative zu dieser Bibliothek ist das Programm **expect**. **expect** interpretiert Skripte in einer höheren Sprache, die den Dialog steuern. Außerdem kann der Benutzer bei Bedarf die Steuerung übernehmen und unmittelbar eingreifen. Wenn es nicht unbedingt nötig ist, ein eigenes C-Programm zu schreiben, ist es viel einfacher, die ganze Interaktion mit **expect** auszuführen. Es ist in den folgenden Quellen näher beschrieben:

*"expect: Curing Those Uncontrollable Fits of Interactivity"* von Don Libes, Proceedings of the Summer 1990 USENIX Conference, Anaheim, California, June 11-15, 1990.

*"Using expect to Automate System Administration Tasks"* von Don Libes, Proceedings of the 1990 USENIX Large Installation Systems Administration Conference, Colorado Springs, Colorado, October 17-19, 1990.

expect(1), alarm(3), read(2), write(2), fdopen(3), execve(2), execvp(3), longjmp(3), pty(4).

Im Verzeichnis test der Quelldistribution von **expect** gibt es mehrere C-Beispielprogramme, die die expect-Bibliothek verwenden.

# Autoren

Don Libes, libes@nist.gov, Nationales Institut für Standards und Technologie

# Danksagungen

Dank an John Ousterhout (UCBerkeley) für den Mustervergleicher.

Entwurf und Umsetzung der Bibliothek **expect** wurden von der Regierung der USA bezahlt und sind deshalb gemeinfrei. Der Autor und das NIST wünschen eine Nennung, wenn dieses Programm und diese Dokumentation oder Teile davon verwendet werden.
