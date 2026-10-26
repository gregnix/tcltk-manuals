---
CommandName: LIBEXPECT
ManualSection: 3
Version: 12 December 1991
TclPart: 
TclDescription: 
Links:
 - An alternative to this library is the expect program. expect interprets scripts written in a high-level language which direct the dialogue. In addition
 - the user can take control and interact directly when desired. If it is not absolutely necessary to write your own C program
 - "it is much easier to use expect to perform the entire interaction. It is described further in the following references: \"expect: Curing Those Uncontrollable Fits of Interactivity\" by Don Libes"
 - Proceedings of the Summer 1990 USENIX Conference
 - Anaheim
 - California
 - June 11-15
 - 1990. "Using expect to Automate System Administration Tasks" by Don Libes
 - Proceedings of the 1990 USENIX Large Installation Systems Administration Conference
 - Colorado Springs
 - Colorado
 - October 17-19
 - 1990. expect(1)
 - alarm(3)
 - read(2)
 - write(2)
 - fdopen(3)
 - execve(2)
 - execvp(3)
 - longjmp(3)
 - pty(4). There are several examples C programs in the test directory of expect's source distribution which use the expect library
Copyright:
---

# NAME

libexpect - Bibliothek für programmierten Dialog mit interaktiven Programmen

# BESCHREIBUNG

Diese Bibliothek enthält Funktionen, mit denen Expect als Tcl-Erweiterung oder unmittelbar aus C oder C++ verwendet werden kann, ohne Tcl. Expect als Tcl-Erweiterung hinzuzufügen, ist sehr kurz und einfach. Das kommt zuerst.

# ÜBERSICHT

