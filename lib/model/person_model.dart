class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'name': name,
  //     'age': age,
  //   };
  // }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] as String,
      age: json['age'] as int,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Person.fromJson(String source) =>
  //     Person.fromMap(json.decode(source) as Map<String, dynamic>);
}
