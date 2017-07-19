interface IRudder {
  PVector Rudder = new PVector();
  void process();
}

class RudderAWSD implements IRudder {
  PVector Rudder;
  Car car;

  RudderAWSD(Car car) {
    Rudder = PVector.fromAngle(radians(0));
    this.car = car;
  }

  void process() {
    //Update speed and dirrection
    processRudderMovement();
    processSpeedControl();

    //Update direction according to the rudder angle
    //but don't change it fast (division by 70)
    car.Direction = PVector.fromAngle(car.Direction.heading() + Rudder.heading()/70);
    //Update car position
    car.Position.add(car.Direction.x*car.Speed, car.Direction.y*car.Speed);

    //Draw
    this.draw();
  }

  protected void processRudderMovement() {    
    if (keyPressed) {
      //Update angle
      float angle = 0;
      if ( key == 'a') {
        angle = -4;
      } else if ( key == 'd') {
        angle = 4;
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

  protected void processSpeedControl() {
    if (keyPressed) {
      //Update speed
      float speedInc = 0;
      if ( key == 'w') {
        speedInc = 0.1;
      }
      if ( key == 's') {
        speedInc = -0.1;
      }

      car.Speed += speedInc;
      if (car.Speed > car.MaxSpeed) car.Speed = car.MaxSpeed;
      if (car.Speed < -car.MaxSpeed) car.Speed = -car.MaxSpeed;
    }
  }

  protected void normalizeRudder() {
    if (Rudder.heading() < radians(0))
      Rudder = PVector.fromAngle(Rudder.heading() + radians(5));
    if (Rudder.heading() > radians(0))
      Rudder = PVector.fromAngle(Rudder.heading() - radians(5));

    if (Rudder.heading() > radians(0) && Rudder.heading() < radians(5))
      Rudder = PVector.fromAngle(radians(0));
    if (Rudder.heading() < radians(0) && Rudder.heading() > radians(-5))
      Rudder = PVector.fromAngle(radians(0));
  }

  protected void draw() {
    //Draw Rudder
    ellipse(width/2, height-100, 30, 30);
    PVector rudderNormalized = PVector.fromAngle(Rudder.heading() - radians(90));
    line(width/2, height-100, width/2 + rudderNormalized.x*15, height-100+rudderNormalized.y*15);
  }
}

class RudderKNN implements IRudder {
  Car car;
  PVector Rudder;
  private ArrayList<CarState> data;

  //0 - learning
  //1 - self driving
  private int state = 0;

  RudderAWSD rudderLearning;

  RudderKNN(Car car) {
    data = new ArrayList<CarState>();
    this.car = car;
    rudderLearning = new RudderAWSD(car);
  }

  CarState getCarState() {
    CarState state  = new CarState(car.Sensors.size());
    for (int i=0; i<car.Sensors.size(); i++) {
      PVector sensorIntersection = car.Sensors.get(i).Intersection();
      if (sensorIntersection != null) {
        state.sensorsData[i]=sensorIntersection.z;
      }
    }
    state.rudderState = Rudder.copy();
    state.Speed = car.Speed;
    return state;
  }

  void process() {
    processKeyPressed();
    if (state == 0) {
      rudderLearning.process();
      this.Rudder = rudderLearning.Rudder;
      data.add(getCarState());
      println(data.size());
    }
    if (state == 1) {
      CarState currentState = getCarState();
      CarState targetState = data.get(0);
      float targetDistance = currentState.compare(targetState);
      for (int i=0; i<data.size(); i++) {
        CarState stateI = data.get(i);
        float dstI = currentState.compare(stateI);
        if (targetDistance>dstI) {
          targetState = stateI;
          targetDistance = dstI;
        }
      }
      car.Speed = targetState.Speed;
      car.Direction = PVector.fromAngle(car.Direction.heading() + targetState.rudderState.heading()/70);
      //Update car position
      car.Position.add(car.Direction.x*car.Speed, car.Direction.y*car.Speed);
    }
  }

  private void processKeyPressed() {
    if (keyPressed && key == 'r') {
      state ++;
      if (state > 1) {
        state=0;
      }
    }
  }
}