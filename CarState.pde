class CarState {
  float[] sensorsData;
  PVector rudderState;
  float Speed; 

  CarState(int sensorsCount) {
    sensorsData = new float[sensorsCount];
  }

  float compare(CarState state) {
    float distance = 0;
    for (int i=0; i<state.sensorsData.length; i++) {
      float diff = state.sensorsData[i] - sensorsData[i];
      distance += diff*diff;
    }
    return sqrt(distance);
  }
}