class Chibi
{
 PImage chibiBothered, chibiCurrent;
 PVector position, target, offWindowX, offWindowY;
 float movementSpeed = 0.1;
 int spreadMargin = 1;
 int index;
 boolean alive = true;
 int targetChange = 100;
    
 Chibi(float x, float y, int _index)
 {
   index = _index;
   position = new PVector(x, y);
  
   chibiBothered = loadImage("face02.png");
   chibiBothered.resize(chibiBothered.width/3, chibiBothered.height/3);
  
   chibiCurrent = chibiBothered;
   
   target = new PVector(random(width), random(height));
 }
  
 void update()
 {
   if(position.dist(target) < 90) // causes chibis to lerp off screen after spawning in every direction depending on random spawn location
   {
     if(position.x >= width/2)
     {
       target.x += targetChange;
     }
     else if(position.x < width/2)
     {
       target.x -= targetChange;
     }
     if(position.y >= height/2)
     {
       target.y += targetChange;
     }
     else if(position.y < height/2)
     {
       target.y -= targetChange;
     }
   }
   
   else if(position.dist(target) >  5) // chibis lerp to target
   {
     position = position.lerp(target, movementSpeed).add(new PVector(random(-spreadMargin, spreadMargin), random(-spreadMargin, spreadMargin))); 
   }
   
   if(position.x > width || position.x < 0 || position.y > height || position.y < 0) // chibis off screen are dead
   {
     alive = false;
   }
   else
   {
     alive = true;
   }
 }
 
 void draw()
 {
   noTint();
   imageMode(CENTER);
   image(chibiCurrent, position.x, position.y);
 }
 
 void run()
 {
   update();
   draw();
 }
}
