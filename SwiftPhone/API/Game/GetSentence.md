## Einen Satz erhalten**

  Erhalte den Initialisierung Satz oder den Satz des beschriebenen Bildes.

## URL

  _/game/sentence/:key/:id_

## Method:
  
  `GET`
  
## URL Params

   `id` des Spielers und `key` zu der Spiellobby.

   **Required:**
 
   `key=[String]`

   `id=[String]`


## Success Response:
  
  `sentence` ist der Initialisierung Satz oder den Satz des beschriebenen Bildes.

  * **Code:** 200 <br />
    **Content:** 
    ```json
    {
      "sentence": "<String>",
    }
    ```
 
## Error Response:

  * **Code:** 400 Bad Request<br />
    **Note:** Ungültige Parameter

  * **Code:** 404 Not Found<br />
    **Note:** Konnte keine Resourcen anhand der Parameter finden.

  * **Code:** 500 Internal Server Error<br />
    **Note:** Das Ergebnis konnte nicht erstellt werden.

