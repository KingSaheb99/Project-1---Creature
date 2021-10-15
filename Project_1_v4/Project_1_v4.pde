import processing.sound.*; //Initializes the Official Processing Foundation Sound Library

Creature creature;

ArrayList<Food> foods = new ArrayList<Food>();
ArrayList<Chibi> chibis = new ArrayList<Chibi>();

PVector mousePos;
int safeDistance = 300;

PImage bg;

SoundFile eat, bothered, scared, death, chibiSound, bgm;

void setup()
{
  size(1920, 1080, P2D);
  
  creature = new Creature(random(200, width - 200), random(100, height - 100)); 
  
  bg = loadImage("grass.png");
  image(bg, 0, 0, width, height);
  bg.resize(width, height);
  
  bgm = new SoundFile(this, "neneBGM.wav");
  bgm.loop();
  bgm.amp(0.25);
  
  eat = new SoundFile(this, "eat.wav");
  
  bothered = new SoundFile(this, "bothered.wav");
  bothered.loop();
  
  scared = new SoundFile(this, "wormScared.wav");
  death = new SoundFile(this, "wormDeath.wav");
  
  chibiSound = new SoundFile(this, "chibi.wav");
}

void mouseClicked()
{
  mousePos = new PVector(mouseX, mouseY);
    
  if(mousePos.dist(creature.position) > safeDistance) //food spawned if you click safe distance away from creature
  {
    foods.add(new Food(mouseX, mouseY));
  }
}

void draw()
{
  background(bg);
 
 for(int i=0; i < foods.size(); i++)
 {
   foods.get(i).run();
 }
 
 for(int i=foods.size()-1; i >= 0; i--)
 {
   Food food = foods.get(i);
   
   if(!food.alive)
   {
     foods.remove(i);
   }
 }

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
