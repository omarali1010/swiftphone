## Erstelle eine Lobby

  Erstellt eine Lobby, diese bleibt bestehen, solange die nicht gestartet wird. Der Spieler ist erst vollständig verbunden, sobalt dieser sich mit dem WebSocket erfolgreich verbunden hat.

## URL

  _/lobby/create_

## Method:
  
  `POST`
  
## Data Params

  `Name` ist der Spielername des Spielers. Zum Festlegen der Spielzeit wird `writetime` und `drawtime` eine Zeit in Sekunden Angegeben.

  ```json
  {
    "name": "<String>",
    "gameSettings": {
      "writetime": <Float>,
      "drawtime": <Float>
    }
  }
  ```

  ## Success Response:
  
  Die `id` wird zur weiteren Interaktion mit dem Backend benötigt. Der `key` wird verwendet, dass andere Spieler der Lobby beitreten können.

  * **Code:** 200 <br />
    **Content:** 
    ```json
    {
      "user": {
        "name": "<String>",
        "id": "<String>"
      },
      "key": "<String>"
    }
    ```
 
## Error Response:

  * **Code:** 400 Bad Request <br />
    **Note:** Der Body ist möglicherweise `nil`

  * **Code:** 500 Internal Server Error <br />
    **Note:** Die Ergebnis konnte nicht erstellt werden

