int size = 500;
float reducedSize = size * 0.9f;
int totalSize = 5 * size;

String testString = "Hal-lo, dies ist ein doo-fer Test-string um zu tes-ten wie gut die Wort-tren-nung funk-tio-niert";

void setup() {
  size(1000, 1000);
  background(230, 210, 240);

  noFill();
  stroke(0);
  strokeWeight(5);
  rect(100, 100, 500, 2000);

  fill(0);
  textSize(70);
  rectMode(CENTER);
  text(formatText(testString), 110, 160);
}

void draw() {
}

String formatText(String in) {
  String ret = "";
  var split = split(in, ' ');
  var first = true;
  var reducedSize = 490;
  for (var word : split) {
    if(textWidth(ret + "XX") >= reducedSize){
      ret += "\n";
      first = true;
    }
    if (!word.contains("-")) {
      if (textWidth(ret + " " + word) >= reducedSize) {
        ret += "\n";
        first = true;
      }
      if (!first)
        ret += " ";
      ret += word;
      first = false;
    } else {
      if(!first)
        ret += " ";
      var firstSyllable = true;
      var syllables = split(word, '-');
      for (var syl : syllables) {
        if (textWidth(ret + syl + '-') >= reducedSize) {
          if(!firstSyllable)
            ret += "-";
          ret += "\n";
          first = true;
        }
        ret += syl;
        firstSyllable = false;
      }
      first = false;
    }
    println(ret + "; " + textWidth(ret));
    println("----------------");
  }
  return ret;
}
