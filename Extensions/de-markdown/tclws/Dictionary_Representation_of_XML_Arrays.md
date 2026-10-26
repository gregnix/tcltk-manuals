XML-Arrays werden im Dictionary-Format als Liste von Werten dargestellt. Sehen wir uns an, wie das für einen [einfachen Typ](#array-eines-einfachen-typs) und für einen [komplexen Typ](#array-eines-komplexen-typs); aussieht.

### Array eines einfachen Typs

Nehmen wir an, ein Element hat die folgende Definition:

```
    <xs:element minOccurs="0" maxOccurs="unbounded" name="Primes" type="xs:integer" />
```

Nehmen wir außerdem an, dass dieses Element in unserem Dictionary die ersten vier Primzahlen enthält. Die Dictionary-Darstellung dieses Elements sähe dann so aus:

```
    Primes {2 3 5 7}
```

Oder, wenn Attribute verwendet werden (das heißt, parseInAttr und/oder genOutAttr sind gesetzt), sähe es so aus:

```
    Primes {{} {2 3 5 7}}
```

### Array eines komplexen Typs

Nehmen wir an, die Typdefinition lautet:

```
<xs:element name="Person">
  <xs:complexType>
    <xs:sequence>
      <xs:element name="FristName" type="xs:string"/>
      <xs:element name="LastName" type="xs:integer"/>
    </xs:sequence>
  </xs:complexType>
</xs:element>
```

Nehmen wir die folgende Definition an:

```
    <xs:element minOccurs="0" maxOccurs="unbounded" name="Attendees" type="Person" />
```

Nehmen wir nun an, die folgenden Personen nehmen teil:

-  John Doe
-  Jane Doe

Die Dictionary-Darstellung dieses Elements sähe dann so aus:

```
    Attendees {
        {FirstName {John} LastName {Doe}}
        {FirstName {Jane} LastName {Doe}}
    }
```

Oder, wenn Attribute verwendet werden (das heißt, parseInAttr und/oder genOutAttr sind gesetzt), sähe es so aus:

```
    Attendees {
        {{} {FirstName {{} {John}} LastName {{} {Doe}}}}
        {{} {FirstName {{} {Jane}} LastName {{} {Doe}}}}
    }
```
