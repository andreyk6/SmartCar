class Car {
  int Size;
  PVector Direction;
  PVector Position;
  float Speed, MaxSpeed;

  public Car(int size, int x, int y, float maxSpeed) {
    Size = size;
    Position = new PVector(x, y);
    MaxSpeed = maxSpeed;
    Direction = PVector.fromAngle(radians(0));
  }

  public void draw() {
    //Update speed and dirrection
    processRudderMovement();

    //Update car position
    Position.add(Direction.x*Speed, Direction.y*Speed);

    //Draw car
    stroke(0, 0, 0);
    ellipse(Position.x, Position.y, Size, Size);
    if (Speed<0) {
      stroke(200, 0, 0);
    }
    line(Position.x, Position.y, Position.x+Direction.x*Speed*10, Position.y+Direction.y*Speed*10);
  }

  private void processRudderMovement() {
    if (keyPressed) {
      //Update angle
      float angle = 0;
      if ( key == 'a') {
        angle = -1;
      }
      if ( key == 'd') {
        angle = 1;
      }
      Direction = PVector.fromAngle(Direction.heading() + radians(angle));

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
}