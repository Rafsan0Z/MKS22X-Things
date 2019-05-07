PImage rock;
PShape alien,top,bottom;
int tick;
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
    h = 30+random(30);
    w = 30+random(30);
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
    if (x <= 0 || x > width - w){
      dx*=-1;
    }
    else if (y <= 0 || y > height - h){
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
