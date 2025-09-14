
void main() {
  final data = [
    1,
    [2, 3, 4],
    {'a': 5, 'b': ["ab", 7]},
    (first: 8, second: "c"),
    {'c': (first: 10, second: ["xy", 12])},
    "z",
    13.5,
    [14, {'d': 15, 'e': (first: "p", second: 17)}],
  ];

  var total = 0;
  for (final item in data) {
    total += sumNested(item);
  }

  print("Total sum: $total");
}
int sumNested(dynamic obj) {
  switch(obj){
    case int n:
      return n;
    case double d:
      return d.floor();
    case String s:
      return sumASCII(s);
    case List<dynamic> l:
      return sumSpecialList(l);
    case Map<dynamic, dynamic> m:
      var total = 0;
      for (final v in m.values) {
        total += sumNested(v);
      }
      return total;
    case Record r:
      return sumRecord(r);

    default:
      return 0;
  }
}

int sumASCII(String s){
  var total = 0;
  for(final c in s.runes){
    total+=c;
  }
  return total;
}

int sumSpecialList(List<dynamic> l){
  switch(l){
    case []:
      return 0;
    case [var head, ...var tail]:
      return sumNested(head) + sumSpecialList(tail);

    default:
      return 0;
  }
}

int sumRecord(Record r) {
  switch (r) {
    case (var a, var b):
      return sumNested(a) + sumNested(b);

    case (first: var a, second: var b):
      return sumNested(a) + sumNested(b);

    default:
      return 0;
  }
}