class WordCluster {
  int numSearches;
  String theme;

  WordCluster() {
    numSearches = 0;
  }

  String toString() {
    return theme + " : " + numSearches;
  }
}
