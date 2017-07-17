class Wall extends Line {
  Wall() {
    super(0, 0, 0, 0);
  }

  Wall(float x1, float y1, float x2, float y2) {
    super(x1, y1, x2, y2);
  }

  Wall(PVector a, PVector b) {
    super(a, b);
  }

  public void draw() {
    strokeWeight(7);
    line(start.x, start.y, end.x, end.y);
    strokeWeight(2);
  }

  public Wall copy() {
    return new Wall(start.x, start.y, end.x, end.y);
  }
}