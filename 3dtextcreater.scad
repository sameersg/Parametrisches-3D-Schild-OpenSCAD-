/* =====================================================================
   PARAMETRISCHES 3D-SCHILD MIT DESIGN-STILEN
   Optimiert für zweifarbigen FDM-Druck ohne Supports (M600)
   ===================================================================== */

$fn = 60;

// =====================================================================
// 1. DESIGN-STIL AUSWAHL
// =====================================================================
Design_Stil = 1; // [1:Klassisch, 2:Gerahmt (Vintage), 3:Unterstrichen (Sportlich), 4:Stehend (Aufsteller), 5:Banner (Geschwungene Fahne)]

// =====================================================================
// 2. TEXT PARAMETER
// =====================================================================
Basis_Text     = "Mama";
Overlay_Text   = "Beste";

Font_Basis   = "Arial Black";
Font_Overlay = "Brush Script MT, Comic Sans MS:style=Italic";

Basis_Schriftgroesse   = 40;
Overlay_Schriftgroesse = 25;

// =====================================================================
// 3. DRUCK-OPTIMIERUNG
// =====================================================================
// Werte < 1.0 schieben Buchstaben zusammen, damit sie verschmelzen.
Abstand_Basis   = 0.85;
Abstand_Overlay = 0.70;

// =====================================================================
// 4. DIMENSIONEN
// =====================================================================
Dicke_Basis    = 15;
Dicke_Overlay  = 5;
Ueberlappung   = 2; // Z-Überlappung Overlay → Basis (mind. 1-2 mm)

// =====================================================================
// 5. POSITIONIERUNG (Defaults für Stil 1 – Klassisch)
// =====================================================================
Overlay_Pos_X = -15;
Overlay_Pos_Y = 20;

// =====================================================================
// 6. SYMBOLE
// =====================================================================
Symbol_Typ = 2; // [0:Aus, 1:Ringe (Hochzeit), 2:Herz, 3:Stern, 4:Diamant, 5:Mond, 6:Krone, 7:Blume, 8:Pfeil, 9:Kreuz/Plus, 10:Unendlich, 11:Blitz]
Symbol_Groesse = 20;
Symbol_Pos_X  = 55;
Symbol_Pos_Y  = 22;

// =====================================================================
// 7. NOTFALL-BODENPLATTE (Optional, alle Stile)
// =====================================================================
Mit_Bodenplatte = 0; // 1 = aktiviert

// =====================================================================
// 8. STIL-SPEZIFISCHE PARAMETER
// =====================================================================

// --- Stil 2: Gerahmt ---
Rahmen_Padding     = 12;  // Abstand Text → Rahmenrand
Rahmen_Rand_Dicke  = 2.5; // Wandstärke der erhabenen Kante
Rahmen_Rand_Hoehe  = 3;   // Wie hoch die Kante über die Basis ragt
Rahmen_Eckenradius = 10;  // Abrundung der Ecken

// --- Stil 3: Unterstrichen ---
Swoosh_Hoehe       = 4;   // Höhe des Swoosh-Balkens
Swoosh_Ueberstand  = 20;  // Überstand links/rechts über den Text hinaus

// --- Stil 4: Stehend ---
Fussplatte_Tiefe      = 25; // Tiefe der Fußplatte (Y-Richtung)
Fussplatte_Hoehe      = 5;  // Höhe der Fußplatte
Fussplatte_Ueberstand = 8;  // Überstand links/rechts über Text

// --- Stil 5: Banner ---
Banner_Padding   = 10;  // Abstand Text → Bannerrand
Banner_Wellung   = 12;  // Stärke der Wellen-Enden


/* =====================================================================
   BERECHNETE HILFSGRÖSSEN
   ===================================================================== */

text_breite    = len(Basis_Text) * Basis_Schriftgroesse * Abstand_Basis * 0.65;
text_hoehe     = Basis_Schriftgroesse * 0.75;
overlay_breite = len(Overlay_Text) * Overlay_Schriftgroesse * Abstand_Overlay * 0.65;


/* =====================================================================
   HILFS-MODULE (2D-Profile)
   ===================================================================== */

