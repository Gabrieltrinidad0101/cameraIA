class ArrayToString {
  String arrayToString(List array) {
    String elements = " ";
    array.forEach((element) => elements += "$element ");
    return elements;
  }
}
