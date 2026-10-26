# Befehle zum interaktiven Sortieren nach einer oder mehreren Spalten

## Für Tablelist Version 7.12

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Übersicht](#berblick)
- [Der Befehl tablelist::sortByColumn](#der-befehl-tablelist-sortbycolumn)
- [Der Befehl tablelist::addToSortColumns](#der-befehl-tablelist-addtosortcolumns)

[Startseite](index.md)

---

## Überblick

Die auf dieser Referenzseite beschriebenen Befehle ermöglichen es dem Benutzer, die Elemente eines Tablelist-Widgets mithilfe der linken Maustaste nach einer oder mehreren Spalten zu sortieren.

Wenn der Befehl `tablelist::sortByColumn` als Wert der Konfigurationsoption `-labelcommand` angegeben wurde, werden die Elemente anhand der Elemente der entsprechenden Spalten sortiert, wenn Sie die linke Maustaste über einer der Kopfzeilenbeschriftungen drücken und sie später über derselben Beschriftung wieder loslassen.

Wenn der Befehl `tablelist::addToSortColumns` als Wert der Konfigurationsoption `-labelcommand2` angegeben wurde, wird durch Drücken der Maustaste 1 in Verbindung mit der Taste `Shift` über einer der Kopfzeilenbezeichnungen und anschließendes Loslassen über derselben Bezeichnung die entsprechende Spalte an die Liste der Sortierspalten angehängt oder (falls sie bereits in dieser Liste enthalten war) die entsprechende Sortierreihenfolge umgeschaltet; In beiden Fällen werden die Einträge anhand der aktualisierten Listen der Sortierspalten und Sortierreihenfolgen sortiert.

[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::sortByColumn`

**NAME**
: `tablelist::sortByColumn` – Die Elemente eines Tablelist-Widgets nach einer seiner Spalten sortieren

**ÜBERSICHT**
: 

```
tablelist::sortByColumn pathName columnIndex
```

**BESCHREIBUNG**
: Dieser Befehl sortiert die Einträge des Widgets [tablelist](tablelistWidget.md) `pathName` anhand der Elemente der durch `columnIndex` angegebenen Spalten.  Dies geschieht durch Aufruf des Unterbefehls `sortbycolumn` des Tcl-Befehls, der dem angegebenen Tablelist-Widget zugeordnet ist.  Wenn die Elemente zuletzt in aufsteigender Reihenfolge sortiert wurden, basierend auf derselben Spalte, die durch `columnIndex` angegeben wurde, und kein nachfolgender Aufruf des Unterbefehls `resetsortinfo` erfolgte, ist das letzte an `sortbycolumn` übergebene Argument `-decreasing`, andernfalls `-increasing`.

: Nach dem Sortieren der Einträge wird das virtuelle Ereignis `<<TablelistColumnSorted>>` generiert. Bei Tk-Versionen 8.5 oder höher wird dieses virtuelle Ereignis so generiert, dass seine Option `-data` auf eine Liste gesetzt ist, die aus dem numerischen Index der Spalten und der Sortierreihenfolge besteht (`decreasing` oder `increasing`). Der Befehl gibt die Sortierreihenfolge zurück, und zwar als `decreasing` oder `increasing`.

: Wenn die Option `-showlinenumbers` für die angegebene Spalte auf „true“ gesetzt wurde, werden die oben beschriebenen Aktionen nicht ausgeführt und der Rückgabewert ist eine leere Zeichenkette.

: `tablelist::sortByColumn` wird in der Regel als Wert für die Konfigurationsoption `-labelcommand` eines Tablelist-Widgets angegeben.

**SCHLÜSSELWÖRTER**
: tablelist, sort, column, widget


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `tablelist::addToSortColumns`

**NAME**
: `tablelist::addToSortColumns` – Fügen Sie der Liste der Sortierspalten einen Index für die Spalten hinzu und führen Sie die mehrspaltige Sortierung durch

**ÜBERSICHT**
: 

```
tablelist::addToSortColumns pathName columnIndex
```

**BESCHREIBUNG**
: Dieser Befehl fügt den durch `columnIndex` festgelegten Index der Spalten zur Liste der Sortierspalten des [tablelist](tablelistWidget.md)-Widgets `pathName` hinzu und sortiert die Elemente anhand der Elemente der Spalten, die durch die geänderte Liste angegeben werden.  Dies geschieht durch Aufruf des Unterbefehls `sortbycolumnlist` des Tcl-Befehls, der dem angegebenen Tablelist-Widget zugeordnet ist.  Die beiden an `sortbycolumnlist` übergebenen Argumente werden wie folgt aufgebaut: (a) Wenn der angegebene Spaltenindex bereits in der Liste der Sortierspalten des Widgets enthalten ist (der vom Unterbefehl `sortcolumnlist` zurückgegeben wird) dann bleibt diese Liste unverändert, und die Sortierreihenfolge-Liste (die vom Unterbefehl `sortorderlist` gegeben wird) wird aktualisiert, indem das entsprechende ELEMENTE von `increasing` auf `decreasing` umgeschaltet wird und umgekehrt; (b) andernfalls wird der Index des Spalts an die Liste der Sortierspalten angehängt und der Wert `increasing` an die Liste der Sortierreihenfolgen angehängt.

: Nach dem Sortieren der Elemente durch Übergabe der beiden aktualisierten Listen an den Unterbefehl `sortbycolumnlist` wird das virtuelle Ereignis `<<TablelistColumnsSorted>>` (beachten Sie die Pluralform!) generiert.  Bei Tk-Versionen 8.5 oder höher wird dieses virtuelle Ereignis so erzeugt, dass seine OPTION `-data` auf eine Liste gesetzt ist, die aus den beiden oben genannten aktualisierten Listen besteht, die als Argumente an `sortbycolumnlist` übergeben wurden.  Der Befehl gibt die neue Sortierreihenfolge für die angegebene Spalte zurück, und zwar als `decreasing` oder `increasing`.

: Wenn die Option `-showlinenumbers` für die angegebene Spalte auf „true“ gesetzt wurde, werden die oben beschriebenen Aktionen nicht ausgeführt und der Rückgabewert ist eine leere Zeichenkette.

: `tablelist::addToSortColumns` wird in der Regel als Wert der Konfigurationsoption `-labelcommand2` für ein Tablelist-Widget angegeben.

**SCHLÜSSELWÖRTER**
: tablelist, sort, column list, widget


[Inhalt](#inhalt)     [Startseite](index.md)
