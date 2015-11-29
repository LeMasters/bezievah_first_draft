// objects, the next generation

DroneClass[] drone;

void setup() {
  size(800, 800, P2D);
  smooth(8);
  drone = new DroneClass[25];
  for (int i=0; i<drone.length; i++) {
    drone[i] = new DroneClass(i, rndWide(), rndHigh(), random(-1, 1), random(-1, 1), random(36, 75), random(365), random(-0.5, .5));
  }
  screenInit();
}

void draw() {
  screenPrep();
  for (int i=0; i<drone.length; i++) {
    drone[i].show();
    drone[i].move();
    linkNeighbors(i);
  }
}

void linkNeighbors(int alpha) {
  for (int beta=0; beta<drone.length; beta++) {
    if (drone[alpha].ID != drone[beta].ID) {
      float xAlpha = drone[alpha].xPos;
      float yAlpha = drone[alpha].yPos;
      float xBeta = drone[beta].xPos;
      float yBeta = drone[beta].yPos;

      float d = dist(xAlpha, yAlpha, xBeta, yBeta);
      float g = (drone[alpha].dia + drone[beta].dia);
      if (d<g) {
        bezierMaker(alpha, beta, 3.5);
      }
    }
  }
}

void bezierMaker (int alpha, int beta, float n) {
  float xAlpha = drone[alpha].xPos;
  float yAlpha = drone[alpha].yPos;
  float xBeta = drone[beta].xPos;
  float yBeta = drone[beta].yPos;
  float r0 = drone[alpha].rotation;
  float r1 = drone[beta].rotation;
  float d0 = drone[alpha].dia;
  float d1 = drone[beta].dia;
  float nDist = dist(xAlpha, yAlpha, xBeta, yBeta);
  float nMax = d0 + d1;
  n = (nDist / nMax) * n;

  //extend drone alpha into space by n percent
  float xAlphaZero = xAlpha + cos(radians(r0))*d0;
  float yAlphaZero = yAlpha + sin(radians(r0))*d0;
  float xAlphaPrime = xAlpha + cos(radians(r0))*(d0*n);
  float yAlphaPrime = yAlpha + sin(radians(r0))*(d0*n);

  float xBetaZero = xBeta + cos(radians(r1))*d1;
  float yBetaZero = yBeta + sin(radians(r1))*d1;
  float xBetaPrime = xBeta + cos(radians(r1))*(d1*n);
  float yBetaPrime = yBeta + sin(radians(r1))*(d1*n);

  // anchor,control,control,anchor
  noFill();
  //  fill(#FFCC33);
  stroke(#FFFFFF);
  strokeWeight(.5);
  /*
  ellipse(xAlpha, yAlpha, 5, 5);
   rect(xAlphaZero, yAlphaZero, 5, 5);
   rect(xAlphaPrime, yAlphaPrime, 5, 5);
   rect(xBetaZero, yBetaZero, 5, 5);
   rect(xBetaPrime, yBetaPrime, 5, 5);  
   line(xAlphaZero, yAlphaZero, xAlphaPrime, yAlphaPrime);
   line(xBetaZero, yBetaZero, xBetaPrime, yBetaPrime);
   */
  bezier(xAlphaZero, yAlphaZero, xAlphaPrime, yAlphaPrime, xBetaPrime, yBetaPrime, xBetaZero, yBetaZero);
}