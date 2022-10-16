## Erhalte das Ergebnis

  Am Ende der Runde kann die Auflösung abgefragt werden.

## URL

  _/game/solution/:key/_

## Method:
  
  `GET`
  
## URL Params

   `key` der Lobbyschlüssel

   **Required:**
 
   `key=[String]`

## Success Response:
  
  Die Auflösung einer Runde bildet sich folgendermaßen:

  `sentence[0]`, `image[0]`, `sentence[1]`, `image[1]`, ..., `image[n]`

  * **Code:** 200 <br />
    **Content:** 
    ```json
    [
      {
        "sentence": [
          {
            "name": "<String>",
            "sentence": "<String>"
          },
          ...
        ],
        "image": [
          {
            "name": "<String>",
            "image": "<String>"
          },
          ...
        ]
      },
      ...
    ]
    ```
 
## Error Response:

  * **Code:** 400 Bad Request<br />
    **Note:** Ungültige Parameter

  * **Code:** 404 Not Found<br />
    **Note:** Konnte keine Lobby finden.

  * **Code:** 500 Internal Server Error<br />
    **Note:** Das Ergebnis konnte nicht erstellt werden.

