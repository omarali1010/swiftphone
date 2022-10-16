## Verbinden einer Lobby

  Ein neuer Spieler verbindet sich mit einer Lobby. Der Spieler ist erst vollständig verbunden, sobalt dieser sich mit dem WebSocket erfolgreich verbunden hat.

## URL

  _/lobby/join_

## Method:
  
  `POST`

## Data Params

  Der `Name` ist der Spielername des zu verbindenen Spielers. Der `key` ist der Lobby Schlüssel.


  ```json
  {
    "name": "<String>",
    "key": "<String>"
  }
  ```

## Success Response:
  
  Der Spieler erhält seine `id`, mit dieser findet weitere Interaktion mit dem Backend statt. Zum Festlegen der Spielzeit erhält der Spieler die Spieleinstellungen, `writetime` und `drawtime` dies wird in Sekunden angegeben.
  
  * **Code:** 200 <br />
    **Content:** 
    ```json
    {
      "user": {
        "name": "<String>",
        "id": "<String>"
      },
      "gameSettings": {
        "writetime": <Float>,
        "drawtime": <Float>
      }
    }
    ```
 
## Error Response:

   * **Code:** 400 Bad Request<br />
    **Note:** Der Body ist möglicherweise `nil`

   * **Code:** 404 Not Found<br />
    **Note:** Die angegebene Lobby existiert nicht.

   * **Code:** 403 Forbidden<br />
    **Note:** Die Lobby hat die maximal Spieleranzahl von 8 erreicht.

  * **Code:** 500 Internal Server Error<br />
    **Note:** Die Ergebnis konnte nicht erstellt werden.
