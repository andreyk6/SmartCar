class IntersectionDemo {
  Line mouseLine;
  ArrayList<Line> lines;

  IntersectionDemo(int linesCount) {
    //Init mouse line
    mouseLine = new Line();

    //Init lines
    lines = new ArrayList<Line>();
    for (int i=0; i<linesCount; i++) {
      Line randomLine = new Line(random(0, width), random(0, height), random(0, width), random(0, height));
      lines.add(randomLine);
    }
  }

  public void draw() {
    updateMouseLine();
    mouseLine.draw();

    for (int i=0; i<lines.size(); i++) {
      Line line = lines.get(i);
      line.draw();
      PVector intersectionPoint =  mouseLine.Intersect(line);
      if (intersectionPoint != null) {
        ellipse(intersectionPoint.x, intersectionPoint.y, 6, 6);
      }
    }
  }

  void updateMouseLine() {
    mouseLine.start.x= width/2;
    mouseLine.start.y=height/2;
    mouseLine.end.x=mouseX;
    mouseLine.end.y=mouseY;
  }
}