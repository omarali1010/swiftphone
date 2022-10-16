## Ein Bild ändern

  Der Satz, der gezeichnet werden soll, kann mittels dieser Anfrage gesendet bzw. geändert werden. Der Spieler muss zudem sein Status, also ob dieser Bereit ist mit gesendet werden. Möchte der Spieler nur sein Status ändern muss er trotzdem sein Aktuelles Bild mit senden.

## URL

  _/game/image/_

## Method:
  
  `PATCH`
  
## Data Params

  `key` und `user` zu Zuordnung. `image` als png Base64 String. `ready` der Status des Spielers.
  ```json
  {
    "key": "<String>",
    "user": {
      "name": "<String>",
      "id": "<String>"
    },
    "image": "<String>",
    "ready": <Bool>
  }
  ```

## Success Response:
  
  * **Code:** 200 <br />
 
## Error Response:

  * **Code:** 400 Bad Request<br />
    **Note:** Ungültige Parameter

  * **Code:** 404 Not Found<br />
    **Note:** Konnte keine Lobby finden.

