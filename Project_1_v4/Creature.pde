class Creature
{
  boolean isBotherable = true;
  boolean isBothered;
  int botheredMarkTime = 0;
  int botheredTimeout = 3000;
  int counter = 0;
  
  boolean isAngry;
  float angryMarkTime = 0;
  int angryTimer = 5000;
  boolean wasAngry;
  
  int scatterMargin = 100;
  boolean scatterBot;

  boolean isEnraged;
  int enragedMarkTime = 0;
  int enragedTimer = 4000;
  boolean enragedTimeStamp;
  boolean finalPosition;
  float endPositionMarkTime = 0;

  int triggerDistance1 = 100;
  float triggerDistance2 = 25;
  float triggerDistance3 = 100;
  
  PVector position, target, target1, target2, target3, target4, target5;
  PImage fCurrent, fNeutral, fBothered, fHappy, fAngry;
  float movementSpeed = 0.08;
  
  boolean aliveTarget1 = true;
  boolean aliveTarget2;
  boolean aliveTarget3;
  boolean aliveTarget4;
  boolean aliveTarget5;
  
  Creature(float x, float y)
  {
    position = new PVector(x, y);
    target = new PVector(random(width), random(height));
    
    fNeutral = loadImage("face01.png");
    fNeutral.resize(fNeutral.width/4, fNeutral.height/4);
    fBothered = loadImage("face02.png");
    fBothered.resize(fNeutral.width, fNeutral.height);
    fHappy = loadImage("face03.png");
    fHappy.resize(fNeutral.width, fNeutral.height);
    fAngry = loadImage("fAngry.png");
    fAngry.resize(width * 2, height * 2);
    
    fCurrent = fNeutral;
  }
 
  void update()
  {
    PVector mousePos = new PVector(mouseX, mouseY);
    
    isBothered = position.dist(mousePos) < triggerDistance1;
    isAngry = !isBothered && (position.x > width || position.y > height || position.x < 0 || position.y < 0);
   
    if(isEnraged && millis() > enragedMarkTime + enragedTimer)
    {
      fCurrent = fBothered;
      target1 = new PVector(random(width/4), random(height/4));
      target2 = new PVector(random((width * 3/4), width), random(height/4));
      target3 = new PVector(random(width/4), random((height * 3/4), height));
      target4 = new PVector(random((width * 3/4), width), random((height * 3/4), height));
      target5 = new PVector(random(width/2 - scatterMargin, width/2 + scatterMargin), random(height/2 - scatterMargin, height/2 + scatterMargin));
      
      if(aliveTarget1)
      {
      position = position.lerp(target1, movementSpeed);
      }
      if(aliveTarget2)
      {
      position = position.lerp(target2, movementSpeed);
      }
      if(aliveTarget3)
      {
      position = position.lerp(target3, movementSpeed);
      }
      if(aliveTarget4)
      {
      position = position.lerp(target4, movementSpeed);
      }
      if(aliveTarget5)
      {
      position = position.lerp(target5, movementSpeed);
      }
      if(position.dist(target1) < triggerDistance3 && aliveTarget1)
      {
        aliveTarget2 = true;
        aliveTarget1 = false;
      }
      if(position.dist(target2) < triggerDistance3 && aliveTarget2)
      {
        aliveTarget3 = true;
        aliveTarget2 = false;
      } 
      if(position.dist(target3) < triggerDistance3 && aliveTarget3)
      {
        aliveTarget4 = true;
        aliveTarget3 = false;
      }
      if(position.dist(target4) < triggerDistance3 && aliveTarget4)
      {
        aliveTarget5 = true;
        aliveTarget4 = false;
      }
      if(position.dist(target5) < triggerDistance3 && aliveTarget5)
      {
        isBotherable = true;
        isEnraged = false;
        scatterBot = false;
        botheredMarkTime = millis();
        target = new PVector(random(width), random(height));
        aliveTarget5 = false;
      }
    }         
    else if(scatterBot == true)
    {
      wasAngry = false;
      float x = random((width/2 - 100) - scatterMargin, (width/2 - 100) + scatterMargin);
      float y = random((height/2 - 100) - scatterMargin, (height/2 - 100) + scatterMargin);
      
      for(int z=0; z < 10; z++)
      {
        float x2 = x + z;
        float y2 = y + z * 10;
           
        position = new PVector(x2, y2);
      }
    }
    else if(isAngry && wasAngry && millis() > angryMarkTime + angryTimer)
    {
      isBotherable = false;
      isEnraged = true;
      tint(247, 197, 197);
      fCurrent = fAngry;
      scatterBot = true;
      enragedMarkTime = millis();
    }
    else if(isAngry && !wasAngry)
    {
      angryMarkTime = millis();
      wasAngry = true;
    }
    else if(isBotherable)
    {
      if(isBothered)
      {
        fCurrent = fBothered;
        botheredMarkTime = millis();
        position = position.lerp(target, movementSpeed);
        
        
        if(position.dist(target) < triggerDistance2)
        {
          counter = counter + 20;
          target = new PVector(random(0 - counter, width + counter), random(0 - counter, height + counter)); //Longer he is bothered (more targets reached), greater chance of running off screen
        }
        if(position.x < width || position.y < height || position.x > 0 || position.y > 0)
        {
          wasAngry = false; //ensures enraged mode does not acctivate if position went slightly off screen but creature came back onto frame
        }
      }
      if(!isBothered && millis() > botheredMarkTime + botheredTimeout)
      {
        noTint();
        fCurrent = fNeutral;
        target = new PVector(random(width), random(height)); // Won't save previous target. Will never choose target off window first
        counter = 0;
      }
    }
  }
  
  void draw()
  {
    imageMode(CENTER);
    image(fCurrent, position.x, position.y);
  }
 
  void run()
  {
    update();
    draw();
  }
}
