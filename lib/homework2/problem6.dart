void divideNumbers(int a,int b){
  try{
    if(b==0){
      throw Exception("Division by zero is not allowed.");
    }
    double result = a/b;
    print("Result $result");
  }catch(e){
    print("Error: $e");
  }
}
void main() {
  divideNumbers(10, 2);   // Valid division
  divideNumbers(8, 0);    // Division by zero
  divideNumbers(15, 3);   // Valid division
}