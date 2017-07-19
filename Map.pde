class Map { //<>// //<>//
  ArrayList<Wall> walls;

  Map() {
    walls = new ArrayList<Wall>();
  }

  void draw() {
    for (int i=0; i<walls.size(); i++) {
      stroke(#713636);
      walls.get(i).draw();
    }
  }

  void save(String fileName) {
    String[] data = new String[walls.size()];
    for (int i =0; i<walls.size(); i++) {
      Wall wall = walls.get(i);
      data[i] = wall.start.x + ";" + wall.start.y + ";" + wall.end.x + ";" +wall.end.y;
    }
    saveStrings(fileName, data);
  }

  void load(String fileName) {
    String[] data = loadStrings(fileName);
    walls.clear();
    for (int i =0; i<data.length; i++) {
      float[] wall = float(split(data[i], ';'));
      walls.add(new Wall(wall[0], wall[1], wall[2], wall[3]));
    }
  }
}