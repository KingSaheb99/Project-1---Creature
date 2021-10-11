class Creature
{
  
 PImage fCurrent, fNeutral, fBothered, fHappy, fAngry;
 
 boolean isBothered;
 int botheredMarkTime = 0;
 int botheredTimeout = 3000;
 
 float angryMarkTime = 0;
 
 float triggerDistance1 = 100;
 float triggerDistance2 = 25;
 float movementSpeed = 0.08;
 
 PVector position, target; 
  
  Creature(float x, float y)
  {
    println("CREATURE");
    
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
       if(position.x > width || position.y > height || position.x < 0 || position.y < 0)
       {
         angryMarkTime = millis();
         position = new PVector(width/2 - 100, height/2 - 100);
         fCurrent = fAngry;
       }
     }
    
    else if(!isBothered && millis() > botheredMarkTime + botheredTimeout)
    {
      fCurrent = fNeutral;
    }
    println(position.x, " ", position.y);
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
