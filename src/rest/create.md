# Katalogeinträge erzeugen

Nachdem wir die REST-API kennengelernt und über die `GET`-Operation einige
Informationen unseres GeoServers abgerufen haben, werden wir im nächsten Schritt
einen neuen Arbeitsbereich inklusive eines Datenspeichers und Feature Types über
REST anlegen.

## Arbeitsbereich erstellen

Öffnen Sie das Terminal (falls noch nicht geschehen) und geben Sie den folgenden
Befehl zum Erstellen eines neuen Workspaces namens `fossgis` ein:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XPOST \
  -H "Content-type: text/xml" \
  -d "<workspace>
        <name>fossgis</name>
      </workspace>" \
   {{ book.geoServerBaseUrl }}/rest/workspaces
</xmp></pre>

Der obige Aufruf unterscheidet sich in zwei wesentlichen Punkten von den bisherigen
Read-Operationen: Wir nutzen für das Erstellen einer neuen Ressource im Gegensatz
zur HTTP-Operation `GET` die Operation `POST` und schicken einen `XML` Content
<code>&lt;workspace&gt;...&lt;/workspace&gt;</code> an eine eindeutige URL der
REST-API. Die Adresse haben wir durch die bisherigen Schritte identifizieren
können. Nach Aufruf des Befehls sollte im Terminal folgende Ausgabe erscheinen:

