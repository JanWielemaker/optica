Handleiding hypothese editor
----------------------------

In deze versie van de optica simulator heb ik een experimentele
hypothese editor toegevoegd.  Dit is zeker niet de `finale versie',
de gebruikersinterface moet in elk geval verder gestroomlijnd worden.
Het laat echter zien wat er binnen de omgeving mogelijk is en kan
hopelijk als een vertrekpunt voor verdere discussie dienen.

Korte handleiding
-----------------

Het standaard scenario ziet er als volgt uit:

	* Maak een opstelling
	* Klik op het meest rechtse icon om de hypothese editor te
	  openen.
	* Klik daar op het tabel-icon om een tabel te maken.
	* Stel de opstelling in en klik op het fototoestel in de
	  hypothese editor om een regel aan de tabel toe te voegen.
	  Herhaal dit om een meetwaardetabel te maken.
	* Sleep nu de gewense X-as naar het grafiek window.  Tabel
	  kolommen sleep je met de linker muisknop aan de kolom
	  header.  Doe dit daarna met de Y-as.  Je kunt willekeurige
	  kolommen naar de grafiek slepen.  De cursor geeft aan of het
	  een X of een Y-as wordt.
	* Maak een formule door prototypes naar het formule window te
	  slepen.  B.v. 1/x maak je door */* naar het window te slepen,
	  dan de `1' op de bovenste *, en de kolom die je onder wilt
	  hebben op de onderste *.  Daarna kun je de formule op de
	  tabel slepen.  En de nieuwe kolom op de grafiek, etc.

Het is mijn trouwens na ca. 30 minuten proberen niet gelukt de
lenzenformule zo te vinden ...  Nadat ik de formule uit een boek
gehaald had kon ik de simulatie wel valideren.

Handleiding `Authoring' omgeving
--------------------------------

De huidige versie van optica komt  met   twee  icons, `Optica Config' en
`Optica Demo':

	* Optica Demo
	Start "optica.exe" zonder argumenten.  Dit laadt de configuratie
	database `default.opa'.

	* Optica Config
	Start "optica.exe -- -config". Hierbij wordt geen configuratiefile 
	geladen, en komt de interface in de meest algemene vorm op.  De
	twee meest rechtse icons geven toegang tot the authoring
	omgeving. De meest linkse van de twee start de fase configuratie
	tool, de andere de test tool.

Fase configuratie
-----------------

Druk op het configuratie icon. Je krijgt dan een klein window te zien om
configuratie files te laden en de daarin beschreven fasen (experimenten)
te bekijken. Gebruik `File/Load' om b.v. "Default.opa" te laden. Hierin
staan nu twee fasen.  Hierop kun je dubbel-klikken om de fase-editor te
openen.  Je kunt ook met experiment/new een nieuwe fase maken.  De fase
editor laat je de tools selecteren en instrumenten definieren.

Een paar `verborgen' opties: met de rechter muis krijg je een menu op de
tool icons.  Die met het boek en blaadje geven je toegang tot de editor
voor theory en opdracht.

De volgorde van instrumenten kun je veranderen door ze te slepen.

Lenzen komen in twee vormen.  Als de focal distance is gegeven fungeert
de lens als een ideale lens. Als je sfere_left en sfere_right geeft, dan
wordt de lens op die manier getekend.  Je kunt dus zeggen focal distance
= 4, sfere_left = sfere_right = -10 om een positieve holle lens te
maken ...  Dit kan Casper's problemen oplossen.  

Handleiding toetsomgeving
-------------------------

Je kunt een toets laden  (fase1.tst).  Deze   kun  je  vraag  voor vraag
bekijken en editen. Je kunt ook de gehele toets invullen.


	--- Jan
