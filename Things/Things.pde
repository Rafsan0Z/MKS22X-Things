import java.util.Random;
PImage rock, clearrock, clearrock2;
PShape ralien, rhead, rbody;
int tick;

interface Displayable{
  void display();
}

interface Moveable{
  void move();
}

interface Collideable {
 boolean isTouching(Thing other); 
 float getX();
 float getY();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing
  float radius;
  Thing(float x, float y) {
    this.x = x;
    this.y = y;
    radius = 0;
  }
  abstract void display();
}

class Rock extends Thing implements Collideable {
  float h,w;
  int choice;
  PImage rimage;
  
  float getX(){return x+w/2;}
  float getY(){return y+h/2;} //for collision detection. do not touch
  
  Rock(float x, float y) {
    super(x, y);
    h = 40+random(30);
    w = 40+random(30);
    //rimage = clearrock;
    if (random(0,1) < 0.5) {
      choice = 0;
    }
    else {
      choice = 1;
    }
    radius = sqrt(sq(h)+sq(w))/2;
  }
  
  boolean isTouching(Thing other){
    return other.x == this.x && other.y == this.y;
  }
  
  void display() {
    /* ONE PERSON WRITE THIS */
    if (choice == 0) {
       image(clearrock,x,y,w,h);
    }
    else {
      image(clearrock2, x, y, w, h);
      
    }
  }
}
public class LivingRock extends Rock implements Moveable{
  LivingRock(float x, float y) {
    super(x, y);
    dx = 1;
    centerx = x;
    centery = y;
    radius = random(10,100);
    lastStretch = tick;
    baseW = w;
  }
  float baseW;
  float dx;
  float change = 1;
  float centerx, centery;
  float radius;
  int lastStretch;
  void display(){

    image(clearrock,x,y,w,h);
    fill(255);
    ellipse(x+(w)/3,y+10,(w)/6, 10);
    ellipse(x+2*(w)/3,y+10,(w)/6, 10);
    fill(0);
    ellipse(x+(w)/3,y+11,(w)/10, 6);
    ellipse(x+2*(w)/3,y+11,(w)/10, 6);
    //text("display: "+w,20,20);
  }
  void move() {
    //text("move: "+(x+w),20,40);
    //text("width: "+width,20,60);
    if (centerx + dx + w +20>= width){
      centerx = (width - w)/2; //println("dx: "+x);
    }
    else if (centerx + dx < 0) {
      centerx = (width - w)/2;
    }
    else if (centery + sqrt(radius*radius-dx*dx) >= height-h){
      centery= (height-h)/2;
    }
    else if (centery + sqrt(radius*radius-dx*dx) < 0) {
      centery= (height-h)/2;
    }
    x = centerx + dx;
    y = centery + sqrt(radius*radius-dx*dx);
    dx -= change;
    if (dx < radius * -1 || dx > radius) {
      change *= -1;
    }
    pushMatrix();
    rotate(radians(2));
    translate(radius/x,radius/y);
    fill(0);
    popMatrix();
    image(clearrock,x,y,w,h);
    
    
  }
}

class Ball extends Thing implements Moveable,Collideable {
  Ball(float x, float y) {
    super(x, y);
    size = (int)random(40)+ 40;
    dx = (int)random(1,3);if((int)random(2) == 0){dx *= -1;}
    dy = (int)random(1,3);if ((int)random(2) == 0){dy *= -1;}
    c = color((int)random(256),(int)random(256),(int)random(256));
    radius = size/2;
    speed = 1;
    direction = random(2*PI);
  }
  
  float getX(){return x;}
  float getY(){return y;}
  
  color c;
  int size;
  float speed;
  float direction;
  float dx;
  float dy;
  void display() {
    fill(c);
    ellipse(x,y,size,size);
  }
  
  boolean isTouching(Thing other){
    return sqrt(sq(this.x-other.x)+sq(this.y-other.y)) < this.radius + other.radius + 5;
  }
  void reflection(int slope){//up down left right
     
  }
  void move() {
    for (Collideable coll : ListOfCollideables){
      if (coll != this && coll.isTouching(this)){
        float m = (this.x - coll.getX()) / (this.y - coll.getY());
        float angleOfNormal = slopeToRadians(this.y - coll.getY(),this.x - coll.getX());
        float angleOfIncidence = slopeToRadians(dx,dy);
        float angleOfReflection = 2*angleOfNormal - angleOfIncidence;
        float magnitude = sqrt(sq(dx)+sq(dy));
        dx = magnitude*sin(angleOfReflection);
        dy = magnitude*cos(angleOfReflection);
      }
    }
    if (x <= size/2 || x > width - size/2){
      dx*=-1; //dy*=random(.9,1.1);
    }
    else if (y <= size/2 || y > height - size/2){
      dy*=-1; //dx*=random(.9,1.1);
    }
    x+=dx;
    y+=dy;
    //x+=sin(direction);
    //y+=cos(direction);
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;
float slopeToRadians(float x, float y){
  if (x == 0){
    if (y > 0){return PI/2;}
    else if (y < 0){return 3*PI/2;}
  }else if (y == 0){
    if ( x > 0){return 0;}
    else if( x< 0){return PI;}
  }else if( y < 0){
    return PI/2 + atan(y/x);
  }else if (y > 0){
    return atan(y/x);
  }
  return 0.0;
}
float calculateBounce(float dx, float dy, float sx, float sy){
  //float m = (this.x - co.getX()) / (this.y - co.getY());
  float angleOfNormal = slopeToRadians(sy,sx); //println(angleOfNormal);
  float angleOfIncidence = slopeToRadians(dx,dy); //println(angleOfIncidence);
  float angleOfReflection = 2*angleOfNormal - angleOfIncidence;
  //float magnitude = sqrt(sq(x)+sq(y));
  //dx = magnitude*sin(angleOfReflection);
  //dy = magnitude*cos(angleOfReflection);
  return angleOfReflection;
}
void setup() {
  //println(slopeToRadians(1,1));
  println(calculateBounce(1,0,0,1));
  //println(PI/2);
  
  
  size(1000, 800);
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollideables = new ArrayList<Collideable>();
  for (int i = 0; i < 6; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
    ListOfCollideables.add(r);
    ListOfCollideables.add(b);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    ListOfCollideables.add(m);
  }
  rock = loadImage("rock.jpg");
  clearrock = loadImage("rock.png");
  clearrock2 = loadImage("rock2.png");
  tick = 0;
}
void draw() {
  background(255);
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  for (Displayable thing : thingsToDisplay) {
    thing.display();
  } 
  tick++;
}
