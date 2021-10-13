Creature creature;

float startTime;
float currentTime;

void setup()
{
  startTime = millis();
  frameRate(60);
  size(1920, 1080, P2D);
  
  creature = new Creature(random(200, width - 200), random(100, height - 100));
 
  
 
}

void draw()
{
  currentTime = millis();
  
  background(255);
  
  creature.run();
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
