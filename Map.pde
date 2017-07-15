class Map { //<>// //<>//
  ArrayList<Line> walls;
  MapBuilder mapBuilder;
  
  Map() {
    walls = new ArrayList<Line>();
    mapBuilder = new MapBuilder(this);
  }

  void draw() {
    for (int i=0; i<walls.size(); i++) {
      walls.get(i).draw();
    }
    
    mapBuilder.process();
  }
}