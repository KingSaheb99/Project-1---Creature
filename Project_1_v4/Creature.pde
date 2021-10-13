class Creature
{
  boolean isBotherable = true;
  boolean isBothered = false;
  int botheredMarkTime = 0;
  int botheredTimeout = 3000;
  
  boolean isAngry;
  float angryMarkTime = 0;
  int angryTimer = 5000;
  boolean wasAngry;
  int scatterMargin = 100;
  
  boolean isEnraged;
  int enragedMarkTime = 0;
  int enragedTimer = 4000;
  boolean enragedTimeStamp;

  int triggerDistance1 = 100;
  float triggerDistance2 = 25;
  
  PVector position, target;
  PImage fCurrent, fNeutral, fBothered, fHappy, fAngry;
  float movementSpeed = 0.08;
  boolean scatterBot = false;
  
  
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
    isAngry = isBothered && (position.x > width || position.y > height || position.x < 0 || position.y < 0);
    
    if(enragedTimeStamp)
    {
      enragedMarkTime = millis();
      enragedTimeStamp = false;
    }    
    else if(isEnraged && millis() > enragedMarkTime + enragedTimer)
    {
      isBotherable = true;
      isEnraged = false;
      scatterBot = false;
      position = new PVector(random(200, width - 200), random(100, height - 100));
      target = new PVector(random(width), random(height));
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
    else if(!isAngry && wasAngry && millis() > angryMarkTime + angryTimer)
    {
      isBotherable = false;
      isEnraged = true;
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
            for(int i=0; i < 500; i++)
            {
            target = new PVector(random(width - i, width + i), random(height - i, height + i));
            }
          }
      }
      if(!isBothered && millis() > botheredMarkTime + botheredTimeout)
      {
        fCurrent = fNeutral;
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