// --- Basis-Text als 2D-Profil ---
module basis_text_2d() {
    text(Basis_Text, size=Basis_Schriftgroesse, font=Font_Basis,
         halign="center", valign="baseline", spacing=Abstand_Basis);
}

// --- Overlay-Text als 2D-Profil ---
module overlay_text_2d() {
    text(Overlay_Text, size=Overlay_Schriftgroesse, font=Font_Overlay,
         halign="center", valign="baseline", spacing=Abstand_Overlay);
}

// --- Symbol als 2D-Profil (alles handgebaut, kein Font nötig) ---
module symbol_2d() {
    s = Symbol_Groesse; // Kurzform

    if (Symbol_Typ == 1) { // Ringe (Hochzeit)
        wand = max(s * 0.15, 1.0);
        difference() { circle(d=s); circle(d=s - wand*2); }
        translate([s * 0.65, 0, 0])
        difference() { circle(d=s); circle(d=s - wand*2); }
    }
    else if (Symbol_Typ == 2) { // Herz (massiv)
        translate([0, -s*0.2, 0])
        union() {
            rotate([0,0,45]) square(s*0.6, center=true);
            translate([ s*0.3, s*0.3, 0]) circle(d=s*0.6);
            translate([-s*0.3, s*0.3, 0]) circle(d=s*0.6);
        }
    }
    else if (Symbol_Typ == 3) { // Stern (5-zackig)
        circle(d=s, $fn=5);
    }
    else if (Symbol_Typ == 4) { // Diamant/Raute
        rotate([0, 0, 45])
            square(s * 0.6, center=true);
    }
    else if (Symbol_Typ == 5) { // Mond/Halbmond
        difference() {
            circle(d=s);
            translate([s*0.25, s*0.1, 0]) circle(d=s*0.85);
        }
    }
    else if (Symbol_Typ == 6) { // Krone
        polygon(points=[
            [-s*0.5, 0],            // links unten
            [-s*0.5, s*0.3],        // links Basis
            [-s*0.35, s*0.15],      // Tal 1
            [-s*0.2,  s*0.5],       // Zacke links
            [0,       s*0.2],       // Tal Mitte
            [s*0.2,   s*0.5],       // Zacke rechts
            [s*0.35,  s*0.15],      // Tal 2
            [s*0.5,   s*0.3],       // rechts Basis
            [s*0.5,   0]            // rechts unten
        ]);
    }
    else if (Symbol_Typ == 7) { // Blume (6 Blätter)
        for (i = [0:5]) {
            rotate([0, 0, i * 60])
            translate([s*0.22, 0, 0])
                circle(d=s*0.4);
        }
        circle(d=s*0.25); // Mitte
    }
    else if (Symbol_Typ == 8) { // Pfeil (nach rechts)
        // Schaft
        translate([-s*0.15, 0, 0])
            square([s*0.5, s*0.2], center=true);
        // Spitze
        translate([s*0.2, 0, 0])
            polygon(points=[
                [0, s*0.3],
                [s*0.3, 0],
                [0, -s*0.3]
            ]);
    }
    else if (Symbol_Typ == 9) { // Kreuz/Plus
        square([s*0.8, s*0.25], center=true);
        square([s*0.25, s*0.8], center=true);
    }
    else if (Symbol_Typ == 10) { // Unendlich
        wand = max(s * 0.12, 1.0);
        translate([-s*0.22, 0, 0])
        difference() { circle(d=s*0.55); circle(d=s*0.55 - wand*2); }
        translate([ s*0.22, 0, 0])
        difference() { circle(d=s*0.55); circle(d=s*0.55 - wand*2); }
    }
    else if (Symbol_Typ == 11) { // Blitz
        polygon(points=[
            [-s*0.05, s*0.5],       // oben links
            [s*0.2,   s*0.5],       // oben rechts
            [s*0.02,  s*0.05],      // Knick rechts
            [s*0.25,  s*0.05],      // Spitze oben
            [s*0.05,  -s*0.5],      // unten Spitze
            [-s*0.02, -s*0.05],     // Knick links
            [-s*0.25, -s*0.05]      // Ansatz oben
        ]);
    }
}

