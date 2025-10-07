String checkNumber(int number){
  switch(number){
    case > 0:
      return "The number $number is positive";
    case < 0:
      return "The number $number is negative";
    case 0:
      return "The number is zero ";
    default:
      return "Invalid input";
  }
}
void main() {
  // Call the function with different integers
  print(checkNumber(15));   // positive
  print(checkNumber(-7));   // negative
  print(checkNumber(0));    // zero
}