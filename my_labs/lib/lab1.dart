// void main(){
//   print("___Exercise 1___");
//   ex1();
//   print("___Exercise 2___");
//   ex2();
//   print("___Exercise 3___");
//   ex3();
//   print("___Exercise 4___");
//   ex4();
//   print("___Exercise 5___");
//   ex5();
// }

// void main(){
//   int age = 21;
//   double gpa = 3.5;
//   String name = "Nguyen Vy Anh";
//   bool isStudent = true;

//   print("Name: $name");
//   print("Age: $age");
//   print("GPA: $gpa");
//   print("Year of birth: ${2026 - age}");
// }

// void main(){
//   print("1. Arithmetic and comparisiom operators:");
//   int a = 12;
//   int b = 34;
//   print("a + b = ${a+b}");
//   print("a = b true or false: ${a==b}");
//   print("a < b and b > 0 true or false: ${a<b && b>0}");
//   String result = a>b? "a is large than b" : "b is larger than a";
//   print(result);

//   print("2. Set");
//   Set<String> fruits = {"Apple", "Orange", "Banana", "Water Melon", "Orange"};
//   print("Fruits: $fruits");

//   print("3. Map");
//   Map<String, int> score = {"Math" : 9, "English" : 9, "Physics" : 9};
//   print("Math: ${score["Math"]}");

//   print("4. List");
//   List<int> numbers = [1,2,3];
//   numbers.add(4);
//   numbers.remove(2);
//   print("List of numbers: $numbers");
// }

// void main(){
//  String name = "Vy Anh";
//  double score = 8.5;
//  String day = "Monday";

//  List<String> subj = ["Math", "English", "Literature"];

//  if (score >= 5){
//   print("$name passed the exam.");
//  }
//  else{
//   print("$name failed the exam.");
//  }
// // 2. switch case: Display study schedule
//  switch (day){
//   case "Monday":
//     print("Today is Math class.");
//     break;
//   case "Tuesday":
//     print("Today is English class.");
//     break;
//   case "Wed":
//     print("Today is Physics class.");
//     break;
//   default:
//     print("No class today.");
//  }
//  print("Using for loop: ");
//  for(int i=0; i<subj.length;i++){
//   print("Subject ${i+1}: ${subj[i]}");
//  }
//   print("\nUsing for-in loop:");
//   for (var subject in subj) {
//     print(subject);
//   }
//   print("\nUsing forEach:");
//   subj.forEach((subject) {
//     print(subject.toUpperCase());
//   });
//   double total = calculateTotal(score, 5);
//   print("\nTotal score: $total");
//   double bonus = addBonus(score);
//   print("Score after bonus: $bonus");
// }
// double calculateTotal(double score, double bonus) {
//   return score + bonus;
// }
// double addBonus(double score) => score + 1;

// class Car{
//   String brand;
//   Car(this.brand);
//   Car.toyota(): brand = "Toyota";
//   void displayInfo(){
//     print("Car brand: $brand");
//   }
// }

// class ElectricCar extends Car {
//   int batteryLevel;
//   ElectricCar(String brand, this.batteryLevel) : super(brand);
//   @override
//   void displayInfo() {
//     print("Electric car brand: $brand");
//     print("Battery level: $batteryLevel");
//   }
// }
// void main(){
// Car car1 = Car("BMW");
// Car car2 = Car.toyota();
// ElectricCar testa = ElectricCar("Tesla", 90);
// print("1. Normal car");
// car1.displayInfo();
// print("2. Name Constructor Car");
// car2.displayInfo();
// print("3. Electric Car");
// testa.displayInfo();

// }

Future<void> loadData() async{
  print("Loading data...");
  await Future.delayed(Duration(seconds: 5));
  print("Data loaded successfully!");
}

Stream<int> countStream() async*{
  for(int i=0; i<=4;i++){
    await Future.delayed(Duration(seconds: 2));
    yield i;
  }
}

void main() async{
  print("-Async & Future-");
  await loadData();

  print("-Null Safety-");
  String? name;
  print(name ?? "No name available");
  name = "Vy Anh";
  print(name!);

  print("-Stream Example-");
  countStream().listen((value) { 
      print("Stream value: $value");  });
}