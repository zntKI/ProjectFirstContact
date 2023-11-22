int bgX, bgY;
int bgWidth, bgHeight;

int pX, pY;

int offset = 10;

int pXTemp;
int mouseXTemp;
int distance;
int accBgOffset;

int centreCircleRadius = 100;
int screenCentrePointLeft, screenCentrePointRight;

boolean shouldFinishMovement = false;

void setup() {
  size(1500, 1000);

  bgWidth = width * 2;
  bgHeight = height / 2;
  bgX = 100;
  bgY = (height / 2) - (bgHeight / 2);

  pX = width / 2;
  pY = height / 2;

  screenCentrePointLeft = width / 2 - centreCircleRadius;
  screenCentrePointRight = width / 2 + centreCircleRadius;
}

void draw() {
  background(255);

  fill(100, 0, 0);
  rect(bgX, bgY, bgWidth, bgHeight);

  fill(255);
  ellipse(pX, pY, 100, 100);

  fill(0, 0, 255);
  ellipse(screenCentrePointLeft, pY, 20, 20);
  ellipse(screenCentrePointRight, pY, 20, 20);

  if (mousePressed) {
    if (mouseX >= screenCentrePointLeft &&
      mouseX <= screenCentrePointRight) {

      calculateMoveParams();

      if (mouseX < pX && pX - offset > pXTemp - distance) {
        pX -= offset;
      } else if (mouseX > pX && pX + offset < pXTemp + distance) {
        pX += offset;
      }
    } else {
      //Move the player until he reaches the centre's boundrais
      if (mouseX > pX && pX < screenCentrePointRight) {
        pX += offset;
      } else if (mouseX < pX && pX > screenCentrePointLeft) {
        pX -= offset;
      } else {
        //Then move the bg
        if (mouseX > pX) {
          bgX -= offset;
        } else if (mouseX < pX) {
          bgX += offset;
        }
      }
    }
  } else if (shouldFinishMovement) {
    if (mouseXTemp >= screenCentrePointLeft &&
      mouseXTemp <= screenCentrePointRight) {

      if (mouseXTemp <= pX) {
        if (pX - offset > pXTemp - distance) {
          pX -= offset;
        } else {
          shouldFinishMovement = false;
        }
      } else if (mouseXTemp >= pX) {
        if (pX + offset < pXTemp + distance) {
          pX += offset;
        } else {
          shouldFinishMovement = false;
        }
      }
    } else {
      //Move the player until he reaches the centre's boundrais
      if (pX > screenCentrePointLeft &&
        pX < screenCentrePointRight) {
        if (mouseXTemp > pXTemp) {
          pX += offset;
        } else if (mouseXTemp < pXTemp) {
          pX -= offset;
        }
      }
      //Then move the bg
      else { //<>//
        if (mouseXTemp > pXTemp) {
          if (accBgOffset + offset < distance) {
            bgX -= offset;
            accBgOffset += offset;
          } else {
            bgX -= (accBgOffset + offset) - distance;
            shouldFinishMovement = false;
          }
        } else {
          if (accBgOffset + offset < distance) {
            bgX += offset;
            accBgOffset += offset;
          } else {
            bgX += (accBgOffset + offset) - distance;
            shouldFinishMovement = false;
          }
        }
      }
    }
  }
}

void calculateMoveParams() {
  pXTemp = pX;
  mouseXTemp = mouseX;
  distance = abs(mouseXTemp - pXTemp);
}

void mouseReleased() {
  shouldFinishMovement = true;

  if (mouseX >= screenCentrePointLeft &&
    mouseX <= screenCentrePointRight) {
    //Player should move towards that point
    calculateMoveParams();
  } else {
    pXTemp = pX;
    accBgOffset = 0;
    mouseXTemp = mouseX;

    int circleSide = mouseXTemp > screenCentrePointRight ? screenCentrePointRight
      : screenCentrePointLeft;
    //distance to move the bg
    distance = abs(mouseXTemp - circleSide);
  }
}
