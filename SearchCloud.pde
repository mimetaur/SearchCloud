import wordcram.*;

Table table;
HashMap<String, Word> wordsDict;

void setup() {
  size(1000, 600);
  background(230);
  colorMode(HSB);
  noLoop();
  table = loadTable("assets/searches.csv", "header");
  wordsDict = new HashMap<String, Word>();
}

void pullWordClustersFromCsv() {
  for (TableRow row : table.rows()) {
    int numSearches = row.getInt("num_searches");
    String theme = row.getString("cluster_theme");
    String keyword = row.getString("keyword");

    Word word;
    if (wordsDict.get(theme) == null) {
      word = new Word(theme, numSearches);
    } else {
      word = wordsDict.get(theme);
      word.weight += numSearches;
    }
    wordsDict.put(theme, word);
  }
}

void draw() {
  pullWordClustersFromCsv();
  for (Word wc : wordsDict.values()) {
    println(wc);
  }

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
