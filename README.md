# SwiftPhone Dokumentation


## Spielerklärung

Swift Phone ist ein Stille Post Spiel (angelehnt an Gartic Phone) entwickelt für das iPhone. Bei dem Spiel schreiben zuerst alle Spieler innerhalb einer gegebenen Zeit einen beliebigen Satz. Danach werden die Sätze verteilt, wobei keiner den eigenen Satz bekommt. Der erhaltene Satz wird innerhalb einer gegebenen Zeit gezeichnet und anschließend werden die Bilder verteilt. Hierbei gilt ebenfalls, dass kein Spieler das eigene Bild bekommt. Das Bild wird nun innerhalb einer gegebenen Zeit beschrieben und anschließend wird der Satz wieder verteilt. Das Ganze wiederholt sich bis alle Spieler einen Satz/ein Bild von jemand anderem bekommen haben. Am Ende des Spiel gibt es eine Auflösung, in welcher der gesamte Verlauf gezeigt wird.

## Warum die App entwickelt wurde
Dieses Projekt war ein Teil des "CS2365 	Swift-Programmierung unter iOS" an der THM, welches von 4 Studenten entwickelt wurde :
- David Velke
- Anastasia Homagin
- Niko Müller
- Omar Hammad

## Anleitung

Zum Start des Backends muss zu Beginn Vapor über den Homebrew Paketmanager installiert werden.

_brew install vapor_

Nachdem Vapor installiert ist, kann im Backend Ordner mit dem Befehl

_swift run_

das Backend gestartet werden.


## Views und Features


### MainMenuView

Wenn die App gestartet wird, kommt der Benutzer zuerst in die `MainMenuView`.  Hier wird unter dem Logo der App der Benutzername angezeigt. Dieser besteht anfangs aus “RandomName“ und einer zufälligen Zahl. Unter dem Benutzernamen gibt es drei Buttons. “Join Game“ navigiert zur `JoinView`. Der Button “Host Game“ startet ein neues Spiel und navigiert zur `LobbyView`. Mit dem Button “Edit Profile“ wird ein Popup geöffnet, in dem der Benutzername geändert werden kann. Der Benutzername wird in den `UserDefaults` gespeichert, damit er nach dem Schließen der App erhalten bleibt.

<img src="https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/Main.png" width="250px">

### LobbyView

Die `LobbyView` ist der Warteraum für die Spieler. Oben steht der Game Key, der anderen Spielern gegeben werden kann, damit sie dem Spiel beitreten können. Rechts davon ist ein “Copy“-Button, der den Game Key ins Clipboard kopiert. Darunter befindet sich die Liste der Spieler, die in der Lobby sind. Sie werden mit einem Bild und Benutzernamen angezeigt. Die Spieleranzahl ist auf acht Personen beschränkt. Unter der Spielerliste hat der Host einen Button zum Starten des Spiels.

<img src="https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/Lobby.png" width="250px">


### JoinView

In der `JoinView` kann ein Benutzer einem Spiel beitreten. Dafür muss er einen Game Key in das Textfeld eingeben und auf “Join“ klicken. Wenn der Game Key richtig ist und die maximale Spielerzahl noch nicht erreicht wurde, wird der Benutzer zur `LobbyView` navigiert.

<img src="https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/Join.png" width="250px">


### TimerView

Die `TimerView` zeigt die Restzeit an, die der Spieler in einer Runde hat. Die Zeit wird runtergezählt und wenn sie abläuft, werden die Sätze bzw. Bilder an das Backend geschickt.

![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/timer1.png)

![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/timer2.png)

### InitSentenceView

