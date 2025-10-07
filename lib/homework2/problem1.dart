void main() {
  List<String> movies = ["Demon Slayer:Ultimate Train", "The Matrix", "Interstellar"];

  List<int> releaseYears = [2025, 1999, 2014];

  for (int i = 0; i < movies.length; i++) {
    print("${movies[i]} - Released in ${releaseYears[i]}");
  }
}