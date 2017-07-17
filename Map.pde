class Map { //<>// //<>//
  ArrayList<Line> walls;

  Map() {
    walls = new ArrayList<Line>();
  }

  void draw() {
    for (int i=0; i<walls.size(); i++) {
      stroke(#713636);
      walls.get(i).draw();
    }
  }
}