// --- Abgerundetes Rechteck (2D, zentriert) ---
module abgerundetes_rechteck(breite, hoehe, radius) {
    r = min(radius, breite/2 - 0.1, hoehe/2 - 0.1); // Sicherheit
    hull() {
        translate([-(breite/2 - r), -(hoehe/2 - r)]) circle(r=r);
        translate([ (breite/2 - r), -(hoehe/2 - r)]) circle(r=r);
        translate([-(breite/2 - r),  (hoehe/2 - r)]) circle(r=r);
        translate([ (breite/2 - r),  (hoehe/2 - r)]) circle(r=r);
    }
}

// --- Notfall-Bodenplatte (optional, für alle Stile) ---
module bodenplatte() {
    if (Mit_Bodenplatte == 1) {
        color("Gray")
        translate([0, text_hoehe/2, 0])
        cube([text_breite + 10, text_hoehe + 10, 1], center=true);
    }
}


/* =====================================================================
   STIL 1: KLASSISCH
   Originalverhalten – Basis + Overlay oben-links + Symbol
   ===================================================================== */

module stil_klassisch() {
    union() {
        // Basis-Text
        color("LightPink")
        linear_extrude(height=Dicke_Basis)
            basis_text_2d();

        // Overlay-Text (oben links versetzt)
        color("White")
        translate([Overlay_Pos_X, Overlay_Pos_Y, Dicke_Basis - Ueberlappung])
        linear_extrude(height=Dicke_Overlay + Ueberlappung)
            overlay_text_2d();

        // Symbol
        if (Symbol_Typ > 0) {
            color("White")
            translate([Symbol_Pos_X, Symbol_Pos_Y, Dicke_Basis - Ueberlappung])
            linear_extrude(height=Dicke_Overlay + Ueberlappung)
                symbol_2d();
        }

        bodenplatte();
    }
}


/* =====================================================================
   STIL 2: GERAHMT (Vintage/Retro)
   Abgerundeter Rahmen + Basis zentriert + Overlay diagonal "Stempel"
   Grundplatte ist DÜNNER als der Text → Text ragt sichtbar heraus!
   ===================================================================== */

module stil_gerahmt() {
    rahmen_b = text_breite + 2 * Rahmen_Padding;
    rahmen_h = text_hoehe  + 2 * Rahmen_Padding;
    zentrum_y = text_hoehe / 2;
    platte_dicke = Dicke_Basis * 0.4; // Platte dünner als Text!

    union() {
        color("LightPink") {
            // Rahmen-Grundplatte (dünner als Text, damit Text herausragt)
            translate([0, zentrum_y, 0])
            linear_extrude(height=platte_dicke)
                abgerundetes_rechteck(rahmen_b, rahmen_h, Rahmen_Eckenradius);

            // Erhabene Außenkante (Rahmen-Ring, volle Texthöhe)
            translate([0, zentrum_y, 0])
            linear_extrude(height=Dicke_Basis)
                difference() {
                    abgerundetes_rechteck(rahmen_b, rahmen_h, Rahmen_Eckenradius);
                    abgerundetes_rechteck(
                        rahmen_b - 2*Rahmen_Rand_Dicke,
                        rahmen_h - 2*Rahmen_Rand_Dicke,
                        max(2, Rahmen_Eckenradius - Rahmen_Rand_Dicke)
                    );
                }

            // Basis-Text (ragt über die Grundplatte hinaus)
            linear_extrude(height=Dicke_Basis)
                basis_text_2d();
        }

        // Overlay-Text: diagonal rotiert wie ein Stempel (~12°)
        color("White")
        translate([0, zentrum_y, Dicke_Basis - Ueberlappung])
        rotate([0, 0, 12])
        linear_extrude(height=Dicke_Overlay + Ueberlappung)
            overlay_text_2d();

