# Mehrfeld-Eingabe-Widgets für reelle Zahlen  
 im Festkommaformat

## Für Mentry Version 4.5

### von

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Inhalt

- [Der Befehl mentry::fixedPointMentry](#der-befehl-mentry-fixedpointmentry)
- [Der Befehl mentry::putReal](#der-befehl-mentry-putreal)
- [Der Befehl mentry::getReal](#der-befehl-mentry-getreal)

[Startseite](index.md)

---

## Der Befehl `mentry::fixedPointMentry`

**NAME**
: `mentry::fixedPointMentry` – Erstellen und Bearbeiten von mentry-Widgets für reelle Zahlen im Festkommaformat

**ÜBERSICHT**
: 

```
mentry::fixedPointMentry pathName count1 count2 ?-comma? ?options?
```

**BESCHREIBUNG**
: Dieser Befehl erstellt ein neues mentry-Widget `pathName` zur Anzeige und Bearbeitung von reellen Zahlen im Festkommaformat, mit `count1` Zeichen vor und `count2` Ziffern nach dem Dezimalpunkt.  Sowohl `count1` als auch `count2` müssen positive ganze Zahlen sein.  Das Mentry verfügt über zwei Eingabekomponenten, die standardmäßig durch eine Beschriftung mit einem `"."`-Zeichen getrennt sind; der optionale Schalter `-comma` ändert den Beschriftungstext in `","`.  Die unterstützten `options` entsprechen denen des Befehls `mentry::mentry`.

: Der Befehl setzt das Attribut `type` des Widgets auf den Wert `"FixedPoint"` und gibt den Namen des neu erstellten Widgets zurück.

**SCHLÜSSELWÖRTER**
: mentry, widget, real number


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::putReal`

**NAME**
: `mentry::putReal` – Eine reelle Zahl in ein Mentry vom Typ `"FixedPoint"` ausgeben

**ÜBERSICHT**
: 

```
mentry::putReal number pathName
```

**BESCHREIBUNG**
: Dieser Befehl gibt die reelle Zahl `number` an das mentry-Widget `pathName` aus, das zuvor mit dem Befehl `mentry::fixedPointMentry` erstellt worden sein muss (dies wird durch Überprüfung des Attributs `type` des Widgets überprüft, das den Wert `"FixedPoint"` haben muss).

: Der Befehl löst einen Fehler aus, wenn die Zahl nicht in das Widget passt, weil sie zu viele Zeichen vor dem Dezimalpunkt enthält.

**SCHLÜSSELWÖRTER**
: mentry, widget, real number


[Inhalt](#inhalt)     [Startseite](index.md)

---

## Der Befehl `mentry::getReal`

**NAME**
: `mentry::getReal` – Eine reelle Zahl aus einem Mentry des Typs `"FixedPoint"` abrufen

**ÜBERSICHT**
: 

```
mentry::getReal pathName
```

**BESCHREIBUNG**
: Dieser Befehl gibt die Zahl zurück, die im Mentry-Widget `pathName` enthalten ist, das mit dem Befehl `mentry::fixedPointMentry` erstellt worden sein muss (dies wird durch Überprüfung des Attributs `type` des Widgets überprüft, das den Wert `"FixedPoint"` haben muss).

: Wenn beide Eingabekomponenten des Widgets leer sind, setzt der Befehl den Fokus auf die erste Eingabekomponente, löst einen Fehler aus und gibt die Zeichenfolge `"EMPTY"` zurück.

**SCHLÜSSELWÖRTER**
: mentry, widget, real number


[Inhalt](#inhalt)     [Startseite](index.md)
