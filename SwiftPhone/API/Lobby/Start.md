## Start eines Spiels

  Zum Starten des Spiels, kann der Ersteller der Lobby, mittels dieser Anfrage, das Spiel beginnen.

## URL

  _/lobby/start_

## Method:
  
  `PATCH`
  
## Data Params

  Zum Starten des Spiels wird die `id` des Erstellers und der `key` der Lobby benötigt.
  ```json
  {
    "id": "<String>",
    "key": "<String>",
  }
  ```

## Success Response:
  
  * **Code:** 200 <br />
    **Note:** Spiel beginnt.
 
## Error Response:

 * **Code:** 400 Bad Request<br />
   **Note:** Der Body ist `nil`
