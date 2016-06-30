# Basiswissen GeoServer

Der [GeoServer](http://geoserver.org/) ist ein offener, Java-basierter Server,
der es ermöglicht Geodaten auf Basis der Standards des [Open Geospatial Consortium (OGC)](http://www.opengeospatial.org/)
(insb. WMS und WFS) anzuzeigen und zu editieren. Eine besondere Stärke des GeoServers
ist die Flexibilität, mit der er sich um zusätzliche Funktionalität erweitern lässt.

GeoServer ist gut dokumentiert. Die Dokumentation unterteilt sich dabei
in eine Benutzer- und eine Entwicklerdokumentation:

* Benutzerdokumentation: <http://docs.geoserver.org/stable/user/>
* Entwicklerdokumentation: <http://docs.geoserver.org/stable/developer/>

Die beiden Links verweisen auf die Dokumentationen der letzten stabilen Version.
Das *stable* in der URL kann auch durch eine Versionsnummer ersetzt werden, falls
man die Dokumentation einer bestimmten GeoServer-Version aufrufen möchte. Im Rahmen
dieses Workshops wird die **Version {{ book.geoServerVersion }}**, die resultierende
URL der Benutzerdokumentation würde also <http://docs.geoserver.org/{{ book.geoServerVersion }}/user/>
lauten.

![GeoServer-Weboberfläche nach erfolgreichem Login](../assets/geoserver_login_gui.png)

Üblicherweise wird der GeoServer für einen Produktivbetrieb als (Java-)Standalone-Servlet
in Form einer `.war` - Datei bereitgestellt, welche unter <http://geoserver.org/download/>
heruntergeladen werden kann. Die `.war` - Datei muss anschließend auf einem
Servlet-Container (bspw. [Tomcat](http://tomcat.apache.org/) oder
[Jetty](http://eclipse.org/jetty/)) veröffentlicht werden (häufig auch *deploy* genannt). Anschließend
kann die Weboberfläche des GeoServers über den Browser aufgerufen werden.

Weitere Details zur klassischen WAR-Installation finden sich
[hier](http://docs.geoserver.org/stable/en/user/installation/war.html).

> **note**
>
> Der GeoServer ist auf dem OSGeoLive-System bereits vorinstalliert und kann im
> Rahmen des Workshops unter {{ book.geoServerBaseUrl }} aufgerufen werden
> (siehe [hier](../environment/README.md). Diese Variante unterscheidet sich von
> dem klassischen *Deployment* als .war-Datei, da hier ein Java-Programm
> (start.jar) ausgeführt wird, welches programmatisch einen Jetty-Server mit dem
> Geoserver startet. Für die Inhalte des Workshops ist dies aber nicht von Bedeutung.

Im Folgenden werden wir uns zunächst einen Überblick über die GeoServer-Ordnerstruktur
verschaffen. Anschließend wird erläutert wie sich GeoServer-Erweiterungen
installieren lassen. Zum Abschluss dieses Modules wird erklärt wie sich der
Quellcode des GeoServers (bzw. einzelner Erweiterungen) mit dem
*Build-Management-Tool* Maven kompilieren lässt.
