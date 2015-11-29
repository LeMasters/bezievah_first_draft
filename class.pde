class DroneClass {
  int ID;
  float xPos;
  float yPos;
  float xDir;
  float yDir;
  boolean isVisible;
  float dia;
  float rotation; // store in degrees -- much easier.
  float rotDelta;

  DroneClass (int id, float x, float y, float dx, float dy, float d, float r, float rD) {
    ID = id;
    xPos = x;
    yPos = y;
    xDir = dx;
    yDir = dy;
    dia = d;
    rotation = r;
    rotDelta = rD;
    isVisible = false;
  }

  void show() {
    if (isVisible) {
      ellipse(xPos, yPos, dia, dia);
      float arrowX = cos(radians(rotation))*dia + xPos;
      float arrowY = sin(radians(rotation))*dia + yPos;
      line(xPos, yPos, arrowX, arrowY);
    }
  }

  void move() {
    PVector vB = new PVector(xPos, yPos);
    PVector dB = new PVector(xDir, yDir);
    rotation = rotation + rotDelta;
    dB.rotate(radians(rotation));
    vB.add(dB);
    xPos = vB.x;
    yPos = vB.y;
  }
}