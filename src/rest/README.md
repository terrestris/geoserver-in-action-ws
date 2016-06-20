REST-Schnittstelle
==================

Die REST-API erlaubt das Lesen, Schreiben, Aktualisieren und Entfernen von (fast)
allen GeoServer Katalogelementen direkt über das HTTP-Protokoll, d.h. ohne die
Verwendung der graphsichen GeoServer Benutzeroberläche. Hierzu zählen z.B.
Arbeitsbereiche, Datenspeicher, Layer, Stile und Gruppenlayer. In diesem Modul
werden die Grundprinzipien der REST-API vom GeoServer anhand von einfachen
Beispielen erläutert. Bei der Auswahl der folgenden Beispiele wurde auf eine hohe
Praxistauglichkeit und Wiederverwendbarkeit geachtet.

Doch zunächst: Was ist REST?

REST (oder auch ReST) steht Representational State Transfer und ist ein Architekturstil
zur Realisierung von Web Services und wir daher auch häufig im Zusammenhang mit
dem Begriffspaar *RESTful Webservices* genannt. Kernelement des Architekturstils
sind die sog. Ressourcen. Eine Ressource sollte dabei die folgenden Anforderungen
erfüllen (nach [1]):

- **Adressierbarkeit:** Jede Ressource (z.B. ein GeoServer Layer) muss über
  eine eindeutige URI (Unique Resource Identifier) erreichbar sein.
- **Zustandslosigkeit:** Jede Kommunikation über REST enthält alle Informationen,
  die für Server oder Client zum Verständnis notwendig sind, Zustandsinformationen
  (z.B. Sessions) werden nicht von Server oder Client gespeichert. Hieraus ergibt
  sich eine einfache Umsetzung der Skalierbarkeit von Webservices (z.B. für die
  Lastverteilung).
- **Einheitliche Schnittstelle:** Der Zugriff auf jede Ressource muss über
  standardisierte Methoden erlangt werden können. Übersetzt auf das HTTP-Protokoll
  sollten Operationen auf Ressourcen über die Standard-HTTP Methoden (siehe Tabelle)
  implementiert werden.
- **Entkopplung von Ressourcen und Repräsentation:** Jede Ressource kann in
  unterschiedlichen Darstellungsformen/Repräsentationen (z.B. im HTML-, JSON-
  und XML-Format) existieren.

| Operation | Beschreibung |
| --------- | ----------- |
| GET | fordert die angegebene Ressource vom Server an. GET weist keine Nebeneffekte auf. Der Zustand am Server wird nicht verändert, weshalb GET als sicher bezeichnet wird. |
| POST | fügt eine neue (Sub-)Ressource unterhalb der angegebenen Ressource ein. Da die neue Ressource noch keinen URI besitzt, adressiert der URI die übergeordnete Ressource. Als Ergebnis wird der neue Ressourcenlink dem Client zurückgegeben. POST kann im weiteren Sinne auch dazu verwendet werden, Operationen abzubilden, die von keiner anderen Methode abgedeckt werden. |
| PUT | die angegebene Ressource wird angelegt. Wenn die Ressource bereits existiert, wird sie geändert. |
| PATCH | ein Teil der angegebenen Ressource wird geändert. Hierbei sind Nebeneffekte erlaubt. |
| DELETE | löscht die angegebene Ressource. |
| HEAD | fordert Metadaten zu einer Ressource an. |
| OPTIONS | prüft, welche Methoden auf einer Ressource zur Verfügung stehen. |
| CONNECT | Dient dazu, die Anfrage durch einen TCP-Tunnel zu leiten. Wird meist eingesetzt, um eine HTTPS-Verbindung über einen HTTP-Proxy herzustellen. |
| TRACE | 	Gibt die Anfrage zurück, wie sie der Zielserver erhält. Dient etwa dazu, um Änderungen der Anfrage durch Proxyserver zu ermitteln. |

Üblicherweise wird zur Realisierung von REST-Diensten das HTTP-Protokoll genutzt,
deren Operationen in der o.g. Tabelle aufgezeigt sind. Jede Anfrage an einen
REST-Dienst über eine dieser Operationen wird neben der REST-Nachricht (sofern vorhanden)
einen Statuscode an den Client senden. Die folgendene Tabelle enthält eine
Übersicht der zu erwartenden Statuscodes und der damit verbundenen Fehlerquellen:

| Statuscode | Statustext | Beschreibung |
| ----------- | ----------- | ----------- |
| 200 | OK | Request war erfolgreich |
| 201 | Created | Eine neue Ressource (z.B. ein Layer) wurde erfolgreich erstellt |
| 403 | Forbidden | Keine Berechtigung vorhanden  |
| 404 | Not Found | Ressource oder Endpoint nicht gefunden |
| 405 | Method Not Allowed | Falsche Operation für Ressource oder Endpoint (z.B. Request mit GET, aber nur PUT/POST erlaubt) |
| 500 | Internal Server Error | Fehler beim Ausführen (z.B. Syntaxerror im Request oder Fehler beim Verarbeiten) |

Im vorliegenden Modul werden wir nun an Beispielen die GeoServer-REST API nutzen,
um die bestehende Ressouren auszulesen, einen neuen Layer anzulegen, einen
bestehenden Layer zu editieren und abschließend einen bestehenden Layer zu entfernen:

**Footnotes**

[1] Fielding, R.T. (2000): Architectural Styles and the Design of Network-based Software Architectures. Abrufbar unter: <http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm>
