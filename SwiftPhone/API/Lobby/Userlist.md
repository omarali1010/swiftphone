## Benutzerliste einer Lobby

Mittels dieser Anfrage können die tatsächlichen verbundenen Spieler abgefragt werden.

## URL

  _/lobby/userlist/:key_

## Method:
  
  `GET`
  
## URL Params

   `key` ist der Lobbyschlüssel.

   **Required:**
 
   `key=[String]`


## Success Response:

  Die Liste `users` enthält die vollständigen verbundenen Spieler.

  * **Code:** 200 <br />
    **Content:** 
    ```json
    { "users" : [<String>] }
    ```
 
## Error Response:

 * **Code:** 400 Bad Request<br />
    **Note:** Der Body ist `nil`

  * **Code:** 404 Not Found<br />
    **Note:** Die angegebene Lobby existiert nicht.

  * **Code:** 500 Internal Server Error<br />
    **Note:** Die Ergebnis konnte nicht erstellt werden.

