class Food
{
  
  PVector position, mousePos;
  PImage foodFine, foodFineRight, foodScared, foodScaredRight, foodCurrent;
  int sizeValue;
  boolean alive = true;
  boolean wasScared = true;
  int scaredDistance = 500;
  float playMarkTime = 0;
  int audioTimeout = 1000;
  
  Food(float x, float y)
  {
   position = new PVector(x, y);
   
   sizeValue = int(random(-50, 50)); //worms come in different sizes
   
   foodFine = loadImage("foodNormal.png");
   foodFine.resize((foodFine.width/4) + sizeValue, (foodFine.height/4) + sizeValue);
   foodFineRight = loadImage("foodNormalRight.png");
   foodFineRight.resize(foodFine.width, foodFine.height);
   foodScared = loadImage("foodScared.png");
   foodScared.resize(foodFine.width, foodFine.height);
   foodScaredRight = loadImage("foodScaredRight.png");
   foodScaredRight.resize(foodFine.width, foodFine.height);
   
   foodCurrent = foodFine;
  }
  
  void update()
  {
    if(creature.position.dist(position) > scaredDistance) // worms only scream once when creature enters scared distance, then again if he leves and comes back
    {
     wasScared = true; 
    }
    if(creature.position.dist(position) < scaredDistance || creature.isBothered == true || creature.isEnraged == true) //worms will face the creature and get scared if creature is close, angry, or enraged
    {
      
      if(!scared.isPlaying() && millis() > playMarkTime + audioTimeout && wasScared)
      {
      scared.play();
      playMarkTime = millis();
      wasScared = false;
      }
      
      if(creature.position.x > position.x)
      {
       foodCurrent = foodScaredRight; 
      }
      if(creature.position.x < position.x)
      {
        foodCurrent = foodScared;
      }
    }
    else if(!creature.isBothered && millis() > creature.botheredMarkTime + creature.botheredTimeout)
    {
      if(creature.position.x > position.x)
      {
       foodCurrent = foodFineRight;
      }
      if(creature.position.x < position.x)
      {
        foodCurrent = foodFine;
      }
    }
  }
 
  void draw()
  {
    noTint();
   imageMode(CENTER);
   image(foodCurrent, position.x, position.y);
  }
  
  void run()
  {
    update();
    draw();
  }
}
