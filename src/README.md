![](assets/geoserver-logo.png)

# GeoServer in action

Herzlich Willkommen beim **GeoServer in action** Workshop auf der FOSSGIS 2016
in Salzburg.

Dieser Workshop wurde für die Verwendung auf der [OSGeo-Live {{ book.osGeoLiveVersion }} DVD](https://live.osgeo.org) entwickelt und soll Ihnen einen umfassenden Überblick über den GeoServer als
Web-Mapping-Lösung geben.

Bitte stellen Sie sicher, dass Sie die Schritte der
[Vorarbeiten und generelle Informationen](environment/README.md)-Seite ausgeführt
haben, um einen reibungslosen Ablauf zu gewährleisten.

Der Workshop ist aus einer Reihe von Modulen zusammengestellt. In jedem Modul werden Sie eine Reihe von Aufgaben lösen, um ein bestimmtes Ziel zu erreichen. Jedes Modul baut Ihre Wissensbasis iterativ auf.

Die folgenden Module werden in diesem Workshop behandelt:

* [Vorarbeiten und generelle Informationen](environment/README.md)
Grundlegende Informationen zur Workshop-Umgebung (OSGeoLive, Pfade, URLs, Credentials) und notwendige Installationen (maven)

* [Basiswissen GeoServer](basics/README.md)
Basiswissen Geoserver, Kompilieren auf Basis des Source-Codes mit maven, Installation von Plugins

* [REST-Schnittstelle](rest/README.md)
Einrichtung von Workspaces, Stores, Styles und Layern über die REST-Schnittstelle

* [Tipps, Tricks & Troubleshooting](troubleshooting/README.md)
Performance-Optimierung, Protokollierung, Debugging und hilfreiche Tipps

# Autoren

{% for author in book.authors %}
  - {{ author.name }} ([{{ author.mail }}](mailto:{{ author.mail }}))
{% endfor %}

###### (Die Autoren sind alphabetisch nach ihrem Nachnamen sortiert.)
