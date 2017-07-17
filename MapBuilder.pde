class MapBuilder {
  Map map;
  int wallAddingTreshold = 10;

  MapBuilder(Map map) {
    this.map = map;
  }

  void process() {
    processWallAdding();
    processWallRemoving();
    if (newWall!= null) {
      newWall.draw();
    }
  }

  //1 - wall removed and key not released
  //0 - waiting for actions
  private int removingState = 0;

  private void processWallRemoving() {
    //Remove wall if user press Z first time
    if (keyPressed && removingState == 0) {
      if (key == 'Z') {
        if (map.walls.size()>0) {
          map.walls.remove(map.walls.get((map.walls.size()-1)));
          removingState = 1;
        }
      }
    }
    //Reset state when user release key
    if (!keyPressed && removingState == 1) {
      removingState = 0;
    }
  }

  //0 - waiting for actions
  //1 - first point added
  private int wallAddingState = 0;
  //Temp var for creating the wall
  private Wall newWall = null;

  private void processWallAdding() {
    //Init newWall and add first point when mouse pressed   
    if (mousePressed && wallAddingState == 0) {
      newWall = new Wall(mouseX, mouseY, mouseX, mouseY);
      //Set start to nearest point
      PVector nearestPoint = findNearestPoint(new PVector(mouseX, mouseY), wallAddingTreshold);
      if (nearestPoint !=null) {
        newWall.start = nearestPoint;
      }
      //Update wall adding state
      wallAddingState = 1;
    } 

    //Update end point to mouse position
    if (mousePressed && wallAddingState == 1) {
      newWall.end.x = mouseX;
      newWall.end.y = mouseY;
    }
    if (!mousePressed && wallAddingState == 1) {
      if (newWall.length() > wallAddingTreshold)
      {
        //Set end to nearest point
        PVector nearestPoint = findNearestPoint(new PVector(mouseX, mouseY), wallAddingTreshold);
        if (nearestPoint !=null) {
          newWall.end = nearestPoint;
        }

        map.walls.add(newWall.copy());
      }

      //Reset the wall and the state
      newWall = null;
      wallAddingState = 0;
    }
  }

  private PVector findNearestPoint(PVector position, int minDistance) {
    PVector result = null;

    for (int i=0; i<map.walls.size(); i++) {
      Line wall = map.walls.get(i);
      if (result==null || position.dist(wall.start)<position.dist(result)) {
        result = wall.start;
      };
      if (result==null || position.dist(wall.end)<position.dist(result)) {
        result = wall.end;
      };
    }

    if (result == null)
      return null;

    if (position.dist(result)<=minDistance) {
      return result.copy();
    } else {
      return null;
    }
  }
}