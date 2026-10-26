---
CommandName: mapproj
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Library
Keywords:
 - geodesy
 - map
 - projection
Copyright:
 - Copyright (c) 2007 Kevin B. Kenny <kennykb@acm.org>
---

# NAME

mapproj – Routinen für Kartenprojektionen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.5]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [math::interpolate]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [math::special]{.lit} [0.2.2]{.optlit} 
[package]{.cmd} [require]{.sub} [mapproj]{.lit} [1.1]{.optlit} 
[::mapproj::toPlateCarree]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromPlateCarree]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toCylindricalEqualArea]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromCylindricalEqualArea]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toMercator]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromMercator]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toMillerCylindrical]{.cmd} [lambda_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromMillerCylindrical]{.cmd} [lambda_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toSinusoidal]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromSinusoidal]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toMollweide]{.cmd} [lambda_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromMollweide]{.cmd} [lambda_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toEckertIV]{.cmd} [lambda_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromEckertIV]{.cmd} [lambda_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toEckertVI]{.cmd} [lambda_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromEckertVI]{.cmd} [lambda_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toRobinson]{.cmd} [lambda_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromRobinson]{.cmd} [lambda_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toCassini]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromCassini]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toPeirceQuincuncial]{.cmd} [lambda_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromPeirceQuincuncial]{.cmd} [lambda_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toOrthographic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromOrthographic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toStereographic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromStereographic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toGnomonic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromGnomonic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toAzimuthalEquidistant]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromAzimuthalEquidistant]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toLambertAzimuthalEqualArea]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromLambertAzimuthalEqualArea]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toHammer]{.cmd} [lambda_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromHammer]{.cmd} [lambda_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toConicEquidistant]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [phi_1]{.arg} [phi_2]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromConicEquidistant]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [phi_1]{.arg} [phi_2]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toAlbersEqualAreaConic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [phi_1]{.arg} [phi_2]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromAlbersEqualAreaConic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [phi_1]{.arg} [phi_2]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toLambertConformalConic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [phi_1]{.arg} [phi_2]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromLambertConformalConic]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [phi_1]{.arg} [phi_2]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toLambertCylindricalEqualArea]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromLambertCylindricalEqualArea]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toBehrmann]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromBehrmann]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toTrystanEdwards]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromTrystanEdwards]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toHoboDyer]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromHoboDyer]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toGallPeters]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromGallPeters]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
[::mapproj::toBalthasart]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [lambda]{.arg} [phi]{.arg} 
[::mapproj::fromBalthasart]{.cmd} [lambda_0]{.arg} [phi_0]{.arg} [x]{.arg} [y]{.arg} 
:::

# BESCHREIBUNG

Das Paket **mapproj** bietet eine Reihe von Prozeduren zur Umrechnung zwischen Weltkoordinaten (Breiten- und Längengrad) und Kartenkoordinaten bei verschiedenen Kartenprojektionen.

# BEFEHLE

Die folgenden Befehle dienen zur Umrechnung zwischen Weltkoordinaten und Kartenkoordinaten:

**::mapproj::toPlateCarree** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die *Plate-Carrée*-Projektion (zylindrisch äquidistant).

**::mapproj::fromPlateCarree** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der *Plate-Carrée*-Projektion (zylindrisch äquidistant).

**::mapproj::toCylindricalEqualArea** *lambda_0* *phi_0* *lambda* *phi*
: Wandelt in die zylindrische flächentreue Projektion um.

**::mapproj::fromCylindricalEqualArea** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der zylindrischen flächentreuen Projektion.

**::mapproj::toMercator** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die Mercator-Projektion (zylindrisch-konform).

**::mapproj::fromMercator** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der Mercator-Projektion (zylindrisch-konform).

**::mapproj::toMillerCylindrical** *lambda_0* *lambda* *phi*
: Konvertiert in die zylindrische Miller-Projektion.

**::mapproj::fromMillerCylindrical** *lambda_0* *x* *y*
: Konvertiert aus der zylindrischen Miller-Projektion.

