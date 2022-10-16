## Verbinden mit dem WebSocket

Der Spieler ist erst vollständig verbunden, sobalt dieser sich mit dem WebSocket erfolgreich verbunden hat.

## URL

  _/game/_

## Method:
  
  `GET`
  
## URL Headers

  Um erfolgreich sich mit dem WebSocket zu verbinden wird eine gültige Spieler `id` und Lobby `key` benötigt.

### Required:

  `id` des Spielers und `key` zu der Spiellobby.
 
  * `id=[String]`

  * `key=[String]`

## Events:
  
  Folgende Events sind möglich

  - `eventLobbylist` - Ein neuer Spieler ist der Lobby beigetreten oder ein Spieler hat die Lobby verlassen

  - `eventLobby` - Erhält der Spieler nach dem erfolgreichen Verbinden.

  - `eventInitSentence` - Die Spieler können ihren Initialisierten Satz abholen.

  - `eventImage` - Die Spieler können einen Satz abholen, welches sie zeichnen.

  - `eventDescriptionSentence` - Die Spieler können ein Bild abholen, welches sie beschreiben.

  - `eventSolution` - Das Spiel ist zu Ende, Abfrage der Auflösung möglich.

 

## **Notes:**

  Bei trennen der Verbindung wird der Spieler nicht mehr betrachtet