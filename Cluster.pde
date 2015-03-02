class Cluster {
  int numSearches;
  String theme;

  Cluster() {
    numSearches = 0;
  }

  String toString() {
    return theme + " : " + numSearches;
  }
}