**::mapproj::toSinusoidal** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die sinusförmige (Sanson-Flamsteed-)Projektion.

**::mapproj::fromSinusoidal** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der sinusförmigen (Sanson-Flamsteed-)Projektion.

**::mapproj::toMollweide** *lambda_0* *lambda* *phi*
: Konvertiert in die Mollweide-Projektion.

**::mapproj::fromMollweide** *lambda_0* *x* *y*
: Konvertiert aus der Mollweide-Projektion.

**::mapproj::toEckertIV** *lambda_0* *lambda* *phi*
: Konvertiert in die Eckert-IV-Projektion.

**::mapproj::fromEckertIV** *lambda_0* *x* *y*
: Konvertiert aus der Eckert-IV-Projektion.

**::mapproj::toEckertVI** *lambda_0* *lambda* *phi*
: Konvertiert in die Eckert-VI-Projektion.

**::mapproj::fromEckertVI** *lambda_0* *x* *y*
: Konvertiert aus der Eckert-VI-Projektion.

**::mapproj::toRobinson** *lambda_0* *lambda* *phi*
: Wandelt in die Robinson-Projektion um.

**::mapproj::fromRobinson** *lambda_0* *x* *y*
: Konvertiert aus der Robinson-Projektion.

**::mapproj::toCassini** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die Cassini-Projektion (transversal-zylindrisch-äquidistant).

**::mapproj::fromCassini** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der Cassini-Projektion (transversal-zylindrisch-äquidistant).

**::mapproj::toPeirceQuincuncial** *lambda_0* *lambda* *phi*
: Konvertiert in die Peirce-Quincuncial-Projektion.

**::mapproj::fromPeirceQuincuncial** *lambda_0* *x* *y*
: Konvertiert aus der Peirce-Quincuncial-Projektion.

**::mapproj::toOrthographic** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die orthografische Projektion.

**::mapproj::fromOrthographic** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der orthografischen Projektion.

**::mapproj::toStereographic** *lambda_0* *phi_0* *lambda* *phi*
: Wandelt in die stereografische (azimutal-konforme) Projektion um.

**::mapproj::fromStereographic** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der stereografischen (azimutal-konformen) Projektion.

**::mapproj::toGnomonic** *lambda_0* *phi_0* *lambda* *phi*
: Wandelt in die gnomonische Projektion um.

**::mapproj::fromGnomonic** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der gnomonischen Projektion.

**::mapproj::toAzimuthalEquidistant** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die azimutale äquidistante Projektion.

**::mapproj::fromAzimuthalEquidistant** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der azimutalen äquidistanten Projektion.

**::mapproj::toLambertAzimuthalEqualArea** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die azimutale flächentreue Lambert-Projektion.

**::mapproj::fromLambertAzimuthalEqualArea** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der azimutalen flächentreuen Lambert-Projektion.

**::mapproj::toHammer** *lambda_0* *lambda* *phi*
: Konvertiert in die Hammer-Projektion.

**::mapproj::fromHammer** *lambda_0* *x* *y*
: Konvertiert aus der Hammer-Projektion.

**::mapproj::toConicEquidistant** *lambda_0* *phi_0* *phi_1* *phi_2* *lambda* *phi*
: Konvertiert in die konische äquidistante Projektion.

**::mapproj::fromConicEquidistant** *lambda_0* *phi_0* *phi_1* *phi_2* *x* *y*
: Konvertiert aus der konischen äquidistanten Projektion.

**::mapproj::toAlbersEqualAreaConic** *lambda_0* *phi_0* *phi_1* *phi_2* *lambda* *phi*
: Konvertiert in die flächentreue konische Albers-Projektion.

**::mapproj::fromAlbersEqualAreaConic** *lambda_0* *phi_0* *phi_1* *phi_2* *x* *y*
: Konvertiert aus der flächentreuen konischen Albers-Projektion.

