class Person {
  final String name;
  const Person(this.name);
}

void main(List<String> args) {
  const p1 = Person('1');
  const p2 = Person('1');

  const isSame = identical(p1, p2);
  print('is:$isSame');
}

void test(Function foo) {
  foo();
}

void test2() {
  print('22');
}
