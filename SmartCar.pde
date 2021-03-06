Map map;

//Пока не создавайте MapBuilder - добавите его в ходе работы
MapBuilder mapBuilder;

//Пока не создавайте Car - добавите его в ходе работы
Car car;


void setup() {
  size(800, 800);
  //В основе всего лежит карта.
  map = new Map();

  //У карты есть метод draw() - он рисует все обекты, которые есть на карте; 
  //Его вызов нужно добавить в наш цикл draw 
  map.draw();

  //С пустой картой не интересно - туда можно добавлять стены

  //Можно создать стену по двум координатам
  Wall wall1 = new Wall(0, 10, 800, 10);
  //Можно узнать координаты прошлой стены и создать точно такую же, но ниже
  Wall wall2 = new Wall(wall1.start.x, 700, wall1.end.x, 700);
  Wall wall3 = new Wall(0, 0, 0, 800);
  Wall wall4 = new Wall(800, 0, 800, 800);
  //!!!Запускаем, проверяем!!!
  //Не работает - мы не добавили их на карту

  //Добавляем на карту
  map.walls.add(wall1);
  map.walls.add(wall2);
  map.walls.add(wall3);
  map.walls.add(wall4);
  //!!!Запускаем, проверяем!!!


  //Автоматизируем этот процесс используя циклы (расказать про них) 
  //Создаем вертикальные стены в цикле
  for (int x=100; x<600; x+=70) {
    Wall wallA = new Wall(x, 100, x, 300);
    Wall wallB = new Wall(x, 400, x, 600);
    map.walls.add(wallA);
    map.walls.add(wallB);
  }
  //!!!Запускаем, проверяем!!!


  //Создаем горизонтальных стены
  for (int x=100; x<600; x+=140) {
    Wall wallA = new Wall(x, 100, x+70, 100);
    Wall wallB = new Wall(x, 300, x+70, 300);
    Wall wallC = new Wall(x, 400, x+70, 400);
    Wall wallD = new Wall(x, 600, x+70, 600);
    map.walls.add(wallA);
    map.walls.add(wallB);
    map.walls.add(wallC);
    map.walls.add(wallD);
  }
  //!!!Запускаем, проверяем!!!

  //----------Map builder---------------//
  //Через код не всегда удобно рисовать карты и можно воспользоваться MapBuilder позволяет рисовать карты мышкой

  //Создаем его и помещаем в него карту, в которую он будет добавлять новые стены
  mapBuilder = new MapBuilder(map);
  //Для работы MapBuilder необходимо добавить метод process в наш void draw()
  mapBuilder.process();

  //***Правила работы:***
  //   - Мышкой рисуем стены
  //   - Если начинать или заканчивать рисовать стену возле начала/конца другой стены, то начало/конец притягивается
  //   - Shift+Z - отменить
  //!!!Запускаем, проверяем!!!

  //Сохраняем карту 
  //map.save("track1.map"); - добавляем в метод keyPressed()
  //!!!Запускаем, нажимаем "k" - проверяем!!!

  //Открываем файл в текстовом редакторе и читаем)
  //добавляем map.load в метод keyPressed()
  //!!!Запускаем, нажимаем "l" -  проверяем!!!

  //----------Car---------------//
  //Создаем машину (размер, начальный X, начальный Y, максимальная скорость, карта)
  car  = new Car(20, 70, 70, 5, map);

  //для работы машины необходимо добавить car.draw() в void draw()
  //!!!Запускаем, проверяем!!!

  //***Правила работы:***
  //   - w - увиличивает скорость
  //   - s - уменьшает скорость
  //   - a - руль влево
  //   - d - руль вправо
  //   - руль возвращается в начальное положение после поворота
  //   - Если начинать или заканчивать рисовать стену возле начала/конца другой стены, то концы притягивается
  //   - Shift+Z - отменить
  //!!!Запускаем, проверяем!!!

  //----------Sensor---------------//
  //Создаем сенсор (максимальное расстояние, угол, машина)
  Sensor sensor = new Sensor(300, 0, car);
  //Устанавливаем сенсор в машину
  car.Sensors.add(sensor);
  //!!!Запускаем, проверяем!!!

  //Добавляем еще 2 сенсора
  car.Sensors.add(new Sensor(300, -45, car));
  car.Sensors.add(new Sensor(300, 45, car));
  //!!!Запускаем, проверяем!!!

  //Работаем над своей трассой... сохраняем ее и завтра приступаем к обучению машины
  
  
  //--День 2---
  //1. Создаем свой руль в файле RudderLR (left-right)
  //2. Устанавливаем новый руль машине
  car.rudder = new RudderLR(car);
}

void keyPressed() {
  //
  if (key == 'k')
    map.save("track1.map");
  if (key == 'l')
    map.load("track1.map");
}

void draw() {
  background(255);
  map.draw();
  //Пока не пишите mapBuilder.process() - добавите его в ходе работы
  mapBuilder.process();
  //Пока не пишите car.draw() - добавите его в ходе работы
  car.draw();
}