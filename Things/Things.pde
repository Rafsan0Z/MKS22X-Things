import java.util.Random;
PImage rock;
PShape ralien, rhead, rbody;
int tick;
interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable {
 boolean isTouching(Thing other); 
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing implements Collideable {
  float h,w;
  int choice;
  Rock(float x, float y) {
    super(x, y);
    h = 20+random(30);
    w = 20+random(30);
    Random rand = new Random();
    choice = rand.nextInt(3) + 1;
  }
  
  boolean isTouching(Thing other){
   return true; 
  }
  
  void complexShape() {
    // Create the shape group
    ralien = createShape(GROUP);

    // Make three shapes
    ellipseMode(CORNER);
    rhead = createShape(RECT, x+20, y+20, 30.0, 30.0);
    rhead.setFill(color(0,0,100));
    rbody = createShape(TRIANGLE, x+20, y+20, x+10, y-20,x-20,y-20);
    rbody.setFill(color(0,90,0));

    // Add the two "child" shapes to the parent group
    ralien.addChild(rbody);
    ralien.addChild(rhead);
    
   rbody = createShape(ELLIPSE, x-15, y-15, 50.0, 50.0);
   ralien.addChild(rbody);
    
    shape(ralien);
  }
  
  void rimage() {
    image(rock,x,y,w,h);
  }
  
  void simple() {
    fill(0,0,120);
    ellipse(x,y,30.0,30.0);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    if (choice == 0) {
      complexShape();
    }
    else if (choice == 1) {
      rimage();
    }
    else if (choice == 2) {
      simple();
    }
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
    dx = 1;
    dy = 1;
    lastStretch = tick;
  }
  int dx;
  int dy = 1;
  int lastStretch;
  void display(){
    int i = 0;
    if (tick - lastStretch < 100){
      i =  tick - lastStretch;
    }else if (tick - lastStretch < 200){
      i = 100 - (tick - lastStretch - 100);
    }else{lastStretch = tick;}
    image(rock,x,y,w+i,h);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
    x++;
    y++;
    if (x <= 0 || x > width){
      dx*=-1;
    }
    else if (y <= 0 || y > height){
      dy*=-1;
    }
    x+=dx;
    y+=dy;
  }
}

class Ball extends Thing implements Moveable {
  Ball(float x, float y) {
    super(x, y);
    size = 60;
    dx = (int)random(1,3);if((int)random(2) == 0){dx *= -1;}
    dy = (int)random(1,3);if ((int)random(2) == 0){dy *= -1;}
    c = color((int)random(256),(int)random(256),(int)random(256));
  }
  color c;
  int size;
  int dx;
  int dy = 1;
  void display() {
    fill(c);
    ellipse(x,y,size,size);
  }

  void move() {
    if (x <= size/2 || x > width - size/2){
      dx*=-1;
    }
    else if (y <= size/2 || y > height - size/2){
      dy*=-1;
    }
    x+=dx;
    y+=dy;
  }
}



/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;

void setup() {
  size(1000, 800);
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollideables = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
    ListOfCollideables.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
  rock = loadImage("rock.jpg");
  tick = 0;
}
void draw() {
  background(255);
  //text("********"+tick+"",20,20);
  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  tick++;
}