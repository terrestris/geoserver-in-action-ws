Katalogeinträge entfernen
=========================

Um eine Ressource über die REST-API zu entfernen, können wir die HTTP-Operation
`DELETE` nutzen. Das folgende Beispiel zeigt den (zweischrittigen) cURL Aufruf
zum Entfernen eines Layers (**Hinweis**: Durch den Befehl wird der zuvor erzeugte
    Layer *states\_provinces* aus dem Arbeitsbereich fossgis gelöscht!):

Zunächst entfernen wir den Layer:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XDELETE \
  {{ book.geoServerBaseUrl }}/rest/layers/fossgis:states_provinces
</xmp></pre>

Und anschließend den FeatureType des Datenspeichers:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XDELETE \
  {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/datastores/natural_earth/featuretypes/states_provinces
</xmp></pre>

In dem obigen Beispiel wird der FeatureType states\_provinces durch den gleichnamigen
Layer referenziert, wodurch die zweischrittige Lösung notwendig ist. Das alleinige
Ausführen des zweiten Befehls würde in diesem Fall die Fehlermeldung *feature type
referenced by layer(s)* provozieren. Um automatisch alle referenzierten Objekte
(z.B. auch Gruppenlayer) zu entfernen, sollte der Parameter recurse=true gesetzt werden:

<pre><xmp style="margin:0; font-size: .85em;">curl \
  -v \
  -u admin:geoserver \
  -XDELETE \
  {{ book.geoServerBaseUrl }}/rest/workspaces/fossgis/datastores/natural_earth/featuretypes/states_provinces?recurse=true
</xmp></pre>

Wurden die Ressourcen erfolgreich entfernt, wird der Status `HTTP/1.1 200 OK` ausgegeben.

> **note**
>
> Möchten Sie sich - auf Grundlage der Beispiele dieses Workshops oder Ihrer eigenen Daten - weiter mit der REST-API beschäftigen, finden Sie in der offiziellen Dokumentation viele Hinweise und gute Beispiele:
>
> [<http://docs.geoserver.org/stable/en/user/rest/>](http://docs.geoserver.org/stable/en/user/rest/)

Sie haben das Modul REST-Schnittstelle erfolgreich beendet, Sie können
nun mit [Modul Tipps, Tricks & Troubleshooting](../troubleshooting/README.md) fortfahren.
