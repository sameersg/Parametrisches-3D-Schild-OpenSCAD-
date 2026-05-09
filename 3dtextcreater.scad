/* =====================================================================
   OPTIMIERTES 3D-SCHILD (Garantiert Druckbar)
   ===================================================================== */

$fn = 60; // Detailgrad

// --- 1. TEXT PARAMETER ---
Basis_Text = "Mama";
Overlay_Text = "Beste";

// Im Web-Editor fehlen oft spezielle Fonts. Nutze Standard-Systemfonts.
Font_Basis = "Arial Black"; 
Font_Overlay = "Brush Script MT, Comic Sans MS:style=Italic"; 

Basis_Schriftgroesse = 40;
Overlay_Schriftgroesse = 25;

// --- 2. DRUCK-OPTIMIERUNG (Gegen das Auseinanderfallen) ---
// WICHTIG: Diese Werte kleiner als 1.0 einstellen, bis sich die Buchstaben 
// auf dem Bildschirm berühren und zu EINEM Block verschmelzen!
Abstand_Basis = 0.85;   // Schiebt "M a m a" zusammen
Abstand_Overlay = 0.70; // Schiebt "B e s t e" zusammen

// --- 3. DIMENSIONEN ---
Dicke_Basis = 15;      
Dicke_Overlay = 5;     
Ueberlappung = 2; // Z-Überlappung, damit der Slicer es als ein Teil erkennt

// --- 4. POSITIONIERUNG ---
// Y-Position muss klein genug sein, damit "Beste" auf "Mama" aufliegt!
Overlay_Pos_X = -15;
Overlay_Pos_Y = 20; // Reduziert von 32 auf 20, damit es überlappt

// --- 5. SYMBOLE ---
Symbol_Typ = 2; // 0 = Aus, 1 = Ringe, 2 = Herz, 3 = Stern
Symbol_Groesse = 20;
Symbol_Pos_X = 55;
Symbol_Pos_Y = 22;

// --- 6. NOTFALL-BODENPLATTE (Optional) ---
// Wenn du "1" einträgst, wird ein unsichtbarer 1mm dicker Verbindungssteg 
// unter die Buchstaben gelegt, falls sie sich partou nicht berühren wollen.
Mit_Bodenplatte = 0; 


/* =====================================================================
   MODELLGENERIERUNG
   ===================================================================== */

union() {
    // Ebene 1: Basis-Text
    color("LightPink") 
    linear_extrude(height = Dicke_Basis)
        text(Basis_Text, size = Basis_Schriftgroesse, font = Font_Basis, halign = "center", valign = "baseline", spacing = Abstand_Basis);

    // Ebene 2: Overlay-Text
    color("White")
    translate([Overlay_Pos_X, Overlay_Pos_Y, Dicke_Basis - Ueberlappung])
    linear_extrude(height = Dicke_Overlay + Ueberlappung)
        text(Overlay_Text, size = Overlay_Schriftgroesse, font = Font_Overlay, halign = "center", valign = "baseline", spacing = Abstand_Overlay);

    // Ebene 3: Symbol
    if (Symbol_Typ > 0) {
        color("White")
        translate([Symbol_Pos_X, Symbol_Pos_Y, Dicke_Basis - Ueberlappung])
        linear_extrude(height = Dicke_Overlay + Ueberlappung) {
            if (Symbol_Typ == 1) { // Ringe
                wand = Symbol_Groesse * 0.15;
                difference() { circle(d=Symbol_Groesse); circle(d=Symbol_Groesse - wand*2); }
                translate([Symbol_Groesse * 0.65, 0, 0])
                difference() { circle(d=Symbol_Groesse); circle(d=Symbol_Groesse - wand*2); }
            }
            else if (Symbol_Typ == 2) { // Herz (massiv für besseren Druck)
                translate([0, -Symbol_Groesse*0.2, 0])
                union() {
                    rotate([0, 0, 45]) square(Symbol_Groesse*0.6, center=true);
                    translate([Symbol_Groesse*0.3, Symbol_Groesse*0.3, 0]) circle(d=Symbol_Groesse*0.6);
                    translate([-Symbol_Groesse*0.3, Symbol_Groesse*0.3, 0]) circle(d=Symbol_Groesse*0.6);
                }
            }
            else if (Symbol_Typ == 3) { // Stern
                circle(d=Symbol_Groesse, $fn=5);
            }
        }
    }
    
    // Ebene 4: Notfall-Bodenplatte
    if (Mit_Bodenplatte == 1) {
        color("Gray")
        translate([0, 10, 0.5])
        cube([Basis_Schriftgroesse * len(Basis_Text) * 0.8, Basis_Schriftgroesse, 1], center=true);
    }
}