**::mapproj::toLambertConformalConic** *lambda_0* *phi_0* *phi_1* *phi_2* *lambda* *phi*
: Konvertiert in die konforme konische Lambert-Projektion.

**::mapproj::fromLambertConformalConic** *lambda_0* *phi_0* *phi_1* *phi_2* *x* *y*
: Konvertiert aus der konformen konischen Lambert-Projektion. Unter den zylindrischen flächentreuen Projektionen gibt es mehrere benannte Standardparallelen:

**::mapproj::toLambertCylindricalEqualArea** *lambda_0* *phi_0* *lambda* *phi*
: Wandelt in die zylindrische flächentreue Lambert-Projektion um. (Die Standardparallele ist der Äquator.)

**::mapproj::fromLambertCylindricalEqualArea** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der zylindrischen flächentreuen Lambert-Projektion. (Die Standardparallele ist der Äquator.)

**::mapproj::toBehrmann** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die zylindrische flächentreue Behrmann-Projektion. (Die Standardparallelen liegen bei 30 Grad Nord und Süd.)

**::mapproj::fromBehrmann** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der zylindrischen flächentreuen Behrmann-Projektion. (Die Standardparallelen liegen bei 30 Grad Nord und Süd.)

**::mapproj::toTrystanEdwards** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die zylindrische flächentreue Trystan-Edwards-Projektion. (Die Standardparallelen liegen bei 37,4 Grad Nord und Süd.)

**::mapproj::fromTrystanEdwards** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der zylindrischen flächentreuen Trystan-Edwards-Projektion. (Die Standardparallelen liegen bei 37,4 Grad Nord und Süd.)

**::mapproj::toHoboDyer** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die zylindrische flächentreue Hobo-Dyer-Projektion. (Die Standardparallelen liegen bei 37,5 Grad Nord und Süd.)

**::mapproj::fromHoboDyer** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der zylindrischen flächentreuen Hobo-Dyer-Projektion. (Die Standardparallelen liegen bei 37,5 Grad Nord und Süd.)

**::mapproj::toGallPeters** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die zylindrische flächentreue Gall-Peters-Projektion. (Die Standardparallelen liegen bei 45 Grad Nord und Süd.)

**::mapproj::fromGallPeters** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der zylindrischen flächentreuen Gall-Peters-Projektion. (Die Standardparallelen liegen bei 45 Grad Nord und Süd.)

**::mapproj::toBalthasart** *lambda_0* *phi_0* *lambda* *phi*
: Konvertiert in die zylindrische flächentreue Balthasart-Projektion. (Die Standardparallelen liegen bei 50 Grad Nord und Süd.)

**::mapproj::fromBalthasart** *lambda_0* *phi_0* *x* *y*
: Konvertiert aus der zylindrischen flächentreuen Balthasart-Projektion. (Die Standardparallelen liegen bei 50 Grad Nord und Süd.)


# ARGUMENTE

Die Projektionsbefehle akzeptieren die folgenden Argumente:

*lambda*
: Längengrad des zu projizierenden Punktes in Grad.

*phi*
: Breitengrad des zu projizierenden Punktes in Grad.

*lambda_0*
: Längengrad des Mittelpunkts des Kartenblatts in Grad. Bei vielen Projektionen ist dieser Wert auch der Referenzmeridian der Projektion.

*phi_0*
: Breitengrad des Mittelpunkts des Kartenblatts in Grad. Bei azimutalen Projektionen ist dieser Wert auch der Breitengrad des Projektionsmittelpunkts.

*phi_1*
: Breitengrad der ersten Referenzparallele, bei Projektionen, die Referenzparallele verwenden.

*phi_2*
: Breitengrad der zweiten Referenzparallele, bei Projektionen, die Referenzparallele verwenden.

*x*
: X-Koordinate eines Punktes auf der Karte, in Einheiten des Erdradius.

*y*
: Y-Koordinate eines Punktes auf der Karte, in Einheiten des Erdradius.


# ERGEBNISSE

