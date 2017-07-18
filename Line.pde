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

  //Return intersection point or null
  public PVector Intersect(Line b) {
    return LineHelper.Intersect(this, b);
  }

  public void draw() {
    line(start.x, start.y, end.x, end.y);
  }

  public Line copy() {
    return new Line(start.x, start.y, end.x, end.y);
  }

  public float length() {
    return start.dist(end);
  }

  public PVector getDistance( float x, float y ) {
    PVector result = new PVector();
    float dx = end.x - start.x; 
    float dy = end.y - start.y; 
    float d = sqrt( dx*dx + dy*dy ); 
    float ca = dx/d; // cosine
    float sa = dy/d; // sine 

    float mx = (-start.x+x)*ca + (-start.y+y)*sa;

    if ( mx <= 0 ) {
      result.x = start.x; 
      result.y = start.y;
    } else if ( mx >= d ) {
      result.x = end.x; 
      result.y = end.y;
    } else {
      result.x = start.x + mx*ca; 
      result.y = start.y + mx*sa;
    }

    float dx2 = x - result.x; 
    float dy2 = y - result.y; 
    result.z = sqrt( dx2*dx2 + dy2*dy2 ); 

    return result;
  }
}