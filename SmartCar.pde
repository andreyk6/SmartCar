IntersectionDemo intersectionDemo;
Map map;
Car car;

void setup() {
  size(600, 600);
  intersectionDemo = new IntersectionDemo(10);
  map = new Map();
  car = new Car(30, width/2, height/2, 10);
}
void draw() {
  background(255);
  map.draw();
  car.draw();
  //intersectionDemo.draw();
}