Bei allen Prozeduren, deren Namen mit „to“ beginnen, ist der Rückgabewert eine Liste aus einer *x*-Koordinate und einer *y*-Koordinate. Die Koordinaten beziehen sich auf den Mittelpunkt des zu zeichnenden Kartenblatts und werden in Erdradien am Referenzort auf der Karte gemessen. Bei allen Funktionen, deren Namen mit „from“ beginnen, ist der Rückgabewert eine Liste aus Längen- und Breitengrad in Grad.

# AUSWAHL EINER PROJEKTION

Dieses Paket bietet eine Vielzahl von Projektionen, da keine einzelne Projektion für alle Karten geeignet ist. In diesem Abschnitt soll eine Orientierungshilfe bei der Auswahl einer Projektion gegeben werden.

Zuerst ist die Art der Daten zu betrachten, die auf der Karte dargestellt werden sollen. Handelt es sich um *gerichtete* Daten (z. B. Winde, Meeresströmungen oder Magnetfelder), ist eine Projektion nötig, die Winkel beibehält; diese heißen *konforme* Projektionen. Zu den konformen Projektionen zählen die Mercator-Projektion, die azimutale flächentreue Albers-Projektion, die stereografische Projektion und die Peirce-Quincuncial-Projektion. Handelt es sich um *thematische* Daten, die Eigenschaften von Land oder Wasser beschreiben, wie Temperatur, Bevölkerungsdichte, Landnutzung oder demografische Daten, ist eine Projektion nötig, bei der die Flächen auf der Karte proportional zu den Flächen in der Wirklichkeit sind. Zu diesen sogenannten *flächentreuen* Projektionen gehören die verschiedenen zylindrischen flächentreuen Projektionen, die sinusförmige Projektion, die azimutale flächentreue Lambert-Projektion, die flächentreue konische Albers-Projektion sowie mehrere Weltkartenprojektionen (zylindrische Miller-Projektion, Mollweide, Eckert IV, Eckert VI, Robinson und Hammer). Ist der entscheidende Faktor in den Daten die Entfernung von einem zentralen Punkt oder einer Linie (wie bei Flugstrecken), eignet sich eine *äquidistante* Projektion wie *Plate Carrée*, Cassini, die azimutale äquidistante oder die konische äquidistante Projektion am besten. Ist die Richtung von einem zentralen Punkt aus ein entscheidender Faktor (beispielsweise Flugrouten oder die Ausrichtung von Funkantennen), kommt fast sicher eine der azimutalen Projektionen in Frage. Geeignete Möglichkeiten sind die azimutale äquidistante, die azimutale flächentreue, die stereografische und möglicherweise die orthografische Projektion.

Als Nächstes ist zu betrachten, welchen Teil der Erde die Karte abdecken soll und welche allgemeine Form das betreffende Gebiet aufweist. Für Karten der gesamten Erde sind die zylindrischen flächentreuen Projektionen, die Eckert-IV- und -VI-Projektionen sowie die Mollweide-, Robinson- und Hammer-Projektionen insgesamt eine gute Wahl. Die Mercator-Projektion ist zwar traditionell, doch aufgrund der extremen Flächenverzerrungen in hohen Breiten ist sie eine schlechte Wahl, es sei denn, eine konforme Projektion ist erforderlich. Die Peirce-Projektion ist unter den konformen Projektionen die bessere Wahl, da sie Landformen weniger verzerrt. Die zylindrische Miller-Projektion ist ein Kompromiss, der Formen ähnlich der traditionellen Mercator-Projektion liefern soll, jedoch mit geringerer polarer Streckung. Die Peirce-Quincuncial-Projektion stellt alle Kontinente mit akzeptabler Verzerrung dar, wenn ein Referenzmeridian nahe +20 Grad gewählt wird. Die Robinson-Projektion liefert ansprechende Karten für Dinge wie politische Gliederungen, sollte bei der Darstellung wissenschaftlicher Daten jedoch vermieden werden, da andere Projektionen nützlichere geometrische Eigenschaften haben.

