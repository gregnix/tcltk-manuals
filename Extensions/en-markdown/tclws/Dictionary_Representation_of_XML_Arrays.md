 XML arrays are represented in dictionary format as a list of values. Lets consider what this looks like for a [simple type](#array-of-simple-type) and for a [complex type](#array-of-complex-type);. 

### Array of Simple Type

 Lets assume we have an element with the following definition: 

```
    <xs:element minOccurs="0" maxOccurs="unbounded" name="Primes" type="xs:integer" />
```

Lets also assume that we will have that element in our dictionary with
the first four prime numbers, thus the dictionary representation for
that element would look like:

```
    Primes {2 3 5 7}
```

Or, if we have are using attributes (i.e. parseInAttr and/or genOutAttr are set), it would look like:

```
    Primes {{} {2 3 5 7}}
```

### Array of Complex Type

 Lets assume we have the type definition: 

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

Lets assume we have the following definition:

```
    <xs:element minOccurs="0" maxOccurs="unbounded" name="Attendees" type="Person" />
```

Now lets assume the following people are are attending:

-  John Doe 
-  Jane Doe 

Thus the dictionary representation for that element would look like:

```
    Attendees {
        {FirstName {John} LastName {Doe}}
        {FirstName {Jane} LastName {Doe}}
    }
```

Or, if we have are using attributes (i.e. parseInAttr and/or genOutAttr are set), it would look like:

```
    Attendees {
        {{} {FirstName {{} {John}} LastName {{} {Doe}}}}
        {{} {FirstName {{} {Jane}} LastName {{} {Doe}}}}
    }
```