        // Symbol: Ecke oben rechts
        if (Symbol_Typ > 0) {
            color("White")
            translate([rahmen_b/2 - Rahmen_Padding,
                       zentrum_y + rahmen_h/2 - Rahmen_Padding,
                       Dicke_Basis - Ueberlappung])
            linear_extrude(height=Dicke_Overlay + Ueberlappung)
                symbol_2d();
        }

        bodenplatte();
    }
}


/* =====================================================================
   STIL 3: UNTERSTRICHEN (Sportlich/Modern)
   Swoosh-Balken unten + Basis oben + Overlay als Subtitle auf Swoosh
   ===================================================================== */

module stil_unterstrichen() {
    swoosh_b = text_breite + 2 * Swoosh_Ueberstand;
    swoosh_y_pos = -Swoosh_Hoehe - 2; // unter der Baseline

    union() {
        color("LightPink") {
            // Basis-Text (über dem Swoosh)
            linear_extrude(height=Dicke_Basis)
                basis_text_2d();

            // Swoosh-Balken: dynamischer Balken mit abgerundeten Enden
            // Liegt bei Z=0 bis Dicke_Basis → verschmilzt mit Text
            translate([0, swoosh_y_pos + Swoosh_Hoehe/2, 0])
            linear_extrude(height=Dicke_Basis)
                hull() {
                    // Linkes Ende (dünner, dynamisch)
                    translate([-swoosh_b/2, 0])
                        circle(d=Swoosh_Hoehe * 0.5);
                    // Mitte
                    circle(d=Swoosh_Hoehe);
                    // Rechtes Ende (volle Höhe, kräftig)
                    translate([swoosh_b/2, 0])
                        circle(d=Swoosh_Hoehe);
                }
        }

        // Overlay-Text: als Subtitle UNTER dem Basis-Text, auf dem Swoosh
        color("White")
        translate([0, swoosh_y_pos + Swoosh_Hoehe/2, Dicke_Basis - Ueberlappung])
        linear_extrude(height=Dicke_Overlay + Ueberlappung)
            overlay_text_2d();

        // Symbol: rechts am Ende des Swoosh
        if (Symbol_Typ > 0) {
            color("White")
            translate([swoosh_b/2 + Symbol_Groesse * 0.3,
                       swoosh_y_pos + Swoosh_Hoehe/2,
                       Dicke_Basis - Ueberlappung])
            linear_extrude(height=Dicke_Overlay + Ueberlappung)
                symbol_2d();
        }

        bodenplatte();
    }
}


/* =====================================================================
   STIL 4: STEHEND (Aufsteller)
   Text steht aufrecht auf dem Tisch, mit flacher Fußplatte
   ===================================================================== */

module stil_stehend() {
    platte_b = text_breite + 2 * Fussplatte_Ueberstand;

    union() {
        color("LightPink") {
            // Fußplatte: flach auf dem Druckbett (Z=0)
            // Zentriert in X, erstreckt sich in Y für Stabilität
            translate([0, -Fussplatte_Tiefe/2, Fussplatte_Hoehe/2])
            cube([platte_b, Fussplatte_Tiefe, Fussplatte_Hoehe], center=true);

            // Basis-Text: steht aufrecht (90° um X rotiert)
            // Nach Rotation: Text-Profil in XZ-Ebene, Dicke in -Y
            // Baseline bei Z = Fussplatte_Hoehe (sitzt auf Fußplatte)
            translate([0, 0, Fussplatte_Hoehe - 1]) // 1mm Überlappung mit Platte
            rotate([90, 0, 0])
            linear_extrude(height=Dicke_Basis)
                basis_text_2d();
        }

        // Overlay-Text: steht ebenfalls aufrecht, oberhalb des Basis-Textes
        // Z-Position: Basis-Texthöhe + Fussplatte - Überlappung
        color("White")
        translate([Overlay_Pos_X * 0.5,
                   0,
                   Fussplatte_Hoehe + text_hoehe - Ueberlappung])
        rotate([90, 0, 0])
        linear_extrude(height=Dicke_Overlay + Ueberlappung)
            overlay_text_2d();

