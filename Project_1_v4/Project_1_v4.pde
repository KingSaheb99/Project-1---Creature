Creature creature;
//Food food;

float startTime;
float currentTime;
//  int safeDistance = 300;
//  PVector position, mousePos;


void setup()
{
  startTime = millis();
  frameRate(60);
  size(1920, 1080, P2D);
  
  creature = new Creature(random(200, width - 200), random(100, height - 100));
//  food = new Food(mouseX, mouseY);
 
  
 
}

void draw()
{
  currentTime = millis();
  
  background(255);
  
 // mousePos = new PVector(mouseX, mouseY);
  
  creature.run();
 // food.run();
}

void keyPressed() //Exit program on ESC
{
  if(key == CODED)
  {
    if(keyCode == ESC)
    {
      exit ();
    }
  }
}
/*
void mouseClicked()
  {
    if(mousePos.dist(creature.position) > safeDistance)
    {
      food.draw();
    }
  }*/
