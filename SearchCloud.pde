import wordcram.*;

Table table;
HashMap<String, Cluster> words;

void setup() {
  size(1000, 600);
  background(230);
  colorMode(HSB);
  noLoop();
  table = loadTable("assets/searches.csv", "header");
  words = new HashMap<String, Cluster>();
}

void draw() {
  for (TableRow row : table.rows()) {
    int numSearches = row.getInt("num_searches");
    String theme = row.getString("cluster_theme");
    String keyword = row.getString("keyword");

    Cluster cluster = new Cluster();
    if (words.get(theme) == null) {
      cluster.numSearches = numSearches;
      cluster.theme = theme;
    } else {
      cluster = words.get(theme);
    }
    words.put(theme, cluster);
  }

  for (Cluster c : words.values()) {
    println(c);
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
