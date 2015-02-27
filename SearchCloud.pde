import wordcram.*;

void setup() {
  size(1000, 600);
  background(230);
  colorMode(HSB);
  noLoop();
}

void draw() {
  // pulled this from the wordcram docs as example
  new WordCram(this)
    .fromWebPage("http://en.wikipedia.org/wiki/Special:Random")
    .withColors(color(30), color(110),
                color(random(255), 240, 200))
    .sizedByWeight(5, 120)
    .drawAll();
}

void endDraw() {
  save(new File(sketchPath("")).getName() + ".png");
  exit();
}