        // Symbol: oben rechts neben dem stehenden Text
        if (Symbol_Typ > 0) {
            color("White")
            translate([text_breite/2 + Symbol_Groesse * 0.3,
                       0,
                       Fussplatte_Hoehe + text_hoehe * 0.5])
            rotate([90, 0, 0])
            linear_extrude(height=Dicke_Overlay + Ueberlappung)
                symbol_2d();
        }
    }
}


/* =====================================================================
   STIL 5: BANNER (Welle/Fahne)
   Geschwungene Fahne + Basis erhöht + Overlay bogenförmig oben
   Banner-Körper ist DÜNNER als der Text → Text ragt heraus!
   ===================================================================== */

module stil_banner() {
    banner_b = text_breite + 2 * Banner_Padding;
    banner_h = text_hoehe  + 2 * Banner_Padding;
    zentrum_y = text_hoehe / 2;
    banner_dicke = Dicke_Basis * 0.4; // Banner dünner als Text!
    tail_laenge = Banner_Wellung * 1.5; // Länge der Schwanz-Enden

    union() {
        color("LightPink") {
            // Banner-Hauptkörper: flache Grundfläche (dünner als Text)
            translate([0, zentrum_y, 0])
            linear_extrude(height=banner_dicke)
                abgerundetes_rechteck(banner_b, banner_h, 4);

            // Banner-Schwanz links: V-förmiges Ribbon-Ende
            translate([-banner_b/2 - tail_laenge/2, zentrum_y, 0])
            linear_extrude(height=banner_dicke)
                polygon(points=[
                    [tail_laenge/2,  banner_h/2],     // oben rechts (Anschluss)
                    [tail_laenge/2, -banner_h/2],     // unten rechts (Anschluss)
                    [-tail_laenge/2, -banner_h/2 + Banner_Wellung * 0.4], // unten links
                    [0, 0],                            // V-Einschnitt Mitte
                    [-tail_laenge/2,  banner_h/2 - Banner_Wellung * 0.4]  // oben links
                ]);

            // Banner-Schwanz rechts: V-förmiges Ribbon-Ende (gespiegelt)
            translate([banner_b/2 + tail_laenge/2, zentrum_y, 0])
            linear_extrude(height=banner_dicke)
                polygon(points=[
                    [-tail_laenge/2,  banner_h/2],     // oben links (Anschluss)
                    [-tail_laenge/2, -banner_h/2],     // unten links (Anschluss)
                    [tail_laenge/2, -banner_h/2 + Banner_Wellung * 0.4], // unten rechts
                    [0, 0],                            // V-Einschnitt Mitte
                    [tail_laenge/2,  banner_h/2 - Banner_Wellung * 0.4]  // oben rechts
                ]);

            // Basis-Text (ragt über den Banner-Körper hinaus)
            linear_extrude(height=Dicke_Basis)
                basis_text_2d();
        }

        // Overlay-Text: oben über dem Basis-Text, auf dem Banner
        color("White")
        translate([0,
                   text_hoehe + Banner_Padding * 0.3,
                   Dicke_Basis - Ueberlappung])
        linear_extrude(height=Dicke_Overlay + Ueberlappung)
            overlay_text_2d();

        // Symbol: mittig oben, wie eine Krone
        if (Symbol_Typ > 0) {
            color("White")
            translate([0,
                       text_hoehe + Banner_Padding + Symbol_Groesse * 0.3,
                       Dicke_Basis - Ueberlappung])
            linear_extrude(height=Dicke_Overlay + Ueberlappung)
                symbol_2d();
        }

        bodenplatte();
    }
}


/* =====================================================================
   HAUPTLOGIK: STIL-AUSWAHL
   ===================================================================== */

if (Design_Stil == 1) {
    stil_klassisch();
}
else if (Design_Stil == 2) {
    stil_gerahmt();
}
else if (Design_Stil == 3) {
    stil_unterstrichen();
}
else if (Design_Stil == 4) {
    stil_stehend();
}
else if (Design_Stil == 5) {
    stil_banner();
}
else {
    // Fallback: Klassisch
    echo("WARNUNG: Ungültiger Design_Stil! Verwende Stil 1 (Klassisch).");
    stil_klassisch();
}
