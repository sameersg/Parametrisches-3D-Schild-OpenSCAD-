# Parametrisches 3D-Schild (OpenSCAD) 🎨🖨️

Ein vollständig anpassbares, zweischichtiges 3D-Modell für personalisierte Namensschilder, Dekorationen oder Geschenke (z.B. "Beste Mama", "The Smith"). Erstellt mit **OpenSCAD** und speziell optimiert für den zweifarbigen FDM-3D-Druck (Filamentwechsel).

## ✨ Features

* **5 Design-Stile:** Wähle per Dropdown im Customizer zwischen Klassisch, Gerahmt (Vintage), Unterstrichen (Sportlich), Stehend (Aufsteller) und Banner (Fahne).
* **12 handgebaute Symbole:** Herz, Stern, Krone, Blitz, Mond, Blume und mehr – alles mit reiner Geometrie, kein Font nötig.
* **Komplett parametrisch:** Ändere Texte, Schriftarten, Größen und Positionen direkt im Customizer oder im Code.
* **Druckfertig optimiert:** Integrierte Parameter für Buchstabenabstände (Tracking/Spacing), damit der Text als *ein massives Teil* gedruckt wird und nicht in Einzelbuchstaben zerfällt.
* **Zweifarb-Design:** Entwickelt, um durch einen simplen Filamentwechsel im Slicer (Pause at height / M600) zweifarbig gedruckt zu werden.
* **Ohne Supports druckbar:** Alle Stile sind so konstruiert, dass sie ohne Stützstrukturen gedruckt werden können.
* **Notfall-Bodenplatte:** Optionaler Verbindungssteg für sehr filigrane oder stark separierte Schriftarten.

## 🎭 Design-Stile

| Stil | Name | Beschreibung |
| :---: | :--- | :--- |
| 1 | **Klassisch** | Text + Overlay oben-links versetzt – wie ein handgeschriebenes Geschenk. |
| 2 | **Gerahmt (Vintage)** | Abgerundeter Rahmen mit erhabener Kante. Overlay diagonal rotiert wie ein Stempel. |
| 3 | **Unterstrichen (Sportlich)** | Dynamischer Swoosh-Balken unter dem Text. Overlay als Subtitle auf dem Balken. |
| 4 | **Stehend (Aufsteller)** | Text steht aufrecht auf dem Tisch mit stabiler Fußplatte – perfekt als Schreibtisch-Deko. |
| 5 | **Banner (Fahne)** | Geschwungene Fahne mit V-förmigen Ribbon-Enden. Overlay oben, feierlicher Look. |

## 🔣 Symbole

Alle Symbole sind mit reiner OpenSCAD-Geometrie gebaut – kein spezieller Font nötig!

| Nr | Symbol | Nr | Symbol |
| :---: | :--- | :---: | :--- |
| 0 | Aus | 6 | Krone 👑 |
| 1 | Ringe (Hochzeit) 💍 | 7 | Blume 🌸 |
| 2 | Herz ❤️ | 8 | Pfeil ➡️ |
| 3 | Stern ⭐ | 9 | Kreuz/Plus ✚ |
| 4 | Diamant ♦️ | 10 | Unendlich ∞ |
| 5 | Mond 🌙 | 11 | Blitz ⚡ |

## 🚀 Voraussetzungen