Zur `InitSentenceView` gelangt der Benutzer beim Starten des Spiels. Hier wird der erste Satz geschrieben. Im Textfeld ist ein Beispielsatz als Placeholder hinterlegt. Falls ein Spieler das Textfeld leer lassen sollte, wird der Beispielsatz aus dem Placeholder für die nächste Runde genommen. Unter dem Textfeld gibt es einen “Submit“-Button, mit dem der Benutzer frühzeitig abgeben kann. Das Textfeld kann dann nicht weiterbearbeitet werden und der Button ändert sich zu einem “Submitted“-Button. Wenn der Spieler daraufklickt, ändert sich der Button zurück und das Textfeld kann wieder bearbeitet werden. Oben gibt es einen Timer (`TimerView`), der die verbleibende Zeit anzeigt. Wenn die Zeit abläuft, wird der Satz abgegeben und der Spieler wird zur `CanvasView`  oder `SolutionView` (wenn das Spiel fertig ist) weitergeleitet. Falls alle vor Ablauf des Timers abgeben, werden die Spieler ebenfalls weitergeleitet.


<img src="https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/Init.png" width="250px">

### CanvasView

In der `CanvasView` wird ein gegebener Satz gezeichnet. Oben links steht der Satz, der gezeichnet werden soll. Rechts daneben gibt es einen Timer (`TimerView`), der die verbleibende Zeit angibt. Nach Ablauf der Zeit wird das Bild abgegeben und der Spieler wird zur `DescribeSentenceView` oder `SolutionView` (wenn das Spiel fertig ist) weitergeleitet. In der Mitte befindet sich ein weißer Bereich, auf dem gezeichnet werden kann. Unter dem Bereich zum Zeichnen gibt es ganz links eine Farbauswahl (`ColorPicker`). Daneben gibt es einen `Slider`, der die Breite des Pinsels angibt. Rechts davon ist ein Vor- und Zurück-Button, sowie ein Löschen-Button. Der Löschen-Button löscht das gezeichnete Bild und den bisherigen Verlauf. Darunter befindet sich ein “Submit“-Button. Dieser funktioniert auf die gleiche Weise wie bei der `InitSentenceView`.


<img src="https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/Canvas.png" width="250px">


### DescribeSentenceView

In der `DescribeSentenceView` wird ein gegebenes Bild gezeichnet. Oben gibt es einen Timer, darunter folgt das Bild, welches gezeichnet werden soll. Hier gibt es ebenfalls ein Textfeld und einen “Submit“-Button wie in der `InitSentenceView`. Allerdings gibt es bei der `DescribeSentenceView` keinen Placeholder, der alternativ genommen wird, falls das Textfeld leer bleibt.

<img src="https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/Describe.png" width="250px">

### SolutionView

In der `SolutionView` wird der gesamte Verlauf des Spiels in einem Chat angezeigt. Die Sätze der Spieler sind auf der linken Seite und die Bilder sind auf der rechten Seite. Über dem Satz/Bild steht der Name des Spielers und jeweils rechts oder links ist das Profilbild.

<img src="https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/Solution2.png" width="250px">


### DisconnectedView

Die `DisconnectedView `ermöglicht es, zum Hauptmenü zu gelangen, wenn mal die Verbindung zum Backend unterbrochen wird.

<img src="https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/Disconnect.png" width="250px">


### Custom Style

`ButtonView `und `DarkGreyButton `stellen ein eigenes Design für Buttons zur Verfügung. Die `TextFieldView `stellt ein eigenes Design für ein Textfeld zur Verfügung.


## Genutzte Frameworks

Foundation ist ein Framework, das Basisfunktionen zur Verfügung stellt, wie zum Beispiel Datenspeicherung und -persistenz oder Textverarbeitung.

SwiftUI ist ein Framework, das zum Erstellen des User Interface dient. Es stellt Views, Layoutstrukturen, sowie Event Handler zur Verfügung. SwiftUI wurde zum Erstellen der GUI verwendet.

Vapor ist ein Webframework für Swift. Damit ist es möglich in Swift Backends, Web APIs und HTTP Server zu schreiben, des Weiteren ermöglicht es Kommunikation über einen WebSocket. Vapor verwaltet den Spielablauf und die Kommunikation der Clients.


## Datenspeicherung/-struktur

In den `UserDefaults `wird ein Benutzername gespeichert. Dieser besteht aus einem `key username `mit einem `value` vom Typ `String`.

