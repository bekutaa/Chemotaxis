Bacteria [] colony;
Food [] stock;

int randomTimer = (int)(Math.random()*4)+3;
int randomTimer2 = (int)(Math.random()*5)+4;

void setup()
{
  //setup basic canvas
  size(500, 500);
  background(60, 175, 80);

  //create new Bacteria
  colony = new Bacteria[3];
  for (int i = 0; i < colony.length; i++)
  {
    colony[i] = new Bacteria();
  }

  //create Food
  stock = new Food[3];
  for (int i = 0; i < stock.length; i++)
  {
    stock[i] = new Food();
  }
}

void draw()
{
  noStroke();
  fill(60, 175, 80, 100);
  rect(-20, -20, 600, 600);

  //Two loops: one for # of bacteria, one for # of food
  for (int f = 0; f < stock.length; f++)
  {
    if (stock[f].foodTimer > (60*randomTimer))
    {
      for (int b = 0; b < colony.length; b++)
      {
        //If the bacterium is more than 15 units away from the food
        if (
        (dist(colony[b].myX, colony[b].myY, stock[f].foodX, stock[f].foodY)) > 15
          )
        {
          stock[f].show();
        }
        //If the bacterium is less than 15 units away from the food
        else
        {
          stock[f].foodFlag = false;
          if (!colony[b].deathFlag)
          {
            colony[b].eatGrow();
          }
          System.out.println(b);
          System.out.println(colony[b].mySize);

          //Food is created in a new location      
          if (stock[f].foodTimer > ( (60*randomTimer) + ( (int)(Math.random()*2)+2 ) ) )
          {
            stock[f].foodTimer = 0;
            randomTimer = (int)(Math.random()*4)+3;

            stock[f].randomize();
          }
        }
      }
    }
  }

  //Bacteria code  
  for (int i = 0; i < colony.length; i++)
  {
    if (!colony[i].deathFlag)
    {
      colony[i].walk();
    }
    colony[i].show();
  }

  //Create a target based on the mouse position when it is clicked.
  if (mousePressed == true)
  {
    targetCircle();
  }

//  for (int i = 0; i < colony.length; i++)
//  {
//    print("colony[" + i + "] size: " + colony[i].mySize + "; ");
//  }
//  println();

  for (int f = 0; f < stock.length; f++)
  {
    stock[f].foodTimer ++ ;
  }
}

void keyPressed()
{
  //re-randomize bacteria positions if A is pressed
  if (key == 'a')
  {
    for (int i = 0; i < colony.length; i++)
    {
      colony[i].randomPos();
    }
  }
}

