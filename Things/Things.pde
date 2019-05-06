PImage rock;
interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  float h,w;
  Rock(float x, float y) {
    super(x, y);
    h = 20+random(30);
    w = 20+random(30);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    //fill(0,0,255);
    image(rock,x,y,w,h);
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
  }
}

class Ball extends Thing implements Moveable {
  Ball(float x, float y) {
    super(x, y);
    size = 60;
    dx = 1;
    dy = 1;
  }
  int size;
  int dx;
  int dy = 1;
  void display() {
    fill(255,0,0);
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

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
  rock = loadImage("rock.jpg");
}
void draw() {
  background(255);
  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
