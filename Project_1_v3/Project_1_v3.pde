Creature creature;

void setup()
{
  size(1920, 1080, P2D);
  
  creature = new Creature(random(width), random(height));
  
 
}

void draw()
{
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
