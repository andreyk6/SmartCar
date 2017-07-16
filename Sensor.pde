class Sensor {
  PVector rayVector;

  Map Map;
  Car Car;

  Sensor(int maxDistance, float angle, Map map, Car car) {
    Map = map;
    Car = car;
    rayVector = PVector.fromAngle(radians(angle));
    rayVector.mult(maxDistance);
  }

  void draw() {
    stroke(220);
    getRay().draw();
    stroke(0);

    PVector intersectionPoint = Intersection();
    if (intersectionPoint != null) {
      ellipse(intersectionPoint.x, intersectionPoint.y, 6, 6);
      println(intersectionPoint.z);
    }
  }

  Line getRay() {
    float fromX = Car.Position.x;
    float fromY = Car.Position.y;
    PVector normalizedRay = PVector.fromAngle(rayVector.heading()+Car.Direction.heading());
    normalizedRay.mult(rayVector.mag());
    return new Line(fromX, fromY, fromX+normalizedRay.x, fromY+normalizedRay.y);
  }

  PVector Intersection() {
    Line ray = getRay();
    PVector result = null;

    for (int i=0; i<map.walls.size(); i++) {
      Line line = map.walls.get(i);
      PVector intersectionPoint =  ray.Intersect(line);

      if (intersectionPoint == null) 
      continue;

      if (result == null) {
        result = intersectionPoint;
      } else if (PVector.dist(ray.start, intersectionPoint) < PVector.dist(ray.start, result)) {
        result = intersectionPoint;
      }
    }

    if (result!=null) {
      result.z = PVector.dist(ray.start, result);
    }
    return result;
  }
}