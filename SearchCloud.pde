import wordcram.*;

Table table;
HashMap<String, WordCluster> wordClusters;

void setup() {
  size(1000, 600);
  background(230);
  colorMode(HSB);
  noLoop();
  table = loadTable("assets/searches.csv", "header");
  wordClusters = new HashMap<String, WordCluster>();
}

void pullWordClustersFromCsv() {
  for (TableRow row : table.rows()) {
    int numSearches = row.getInt("num_searches");
    String theme = row.getString("cluster_theme");
    String keyword = row.getString("keyword");

    WordCluster wordCluster = new WordCluster();
    if (wordClusters.get(theme) == null) {
      wordCluster.theme = theme;
      wordCluster.numSearches = numSearches;
    } else {
      wordCluster = wordClusters.get(theme);
      wordCluster.numSearches += numSearches;
    }
    wordClusters.put(theme, wordCluster);
  }
}

void draw() {
  pullWordClustersFromCsv();
  for (WordCluster wc : wordClusters.values()) {
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
