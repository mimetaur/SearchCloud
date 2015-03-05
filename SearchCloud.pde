import wordcram.*;

boolean fileChosen = false;
String selectedFile;
String selectedBaseFileName;

void setup() {
  size(1000, 600);
  background(230);
  colorMode(HSB);
  noLoop();
  selectInput("Select a file to process:", "onFileSelected");
}

void onFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    selectedFile = selection.getAbsolutePath();
    String fileName = selection.getName();
    selectedBaseFileName = fileName.substring(0, fileName.lastIndexOf('.'));

    Word[] words = wordsFromCsv();

    new WordCram(this)
      .fromWords(words)
      .withColors(color(30), color(110),
                    color(random(255), 240, 200))
      .sizedByWeight(10, 100)
      .drawAll();
  }
}

Word[] wordsFromCsv() {
  HashMap<String, Word> wordsDict = new HashMap<String, Word>();
  Table table = loadTable(selectedFile, "header");

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

  Word[] words = new Word[wordsDict.size()];
  int i = 0;
  for (Word w : wordsDict.values()) {
    words[i] = w;
    i++;
  }
  println(words);
  return words;
}

void draw() {

}

void endDraw() {
  save(selectedBaseFileName + ".png");
  exit();
}
