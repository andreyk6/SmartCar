IntersectionDemo intersectionDemo;

void setup() {
  size(600, 600);
  intersectionDemo = new IntersectionDemo(10);
}
void draw() {
  background(255);
  intersectionDemo.draw();
}