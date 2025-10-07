import 'dart:io';

void main(){
  stdout.write("Enter your name: ");
  String? name  = stdin.readLineSync();

  stdout.write("Enter your age: ");
  String? ageInput  = stdin.readLineSync();
  int age = int.parse(ageInput!);

  switch(age){
    case < 18:
      print("You are a teenager.");
      break;
    case >= 18 && < 60:
      print("You are an adult.");
      break;
    case >= 60:
      print("Granny or daddy");
      break;
    default:
      print("Invalid age input.");
  }
}