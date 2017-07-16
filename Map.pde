class Map { //<>// //<>//
  ArrayList<Line> walls;
  MapBuilder mapBuilder;
  
  Map() {
    walls = new ArrayList<Line>();
    mapBuilder = new MapBuilder(this);
  }

  void draw() {
    for (int i=0; i<walls.size(); i++) {
      stroke(#713636);
      walls.get(i).draw();
    }
    
    mapBuilder.process();
  }
}