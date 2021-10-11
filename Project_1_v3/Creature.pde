class Creature
{
  
 PImage fCurrent, fNeutral, fBothered, fHappy, fAngry;
 
 boolean isBotherable = true;
 boolean isBothered;
 int botheredMarkTime = 0;
 int botheredTimeout = 3000;
 
 boolean isAngry;
 boolean wasAngry;
 float angryMarkTime = 0;
 int angryTimer = 5000;
 int scatterMargin = 100;
 
 boolean isEnraged;
 int enragedMarkTime = 0;
 int roarTime = 300;
 boolean parallaxTimer;
 
 float triggerDistance1 = 100;
 float triggerDistance2 = 25;
 float movementSpeed = 0.08;
 
 PVector position, target; 
 float x2, y2;

 
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
    
    isAngry = isBothered && (position.x > width || position.y > height || position.x < 0 || position.y < 0);
    
    if(isAngry)
    {
      angryMarkTime = millis();
      wasAngry = true;
    }
    else if(wasAngry && !isAngry && millis() > angryMarkTime + angryTimer)
    {
     isBotherable = false;
     isEnraged = true;
     enragedMarkTime = millis();
     fCurrent = fAngry;
     
     float x = random((width/2 - 100) - scatterMargin, (width/2 - 100) + scatterMargin);
     float y = random((height/2 - 100) - scatterMargin, (height/2 - 100) + scatterMargin);
       
     for(int z=0; z < 10; z++)
     {
      float x2 = x + z;
      float y2 = y + z * 10;
         
      position = new PVector(x2, y2);
     
     }  
    
     parallaxTimer = true;
     println("HERE0");
    }
    if(isEnraged && parallaxTimer && wasAngry)
    {
      println("HERE1");
     for(int enragedTimer = 0; enragedTimer <= (frameRate * 50); enragedTimer++)
     {
     //  println(enragedTimer + " " + (frameRate * 50));
       if(enragedTimer > (frameRate * 50) - 2)
       {
       isEnraged = false;
       println("HERE2");
       }
     }
    }
    else if(!isEnraged && wasAngry && parallaxTimer)
    {
      
      println("HERE3");
      for(int i=0; i <= 1000000; i++)
      {
        println("HERE4");
        if(i == 1000000)
        {
          
                println("HERE5");
          isEnraged = false;
          wasAngry = false;
          parallaxTimer = false;
          position = new PVector(random(200, width - 200), random(100, height - 100));
          target = new PVector(random(width), random(height));
          isBotherable = true;
          
        }
      }
    } 
    else
    {
      isAngry = false;
    }
    
  
      
       
       
       
       
   /*    
     for(int counter=0; counter < roarTime; counter++)
     {
       println(counter);
       if(counter == roarTime)
       {
         wasAngry = false;
         isEnraged = false;
         isBotherable = true;
         counter = 0;
       }
     } 
     */

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
  
  void run()
  {
    update();
    draw();
  }
}