::: {.synopsis} :::
[#include]{.cmd} [expect_tcl.h]{.lit}
[Expect_Init]{.cmd}(interp);

cc files... -lexpect5.20 -ltcl7.5 -lm
:::

Hinweis: Die Bibliotheksversionen können in der tatsächlichen Ausgabe abweichen.

Die Funktion Expect_Init fügt dem genannten Interpreter expect-Befehle hinzu. Vorhandene Befehle werden nicht überschrieben. Aliase, die mit "exp\_" beginnen, werden für expect-Befehle aber immer angelegt. "send" kann zum Beispiel als "exp_send" verwendet werden.

Expect-Befehle werden nur über Tcl_Eval aufgerufen. Bestimmte Hilfsfunktionen dürfen unmittelbar aufgerufen werden. Die Hilfsfunktionen sind unten zusammengefasst. Das kann nützlich sein, um eine eigene main zu bauen. Die Datei exp_main_exp.c in der Expect-Distribution ist eine main als Vorbild. Ein weiteres Vorbild ist tclAppInit.c in der Tcl-Distribution. Ein Vorbild für die Arbeit mit Tk steht in exp_main_tk.c in der Expect-Distribution.

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

**exp_cmdlinecmds** ist 1, wenn Expect mit Befehlen auf der Programm-Befehlszeile aufgerufen wurde, zum Beispiel mit "-c". **exp_interactive** ist 1, wenn Expect mit der Markierung -i aufgerufen wurde oder wenn keine Befehle und kein Skript aufgerufen werden. **exp_cmdfile** ist ein Strom, aus dem Expect Befehle liest. **exp_cmdfilename** ist der Name einer Datei, die Expect öffnet und aus der es Befehle liest. **exp_tcl_debugger_available** ist 1, wenn der Debugger scharf gemacht wurde.

**exp_parse_argv** liest die Darstellung der Befehlszeile. Je nachdem, was gefunden wird, werden die anderen hier aufgeführten Variablen passend eingerichtet. **exp_interpreter** fragt den Benutzer interaktiv nach Befehlen und wertet sie aus. **exp_interpret_cmdfile** liest den angegebenen Strom und wertet gefundene Befehle aus. **exp_interpret_cmdfilename** öffnet die genannte Datei und wertet gefundene Befehle aus. **exp_interpret_rcfiles** liest die .rc-Dateien und wertet sie aus. Ist my_rc null, wird ~/.expectrc übersprungen. Ist sys_rc null, wird die systemweite expectrc-Datei übersprungen. **exp_cook** gibt einen statischen Puffer zurück, der das Argument enthält, wobei Zeilenumbrüche durch Folgen aus Wagenrücklauf und Zeilenvorschub ersetzt sind. Der Hauptzweck ist, Meldungen zu erzeugen, ohne darauf zu achten, ob das Terminal im Rohmodus oder im kanonischen Modus steht. Ist die Länge null, wird sie über strlen berechnet. **exp_error** ist eine printf-ähnliche Funktion, die das Ergebnis nach interp->result schreibt.

# ÜBERSICHT

::: {.synopsis} :::
[#include]{.cmd} [\<expect.h>]{.lit}

int
[exp_spawnl]{.cmd}(file, arg0 \[, arg1, ..., argn\] (char \*)0);
char \*file;
char \*arg0, \*arg1, ... \*argn;

int
[exp_spawnv]{.cmd}(file,argv);
char \*file, \*argv\[ \];

int
[exp_spawnfd]{.cmd}(fd);
int fd;

FILE \*
[exp_popen]{.cmd}(command);
char \*command;

extern int exp_pid;
extern int exp_ttyinit;
extern int exp_ttycopy;
extern int exp_console;
extern char \*exp_stty_init;
extern void (\*exp_close_in_child)();
extern void (\*exp_child_exec_prelude)();
extern void [exp_close_tcl_files]{.cmd}();

cc files... -lexpect -ltcl -lm
:::

# BESCHREIBUNG

**exp_spawnl** und **exp_spawnv** spalten einen neuen Prozess ab, sodass der aktuelle Prozess dessen stdin, stdout und stderr schreiben und lesen kann. *file* ist der Name einer Datei, die ausgeführt werden soll. Die Zeiger *arg* sind nullterminierte Zeichenketten. Nach dem Stil von execve() ist *arg0*, oder *argv\[0\]*, üblicherweise ein Doppel des Dateinamens.

Es gibt vier Schnittstellen. **exp_spawnl** ist nützlich, wenn die Zahl der Argumente zur Übersetzungszeit bekannt ist. **exp_spawnv** ist nützlich, wenn die Zahl der Argumente zur Übersetzungszeit nicht bekannt ist. **exp_spawnfd** ist nützlich, wenn ein offener Dateideskriptor schon als Quelle vorliegt. **exp_popen** wird weiter unten erklärt.

Wird der Prozess erfolgreich angelegt, kommt ein Dateideskriptor zurück, der stdin, stdout und stderr des Prozesses entspricht. Mit fdopen() kann dem Dateideskriptor ein Strom zugeordnet werden. Darauf sollte fast sicher setbuf() folgen, um die Ein-/Ausgabe zu entpuffern.

Das Schließen des Dateideskriptors erkennt der Prozess gewöhnlich als EOF. Ist ein solcher Prozess beendet, sollte mit wait auf ihn gewartet werden, damit der Prozessplatz im Kern frei wird. Manche Systeme erlauben, das zu unterlassen, wenn das Signal SIGCHLD übergangen wird.

**exp_popen** ist eine weitere Schnittstelle, nach dem Vorbild von popen(). Die Funktion nimmt eine Befehlszeile der Bourne-Shell und gibt einen Strom zurück, der stdin, stdout und stderr des Prozesses entspricht. Die Umsetzung von **exp_popen** unten zeigt **exp_spawnl**.

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

Nachdem ein Prozess gestartet ist, wird die Variable **exp_pid** auf die Prozesskennung des neuen Prozesses gesetzt. Die Variable **exp_pty_slave_name** wird auf den Namen der Slave-Seite der Pty gesetzt.

Die spawn-Funktionen verwenden eine Pty, um mit dem Prozess zu kommunizieren. In der Vorgabe wird die Pty wie das tty des Benutzers eingerichtet, wenn das möglich ist, also wenn die Umgebung ein steuerndes Terminal hat. Diese Einrichtung lässt sich überspringen, indem exp_ttycopy auf 0 gesetzt wird.

Ist exp_ttyinit ungleich null, wird die Pty weiter auf einige systemweite Vorgaben eingerichtet. Die Vorgabe entspricht im Allgemeinen "stty sane".

Die tty-Einstellung lässt sich weiter ändern, indem die Variable **exp_stty_init** gesetzt wird. Diese Variable wird im Stil von stty-Argumenten gelesen. exp_stty_init = "sane"; wiederholt zum Beispiel die Vorgabeeinrichtung.

Auf manchen Systemen lässt sich die Konsolenausgabe auf Ptys umleiten. Wird das unterstützt, erhält der nächste spawn die Konsolenausgabe, wenn die Variable **exp_console** auf 1 gesetzt wird.

Zwischen dem Start eines Prozesses und der Übergabe der Steuerung an das neue Programm können die spawn-Funktionen die Umgebung aufräumen, indem sie Dateideskriptoren schließen. In der Vorgabe werden nur Dateideskriptoren geschlossen, die intern zu Expect gehören, und solche mit der Markierung "close-on-exec".

Weitere Dateideskriptoren lassen sich schließen, indem eine passende Funktion angelegt und exp_close_in_child zugewiesen wird. Die Funktion wird nach dem fork und vor dem exec aufgerufen. Das ändert auch das Verhalten des Befehls spawn in Expect.

Wird auch Tcl verwendet, kann die Funktion exp_close_tcl_files bequem sein. Die Funktion schließt alle Dateien zwischen den vorgegebenen Standard-Dateideskriptoren und dem höchsten Deskriptor, den Tcl kennt. Expect tut das.

Die Funktion exp_child_exec_prelude ist die letzte Funktion, die im Kind vor dem eigentlichen exec aufgerufen wird. Die Funktion lässt sich neu definieren, etwa um die uid oder die Signale zu verändern.

# EIGENE PTY ZUTEILEN

```
extern int exp_autoallocpty;
extern int exp_pty[2];
```

Die spawn-Funktionen verwenden eine Pty, um mit dem Prozess zu kommunizieren. In der Vorgabe wird bei jedem Start eines Prozesses automatisch eine Pty zugeteilt. Sollen die Ptys selbst zugeteilt werden, wird vor dem Aufruf einer spawn-Funktion **exp_autoallocpty** auf 0 gesetzt, **exp_pty\[0\]** auf den Dateideskriptor der Master-Pty und **exp_pty\[1\]** auf den Dateideskriptor der Slave-Pty. Die expect-Bibliothek nimmt dann keine Pty-Einrichtung vor, exp_stty_init wird zum Beispiel nicht verwendet. Der Dateideskriptor der Slave-Pty wird automatisch geschlossen, wenn der Prozess gestartet wird. Nach dem Start des Prozesses läuft die weitere Kommunikation über den Dateideskriptor der Master-Pty.

**exp_spawnl** und **exp_spawnv** bilden das Suchen der Shell nach einer ausführbaren Datei in einer Verzeichnisliste nach. Die Verzeichnisliste kommt aus der Umgebung.

# EXPECT-VERARBEITUNG

Aus einem Prozess, den **exp_spawnl** oder **exp_spawnv** gestartet hat, lässt sich mit read() lesen. Bequemere Funktionen stehen bereit. Es folgen:

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

Das Argument type ist einer von mehreren Werten. exp_end zeigt, dass keine weiteren Muster folgen. exp_glob zeigt, dass das Muster eine Zeichenkette im Glob-Stil ist. exp_exact zeigt, dass das Muster eine genaue Zeichenkette ist. exp_regexp zeigt, dass das Muster eine Zeichenkette im Regexp-Stil ist. exp_compiled zeigt, dass das Muster eine Zeichenkette im Regexp-Stil ist und dass seine kompilierte Form ebenfalls angegeben wird. exp_null zeigt, dass das Muster eine Null ist. Zur Fehlersuche muss danach auch ein Zeichenkettenmuster folgen.

Wird die kompilierte Form bei den Funktionen **exp_expectl** und **exp_fexpectl** nicht angegeben, wird jede intern vorgenommene Musterkompilierung verworfen, nachdem die Funktion zurückgekehrt ist. Die Funktionen **exp_expectv** und **exp_fexpectv** kompilieren Muster automatisch und verwerfen sie nicht. Stattdessen werden sie verworfen, indem für jedes Muster free aufgerufen wird. Verwerfen ist nur beim letzten Verwenden der Fälle nötig.

Passende Regexp-Teilmuster werden in der kompilierten regexp gespeichert. Enthält "re" eine kompilierte regexp, steht die passende Zeichenkette in re->startp\[0\]. Die passenden Teilzeichenketten, nach den Klammern im ursprünglichen Muster, stehen in re->startp\[1\], re->startp\[2\] und so weiter bis re->startp\[9\]. Die zugehörigen Enden der Zeichenketten sind re->endp\[x\], wobei x derselbe Index ist wie beim Anfang der Zeichenkette.

Der Typ exp_null passt, wenn in der Eingabe eine Null erscheint. Die Variable exp_remove_nulls muss auf 0 gesetzt werden, damit Nullen nicht automatisch entfernt werden. In der Vorgabe ist exp_remove_nulls 1, und Nullen werden automatisch entfernt.

**exp_expectv** und **exp_fexpectv** sind nützlich, wenn die Zahl der Muster nicht im Voraus bekannt ist. Dann stehen die Gruppen in einem Feld. Das Ende des Feldes bezeichnet eine struct exp_case mit dem Typ exp_end. Im Rest dieser Erörterung werden diese Funktionen allgemein *expect* genannt.

Passt ein Muster, kommt die zugehörige ganze Zahl zurück. Die Werte müssen nicht eindeutig sein, sollten aber positiv sein, damit sie nicht mit EXP_EOF, EXP_TIMEOUT oder EXP_FULLBUFFER verwechselt werden. Bei EOF oder Zeitüberschreitung kommt der Wert **EXP_EOF** oder **EXP_TIMEOUT** zurück. Die Vorgabezeitspanne ist 10 Sekunden und lässt sich durch Setzen der Variable **exp_timeout** ändern. Der Wert -1 schaltet eine Zeitüberschreitung aus. Der Wert 0 lässt die expect-Funktion nach einem read() sofort zurückkehren, also pollen. Davor muss aber eine Funktion wie select, poll oder eine Rückruffunktion einer Ereignisverwaltung stehen, damit Daten zum Lesen da sind.

Ist die Variable exp_full_buffer 1, kommt EXP_FULLBUFFER zurück, wenn exp_buffer voll wird und kein Muster gepasst hat.

Kehrt die expect-Funktion zurück, zeigt **exp_buffer** auf den Puffer der Zeichen, die für den Vergleich betrachtet wurden. **exp_buffer_end** zeigt auf die Stelle ein Zeichen hinter dem letzten Zeichen in exp_buffer. Ist eine Übereinstimmung entstanden, zeigt **exp_match** in **exp_buffer** auf den Anfang der Übereinstimmung. **exp_match_end** zeigt auf das Zeichen hinter dem Ende der Übereinstimmung.

Kommt neue Eingabe, wird sie mit jedem Muster in der aufgeführten Reihenfolge verglichen. Das Fehlen einer Übereinstimmung lässt sich prüfen, indem das letzte Muster etwas ist, das sicher erscheint, etwa eine Eingabeaufforderung. Gibt es keine Eingabeaufforderung, ist auf **EXP_TIMEOUT** zu prüfen, so wie bei der Arbeit von Hand. Weitere Überlegungen und Vorgehensweisen zum Angeben von Mustern für **expect** stehen in der Dokumentation des Programms **expect** selbst. Weitere Angaben stehen unter SEE ALSO weiter unten.

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

Sternchen, wie im Beispiel oben, sind eine nützliche Kurzform, um Zeichen am Zeilenende und anderes Detail wegzulassen. Muster müssen die ganze Ausgabe des aktuellen Prozesses treffen, seit dem vorigen read auf dem Deskriptor oder Strom. Mehr als 2000 Bytes Ausgabe können frühere Bytes zum „Vergessen“ zwingen. Das lässt sich durch Setzen der Variable **exp_match_max** ändern. Übermäßig große Werte können den Mustervergleich verlangsamen.

# LAUF IM HINTERGRUND

```
extern int exp_disconnected;
int exp_disconnect();
```

Ein Prozess lässt sich in den Hintergrund legen, nachdem er zu laufen begonnen hat. Ein typischer Gebrauch ist, Passwörter zu lesen und dann im Hintergrund zu schlafen, bevor die Passwörter für die eigentliche Arbeit verwendet werden.

Um einen Prozess in den Hintergrund zu legen, wird fork aufgerufen, im Kindprozess exp_disconnect() und im Elternprozess exit(). Das löst den Prozess vom steuernden Terminal. Soll ein Prozess auf andere Weise in den Hintergrund, muss die Variable exp_disconnected auf 1 gesetzt werden. Prozesse, die danach gestartet werden, starten dann richtig.

# MEHRFACHZUGRIFF

In der Vorgabe blockieren die expect-Funktionen in einem read auf einem einzigen Dateideskriptor. Soll auf Muster von mehreren Dateideskriptoren gewartet werden, dienen select, poll oder eine Ereignisverwaltung. Daran ist abzulesen, welcher Dateideskriptor zum Lesen bereit ist.

Ist ein Dateideskriptor zum Lesen bereit, können die expect-Funktionen genau ein read ausführen, indem timeout auf 0 gesetzt wird.

# STEUERUNG DES SLAVE

```
void
exp_slave_control(fd,enable)
int fd;
int enable;
```

Das Einfangen der Pty geschieht gewöhnlich automatisch durch die expect-Funktionen. Soll zum Beispiel ein ioctl unmittelbar auf dem Slave-Gerät abgesetzt werden, wird das Einfangen vorübergehend ausgeschaltet.

Das Einfangen der Pty lässt sich mit exp_slave_control steuern. Das erste Argument ist der Dateideskriptor des gestarteten Prozesses. Das zweite Argument ist 0, wenn das Einfangen ausgeschaltet werden soll, und 1, wenn es eingeschaltet werden soll.

# FEHLER

Alle Funktionen zeigen Fehler, indem sie -1 zurückgeben und errno setzen.

Fehler, die auftreten, nachdem die spawn-Funktionen abgespalten haben, etwa der Versuch, ein nicht vorhandenes Programm zu starten, werden auf stderr des Prozesses geschrieben und vom ersten **expect** gelesen.

# SIGNALE

```
extern int exp_reading;
extern jmp_buf exp_readenv;
```

**expect** verwendet alarm() für die Zeitüberschreitung. Werden während **expect** Alarme erzeugt, läuft die Zeit vorzeitig ab.

Intern ruft **expect** read() auf, das von Signalen unterbrochen werden kann. Werden Signalbehandler definiert, lässt sich das interne read von **expect** neu starten oder abbrechen. Die Variable **exp_reading** ist wahr genau dann, wenn das read von **expect** unterbrochen wurde. longjmp(exp_readenv,EXP_ABORT) bricht das read ab. longjmp(exp_readenv,EXP_RESTART) startet das read neu.

# PROTOKOLL

```
extern int exp_loguser;
extern int exp_logfile_all
extern FILE *exp_logfile;
```

Ist **exp_loguser** ungleich null, sendet **expect** jede Ausgabe des gestarteten Prozesses nach stdout. Interaktive Programme senden ihre Eingabe gewöhnlich zurück, deshalb genügt das meist, um beide Seiten des Gesprächs zu zeigen. Ist **exp_logfile** ebenfalls ungleich null, wird dieselbe Ausgabe in den Strom geschrieben, den **exp_logfile** bezeichnet. Ist **exp_logfile_all** ungleich null, wird **exp_logfile** geschrieben, unabhängig vom Wert von **exp_loguser**.

# FEHLERSUCHE

Die Bibliothek ist leicht zu verwenden. Das eigenständige Programm expect ist aber sehr viel leichter zu verwenden als die Arbeit mit dem C-Compiler und seinem üblichen Kreis aus Bearbeiten, Übersetzen und Fehlersuchen. Anders als bei typischen C-Programmen besteht die Fehlersuche meist nicht darin, den C-Compiler zur Annahme der Programme zu bringen, sondern den Dialog richtig zu bekommen. Skripte von expect nach C zu übertragen, ist gewöhnlich nicht nötig. Die Geschwindigkeit interaktiver Dialoge ist zum Beispiel so gut wie nie das Problem. Zuerst sollte das eigenständige Programm 'expect' versucht werden. Für die meisten ist es eine passendere Lösung als die Bibliothek.

Soll trotzdem in C nach Fehlern gesucht werden, helfen die folgenden Werkzeuge.

```
extern int exp_is_debugging;
extern FILE *exp_debugfile;
```

Expect-Dialoge wirken sehr naheliegend. Dialoge in einem Programm festzuhalten, kann viele Überraschungen in der Schnittstelle eines Programms zeigen. Deshalb gibt es verschiedene Hilfen zur Fehlersuche. Die oben genannten Variablen steuern sie, in der Vorgabe alle 0.

Interne Angaben zur Fehlersuche von **expect** gehen nach stderr, wenn **exp_is_debugging** ungleich null ist. Die Angaben umfassen jedes empfangene Zeichen und jeden Versuch, die aktuelle Eingabe mit den Mustern zu vergleichen. Nicht druckbare Zeichen werden zusätzlich in eine druckbare Form übersetzt. Ein Control-C erscheint zum Beispiel als Zirkumflex, gefolgt von einem C. Ist **exp_logfile** ungleich null, werden diese Angaben auch in diesen Strom geschrieben.

Ist **exp_debugfile** ungleich null, werden alle gewöhnlichen Angaben und alle Angaben zur Fehlersuche in diesen Strom geschrieben, unabhängig vom Wert von **exp_is_debugging**.

# EINSCHRÄNKUNGEN

Die Stromfassungen der Funktionen **expect** sind viel langsamer als die Fassungen mit Dateideskriptor, weil sich eine unbekannte Zahl von Bytes nicht übertragbar lesen lässt, ohne dass eine Zeitüberschreitung droht. Die Zeichen werden deshalb einzeln gelesen. Die Fassungen von **expect** mit Dateideskriptor sind deshalb vorzuziehen, auch wenn automatisierte interaktive Programme gewöhnlich keine hohe Geschwindigkeit verlangen.

Beides zusammen geht: Schreiben mit den üblichen Stromfunktionen und Lesen mit den Dateideskriptor-Fassungen von **expect**, solange keine anderen Eingabefunktionen für Ströme dazwischen gemischt werden, etwa fgetc. Dazu wird jedes Mal fileno(stream) als Dateideskriptor übergeben. Glücklicherweise gibt es wenig Grund, beim Lesen von interaktiven Programmen etwas anderes als die Funktionen **expect** zu verwenden.

Zu exp_popen gibt es kein passendes exp_pclose, anders als bei popen und pclose. Eine Verbindung zu schließen, braucht nur zwei Funktionen, fclose() und danach das Warten auf die pid. Diese beiden Schritte liegen aber nicht selten weit auseinander, sodass die Funktion wenig Wert zu haben scheint.

Läuft das auf einem Cray unter Unicos, das ist das, was aus Erfahrung sicher ist, muss das kompilierte Programm als root oder setuid laufen. Das Problem ist, dass der Cray nur root-Prozessen erlaubt, Ptys zu öffnen. Die Vorsicht sollte so groß wie möglich sein. Werden die Rechte nicht gebraucht, steht setuid(0) nur unmittelbar vor dem Aufruf einer spawn-Funktion, und unmittelbar danach wird es zurückgesetzt.

Gewöhnlich braucht **spawn** wenig Zeit. Dauert spawn auffällig lange, trifft es vermutlich auf festgefahrene Ptys. Auf Ptys laufen mehrere Prüfungen, damit es keine Verwicklung mit fehlgeleiteten Prozessen gibt. Das dauert 10 Sekunden je festgefahrener Pty. Läuft expect mit der Option -d, zeigt sich, ob **expect** viele Ptys in merkwürdigen Zuständen trifft. Lassen sich die Prozesse nicht beenden, an denen diese Ptys hängen, bleibt als einziger Ausweg ein Neustart.

# BUGS

Die Funktionen **exp_fexpect** arbeiten unter HP-UX gar nicht. Das scheint ein Fehler in getc zu sein. Es gilt der Rat weiter oben, die Funktionen **exp_expect** zu verwenden. Die brauchen getc nicht. Wird der Fehler behoben, und die letzte Ausgabe ist geprüft, soll das dem Autor mitgeteilt werden.

# AUTOREN

Don Libes, libes@nist.gov, Nationales Institut für Standards und Technologie

# DANKSAGUNGEN

Dank an John Ousterhout (UCBerkeley) für den Mustervergleicher.

Entwurf und Umsetzung der Bibliothek **expect** wurden von der Regierung der USA bezahlt und sind deshalb gemeinfrei. Der Autor und das NIST wünschen eine Nennung, wenn dieses Programm und diese Dokumentation oder Teile davon verwendet werden.
