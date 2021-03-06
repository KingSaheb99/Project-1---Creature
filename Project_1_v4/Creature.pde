class Creature
{
  
  boolean isBotherable = true;
  boolean isBothered;
  int botheredMarkTime = 0;
  int botheredTimeout = 3000;
  int counter = 0;
  
  Food foodTarget;
  boolean isHungry = false;
  boolean canEat;
  int foodChoice;
  int safeDistance = 300;
  
  boolean isSick;
  float bloatCounter = 1.0;
  float bloatIncrease = 0.1;
  
  int numChibis = 60;
  ArrayList<Chibi> chibis = new ArrayList<Chibi>();
  float chibiSpawnMarkTime = 0;
  int chibiSpawnTimeout = 100;
  boolean chibiSpawned;
  float playMarkTime2 = 0;
  int playTimeout2 = 0;
  
  boolean isAngry;
  float angryMarkTime = 0;
  int angryTimer = 8000;
  boolean wasAngry;
  
  int scatterMargin = 100;
  int scatterMargin2 = 5;
  boolean scatterBot;

  boolean isEnraged;
  int enragedMarkTime = 0;
  int enragedTimer = 4000;
  boolean enragedTimeStamp;
  boolean finalPosition;
  float endPositionMarkTime = 0;
  float playMarkTime = 0;
  int playTimeout = 2500;

  int triggerDistance1 = 100;
  float triggerDistance2 = 25;
  float triggerDistance3 = 100;
  
  PVector position, target, target1, target2, target3, target4, target5, screenCenter;
  PImage fCurrent, fNeutral, fBothered, fHappy, fAngry;
  int neutralOrigX, neutralOrigY, botheredOrigX, botheredOrigY, angryOrigX, angryOrigY;
  float movementSpeed = 0.08;
  float movementSpeed2 = 0.02;
  
  boolean aliveTarget1 = true;
  boolean aliveTarget2;
  boolean aliveTarget3;
  boolean aliveTarget4;
  boolean aliveTarget5;
    
  Creature(float x, float y)
  {
    position = new PVector(x, y);
    target = new PVector(random(width), random(height));
    screenCenter = new PVector(width/2, height/2);
    pickFoodTarget();
    
    fNeutral = loadImage("face01.png"); // original vals stored to ensure pixel array length matches after all resizes
    fNeutral.resize(fNeutral.width/4, fNeutral.height/4);
    neutralOrigX = fNeutral.width;
    neutralOrigY = fNeutral.height;
    
    fBothered = loadImage("face02.png");
    fBothered.resize(fBothered.width/2, fBothered.height/2);
    botheredOrigX = fBothered.width;
    botheredOrigY = fBothered.height;
    
    fAngry = loadImage("fAngry.png");
    fAngry.resize(width * 2, height * 2);
    angryOrigX = fAngry.width;
    angryOrigY = fAngry.height;
    
    fCurrent = fNeutral;
  }
 
  void update()
  {
    PVector mousePos = new PVector(mouseX, mouseY);
    
    isBothered = position.dist(mousePos) < triggerDistance1;
    isAngry = !isBothered && (position.x > width || position.y > height || position.x < 0 || position.y < 0); 
    
    if(foodChoice < 0 || foodChoice > foods.size() - 1) pickFoodTarget();
   
    if(isEnraged && millis() > enragedMarkTime + enragedTimer) // enraged movement "animation"
    {
      fCurrent = fBothered;
      
      if(!puffing.isPlaying() && millis() > playMarkTime + playTimeout)
      {
        playMarkTime = millis();
        puffing.play();
      }
      
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
        aliveTarget1 = true;
      }
    }         
    else if(scatterBot == true) // enraged scatter effect
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
    else if(isAngry && wasAngry && millis() > angryMarkTime + angryTimer) // jumpscare
    {
      enraged.play();
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
        isHungry = false;
        canEat = false;
        fCurrent = fBothered;
        botheredMarkTime = millis();
        position = position.lerp(target, movementSpeed); //runs away if bothered
        
        if(bothered.isPlaying())
        {
        bothered.amp(1); // unmutes bothered audio when bothered. This allows for the audio to loop and play without resetting every time
        }
        
        if(position.dist(target) < triggerDistance2) //new target if reached previous target
        {
          counter = counter + 20;
          target = new PVector(random(0 - counter, width + counter), random(0 - counter, height + counter)); // longer he is bothered (more targets reached), greater chance of running off screen
        }
        if(position.x < width || position.y < height || position.x > 0 || position.y > 0)
        {
          wasAngry = false; // ensures enraged mode does not acctivate if position went slightly off screen but creature came back into frame
        }
      }
      if(!isBothered && millis() > botheredMarkTime + botheredTimeout)
      {
        noTint();
        canEat = true;
        fCurrent = fNeutral;
        target = new PVector(random(width), random(height)); // won't save previous target. Will never choose target off window first
        counter = 0;
        
        if(bothered.isPlaying())
        {
        bothered.amp(0); // mutes bothered audio when not bothered. This allows for the audio to loop and play without resetting every time
        }
        
        if(bloatCounter >= 1.60) // creature becomes sick if he eats too much food
        {
          isSick = true;
          chibiSpawnMarkTime = millis();
          
          if(!sick.isPlaying() && millis() > playMarkTime2 + playTimeout2)
          {
            sick.play();
            playMarkTime2 = millis();
            playTimeout2 = 15000; // allows for sound to play if user makes creature sick within 15 seconds of opening the program or in quick succession 
          }
        }
        if(!wasAngry && !isHungry && foods.size() > 0)
        {
          pickFoodTarget();
          isHungry = true;
        }
        else if(isHungry && foods.size() > 0)
        {
          if(mousePos.dist(foodTarget.position) > safeDistance) // only eats food if you stay away
          {
          position = position.lerp(foodTarget.position, movementSpeed);
          }
        }
      }
    }
    
    if(foods.size() > 0)
    {
      foodTarget = foods.get(foodChoice);
      
      if(canEat && foodTarget.alive && position.dist(foodTarget.position) < triggerDistance2) //eats food
      {
        death.play(); // worm death
        bloatCounter = bloatCounter + bloatIncrease; // increases size as creature eats
        foodTarget.alive = false;
        fNeutral.resize(int(fNeutral.width * bloatCounter), int(fNeutral.height * bloatCounter));
        fBothered.resize(int(fBothered.width * bloatCounter), int(fBothered.height * bloatCounter));
        fAngry.resize(int(fAngry.width * bloatCounter), int(fAngry.height * bloatCounter));
        pickFoodTarget();
        eat.play(); //gulp noise
      }
    }
    
    if(chibiSpawned)
    {
      if(!chibiSound.isPlaying())
      {
        chibiSound.play();
      }
    }
    else if(chibis.size() == 0)
    {
      if(chibiSound.isPlaying())
      {
        chibiSound.stop();
      }
    }
  }
  
  void draw()
  {
    imageMode(CENTER);
    image(fCurrent, position.x, position.y);
    
    for(int i=0; i<chibis.size(); i++)
    {
    chibis.get(i).run();
    chibiSpawned = true;
    }
 
    for(int i=chibis.size()-1; i>=0; i--)
    {
      Chibi chibi = chibis.get(i);
   
     if(!chibi.alive) // removes food from array list if eaten
     {
       chibis.remove(i);
       numChibis = numChibis - 1;
       chibiSpawned = false;
       
       if(chibis.size() == 0 && bloatCounter > 1.6)
       {
         bloatCounter = 1.0;
         isSick = false;
         isBotherable = true;
         isHungry = true;
         canEat = false;
         numChibis = 60; // resets numChibis for next time it's sick
         noTint();
         fNeutral.resize(neutralOrigX, neutralOrigY);
         fBothered.resize(botheredOrigX, botheredOrigY);
         fAngry.resize(angryOrigX, angryOrigY);
       }
     }
    }
  }
  
  void pickFoodTarget()
  {
   if(foods.size() > 0)
   {
     foodChoice = int(random(foods.size()));
     foodTarget = foods.get(foodChoice);
   }
  }
  
  void isSick()
  {
    if(isSick) // creture looks sickly and poops out chibis
    {
      tint(147, 247, 255);
      position = position.lerp(screenCenter, movementSpeed2);
      bloatCounter = 1.61;
      triggerDistance1 = 100;
      isBotherable = false;
      isHungry = false;
      canEat = false; 
      
      if(position.dist(screenCenter) < 15)
      {
        position = screenCenter.add(new PVector(random(-scatterMargin2, scatterMargin2), random(-scatterMargin2, scatterMargin2))); // creature shakes as he poops
        
        for(int i=0; i<numChibis; i++)
        {
          if(millis() > chibiSpawnMarkTime + chibiSpawnTimeout) // ensures chibis come out one at a time, ten times / second
          {
          chibis.add(new Chibi(screenCenter.x, screenCenter.y, i));
          chibiSpawnMarkTime = millis(); 
          }
        }
      }
    }
  }
 
  void run()
  {
    update();
    isSick();
    draw();
  }
}