![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/cust1.png)

![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/cust2.png)

![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/cust3.png)

## Netzwerkkommunikation

Die Anwendung benötigt eine Verbindung zu dem Server, da diese so gestaltet ist, dass die Clients über den Server interagieren müssen. Das Backend wurde mittels des Vapor Frameworks in Swift geschrieben. Dort sendet der Server nach Veränderungen ein Event ab. Dies funktioniert nach dem Sever-Sent-Event Prinzip. Nachdem der Server ein Event ausgelöst hat, muss der Client die entsprechende Ressource vom Backend über HTTP abfragen.

Die erste Interaktion mit dem Server findet beim Erstellen der Lobby statt. Der Ersteller der Lobby gibt seinen Spielernamen und die Spieleinstellungen in der Anfrage an. Im Gegenzug erhält er eine UserID und den Lobby _Key_. Die _UserID_ wird zur weiteren Interaktion benötigt. Der _Key_ dient zum Verbinden weiterer Spieler. Die weiteren Mitspieler geben ihren Namen und den Lobby Key in der Anfrage an und erhalten im Gegenzug ihre _UserID_ und die entsprechenden Spieleinstellungen zurück. Die Spieler befinden sich zuerst in einer temporären Userlist bis sie sich mit dem WebSocket verbinden.


![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/1.jpg)

Bei der Verbindung mit dem Server und dem WebSocket muss die _UserID_ und der Lobby _Key_ im Header Bereich angegeben werden. Die Spieler gelangen anschließend in die endgültige _Userlist_.

![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/2.jpg)

Die Spieler, die sich in der _Userlist_ befinden, erhalten bei Veränderung (1) der Liste ein Event vom Server, dass sich diese Liste aktualisiert hat (2). Die Clients müssen dann die neue _Userlist_ vom Server abfragen (3). Die Spieler warten, solange bis der Ersteller der Lobby das Spiel startet.

![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/3.jpg)

Sobald das Spiel startet, wird auch hier ein Event vom Server gesendet. Die Spieler gelangen in die `SentenceView` und müssen einen Beispiel-Satz vom Server abfragen. Diesen Satz können die Spieler bearbeiten oder unverändert lassen. Ein Spieler kann auch vorzeitig seinen Satz abgeben. Sollten dies alle Spieler machen, geht es weiter zur nächsten Runde. Sollte der Spieler, der seinen Satz vorzeitig abgegeben hat, diesen doch wieder bearbeiten wollen, kann er dies machen, sofern die anderen Spieler noch nicht abgegeben haben oder die Zeit nicht abgelaufen ist. Alle Spieler senden automatisch nach Ablauf der Zeit ihren Text aus dem Textfeld ab. Sobald die vorher genannten Gründe erfüllt worden sind, sendet der Server ein Event an alle Spieler, damit es in der nächsten Runde weitergehen kann. Der zuvor beschriebene Ablauf gilt auch für die weiteren Spielrunden und auch bei der `CanvasView`. Dies wird solange wiederholt, bis alle Spielrunden gespielt wurden. Der Server teilt den Spielern mit, wann das Spiel zuende ist. Jeder Spieler fragt die Auflösung aller Runden anschließend ab.

![](https://github.com/omarali1010/swiftphone/blob/main/SwiftPhone/IMG/4.jpg)

Für eine detailliertere Beschreibung der Anfragen siehe Rest [API Dokumentation](./API/API.md).


## Quellen

[https://www.youtube.com/watch?v=I-Eacg9Kjuw](https://www.youtube.com/watch?v=I-Eacg9Kjuw)

[https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image](https://www.hackingwithswift.com/quick-start/swiftui/how-to-convert-a-swiftui-view-to-an-image)

[https://developer.apple.com/documentation/foundation](https://developer.apple.com/documentation/foundation)

[https://developer.apple.com/documentation/swiftui/](https://developer.apple.com/documentation/swiftui/)

[https://docs.vapor.codes/](https://docs.vapor.codes/)

[https://getavataaars.com/](https://getavataaars.com/)
