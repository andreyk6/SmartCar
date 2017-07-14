class Line {
  public PVector start = new PVector();
  public PVector end = new PVector();

  Line() {
    this(0, 0, 0, 0);
  }

  Line(float x1, float y1, float x2, float y2) {
    this(new PVector(x1, y1), new PVector(x2, y2));
  }

  Line(PVector a, PVector b) {
    start = a;
    end = b;
  }

  public PVector Intersect(Line b) {
    return LineHelper.Intersect(this, b);
  }

  public void draw() {
    line(start.x, start.y, end.x, end.y);
  }
}