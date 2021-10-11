class Creature
{
  
 PImage fCurrent, fNeutral, fBothered, fHappy, fAngry;
 
 boolean isBotherable = true;
 boolean isBothered;
 int botheredMarkTime = 0;
 int botheredTimeout = 3000;
 
 boolean isAngry;
 float angryMarkTime = 0;
 int angryTimer = 5000;
 
 float triggerDistance1 = 100;
 float triggerDistance2 = 25;
 float movementSpeed = 0.08;
 
 PVector position, target; 
 
 boolean debug = true;
  
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
    
    if(isBotherable)
    {  
      isBothered = position.dist(mousePos) < triggerDistance1;
      
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
      else if(!isBothered && millis() > botheredMarkTime + botheredTimeout)
      {
      fCurrent = fNeutral;
      }
    }
    
    isAngry = isBothered && (position.x > width || position.y > height || position.x < 0|| position.y < 0);
    
    if(isAngry)
    {
      angryMarkTime = millis();
    }
    else if(!isAngry && millis() > angryMarkTime + angryTimer)
    {
     isBotherable = false;
     fCurrent = fAngry;
    // float x = random((width/2 - 100) - 50, (width/2 - 100) + 50);
     position = new PVector(width/2 - 100, height/2 - 100);
    }
    
 

  
    if(debug)
    {
     //println(position.x + " " + position.y);
     //println(millis());
    }
  }
  
  void draw()
  {
    imageMode(CENTER);
    
    image(fCurrent, position.x, position.y);
  }
  /*
  void isAngry()
  {
    isBothered = false;
    angryMarkTime = millis();
    
    if(angryMarkTime > 10000)
    {
      println("YES");
    position = new PVector(width/2 - 100, height/2 - 100);
    fCurrent = fAngry;
    }
  }
  */
  
  void run()
  {
    update();
    draw();
  }
}
