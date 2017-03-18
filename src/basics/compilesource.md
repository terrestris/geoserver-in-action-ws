# Kompilieren auf Basis des Quellcodes

> **caution**
>
> Die Inhalte aus diesem Abschnitt werden nur dann funktionieren, wenn Sie zuvor das Skript aus dem Abschnitt
>  [Vorarbeiten und generelle Informationen](../environment/README.md)
> erfolgreich ausgeführt haben!

In diesem Abschnitt wird gezeigt wie sich der Quellcode des GeoServers bzw.
einzelner Module mit dem *Build-Management-Tool* [Maven](http://maven.apache.org/)
kompilieren lässt. Maven wird von der GeoServer-Community für die Erstellung und
Verwaltung der Software eingesetzt. Anschließend könnten Sie z.B. den Original-Code
für spezielle Anwendungsfälle anpassen (oder erweitern) und eine derart
modifizierte GeoServer-Version einsetzen.

> **note**
>
> Maven ist eine auf Java basierende OpenSource-Software zur standardisierten
> Erstellung und Verwaltung von (Java-)Programmen. Ausgehend von einer Validierung
> der Quelldateien, über das Kompilieren, Testen, Verpacken bis hin zum Installieren
> der Software bietet Maven Unterstützung für den gesamten Lebenszyklus einer
> Software. Leider können wir an dieser Stelle nicht näher auf Maven eingehen,
> da dies den Rahmen des Workshops sprengen würde. Einen Einstieg in die Maven-Welt
> finden Sie z.B. unter [<http://maven.apache.org/guides/>](http://maven.apache.org/guides/).

Bevor wir konkrete Maven-Befehle aufrufen, um sogenannte *Maven-Artefakte* zu
erzeugen (welche in unserem Falle Java-Kompilaten, also .jar-Dateien, entsprechen)
wollen wir zunächst aufzeigen wie Sie grundsätzlich mit dem GeoServer-Quellcode
und Maven arbeiten können.

Anschließend werden wir exemplarisch den Quellcode der [INSPIRE](http://inspire.ec.europa.eu/)-Erweiterung
des GeoServers mit Maven kompilieren und auf dem GeoServer installieren.

## GeoServer-Quellcode und Maven

Der GeoServer-Quellcode wird mit [git](http://git-scm.com/) verwaltet. *Git* ist
eine freie Software zur verteilten Versionsverwaltung von Dateien, mit dem z.B.
auch der Linux-Kernel verwaltet wird. Den Quellcode des GeoServers finden Sie hier:

[https://github.com/geoserver/geoserver](https://github.com/geoserver/geoserver)

Wenn Sie sich dort in den Ordner `src/extension/inspire` durchklicken, können Sie
feststellen, dass es in jedem dieser drei Ordner eine Datei `pom.xml` gibt. *POM*
steht für Project Object Model und es handelt sich hier um die Konfigurationsdateien
für Maven (`pom.xml`), in denen z.B. Abhängigkeiten zu anderen Bibliotheken definiert sind.

Jede `pom.xml` im Ordner `src/` ist die zentrale Maven-Konfigurationsdatei auf höchster Ebene, also
des GeoServers als Gesamtsystem und repräsentiert dabei ein eingenständiges Maven-Modul.
Die `pom.xml` im Ordner `src/extension/` definiert ein Maven-Submodul *extension*,
die `pom.xml` in `src/extension/inspire/` ist wiederum
ein Submodul von *extension*.

Wenn Sie auf dem Terminal unterwegs sind und in ein Verzeichnis navigieren, dass
eine `pom.xml` enthält, können Sie dort Maven-Befehle ausführen. Der Befehl
`mvn package` würde z.B. das entsprechende Artefakt bauen und in einen Unterordner
`target/` ablegen.

Nähere Details zur Verwendung von Maven beim Kompilieren von GeoServer finden Sie unter [<http://docs.geoserver.org/latest/en/developer/maven-guide/index.html>](http://docs.geoserver.org/latest/en/developer/maven-guide/index.html).

## Kompilieren der INSPIRE-Erweiterung

Wir werden nun die INSPIRE-Erweiterung des GeoServers auf Basis des Quellcodes
selber kompilieren. Anschließend kann die Erweiterung analog zum [vorigen Abschnitt](./installextensions.md)
im GeoServer installiert werden.

> **note**
>
> Das Herunterladen des (gesamten) GeoServer-Quellcodes und insbesondere das
> (erstmalige) Ausführen bestimmter Maven-Befehle kann u.U. sehr lange dauern.
> Im Falle von Maven ist dies darauf zurückzuführen, dass Maven zunächst alle
> benötigten Abhängigkeiten auflöst und diese anschließend aus öffentlich verfügbaren
> Maven-*Repositories* in ein lokales Maven-*Repository* auf ihrem Rechner
> herunterlädt bzw. installiert. Um diesen Prozess zu beschleunigen hat das
> Script, welches Sie zu Beginn des Workshops ausgeführt haben, bereits
> vorbereitende Maßnahmen getroffen.

Zu Beginn des Workshops haben Sie ein Skript ausgeführt, welches gewisse
Vorbereitungen getroffen hat, damit die Paketierung der INSPIRE-Erweiterung bei
der erstmaligen Ausführung der Maven-Befehle nur wenige Sekunden statt vieler
Minuten dauert.

Sie sollten in Ihrem Home-Verzeichnis `/home/user` ein Verzeichnis `src/` vorfinden,
in welchem sich **ausschließlich** der Quellcode der INSPIRE-Erweiterung (in
Version {{ book.geoServerVersion }}) befindet. Das Skript hat darüberhinaus alle
(im nächsten Schritt) benötigten Abhängigkeiten in ihr lokales Maven-Repository
`~/.m2` vorinstalliert, welche Maven ansonsten selbst installieren (und was
entsprechend länger dauern) würde.

Wechseln Sie nun in das Verzeichnis mit der pom.xml und dem Quellcode der
INSPIRE-Erweiterung:

```bash
cd ~/src/extension/inspire/
```

Wir können nun den Maven-Befehl ausführen, mit dem sich die INSPIRE-Erweiterung
(auf Basis des aktuellen Quellcodes) paketieren lässt:

```bash
mvn package
```

Sie können die Paketierung auch beschleunigen, indem Sie auf das Ausführen von
Tests verzichten:

```bash
mvn package -DskipTests
```

Ebenso könnten Sie nur die Tests ausführen:

```bash
mvn test
```

Es ist auch möglich auf der Ebene des *extension*-Moduls die INSPIRE-Erweiterung
zu *bauen*. Hierzu muss zunächst in das *extension*-Verzeichnis gewechselt werden,
um dort den mvn package-Befehl unter Verwendung eines bestimmten Profils zu
verwenden:

```bash
cd ~/src/extension/
```

```bash
mvn package -P inspire -DskipTests
```

Wenn einer der mvn package-Befehle erfolgreich durchgelaufen ist, finden Sie im
Verzeichnis `~/src/extension/inspire/target/` das erzeugte Kompilat (gs-inspire-{{ book.geoServerVersion }}.jar),
welches wie im vorigen [Abschnitt](./installextensions.md) auf dem GeoServer
installiert werden kann.

<pre>
<xmp style="margin:0; font-size: .85em;">
sudo cp \
  ~/src/extension/inspire/target/gs-inspire-{{ book.geoServerVersion }}.jar \
  /usr/local/lib/geoserver-{{ book.geoServerVersion }}/webapps/geoserver/WEB-INF/lib
</xmp>
</pre>

Sobald dies geschehen ist (GeoServer-Neustart nicht vergessen!), erscheint bei
der WMS-Konfiguration in der GeoServer-Weboberfläche ein zusätzlicher Bereich
*INSPIRE* (unten).

![GeoServer-Weboberfläche (Bereich *WMS*) nach der INSPIRE-Installation](../assets/inspire_success.png)

Im folgenden [Abschnitt](../rest/README.md) werden werden Sie die GeoServer-REST
Schnittstelle kennenlernen, mit der sich viele Dinge, die Sie über die Weboberfläche
konfigurieren können, auf programmatischem Wege ausführen können.
