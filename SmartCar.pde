IntersectionDemo intersectionDemo;
Map map;

void setup() {
  size(600, 600);
  intersectionDemo = new IntersectionDemo(10);
  map = new Map();
}
void draw() {
  background(255);
  map.draw();
  //intersectionDemo.draw();
}