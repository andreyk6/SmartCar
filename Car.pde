class Car {
  int Size;
  PVector Direction;
  PVector Position;
  PVector Rudder;
  float Speed, MaxSpeed;
  Map Map;

  ArrayList<Sensor> Sensors =new ArrayList<Sensor>();

  public Car(int size, int x, int y, float maxSpeed, Map map) {
    Map = map;
    Size = size;
    Position = new PVector(x, y);
    MaxSpeed = maxSpeed;
    Direction = PVector.fromAngle(radians(0));
    Rudder = PVector.fromAngle(radians(0));
  }

  public void draw() {
    //Update speed and dirrection
    processRudderMovement();
    processSpeedControl();

    //Update direction according to the rudder angle
    //but don't change it fast (division by 70)
    Direction = PVector.fromAngle(Direction.heading() + Rudder.heading()/70);
    //Update car position
    Position.add(Direction.x*Speed, Direction.y*Speed);

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

    //Draw Rudder
    ellipse(width/2, height-100, 30, 30);
    PVector rudderNormalized = PVector.fromAngle(Rudder.heading() - radians(90));
    line(width/2, height-100, width/2 + rudderNormalized.x*15, height-100+rudderNormalized.y*15);
  }

  private void processRudderMovement() {    
    if (keyPressed) {
      //Update angle
      float angle = 0;
      if ( key == 'a') {
        angle = -2;
      } else if ( key == 'd') {
        angle = 2;
      } else {
        normalizeRudder();
      }
      Rudder = PVector.fromAngle(Rudder.heading() + radians(angle));
      if (Rudder.heading() < -PI/1.3)
        Rudder = PVector.fromAngle(-PI/1.3);
      if (Rudder.heading() > PI/1.3)
        Rudder = PVector.fromAngle(PI/1.3);
    } else {
      normalizeRudder();
    }
  }

  void processSpeedControl() {
    if (keyPressed) {
      //Update speed
      float speedInc = 0;
      if ( key == 'w') {
        speedInc = 0.1;
      }
      if ( key == 's') {
        speedInc = -0.1;
      }

      Speed += speedInc;
      if (Speed > MaxSpeed) Speed = MaxSpeed;
      if (Speed < -MaxSpeed) Speed = -MaxSpeed;
    }
  }

  void normalizeRudder() {
    if (Rudder.heading() < radians(0))
      Rudder = PVector.fromAngle(Rudder.heading() + radians(5));
    if (Rudder.heading() > radians(0))
      Rudder = PVector.fromAngle(Rudder.heading() - radians(5));
  }
}