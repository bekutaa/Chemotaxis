Bacteria ichi, ni, san, yon, go;
Food un;

int timer1 = 0;
int randomTimer = (int)(Math.random()*3)+2;

boolean foodFlag1 = false;

void setup()
{
  //setup basic canvas
  size(500, 500);
  background(60, 175, 80);

  //create new Bacteria
  ichi = new Bacteria();
 
  ni = new Bacteria();
  
  san = new Bacteria();
  
  yon = new Bacteria();
  
  go = new Bacteria();
  
  //create Food
  un = new Food();
}

void draw()
{
  noStroke();
  fill(60, 175, 80, 100);
  rect(-20, -20, 600, 600);

  if(timer1 > (60*randomTimer))
  {
    //If a bacterium's X/Y is NOT the same as the Food's
    if(
    (
    (ichi.myX == un.foodX && ichi.myY == un.foodY) ||
    (ni.myX   == un.foodX && ni.myY   == un.foodY) ||
    (san.myX  == un.foodX && san.myY  == un.foodY) ||
    (yon.myX  == un.foodX && san.myY  == un.foodY) ||
    (go.myX   == un.foodX && go.myY   == un.foodY)
    ) == false)
    {
      un.show();
      foodFlag1 = true;
    }
    
    //If the bacteria's X/Y is the SAME as the Food's
    else
    {
      //Food is created in a new location      
      if(timer1 > ( (60*randomTimer) + ( (int)(Math.random()*2)+2 ) ) )
      {
        un.randomize();
        
        timer1 = 0;
        randomTimer = (int)(Math.random()*3)+2;
      }
      foodFlag1 = false;
    }
  }
  
  //Bacteria code  
  ichi.walk();
  ichi.show();

  ni.walk();
  ni.show();
  
  san.walk();
  san.show();
  
  yon.walk();
  yon.show();
  
  go.walk();
  go.show();
  
  //Create a target based on the mouse position when it is clicked.
  if(mousePressed == true)
  {
    targetCircle();
  }
    
  timer1++;
}

void keyPressed()
{
  //re-randomize bacteria positions if A is pressed
  if (key == 'a')
  {
    ichi.randomPos();
    ni.randomPos();
    san.randomPos();
    yon.randomPos();
    go.randomPos();
  }
}

void targetCircle()
{
  int circleX = mouseX;
  int circleY= mouseY;
    
  noFill();
  strokeWeight(2);
  stroke(255, 255, 255, 200);
  ellipse(circleX, circleY, 10, 10);
  ellipse(circleX, circleY, 20, 20); 
}

class Bacteria
{
  int myX, myY;
  int color1, color2, color3;

  Bacteria()
  {
    myX = (int)(Math.random()*500);
    myY = (int)(Math.random()*500);
    
    color1 = (int)(Math.random()*155)+100;
    color2 = (int)(Math.random()*155)+100;
    color3 = (int)(Math.random()*155)+100;
  }

  void randomPos()
  {
    myX = (int)(Math.random()*500);
    myY = (int)(Math.random()*500);
  }
  
  void walk()
  {
    //If there is no food, the bacteria will move towards the mouse when it is clicked.
    if(!foodFlag1)
    {
      if(mousePressed == true)
      {
        //-------------------------------------------------------------------------
        //Left/Right movement
        
        //If the bacterium is to the left of the mouse...
        if(myX < mouseX)
        {
          if( (int)(Math.random()*2) > 0 )
          {
            //X changes by a value between 0 and 5, inclusive.
            myX = myX + (int)(Math.random()*6);
          }
          else
          {
            //X changes by a value between 0 and -2, inclusive.
            myX = myX + (int)(Math.random()*3)-2;
          }
        }
        
        //If the bacterium is to the right of the mouse...
        else
        {
          if( (int)(Math.random()*2) > 0 )
          {
            //X changes by a value between 0 and -5, inclusive.
            myX = myX + (int)(Math.random()*7)-5;
          }
          else
          {
            //X changes by a value between 0 and 2, inclusive.
            myX = myX + (int)(Math.random()*3);
          }
        }
        
        //-------------------------------------------------------------------------
        //Up/Down movement
        
        //If the bacterium is above the mouse...
        if(myY < mouseY)
        {
          if( (int)(Math.random()*2) > 0 )
          {
            //Y changes by a value between 0 and 5, inclusive.
            myY = myY + (int)(Math.random()*6);
          }
          else
          {
            //Y changes by a value between 0 and -2, inclusive.
            myY = myY + (int)(Math.random()*3)-2;
          }          
        }
        
        //If the bacterium is below the mouse...
        else
        {
          if( (int)(Math.random()*2) > 0 )
          {
            //Y changes by a value between 0 and -5, inclusive.
            myY = myY + (int)(Math.random()*7)-5;
          }
          else
          {
            //Y changes by a value between 0 and 2, inclusive.
            myY = myY + (int)(Math.random()*3);
          }
        }
      }
    }
    
    else
    {
      //Same code, but applied to food instead. Bacteria ignore the mouse if there is food onscreen.
      
      if(myX < un.foodX)
      {
        if( (int)(Math.random()*2) > 0 )
        {
          //X changes by a value between 0 and 5, inclusive.
          myX = myX + (int)(Math.random()*6);
        }
        else
        {
          //X changes by a value between 0 and -2, inclusive.
          myX = myX + (int)(Math.random()*3)-2;
        }
      }
      else
      {
        if( (int)(Math.random()*2) > 0 )
        {
          //X changes by a value between 0 and -5, inclusive.
          myX = myX + (int)(Math.random()*7)-5;
        }
        else
        {
          //X changes by a value between 0 and 2, inclusive.
          myX = myX + (int)(Math.random()*3);
        }
      }
        
      if(myY < un.foodY)
      {
        if( (int)(Math.random()*2) > 0 )
        {
          //Y changes by a value between 0 and 5, inclusive.
          myY = myY + (int)(Math.random()*6);
        }
        else
        {
          //Y changes by a value between 0 and -2, inclusive.
          myY = myY + (int)(Math.random()*3)-2;
        }
      }
      else
      {
        if( (int)(Math.random()*2) > 0 )
        {
          //Y changes by a value between 0 and -5, inclusive.
          myY = myY + (int)(Math.random()*7)-5;
        }
        else
        {
          //Y changes by a value between 0 and 2, inclusive.
          myY = myY + (int)(Math.random()*3);
        }
      }
    }
    
    {
      //X and Y change by an integer between -5 and 5, inclusive.
      myX = myX + (int)(Math.random()*11)-5;
      myY = myY + (int)(Math.random()*11)-5;
  
      //X and Y "scrollover"
      if (myX > 615)
      {
        myX = -15;
      }
      if (myX < -15)
      {
        myX = 615;
      }
  
      if (myY > 615)
      {
        myY = -15;
      }
      if (myY < -15)
      {
        myY = 615;
      }
    }
  }
  
  void show()
  {
    strokeWeight(1);
    fill(color1, color2, color3, 200);
    ellipse(myX, myY, 15, 15);
  }
}

class Food
{
  int foodX, foodY;
  
  Food()
  {
    foodX = (int)(Math.random()*500);
    foodY = (int)(Math.random()*500);
  }

  void randomize()
  {
    foodX = (int)(Math.random()*500);
    foodY = (int)(Math.random()*500);
  }
  
  void show()
  {
    noStroke();
    fill(250,210,135);
    rect(foodX-5, foodY-5, 10, 10);
  }
}