<pre><code>* Hostname was NOT found in DNS cache
*   Trying 127.0.0.1...
* Connected to localhost (127.0.0.1) port 8082 (#0)
* Server auth using Basic with user 'admin'
> POST /geoserver/rest/workspaces HTTP/1.1
> Authorization: Basic YWRtaW46Z2Vvc2VydmVy
> User-Agent: curl/7.35.0
> Host: localhost:8082
> Accept: */*
> Content-type: text/xml
> Content-Length: 69
>
* upload completely sent off: 69 out of 69 bytes
< HTTP/1.1 201 Created
< Date: Tue, 24 Feb 2015 10:03:56 GMT
< Location: {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis
* Server Noelios-Restlet-Engine/1.0..8 is not blacklisted
< Server: Noelios-Restlet-Engine/1.0..8
< Transfer-Encoding: chunked
<
* Connection #0 to host localhost left intact
</code></pre>

An dieser Stelle sind zwei Informationen für uns entscheidend:  
1. `HTTP/1.1 201 Created`: Der Aufruf wurde erfolgreich bearbeitet und die
   Ressource erstellt.
2. `{{ book.geoServerBaseUrl }}/rest/workspaces/fossgis`: Die (eindeutige) URL
   unseres neuen Arbeitsbereichs.

Wir können nun überprüfen, ob der Arbeitsbereich tatsächlich angelegt wurde, indem wir

- *klassisch* die [GeoServer GUI]({{ book.geoServerBaseUrl }}) öffnen und dort über den
  Menüeintrag `Arbeitsbereiche` alle vorhandenen Arbeitsbereiche auflisten oder
- *über die REST-API* eine Auflistung aller Arbeitsbereiche anfordern (im `XML`-Format):

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XGET \
  -H "Accept: text/xml" \
   {{ book.geoServerBaseUrl }}/rest/workspaces
</xmp></pre>

In beiden Fällen werden wir erkennen, dass ein neuer Arbeitsbereich namens
fossgis vorhanden ist.

## Datenspeicher erstellen

Nachdem wir einen neuen Arbeitsbereich erstellt haben, werden wir diesem einen neuen
Datenspeicher hinzufügen. Der folgende Befehl erzeugt (Operation `POST`!) einen
neuen PostGIS Datenspeicher (`dbtype`) mit den Namen natural\_earth und den
folgenden DB-Verbindungsparametern:

- **Hostadresse**: localhost (`host`)
- **Hostport**: 5432 (`port`)
- **Datenbankname**: natural\_earth2 (`database`)
- **Benutzer**: user (`user`)
- **Passwort**: user (`passwd`)

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XPOST \
  -H "Content-type: text/xml" \
  -d "<dataStore>
      <name>natural_earth</name>
      <connectionParameters>
        <host>localhost</host>
        <port>5432</port>
        <database>natural_earth2</database>
        <user>user</user>
        <passwd>user</passwd>
        <dbtype>postgis</dbtype>
      </connectionParameters>
      </dataStore>" \
   {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/datastores
</xmp></pre>

> **note**
>
> Die hier genutzte Datenbank *natural\_earth2* ist auf der OSGeoLive vorinstalliert
> und entstammt dem Natural Earth Projekt. Weiterführende Informationen zum Datensatz
> sowie die Daten selbst finden Sie unter [<http://www.naturalearthdata.com/>](http://www.naturalearthdata.com/).

Die erfolgreiche Anlage des Datenspeichers wird uns erneut über den Statuscode
`HTTP/1.1 201 Created` bestätigt und kann wiederum über die [GUI]({{ book.geoServerBaseUrl }})
oder das Auslesen über die API kontrolliert werden:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XGET \
  -H "Accept: text/xml" \
  {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/datastores/natural_earth.xml
</xmp></pre>

Die Antwort sollte wie folgt aussehen:

<pre><xmp style="margin:0; font-size: .85em;"><dataStore>
  <name>natural_earth</name>
  <type>PostGIS</type>
  <enabled>true</enabled>
  <workspace>
    <name>fossgis</name>
    <atom:link xmlns:atom="http://www.w3.org/2005/Atom" rel="alternate" href="{{ book.geoServerBaseUrl }}/rest/workspaces/fossgis.xml" type="application/xml"/>
  </workspace>
  <connectionParameters>
    <entry key="port">5432</entry>
    <entry key="passwd">crypt1:36+tgAgu2EC0mGyPR7MNkQ==</entry>
    <entry key="dbtype">postgis</entry>
    <entry key="host">localhost</entry>
    <entry key="user">user</entry>
    <entry key="database">natural_earth2</entry>
    <entry key="namespace">http://fossgis</entry>
  </connectionParameters>
  <\_\_default>false</\_\_default>
  <featureTypes>
    <atom:link xmlns:atom="http://www.w3.org/2005/Atom" rel="alternate" href="{{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/datastores/natural_earth/featuretypes.xml" type="application/xml"/>
  </featureTypes>
</dataStore>
</xmp></pre>

## Stil erstellen und hochladen

Nachdem Arbeitsbereich und Datenspeicher angelegt wurden, können wir im nächsten
Schritt einen neuen Stil mit dem Namen `states_provinces` im Arbeitsbereich `fossgis`
anlegen, der die Stildatei (SLD, *Styled Layer Descriptor*) `states_provinces.sld`
assoziiert. Führen Sie dazu zunächst den folgenden Befehl aus:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XPOST \
  -H "Content-type: text/xml" \
  -d "<style>
        <name>states_provinces</name>
        <filename>states_provinces.sld</filename>
      </style>" \
  {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/styles
</xmp></pre>

Erneut wird uns die erfolgreiche Anlage mit dem Status `HTTP/1.1 201 Created`
bestätigt und wir prüfen dies wiederum über die [GUI]({{ book.geoServerBaseUrl }})

Nachdem die Ressource im GeoServer publiziert wurde, können wir über REST den Stil
selbst (*states\_provinces.sld*) an die Ressource binden. Hierzu können wir die
HTTP-Operation `PUT` nutzen, um eine Datei auf den Server zu kopieren:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XPUT \
  -H "Content-type: application/vnd.ogc.sld+xml" \
  -d @states_provinces.sld \
  {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/styles/states_provinces
</xmp></pre>

**Wichtig:** Der obige Befehl setzt zwei Dinge voraus:
1. Es existiert eine SLD-Datei mit dem Namen *states\_provinces.sld* und einem
   validen SLD Inhalt. Die entsprechende Datei kann hier \<./files/states\_provinces.sld\>
   heruntergeladen werden.
2. Der Pfad zur Datei *states\_provinces.sld* ist korrekt. Im obigen Beispiel
   liegt die Datei im gleichen Ordner aus dem cURL aufgerufen wurde. Wechseln Sie
   also ggf. im Terminal zum Ordner der Datei oder passen Sie den cURL-Aufruf an.

War der Befehl erfolgreich, enthält die Antwort im Terminal den Teilstring `< HTTP/1.1 200 OK`.

## Layer anlegen

Der nächste logische Schritt ist das Anlegen eines Layers auf Basis einer Geometrietabelle
aus unserem neuen Datenspeichers natural\_earth. Als Beispiel werden wir die Tabelle
*ne\_10m\_admin\_1\_states\_provinces\_shp* mit dem folgenden Befehl im Arbeitsbereich
fossgis veröffentlichen:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XPOST \
  -H "Content-type: text/xml" \
  -d "<featureType>
        <name>states_provinces</name>
        <nativeName>ne_10m_admin_1_states_provinces_shp</nativeName>
        <nativeCRS>EPSG:4326</nativeCRS>
        <enabled>true</enabled>
      </featureType>" \
  {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/datastores/natural_earth/featuretypes
</xmp></pre>

Und erneut begrüßt uns nach erfolgreichem Hinzufügen der Ressource die Statusmeldung
`HTTP/1.1 201 Created` und selbstverständlich können wir an dieser Stelle erneut das
Ergebnis über die [GUI]({{ book.geoServerBaseUrl }}) oder die REST-API begutachten:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XGET \
  {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/datastores/natural_earth/featuretypes/states_provinces.xml
</xmp></pre>

Die XML-Repräsentation des Layers ist demnach wie folgt (gekürzt):

<pre><xmp style="margin:0; font-size: .85em;"><featureType>
  <name>states_provinces</name>
  <nativeName>ne_10m_admin_1_states_provinces_shp</nativeName>
  <namespace>
    <name>fossgis</name>
    <atom:link xmlns:atom="http://www.w3.org/2005/Atom" rel="alternate" href="@geoserver_url@/rest/namespaces/fossgis.xml" type="application/xml"/>
  </namespace>
  <title>ne_10m_admin_1_states_provinces_shp</title>
  <keywords>
    <string>ne_10m_admin_1_states_provinces_shp</string>
    <string>features</string>
  </keywords>
  <nativeCRS>
    GEOGCS["WGS 84",
       DATUM["World Geodetic System 1984",
       SPHEROID["WGS 84", 6378137.0, 298.257223563, AUTHORITY["EPSG","7030"]],
       AUTHORITY["EPSG","6326"]
     ],
     PRIMEM["Greenwich", 0.0, AUTHORITY["EPSG","8901"]],
     UNIT["degree", 0.017453292519943295],
     AXIS["Geodetic longitude", EAST],
     AXIS["Geodetic latitude", NORTH],
     AUTHORITY["EPSG","4326"]]
  </nativeCRS>
  <srs>EPSG:4326</srs>
  <nativeBoundingBox>
    <minx>-181.800003051758</minx>
    <maxx>181.800018310547</maxx>
    <miny>-60.1882858276367</miny>
    <maxy>84.3496398925781</maxy>
    <crs>EPSG:4326</crs>
  </nativeBoundingBox>
  <latLonBoundingBox>
    <minx>-181.800003051758</minx>
    <maxx>181.800018310547</maxx>
    <miny>-60.1882858276367</miny>
    <maxy>84.3496398925781</maxy>
    <crs>GEOGCS[&quot;WGS84(DD)&quot;,
   DATUM[&quot;WGS84&quot;,
     SPHEROID[&quot;WGS84&quot;, 6378137.0, 298.257223563]],
   PRIMEM[&quot;Greenwich&quot;, 0.0],
   UNIT[&quot;degree&quot;, 0.017453292519943295],
   AXIS[&quot;Geodetic longitude&quot;, EAST],
   AXIS[&quot;Geodetic latitude&quot;, NORTH]]</crs>
  </latLonBoundingBox>
  <projectionPolicy>FORCE_DECLARED</projectionPolicy>
  <enabled>true</enabled>
  <store class="dataStore">
    <name>natural_earth</name>
    <atom:link xmlns:atom="http://www.w3.org/2005/Atom" rel="alternate" href="@geoserver_url@/rest/workspaces/fossgis/datastores/natural_earth.xml" type="application/xml"/>
  </store>
  <maxFeatures>0</maxFeatures>
  <numDecimals>0</numDecimals>
  <overridingServiceSRS>false</overridingServiceSRS>
  <circularArcPresent>false</circularArcPresent>
  <attributes>
    <attribute>
      <name>adm1_code</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>

     (...)

    <attribute>
      <name>the_geom</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>com.vividsolutions.jts.geom.MultiPolygon</binding>
    </attribute>
  </attributes>
<featureType>
</xmp></pre>

Bereits zu diesem Zeitpunkt können wir den Layer über die Layervorschau des GeoServers
oder über einen beliebigen Client (z.B. QGIS) aufrufen. Öffnen Sie hierzu die
[Weboberfläche]({{ book.geoServerBaseUrl }}) vom GeoServer und rufen Sie dort die Layervorschau
(![layer\_preview\_icon](../assets/gui1.png)) auf. Öffnen Sie dort den Layer in der interaktiven
Vorschau durch einen Klick auf OpenLayers (![openlayers\_icon](../assets/gui2.png)). Die
Startansicht der Vorschau sollte dabei in etwa der folgenden Abbildung entsprechen.

![Hallo Welt!](../assets/create1.png)

## Layerstil zuordnen

Vergessen wir jedoch nicht unseren Layerstil states\_provinces aus den vorherigen
Kapiteln, den wir im Folgenden dem Layer states\_provinces zuweisen wollen:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XPUT \
  -H "Content-type: text/xml" \
  -d "<layer>
        <defaultStyle>
          <name>states_provinces</name>
          <workspace>fossgis</workspace>
        </defaultStyle>
      </layer>" \
  {{ book.geoServerBaseUrl }}/rest/layers/fossgis:states_provinces
</xmp></pre>

Bestätigt durch den Status `HTTP/1.1 200 OK` können wir die Layervorschau erneut
aufrufen und werden sehen, dass der neue Stil (hellgraue Landesflächen, dunkelgraue
Landesgrenzen und Beschriftung) dem Layer zugeordnet wurde:

![Layer states\_provinces mit zugehörigem Stil und zentriert auf Nordrhein-Westfalen](../assets/create2.png)

Herzlichen Glückwunsch! Sie haben mit nur wenigen Befehlen im Terminal einen Layer
im GeoServer angelegt!

Lernen wir nun im [nächsten Kapitel](edit.md) das Editieren von Katalogkonfigurationen.
