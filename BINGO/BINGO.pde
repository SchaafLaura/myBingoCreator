int size = 500;
float reducedSize = size * 0.9f;
int totalSize = 5 * size;

String filePath = "text.txt";

PImage freeSpotImage;
ArrayList<PImage> images;

float m = 10.0f;
PGraphics canvas;

void setup() {
  size(500, 500);
  freeSpotImage  = loadImage("free_square.png");
  makeSingles();
  makeBingos();
  exit();
}

void makeBingos() {
  canvas = createGraphics((int)(5 * width + 6 * m), (int)(5 * width + 6 * m));
  images = new ArrayList<PImage>();
  for (int i = 0; i < 47; i++) {
    images.add(loadImage("./singles/" + i + ".png"));
  }

  println("loaded all images");
  for (int i = 0; i < 500; i++) {
    makeBingo(getShuffledIndecies(images.size()));
    println("saved bingo " + i);
    canvas.save("./bingos/"+i+".png");
  }
}

int[] getShuffledIndecies(int n) {
  int[] ret = new int[n];
  for (int i = 0; i < n; i++)
    ret[i] = i;

  for (int i = 0; i < n; i++) {
    var i0 = (int) random(0, n);
    var i1 = (int) random(0, n);
    var tmp = ret[i0];
    ret[i0] = ret[i1];
    ret[i1] = tmp;
  }

  return ret;
}

void makeBingo(int[] indecies) {
  canvas.beginDraw();
  canvas.background(0);

  int k = 0;
  for (int i = 0; i < 25; i++) {
    var xi = k % 5;
    var yi = k / 5;
    if (xi == 2 && yi == 2) {
      k++;
      continue;
    }
    var x = (xi+1)*m + xi * width;
    var y = (yi+1)*m + yi * width;
    canvas.image(images.get(indecies[k++]), x, y);
  }

  canvas.image(freeSpotImage, 3*m+2*width, 3*m+2*height);
  canvas.endDraw();
}

void makeSingles() {
  stroke(0);
  strokeWeight(5);
  fill(0);
  textSize(90);
  rectMode(CENTER);
  var lines = loadStrings(filePath);
  for (int i = 0; i < lines.length; i++) {
    background(255, 255, 255);
    text(formatText(lines[i]), 20, 100);
    saveFrame("./singles/"+i+".png");
  }
}

void draw() {
}

String formatText(String in) {
  String ret = "";
  var split = split(in, ' ');
  var first = true;
  //var reducedSize = 490;
  var reducedSize = 475;
  for (var word : split) {
    if (textWidth(ret + "XX") >= reducedSize) {
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
      if (!first)
        ret += " ";
      var firstSyllable = true;
      var syllables = split(word, '-');
      for (var syl : syllables) {
        if (textWidth(ret + syl + '-') >= reducedSize) {
          if (!firstSyllable)
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
