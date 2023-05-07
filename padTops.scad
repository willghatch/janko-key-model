include <key-base.scad>;

function latinToBraille_upperSix(a) =
    // IE using the upper six braille dots, which I think is the normal thing to do.
    a == "A" ? "\u2801" :
    a == "B" ? "\u2803" :
    a == "C" ? "\u2809" :
    a == "D" ? "\u2819" :
    a == "E" ? "\u2811" :
    a == "F" ? "\u280B" :
    a == "G" ? "\u281B" :
    "?";

function latinToBraille_lowerSix(a) =
    // IE using the lower six braille dots, which I think is the weird thing to do.
    a == "A" ? "\u2802" :
    a == "B" ? "\u2806" :
    a == "C" ? "\u2812" :
    a == "D" ? "\u2832" :
    a == "E" ? "\u2822" :
    a == "F" ? "\u2816" :
    a == "G" ? "\u2836" :
    "?";

module padTop_braille(s, s2=""){
    padTop_text(s=latinToBraille_lowerSix(s), s2=s2, fontSize=7, offset=[7.25,4,0], offset2=[6.75,7,0], font="DejaVu Sans");
}



module padTopSet() {
    translate([(padX + 5) * 0 ,0,0])padTop_braille(s="A", s2="");
    translate([(padX + 5) * 1 ,0,0])padTop_braille(s="A", s2="^");
    translate([(padX + 5) * 2 ,0,0])padTop_braille(s="B", s2="");
    translate([(padX + 5) * 3 ,0,0])padTop_braille(s="C", s2="");
    translate([(padX + 5) * 4 ,0,0])padTop_braille(s="C", s2="^");
    translate([(padX + 5) * 5 ,0,0])padTop_braille(s="D", s2="");
    translate([(padX + 5) * 6 ,0,0])padTop_braille(s="D", s2="^");
    translate([(padX + 5) * 7 ,0,0])padTop_braille(s="E", s2="");
    translate([(padX + 5) * 8 ,0,0])padTop_braille(s="F", s2="");
    translate([(padX + 5) * 9 ,0,0])padTop_braille(s="F", s2="^");
    translate([(padX + 5) * 10 ,0,0])padTop_braille(s="G", s2="");
    translate([(padX + 5) * 11 ,0,0])padTop_braille(s="G", s2="^");

}


padTopSet();
