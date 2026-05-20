mixin M{
  void showSomething(){
    print("Hello...");
  }
}

class B{
  String name = "John";
  void displayInformation(){
    print("Name: $name");
  }
}

class C extends B with M{
@override
void displayInformation() {
  showSomething();
  }}

void main(){

}