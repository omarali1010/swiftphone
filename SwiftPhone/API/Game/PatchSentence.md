## Einen Satz bearbeiten

  Bild was beschrieben werden soll. Die Beschreibung kann mittels dieser Anfrage gesendet bzw. geändert werden. Der Spieler muss zudem sein Status, also ob dieser Bereit ist mit gesendet werden. Möchte der Spieler nur sein Status ändern muss er trotzdem sein Aktuelles Bild mit senden.

## URL

  _/game/sentence_

## Method:
  
  `PATCH`
  
## Data Params

  <_If making a post request, what should the body payload look like? URL Params rules apply here too._>
  ```json
  {
    "key": "<String>",
    "user": {
      "name": "<String>",
      "id": "<String>"
    },
    "sentemce": "<String>",
    "ready": <Bool>
  }
  ```

## Success Response:

  * **Code:** 200 <br />
    **Content:**
 
## Error Response:

  * **Code:** 400 Bad Request<br />
    **Note:** Request Body enthält ein ungültiges Format.

  * **Code:** 404 Not Found<br />
    **Note:** Konnte die Lobby nicht finden.
