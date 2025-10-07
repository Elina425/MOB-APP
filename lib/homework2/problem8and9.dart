class Person{
  String _name;
  int _age;

  Person(this._name, this._age);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'Person{_name: $_name, _age: $_age}';
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

}

class OtherPerson extends Person{
  OtherPerson(String name, int age):super(name, age);
  String lifeStage() {
    if (age < 13) {
      return "Child";
    } else if (age < 20) {
      return "Teenager";
    } else if (age < 65) {
      return "Adult";
    } else {
      return "Senior";
    }
  }
}
void main() {
  var person1 = Person('Elina', 21);

  print('Name: ${person1.name}');
  print('Age: ${person1.age}');

  //problem 9
  var p1 = OtherPerson(person1._name, person1._age);
  var p2 = OtherPerson("Bob", 16);
  var p3 = OtherPerson("Anna", 30);
  var p4 = OtherPerson("Diana", 70);

  print("${p1.name} is a ${p1.lifeStage()}");
  print("${p2.name} is a ${p2.lifeStage()}");
  print("${p3.name} is a ${p3.lifeStage()}");
  print("${p4.name} is a ${p4.lifeStage()}");
}