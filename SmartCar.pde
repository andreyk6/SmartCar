IntersectionDemo intersectionDemo;
Map map;
Car car;

void setup() {
  size(800, 800);

  //Init map (with MapBuilder inside)
  map = new Map();

  //Create car and pass map (for objects detection)
  car = new Car(10, width/2, height/2, 10, map);

  //Init sensors
  for (int angle=-90; angle<=90; angle+=10) {
    car.Sensors.add(new Sensor(200, angle, car));
  };
}

void draw() {
  background(255);
  map.draw();
  car.draw();
}