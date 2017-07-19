class Sensor {
  PVector rayVector;

  Map Map;
  Car Car;

  Sensor(int maxDistance, float angle, Car car) {
    Map = car.Map;
    Car = car;
    rayVector = PVector.fromAngle(radians(angle));
    rayVector.mult(maxDistance);
  }

  void draw() {
    stroke(220);
    Line ray = getRay();
    ray.draw();
    stroke(0);

    PVector intersectionPoint = Intersection();
    if (intersectionPoint != null) {
      ellipse(intersectionPoint.x, intersectionPoint.y, 6, 6);
      fill(0);
      text((int)intersectionPoint.z, ray.end.x, ray.end.y);
      fill(255);
    }
  }

  float getDistance() {
    PVector intersection = this.Intersection();
    if (intersection != null) {
      return intersection.z;
    }
    return rayVector.mag();
  }

  float getMaxDistance() {
    return rayVector.mag();
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