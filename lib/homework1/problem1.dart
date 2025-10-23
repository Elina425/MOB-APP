void main() {
  // Testing with provided cases
  print(numberToWords(0)); // zero
  print(numberToWords(6)); // six
  print(numberToWords(42)); // forty two
  print(numberToWords(123)); // one hundred twenty three
  print(numberToWords(900)); // nine hundred
  print(numberToWords(8379)); // eight thousand three hundred seventy nine
  print(numberToWords(1000001));
  print(numberToWords(1234567)); // one million two hundred thirty four thousand five hundred sixty seven
  print(numberToWords(1000000)); // one million
  print(numberToWords(999999999)); // nine hundred ninety nine million nine hundred ninety nine thousand nine hundred ninety nine
}

String numberToWords(int number) {
  if (number == 0) return "zero";

  String result = "";

  int millions = number ~/ 1000000;
  int thousands = (number % 1000000) ~/ 1000;
  int remainder = number % 1000;

  if (millions > 0) {
    result += convertHundreds(millions) + " million";
  }

  if (thousands > 0) {
    if (result.isNotEmpty) result += " ";
    result += convertHundreds(thousands) + " thousand";
  }

  if (remainder > 0) {
    if (result.isNotEmpty) result += " ";
    result += convertHundreds(remainder);
  }

  return result;
}

String convertHundreds(int num) {
  String result = "";
  int hundreds = num ~/ 100;
  int remainder = num % 100;

  if (hundreds > 0) {
    result += units[hundreds] + " hundred";
    if (remainder > 0) result += " ";
  }

  if (remainder > 0) {
    result += convertTens(remainder);
  }

  return result;
}

String convertTens(int num) {
  if (num < 20) {
    return units[num];
  } else {
    int tensPlace = num ~/ 10;
    int unitsPlace = num % 10;
    String result = tens[tensPlace];
    if (unitsPlace > 0) {
      result += " " + units[unitsPlace];
    }
    return result;
  }
}

final List<String> units = [
  "",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
  "ten",
  "eleven",
  "twelve",
  "thirteen",
  "fourteen",
  "fifteen",
  "sixteen",
  "seventeen",
  "eighteen",
  "nineteen"
];

final List<String> tens = [
  "",
  "",
  "twenty",
  "thirty",
  "forty",
  "fifty",
  "sixty",
  "seventy",
  "eighty",
  "ninety"
];
