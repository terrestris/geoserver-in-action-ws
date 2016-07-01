# Ordnerstruktur des GeoServers

Im Folgenden wird die Ordnerstruktur des GeoServers erläutert. Ausgangspunkt
ist das GeoServer-Verzeichnis:

<pre><xmp style="margin:0; font-size: .85em;">{{ book.geoServerPhysicalPath }}
</xmp></pre>

Dabei sind die folgenden Unterordner von besonderer Bedeutung:


|Verzeichnis|Bedeutung|
|-----------|---------|
|bin/|Enthält Skripte zum Starten und Stoppen des GeoServers (Jetty-Variante/OSGeoLive).|
|data\_dir/|Konfiguration der GeoServer-Daten (z.B. *Arbeitsbereiche, Datenquellen, Layer oder Stile*).|
|data\_dir/logs/|Enthält die Log-Dateien des GeoServers. Auf das Logging wird zum Ende des Workshops auch [hier](../troubleshooting/logging.md) eingegangen.|
|webapps/geoserver/WEB-INF/lib/|Enthält .jar-Dateien, d.h. Java-Kompilate, die beim Starten des Servers in den *ClassPath* geladen werden. Dabei handelt es sich einerseits um Abhängigkeiten (*Dependencies*) des GeoServers zu anderen (OpenSource-)Bibliotheken, die benötigt werden, damit der GeoServer lauffähig ist, z.B. das [Spring Framework](http://spring.io/). Andererseits werden Erweiterungen (ebenfalls in Form von .jar-Dateien) in diesen Ordner installiert.|

> **note**
>
> Die hier erläuterte Struktur bezieht sich auf die Jetty-Umgebung im OSGeoLive-System.
> In anderen Umgebungen (z.B. auf einem Tomcat mit klassischer .war-Datei-Installation)
> kann die Struktur abweichen.

----

> **info**
> Für Produktivsysteme wird (durch Konfiguration des GeoServers) grundsätzlich empfohlen
> ein *DATA\_DIR* außerhalb der Webapplikation zu verwenden, da sich der GeoServer auf diese Weise
> zu neueren Versionen updaten lässt ohne dass die Konfigurationsdaten verloren gehen.
> Details gibt es [hier](http://docs.geoserver.org/latest/en/user/datadirectory/index.html).

Im [folgenden Abschnitt](installextensions.md) wird erklärt wie sich die
Funktionalität des GeoServers durch das Einbinden zusätzlicher Module erweitern lässt.
