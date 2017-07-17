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
  }

  void load(String fileName) {
  }
}