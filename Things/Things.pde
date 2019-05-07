import java.util.Random;
PImage rock, cuterock;
PShape ralien, rhead, rbody;
int tick;
interface Displayable {
  void display();
}

interface Moveable{
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
    h = 40+random(30);
    w = 40+random(30);
  }
  boolean isTouching(Thing other){
    return other.x == this.x && other.y == this.y;
  }
  void display() {
      image(rock,x,y,w,h);
  }
}
public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
    dx = 1;
    dy = 1;
    lastStretch = tick;
    baseW = w;
  }
  float baseW;
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
    w = baseW+i;
    image(rock,x,y,w,h);
    fill(255);
    ellipse(x+(w)/3,y+10,(w)/6, 10);
    ellipse(x+2*(w)/3,y+10,(w)/6, 10);
    fill(0);
    ellipse(x+(w)/3,y+11,(w)/10, 6);
    ellipse(x+2*(w)/3,y+11,(w)/10, 6);
  }
  void move() {
    /* ONE PERSON WRITE THIS */
    if (x <= 0 || x > width-w){
      dx*=-1;
    }
    else if (y <= 0 || y > height-h){
      dy*=-1;
    }
    x+=dx;
    y+=dy;
  }
}

class Ball extends Thing implements Moveable,Collideable {
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
  
  boolean isTouching(Thing other){
    return other.x == this.x && other.y == this.y;
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
    ListOfCollideables.add(m);
  }
  rock = loadImage("rock.jpg");
  cuterock = loadImage("cuterock.jpeg");
  tick = 0;
}
void draw() {
  background(255);
  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  } 
  tick++;
}
