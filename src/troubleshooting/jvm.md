Java Virtual Machine (JVM) tunen
================================

Der GeoServer läuft, wie bereits in Kapitel [Basiswissen GeoServer](../basics/README.md)
beschrieben, innerhalb eines JAVA Servlet Containers wie z.B. *Apache Tomcat*
oder *Jetty*. Ein JAVA Container kann dabei mit gezielten Startup-Parametern
gestartet werden, die das Laufzeitverhalten der in ihm deployten Servlets massiv
beeinflussen können. Die folgende Tabelle führt einige Parameter auf, die in
produktiven GeoServer Instanzen bedacht werden sollten. Die Inhalte stellen
dabei keinen Anspruch an Vollständigkeit und bedürfen einer kritischen Überprüfung
für jede Installation (u.a. in Abhängigkeit der verfügbaren Hardwareressourcen,
erwartbaren Zugriffszahlen, Einsatzzweck des GeoServers). Im Tomcat werden
die Parameter an die JAVA\_OPTS (global) oder CATALINA\_OPTS (Container) übergeben.

Es wird grundsätzlich empfohlen das **Oracle (Sun) JDK statt OpenJDK** zu verwenden,
da ersteres die Performance des GeoServers erhöht. Details dazu gibt es
z.B. [hier](http://boundlessgeo.com/whitepaper/geoserver-production-2/#jdk).

Der Workshop ist an dieser Stelle beendet. Wir hoffen, dass Sie interessante
Dinge über den GeoServer gelernt haben und bedanken uns für Ihre Aufmerksamkeit.