Um dieses Modell zu nutzen, benötigst du:
1. [OpenSCAD](https://openscad.org/downloads.html) (Kostenlos, für Windows/Mac/Linux)
2. Lokale Schriftarten auf deinem Rechner (z.B. "Arial Black", "Brush Script MT").

## 🛠️ Verwendung

1. Lade die Datei `3dtextcreater.scad` herunter und öffne sie in OpenSCAD.
2. Öffne den **Customizer** (Fenster > Customizer) oder ändere die Parameter direkt im Code.
3. Wähle deinen **Design-Stil** und dein **Symbol** im Dropdown.
4. Drücke **F5** für eine schnelle Vorschau. Kontrolliere, ob sich die Buchstaben der Basis berühren und der obere Text gut aufliegt.
5. Drücke **F6** zum finalen Rendern (das kann je nach Schriftart kurz dauern).
6. Klicke auf **File > Export > Export as STL**, um die Datei für deinen Slicer zu speichern.

---

## ⚙️ Parameter-Referenz

Hier ist eine Übersicht aller Variablen, die du im Customizer oder Code anpassen kannst:

### Design-Stil
| Parameter | Beschreibung |
| :--- | :--- |
| `Design_Stil` | `1` = Klassisch, `2` = Gerahmt, `3` = Unterstrichen, `4` = Stehend, `5` = Banner. |

### Text & Schriftarten
| Parameter | Beschreibung |
| :--- | :--- |
| `Basis_Text` | Der Text für die untere, dicke Schicht (z.B. "Mama"). |
| `Overlay_Text` | Der Text für die obere, aufgesetzte Schicht (z.B. "Beste"). |
| `Font_Basis` | Der exakte Name der System-Schriftart für die Basis (z.B. "Arial Black"). |
| `Font_Overlay` | Der Name der System-Schriftart für das Overlay. |
| `Basis_Schriftgroesse` | Schriftgröße der Basis in mm. |
| `Overlay_Schriftgroesse`| Schriftgröße des Overlays in mm. |

### Druck-Optimierung & Dimensionen
| Parameter | Beschreibung |
| :--- | :--- |
| `Abstand_Basis` | **Wichtig:** Abstand der Buchstaben (< 1.0 schiebt sie zusammen, damit sie ein zusammenhängendes Druckteil bilden). |
| `Abstand_Overlay` | Abstand der Overlay-Buchstaben zueinander. |
| `Dicke_Basis` | Z-Höhe (Dicke) der Basis in mm. |
| `Dicke_Overlay` | Z-Höhe (Dicke) der aufgesetzten Schicht in mm. |
| `Ueberlappung` | Wie tief die obere Schicht in die untere einsinkt, damit der Slicer es als ein festes Objekt verbindet (Standard: 2). |
| `Mit_Bodenplatte` | `1` = Erzeugt einen 1mm dicken Verbindungssteg unter dem Text, falls Schriftarten zerfallen. `0` = Deaktiviert. |

### Positionierung & Symbole
| Parameter | Beschreibung |
| :--- | :--- |
| `Overlay_Pos_X` / `_Y` | Verschiebt den oberen Text nach links/rechts (X) oder oben/unten (Y). **Wichtig:** Y muss so gewählt sein, dass der Text physisch aufliegt! |
| `Symbol_Typ` | `0`–`11`: Wähle ein Symbol im Dropdown (siehe Symboltabelle oben). |
| `Symbol_Groesse` | Skaliert das gewählte Symbol. |
| `Symbol_Pos_X` / `_Y` | Verschiebt das Symbol auf dem Schild. |

### Stil-spezifische Parameter
| Parameter | Stil | Beschreibung |
| :--- | :--- | :--- |
| `Rahmen_Padding` | Gerahmt | Abstand Text → Rahmenrand (mm). |
| `Rahmen_Rand_Dicke` | Gerahmt | Wandstärke der erhabenen Kante (mm). |
| `Rahmen_Rand_Hoehe` | Gerahmt | Höhe der Kante über der Basis (mm). |
| `Rahmen_Eckenradius` | Gerahmt | Abrundung der Rahmenecken (mm). |
| `Swoosh_Hoehe` | Unterstrichen | Höhe des Swoosh-Balkens (mm). |
| `Swoosh_Ueberstand` | Unterstrichen | Überstand des Swoosh über den Text hinaus (mm). |
| `Fussplatte_Tiefe` | Stehend | Tiefe der Fußplatte für Standfestigkeit (mm). |
| `Fussplatte_Hoehe` | Stehend | Höhe der Fußplatte (mm). |
| `Fussplatte_Ueberstand` | Stehend | Überstand links/rechts über den Text (mm). |
| `Banner_Padding` | Banner | Abstand Text → Bannerrand (mm). |
| `Banner_Wellung` | Banner | Stärke der V-förmigen Ribbon-Enden (mm). |

---

## 🖨️ Tipps für den 3D-Druck (Slicer-Settings)

Damit das Schild perfekt wird, hier ein paar Empfehlungen für Cura, PrusaSlicer oder Bambu Studio:

* **Filamentwechsel (Color Swap):** Slice das Modell und scrolle in der Schicht-Vorschau genau zu der Ebene, an der die Basis endet und der obere Text/die Symbole beginnen. Füge dort eine Druckpause (`M600` / "Pause at height" / "Add color change") ein.
* **Keine Stützstrukturen nötig:** Das Modell ist so konstruiert, dass es flach auf dem Druckbett liegt und ohne Support gedruckt werden kann.
* **Infill:** 10% bis 15% Gyroid oder Grid sind meistens völlig ausreichend.
* **Bügelfunktion (Ironing):** Wenn du eine sehr glatte Oberfläche für die Basis-Schicht möchtest, aktiviere die Bügelfunktion für die oberste Schicht der Basis.
* **Stehend-Stil (4):** Für optimale Stabilität empfehlen wir 20–30% Infill und mindestens 3 Wandlinien.

## 🤝 Mitwirken

Du hast eine Idee für ein neues Symbol oder einen neuen Design-Stil? Pull Requests sind jederzeit willkommen! 

## 📄 Lizenz

Dieses Projekt steht unter der **GNU General Public License v3.0 (GPLv3)**. 

Das bedeutet kurzgefasst:
* Du darfst den Code privat und kommerziell nutzen.
* Du darfst den Code verändern und weiterverbreiten.
* **Bedingung:** Wenn du eine veränderte Version dieses Codes veröffentlichst, **muss** diese zwingend wieder unter derselben GPLv3-Lizenz Open Source gestellt werden. 

Details zur Lizenz findest du in der [LICENSE](LICENSE)-Datei in diesem Repository.
