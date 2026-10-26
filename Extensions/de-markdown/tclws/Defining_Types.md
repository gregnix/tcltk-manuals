## INHALT

- [1 Überblick](#berblick) 
- [2 Das Paket Webservices Utility laden](#das-paket-webservices-utility-laden) 
- [3 Einen Typ definieren](#einen-typ-definieren) 
- [3 Einen abgeleiteten Typ definieren](#einen-abgeleiteten-typ-definieren) 
- [4 Eine Typdefinition abfragen](#eine-typdefinition-abfragen) 
- [5 Ein Vorlagen-Dictionary für eine Typdefinition erzeugen](#ein-vorlagen-dictionary-f-r-eine-typdefinition-erzeugen) 

 

## ÜBERBLICK

Die Deklaration von Webdienst-Typen gehört zum Paket Webservices Utility.

Beim Schreiben eines Webdienstes ist oft eine komplexe Typdefinition für ein Argument mit strukturierten Daten nötig.

Beim Aufruf einer Operation eines Webdienstes ist es manchmal bequem, einen komplexen Typ zu definieren, um strukturierte Daten als XML-Fragment zurückzugeben, auch wenn der Dienst angibt, nur eine Zeichenkette zu erwarten.

## DAS PAKET WEBSERVICES UTILITY LADEN

Das Serverpaket für Webservices wird so geladen:

```
 package require WS::Utils
```

Dieser Befehl lädt die Hilfsprogramme nur beim ersten Mal, es schadet also nicht, ihn in jede Datei zu setzen, die die Hilfsprogramme verwendet.

---

## EINEN TYP DEFINIEREN

**Prozedurname** : *::WS::Utils::ServiceTypeDef*

**Beschreibung** : Einen Typ für einen Dienst definieren.

**Argumente** :

```
     mode            - Client oder Server
     service         - Name des Dienstes, für den diese Typdefinition gilt
     type            - Der zu definierende oder neu zu definierende Typ
     definition      - Die Definition der Felder des Typs. Sie besteht aus einem
                           oder mehreren Vorkommen einer Felddefinition. Jede Felddefinition
                           besteht aus:  fieldName fieldInfo
                           Dabei ist die Feldinfo: {type typeName comment commentString}
                              typeName kann jeder einfache oder definierte Typ sein.
                              commentString ist eine Zeichenkette in Anführungszeichen, die das Feld beschreibt.
```

**Gibt zurück** : Nichts

**Nebenwirkungen** : Keine

**Ausnahmebedingungen** : Keine

**Voraussetzungen** : Keine

---

## EINEN ABGELEITETEN TYP DEFINIEREN

**Prozedurname** : *::WS::Utils::ServiceSimpleTypeDef*

**Beschreibung** : Einen abgeleiteten Typ für einen Dienst definieren.

**Argumente** :

```
     mode            - Client oder Server
     service         - Name des Dienstes, für den diese Typdefinition gilt
     type            - Der zu definierende oder neu zu definierende Typ
     definition      - Die Definition der Felder des Typs. Sie besteht aus einem
                           oder mehreren Vorkommen einer Felddefinition. Jede Felddefinition
                           besteht aus:  fieldName fieldInfo
                           Dabei: {type typeName comment commentString}
                              baseType typeName - jeder einfache oder definierte Typ.
                              comment commentString - eine Zeichenkette in Anführungszeichen, die das Feld beschreibt.
                              pattern value
                              length value
                              fixed "true"|"false"
                              maxLength value
                              minLength value
                              minInclusive value
                              maxInclusive value
                              enumeration value
```

**Gibt zurück** : Nichts

**Nebenwirkungen** : Keine

**Ausnahmebedingungen** : Keine

**Voraussetzungen** : Keine

---

## EINE TYPDEFINITION ABFRAGEN

**Prozedurname** : *::WS::Utils::GetServiceTypeDef*

**Beschreibung** : Typdefinitionen abfragen.

**Argumente** :

```
     mode            - Client oder Server
     service         - Name des Dienstes, für den diese Abfrage gilt
     type            - Der abzurufende Typ (optional)
```

**Gibt zurück** :

```
     Wenn type nicht angegeben ist, ein Dictionary-Objekt, das alle Typen
     des Dienstes beschreibt.
     Wenn type angegeben ist, ein Dictionary-Objekt, das den Typ beschreibt.
       Eine Definition besteht aus einem Dictionary-Objekt mit den folgenden Schlüsseln und Werten:
         xns         - Der Namespace für diesen Typ.
         definition  - Die Definition der Felder des Typs. Sie besteht aus einem
                       oder mehreren Vorkommen einer Felddefinition. Jede Felddefinition
                       besteht aus:  fieldName fieldInfo
                       Dabei ist die Feldinfo: {type typeName comment commentString}
                         typeName kann jeder einfache oder definierte Typ sein.
                         commentString ist eine Zeichenkette in Anführungszeichen, die das Feld beschreibt.
```

**Nebenwirkungen** : Keine

**Ausnahmebedingungen** : Keine

**Voraussetzungen** : Der Dienst muss definiert sein.

---

## EIN VORLAGEN-DICTIONARY FÜR EINE TYPDEFINITION ERZEUGEN

**Prozedurname** : *::WS::Utils::GenerateTemplateDict*

**Beschreibung** : Ein Vorlagen-Dictionary-Objekt für einen gegebenen Typ erzeugen.

**Argumente** :

```
     mode            - Client oder Server
     serviceName     - Name des Dienstes, in dem der Typ definiert ist
     type            - Der Name des Typs
     arraySize       - Anzahl der Elemente, die in einem Array erzeugt werden. Voreingestellt ist 2.
```

**Gibt zurück** :

```
      Ein Dictionary-Objekt für einen gegebenen Typ. Wenn Ringverweise existieren, haben sie den Wert <** Circular Reference **>
```

**Nebenwirkungen** : Keine

**Ausnahmebedingungen** : Keine

**Voraussetzungen** : Typ und Dienst müssen definiert sein.
