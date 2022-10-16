## Ein Bild erhalten

  Erhalte ein Bild welches beschrieben werden muss.  

## URL

  _/game/image/:key/:id_

## Method:
  
  `GET`
  
##  URL Params

  `id` des Spielers und `key` zu der Spiellobby.

   **Required:**
 
   `key=[String]`

   `id=[String]`


## Success Response:
  
  `image` ist ein png im Base64 Format.

  * **Code:** 200 <br />
    **Content:**
    ```json
    {
      "image": "<String>"
    }
    ```
 
## Error Response:

   * **Code:** 400 Bad Request<br />
    **Note:** Ungültige Parameter

  * **Code:** 404 Not Found<br />
    **Note:** Konnte keine Resourcen anhand der Parameter finden.

  * **Code:** 500 Internal Server Error<br />
    **Note:** Das Ergebnis konnte nicht erstellt werden.

