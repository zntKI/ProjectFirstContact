float x = 500;
float y = 500;

float offset = 0;
float offsetRemaining = 0;
Boolean moving = false;

void setup()
{
  size(1000,1000);
  rectMode(CENTER);
}

void draw()
{
  background(255);
  
  fill(255, 0, 0);
  rect(x-1000 + offset, y, 500, 500);
  fill(255, 255, 0);
  rect(x-500 + offset, y, 500, 500);
  fill(0, 255, 0);
  rect(x + offset, y, 500, 500);
  fill(0, 255, 255);
  rect(x+500 + offset, y, 500, 500);
  fill(0, 0, 255);
  rect(x+1000 + offset, y, 500, 500);
  
  fill(255);
  circle(500, 500, 100);
  
  //rect(x, y, 2000, 100);
  
  if(mousePressed){
      offsetRemaining = mouseX - 500;
      moving = true;
  }
  
  if(moving && offsetRemaining > 10){
    offsetRemaining -= 10;
    offset -= 10;
  }
  else if(moving && offsetRemaining < -10){
    offsetRemaining += 10;
    offset += 10;
  }
  
  if(offsetRemaining > -10 && offsetRemaining < 10){
    moving = false;
  }
  
  if(offset < -1250){
    offset = -1250;
    offsetRemaining = 0;
    moving = false;
  }
  else if(offset > 1250){
    offset = 1250;
    offsetRemaining = 0;
    moving = false;
  }
}
