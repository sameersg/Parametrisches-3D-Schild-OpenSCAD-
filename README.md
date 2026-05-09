# Parametrisches 3D-Schild (OpenSCAD) 🎨🖨️

Ein vollständig anpassbares, zweischichtiges 3D-Modell für personalisierte Namensschilder, Dekorationen oder Geschenke (z.B. "Beste Mama", "The Smith"). Erstellt mit **OpenSCAD** und speziell optimiert für den zweifarbigen FDM-3D-Druck (Filamentwechsel).

![Vorschau des Schildes](Pfad/zu/deinem/vorschaubild.jpg) *(Tipp: Ersetze diesen Link durch ein echtes Foto deines gedruckten Schildes!)*

## ✨ Features

* **Komplett parametrisch:** Ändere Texte, Schriftarten, Größen und Positionen direkt im Code.
* **Druckfertig optimiert:** Integrierte Parameter für Buchstabenabstände (Tracking/Spacing), damit der Text als *ein massives Teil* gedruckt wird und nicht in Einzelbuchstaben zerfällt.
* **Zweifarb-Design:** Entwickelt, um durch einen simplen Filamentwechsel im Slicer (Pause at height / M600) zweifarbig gedruckt zu werden.
* **Modulare Symbole:** Optionale 3D-Symbole (ineinandergreifende Ringe für Hochzeiten, Herzen, Sterne) lassen sich mit einem Parameter zuschalten.
* **Notfall-Bodenplatte:** Optionaler Verbindungssteg für sehr filigrane oder stark separierte Schriftarten.

## 🚀 Voraussetzungen

Um dieses Modell zu nutzen, benötigst du:
1. [OpenSCAD](https://openscad.org/downloads.html) (Kostenlos, für Windows/Mac/Linux)
2. Lokale Schriftarten auf deinem Rechner (z.B. "Arial Black", "Brush Script MT").

## 🛠️ Verwendung

1. Lade die Datei `3dtextcreater.scad` herunter und öffne sie in OpenSCAD.
2. Ändere die Parameter im oberen Bereich des Codes nach deinen Wünschen (siehe Parameter-Referenz unten).
3. Drücke **F5** für eine schnelle Vorschau. Kontrolliere, ob sich die Buchstaben der Basis berühren und der obere Text gut aufliegt.
4. Drücke **F6** zum finalen Rendern (das kann je nach Schriftart kurz dauern).
5. Klicke auf **File > Export > Export as STL**, um die Datei für deinen Slicer zu speichern.

---

## ⚙️ Parameter-Referenz

Hier ist eine Übersicht aller Variablen, die du im Code anpassen kannst:

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
| `Symbol_Typ` | `0` = Kein Symbol, `1` = Zwei Ringe, `2` = Herz, `3` = Stern. |
| `Symbol_Groesse` | Skaliert das gewählte Symbol. |
| `Symbol_Pos_X` / `_Y` | Verschiebt das Symbol auf dem Schild (ähnlich wie beim Overlay-Text). |

---

## 🖨️ Tipps für den 3D-Druck (Slicer-Settings)

Damit das Schild perfekt wird, hier ein paar Empfehlungen für Cura, PrusaSlicer oder Bambu Studio:

* **Filamentwechsel (Color Swap):** Slice das Modell und scrolle in der Schicht-Vorschau genau zu der Ebene, an der die Basis endet und der obere Text/die Symbole beginnen. Füge dort eine Druckpause (`M600` / "Pause at height" / "Add color change") ein.
* **Keine Stützstrukturen nötig:** Das Modell ist so konstruiert, dass es flach auf dem Druckbett liegt und ohne Support gedruckt werden kann.
* **Infill:** 10% bis 15% Gyroid oder Grid sind meistens völlig ausreichend.
* **Bügelfunktion (Ironing):** Wenn du eine sehr glatte Oberfläche für die Basis-Schicht möchtest, aktiviere die Bügelfunktion für die oberste Schicht der Basis.

## 🤝 Mitwirken

Du hast eine Idee für ein neues Symbol oder eine Verbesserungen am Code? Pull Requests sind jederzeit willkommen! 

## 📄 Lizenz

Dieses Projekt steht unter der **GNU General Public License v3.0 (GPLv3)**. 

Das bedeutet kurzgefasst:
* Du darfst den Code privat und kommerziell nutzen.
* Du darfst den Code verändern und weiterverbreiten.
* **Bedingung:** Wenn du eine veränderte Version dieses Codes veröffentlichst, **muss** diese zwingend wieder unter derselben GPLv3-Lizenz Open Source gestellt werden. 

Details zur Lizenz findest du in der [LICENSE](LICENSE)-Datei in diesem Repository.
