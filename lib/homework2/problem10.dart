void main(){
  List<int> numbers = [1,2,10,3,4,5,4];
  List<int> evenNumbers = numbers.where((n) => n%2 == 0).toList();

  print("Even numbers: $evenNumbers");
}