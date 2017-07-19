class Car {
  int Size;
  PVector Direction;
  PVector Position;
  PVector DefaultPosition;
  float Speed, MaxSpeed;
  IRudder rudder;
  Map Map;

  ArrayList<Sensor> Sensors =new ArrayList<Sensor>();

  public Car(int size, int x, int y, float maxSpeed, Map map) {
    Map = map;
    Size = size;
    Position = new PVector(x, y);
    DefaultPosition = new PVector(x, y);
    MaxSpeed = maxSpeed;
    Direction = PVector.fromAngle(radians(0));
    rudder = new RudderAWSD(this);
  }

  public void draw() {
    //Check walls around
    checkWallsIntersection();

    rudder.process();

    //Draw sensors
    for (int i=0; i<Sensors.size(); i++) {
      Sensors.get(i).draw();
    }

    //Draw car
    stroke(0, 0, 0);
    ellipse(Position.x, Position.y, Size, Size);
    if (Speed<0) {
      stroke(200, 0, 0);
    }
    line(Position.x, Position.y, Position.x+Direction.x*Speed*10, Position.y+Direction.y*Speed*10);
  }

  private void checkWallsIntersection() {
    for (int i=0; i<map.walls.size(); i++) {
      Wall wall = map.walls.get(i);
      PVector distance = wall.getDistance(Position.x, Position.y);
      if (distance.z  <= Size/2) {
        Position = DefaultPosition.copy();
        return;
      }
    }
  }
}