void targetCircle()
{
  int circleX = mouseX;
  int circleY = mouseY;

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
  int mySize;
  boolean deathFlag;
  int deathTimer, deathSize;

  Bacteria()
  {
    myX = (int)(Math.random()*500);
    myY = (int)(Math.random()*500);

    mySize = 15;

    deathFlag = false;

    color1 = (int)(Math.random()*155)+100;
    color2 = (int)(Math.random()*155)+100;
    color3 = (int)(Math.random()*155)+100;
  }

  void randomPos()
  {
    myX = (int)(Math.random()*500);
    myY = (int)(Math.random()*500);
  }

  void eatGrow()
  {
    mySize = mySize + 5;
  }

  void walk()
  {
    //If there is no food, the bacteria will move towards the mouse when it is clicked and held.
    for (int i = 0; i < stock.length; i++)
    {
      if (!stock[i].foodFlag)
      {
        if (mousePressed == true)
        {
          //-------------------------------------------------------------------------
          //Left/Right movement

          //If the bacterium is to the left of the mouse...
          if (myX < mouseX)
          {
            if ( (int)(Math.random()*2) > 0 )
            {
              //X changes by a value between 0 and 5, inclusive.
              myX = myX + (int)(Math.random()*6);
            } else
            {
              //X changes by a value between 0 and -2, inclusive.
              myX = myX + (int)(Math.random()*3)-2;
            }
          }

          //If the bacterium is to the right of the mouse...
          else
          {
            if ( (int)(Math.random()*2) > 0 )
            {
              //X changes by a value between 0 and -5, inclusive.
              myX = myX + (int)(Math.random()*7)-5;
            } else
            {
              //X changes by a value between 0 and 2, inclusive.
              myX = myX + (int)(Math.random()*3);
            }
          }

          //-------------------------------------------------------------------------
          //Up/Down movement

          //If the bacterium is above the mouse...
          if (myY < mouseY)
          {
            if ( (int)(Math.random()*2) > 0 )
            {
              //Y changes by a value between 0 and 5, inclusive.
              myY = myY + (int)(Math.random()*6);
            } else
            {
              //Y changes by a value between 0 and -2, inclusive.
              myY = myY + (int)(Math.random()*3)-2;
            }
          }

          //If the bacterium is below the mouse...
          else
          {
            if ( (int)(Math.random()*2) > 0 )
            {
              //Y changes by a value between 0 and -5, inclusive.
              myY = myY + (int)(Math.random()*7)-5;
            } else
            {
              //Y changes by a value between 0 and 2, inclusive.
              myY = myY + (int)(Math.random()*3);
            }
          }
        }
      } else
      {
        //Same code, but applied to food instead. Bacteria ignore the mouse if there is food onscreen.

        for (int f = 0; f < stock.length; f++)
        {
          if (dist(myX, myY, stock[f].foodX, stock[f].foodY) < 120)
          {
            if (myX < stock[f].foodX)
            {
              if ( (int)(Math.random()*2) > 0 )
              {
                //X changes by a value between 0 and 5, inclusive.
                myX = myX + (int)(Math.random()*6);
              } else
              {
                //X changes by a value between 0 and -2, inclusive.
                myX = myX + (int)(Math.random()*3)-2;
              }
            } else
            {
              if ( (int)(Math.random()*2) > 0 )
              {
                //X changes by a value between 0 and -5, inclusive.
                myX = myX + (int)(Math.random()*7)-5;
              } else
              {
                //X changes by a value between 0 and 2, inclusive.
                myX = myX + (int)(Math.random()*3);
              }
            }

            if (myY < stock[f].foodY)
            {
              if ( (int)(Math.random()*2) > 0 )
              {
                //Y changes by a value between 0 and 5, inclusive.
                myY = myY + (int)(Math.random()*6);
              } else
              {
                //Y changes by a value between 0 and -2, inclusive.
                myY = myY + (int)(Math.random()*3)-2;
              }
            } else
            {
              if ( (int)(Math.random()*2) > 0 )
              {
                //Y changes by a value between 0 and -5, inclusive.
                myY = myY + (int)(Math.random()*7)-5;
              } else
              {
                //Y changes by a value between 0 and 2, inclusive.
                myY = myY + (int)(Math.random()*3);
              }
            }
          }
        }
      }
    }

    {
      //X and Y change by an integer between -5 and 5, inclusive.
      myX = myX + (int)(Math.random()*11)-5;
      myY = myY + (int)(Math.random()*11)-5;

      //X and Y "scrollover"
      if (myX > 515)
      {
        myX = -15;
      }
      if (myX < -15)
      {
        myX = 515;
      }

      if (myY > 515)
      {
        myY = -15;
      }
      if (myY < -15)
      {
        myY = 515;
      }
    }
  }

  void show()
  {    
    if (mySize > 35)
    {
      deathSize = mySize;
      deathFlag = true;
      deathTimer = 0;
    }

    //      if (deathFlag)
    //      {
    //        mySize = mySize - 1;
    //        deathTimer = 0;
    //        deathTimer++;
    //      }
    //
    //      if (mySize == 0)
    //      {
    //        deathFlag = false;
    //        deathTimer++;

    if (deathFlag)
    {
      if (deathSize > 0)
      {
        mySize--;
      }

      deathTimer++;

      deathSize--;

      if (deathTimer > 30*randomTimer2)
      {
        deathFlag = false;

        mySize = 15;

        color1 = (int)(Math.random()*155)+100;
        color2 = (int)(Math.random()*155)+100;
        color3 = (int)(Math.random()*155)+100;

        myX = (int)(Math.random()*500);
        myY = (int)(Math.random()*500);         

        deathTimer = 0;
      }
    }

    strokeWeight(1);
    fill(color1, color2, color3, 200);
    ellipse(myX, myY, mySize, mySize);
  }
}

class Food
{
  int foodX, foodY;
  boolean foodFlag;
  int foodTimer;

  Food()
  {
    foodTimer = 0;

    foodFlag = false;
    foodX = (int)(Math.random()*300)+100;
    foodY = (int)(Math.random()*300)+100;
  }

  void randomize()
  {
    foodX = (int)(Math.random()*300)+100;
    foodY = (int)(Math.random()*300)+100;
  }

  void show()
  {
    foodFlag = true;
    noStroke();
    fill(250, 210, 135);
    rect(foodX-5, foodY-5, 10, 10);
  }
}
