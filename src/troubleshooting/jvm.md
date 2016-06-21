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
die Parameter an die JAVA_OPTS (global) oder CATALINA_OPTS (Container) übergeben.

Es wird grundsätzlich empfohlen das **Oracle (Sun) JDK statt OpenJDK** zu verwenden,
da ersteres die Performance des GeoServers erhöht. Details dazu gibt es
z.B. [hier](http://boundlessgeo.com/whitepaper/geoserver-production-2/#jdk).

| Parameter | Beschreibung | Beispiel |
| --------- | ------------ | -------- |
| -server | Für Server optimierte JVM. |  |
| -Xms | Steuert die Anfangsgröße des Java-Heap-Speichers. Für Produktivsysteme werden Werte im Bereich von 2 bis 4 GB empfohlen. | -Xms2g |
| -Xmx | Steuert die maximale Größe des Java-Heap-Speichers. d.h. dieser Wert darf nicht kleiner sein als :file:`-Xms`. Es gibt unterschiedliche Meinungen darüber, ob für :file:`-Xms` und :file:`-Xmx` dieselben Werte, d.h. :file:`Xms=Xmx` verwendet werden sollen oder nicht. Wir verwenden auf unseren Systemen :file:`Xms=Xmx` und haben damit keine schlechten Erfahrungen gemacht! | -Xmx2g |
| -XX:PermSize | Definiert die anfänliche Größe des Speichers, der für die permanente Objektgenerierung reserviert ist. | -XX:PermSize=256m |
| -XX:MaxPermSize | Definiert die maximale Größe des Speichers, der für die permanente Objektgenerierung reserviert ist. Ein Wert von maximal 256 MB ist hier absolut ausreichend. | -XX:MaxPermSize=256m |
| -Djavax.servlet.request.encoding | Zeichenkodierung eingehender Anfragen (Standard: ISO 8559-1) | -Djavax.servlet.request.encoding=UTF-8 |
| -Djavax.servlet.response.encoding | Zeichenkodierung ausgehender Antworten (Standard: ISO 8559-1) | -Djavax.servlet.response.encoding=UTF-8 |
| -Dfile.encoding | Zeichenkodierung beim Umgang mit statischen Dateien (Standard: Default des Betriebssystems, daher ggf. wichtig bei Windows-Systemen) | -Dfile.encoding=UTF-8 |
| -XX:+UseParallelGC | Garbage Collection für Mehrkern-Systeme (siehe [hier](http://boundlessgeo.com/whitepaper/geoserver-production-2/#jvm)) |  |
| -XX:+UseParallelOldGC |  s.o. |  |

Der Workshop ist an dieser Stelle beendet. Wir hoffen, dass Sie interessante
Dinge über den GeoServer gelernt haben und bedanken uns für Ihre Aufmerksamkeit.