Soll die Karte eine Hemisphäre abdecken, eignen sich die stereografische, die azimutal-äquidistante, die Hammer- oder die Mollweide-Projektion; sie alle bilden die Hemisphäre als Kreis ab.

Soll die Karte ein großes Gebiet abdecken (mindestens einige hundert Kilometer Seitenlänge), jedoch weniger als eine Hemisphäre, stehen mehrere Möglichkeiten zur Auswahl. Azimutale Projektionen eignen sich in der Regel gut (stereografisch, azimutal äquidistant oder azimutal flächentreu nach Lambert, je nachdem, ob Formen, Entfernungen von einem Mittelpunkt oder Flächen von Bedeutung sind). Azimutale Projektionen (und möglicherweise die Cassini-Projektion) sind die einzigen wirklich guten Möglichkeiten für die Kartierung der Polarregionen.

Liegt das große Gebiet in einer der gemäßigten Zonen und ist es rund oder erstreckt es sich vorwiegend in Ost-West-Richtung, sind konische Projektionen eine gute Wahl. Die konforme konische Lambert-Projektion, die äquidistante konische Projektion oder die flächentreue konische Albers-Projektion kommen in Frage, je nachdem, ob Form, Entfernung oder Fläche die wichtigsten Parameter sind. Bei jeder dieser Projektionen sind die Referenzparallelen bei etwa 1/6 und 5/6 des darzustellenden Breitenbereichs zu wählen. So wirken beispielsweise Karten der 48 zusammenhängenden Bundesstaaten der Vereinigten Staaten mit Referenzparallelen von 28,5 und 45,5 Grad besonders ansprechend.

Ist das große Gebiet äquatorial und rund oder erstreckt es sich vorwiegend in Ost-West-Richtung, ist die Mercator-Projektion eine gute Wahl als konforme Projektion; die zylindrische flächentreue Lambert-Projektion und die sinusförmige Projektion sind gute flächentreue Projektionen; und die *Plate Carrée* ist eine gute äquidistante Projektion.

Große Gebiete mit vorwiegend Nord-Süd-Ausrichtung, insbesondere solche, die den Äquator überspannen, brauchen andere Möglichkeiten. Die Cassini-Projektion ist eine gute Wahl für eine äquidistante Projektion (beispielsweise ergibt eine Cassini-Projektion mit einem Zentralmeridian von 80 Grad West eine ansprechende Karte der amerikanischen Kontinente). Als flächentreue Projektionen kommen die zylindrische flächentreue Projektion, die flächentreue konische Albers-Projektion, die sinusförmige Projektion, die Mollweide-Projektion und die Hammer-Projektion in Frage. Eine gute konforme Projektion für diesen Fall ist die transversale Mercator-Projektion, die leider noch nicht implementiert ist.

Bei kleinen Gebieten beginnt sich die Elliptizität der Erde auf den Kartenmaßstab auszuwirken. Dieses Paket versucht nicht, eine genaue Kartierung großmaßstäblicher topografischer Karten zu leisten. Sind geringfügige Maßstabsfehler in der Anwendung akzeptabel, sollte jede für große Gebiete geeignete Projektion auch für kleine Gebiete geeignet sein.

Es gibt einige Projektionen, die aufgrund ihrer besonderen Eigenschaften berücksichtigt werden. Die orthografische Projektion erzeugt Ansichten der Erde, wie sie aus dem Weltraum zu sehen ist. Die gnomonische Projektion erzeugt eine Karte, auf der alle Großkreise (die kürzeste Entfernung zwischen zwei Punkten auf der Erdoberfläche) als gerade Linien dargestellt werden. Diese Projektion ist zwar für die Navigationsplanung nützlich, weist jedoch extreme Verzerrungen hinsichtlich Form und Fläche auf und kann nur einen begrenzten Bereich der Erde darstellen (deutlich weniger als eine Hemisphäre).

# COPYRIGHT

```
Copyright (c) 2007 Kevin B. Kenny <kennykb@acm.org>
```
