import processing.sound.*; //Initializes the Official Processing Foundation Sound Library

Creature creature;

ArrayList<Food> foods = new ArrayList<Food>();
ArrayList<Chibi> chibis = new ArrayList<Chibi>();

PVector mousePos;
int safeDistance = 300;

PImage bg, cursorImage;

SoundFile eat, bothered, enraged, puffing, scared, death, sick, chibiSound, bgm;

void setup()
{
  size(1920, 1080, P2D);
  
  creature = new Creature(random(200, width - 200), random(100, height - 100)); 
  
  bg = loadImage("grass.png");
  image(bg, 0, 0, width, height);
  bg.resize(width, height);
  
  cursorImage = loadImage("cursor.png");
  image(cursorImage, width + 500, height + 500); // cursor starts off screen so cursor fist displays when user interacts. Also, creature will never start bothered
  
  bgm = new SoundFile(this, "neneBGM.wav");
  bgm.loop();
  bgm.amp(0.25);
  
  eat = new SoundFile(this, "eat.wav");
  sick = new SoundFile(this, "sick.wav");
  
  bothered = new SoundFile(this, "bothered.wav");
  bothered.loop();
  
  enraged = new SoundFile(this, "enraged.wav");
  puffing = new SoundFile(this, "puffing.wav");
  
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
  
  imageMode(CORNER);
  cursor(cursorImage);
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
