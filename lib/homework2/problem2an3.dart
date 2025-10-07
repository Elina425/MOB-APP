void main() {
  //problem2
  String firstName = "Elina";
  String lastName = "Melkonyan";

  String fullName = firstName + " " + lastName;

  String shortName = firstName.substring(0, 4);

  String upperCaseName = fullName.toUpperCase();
  String lowerCaseName = fullName.toLowerCase();

  print("Full Name: $fullName");
  print("Short Name: $shortName");
  print("Upper Case: $upperCaseName");
  print("Lower Case: $lowerCaseName");

  //problem3
  Map<String, String> capitals = {
    'Armenia': 'Yerevan',
    'France': 'Paris',
    'Germany': 'Berlin',
    'Italy': 'Rome'
  };

  capitals.forEach((key, value) {
    print('Country: $key, Capital: $value');
  });
}