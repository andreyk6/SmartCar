//Создаем класс Руль, который будет сам управлять машиной
//extends RudderAWSD - копируем (наследуем) все что было в классе RudderAWSD 
class RudderLR extends RudderAWSD {

  //Конструктор класса
  //Передаем в класс машину, которой нужно управлять
  RudderLR(Car car) {
    super(car);
  }

  protected void processRudderMovement() {    
    //Записываем в переменную angle угол, на который мы хотим повернуть руль
    float angle = 0;

    //Получаем левый и правый сенсоры
    Sensor left = car.Sensors.get(1);
    Sensor right = car.Sensors.get(2);
    //Получаем расстояние
    float leftDst = left.getDistance();
    float rightDst = right.getDistance();

    //
    if (rightDst > leftDst) {
      //Поворачиваем руль правее на 1 градус
      angle = 2;

      //Оптимизация, которую можно добавить позже 
      //Делаем это пропорционально разнице расстояний
      //angle = -5*(1-rightDst/leftDst);
    } else {
      //Поворачиваем руль левее на 1 градус
      angle = -2;

      //Оптимизация, которую можно добавить позже 
      //Делаем это пропорционально разнице расстояний
      //angle = 5*(1-leftDst/rightDst);
    }

    //Создаем новое направление руля
    //heading - угол руля сейчас + угол, на который мы меняем
    float newRudderAngle = Rudder.heading() + radians(angle);

    //Записываем новое значение угла руля
    Rudder = PVector.fromAngle(newRudderAngle);

    //*** 
    //Оптимизация, котоую НУЖНО добавить - ограничить повороты руля (машина не будет сходить с ума и застревать в одном месте)
    //***

    if (Rudder.heading() < -PI/1.3)
     Rudder = PVector.fromAngle(-PI/1.3);
    if (Rudder.heading() > PI/1.3)
     Rudder = PVector.fromAngle(PI/1.3);
  }

  //Управляем скоростью
  protected void processSpeedControl() {
    //Получаем центральный сенсор
    Sensor central = car.Sensors.get(0);
    //Получаем расстояние
    float distance = central.getDistance();
    //Получаем максимальное расстояние, которое измеряет сенсор
    float maxDistance = central.getMaxDistance();

    //Считаем скорость, которую мы хотим установить машине
    float targetSpeed = 0;
    //Если меньше трети от максимального расстояния - едем назад
    if (distance<40) {
      targetSpeed = -car.MaxSpeed;
    } else {
      targetSpeed = (car.MaxSpeed/maxDistance)*distance;
    }

    //Немного меняем скорость машины (мы не можем резко это делать - неправдоподобно)
    car.Speed = car.Speed * 0.95 + targetSpeed*.05;
  }
}