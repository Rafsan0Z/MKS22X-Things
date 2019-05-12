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
 void collide();
 float getX();
 float getY();
}

abstract class Thing implements Displayable, Collideable {
  float x, y;//Position of the Thing
  float radius;
  Thing(float x, float y) {
    this.x = x;
    this.y = y;
    radius = 0;
  }
  float getX() {return x;}
  float getY() {return y;}
  boolean isTouching(Thing other){
    return sqrt(sq(this.x-other.x)+sq(this.y-other.y)) < this.radius + other.radius + 5;
  }
  abstract void display();
  abstract void collide();
}

class Rock extends Thing implements Collideable {
  float h,w;
  int choice;
  PImage rimage;
  
  float getX(){return x+w/2;}
  float getY(){return y+h/2;} //for collision detection. do not touch
  void collide(){};
  
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
    move = (int)random(0,3);
    line = 0;
  }
  float baseW;
  float dx;
  float change = 1;
  float centerx, centery;
  float radius;
  int line;
  int lastStretch;
  float xi = random(-2,2);
  float yi = random(-2,2);
  float angle = random(360);
  int xspeed = 50;
  int yspeed = 50;
  int move;
  void display(){
    image(clearrock,x,y,w,h);
    fill(255);
    ellipse(x+(w)/3,y+10,(w)/6, 10);
    ellipse(x+2*(w)/3,y+10,(w)/6, 10);
    fill(0);
    ellipse(x+(w)/3,y+11,(w)/10, 6);
    ellipse(x+2*(w)/3,y+11,(w)/10, 6);
    fill(255);
    //text("display: "+w,20,20);
  }
  void move() {
    if (move == 0) {
      move0();
    }
    if (move == 1) {
      move1();
    }
    if (move == 2) {
      move2();
    }
  }
  
  void move0() {

    if (centerx + dx + w +20>= width){
      centerx-=2; //println("dx: "+x);
    }
    else if (centerx + dx < 0) {
      centerx-=2;
    }
    else if (centery + sqrt(radius*radius-dx*dx) >= height-h){
      centery-=2;
    }
    else if (centery + sqrt(radius*radius-dx*dx) < 0) {
      centery-=2;
    }
    x = centerx + dx;
    y = centery + sqrt(radius*radius-dx*dx);
    dx -= change;
    if (dx < radius * -1 || dx > radius) {
      
      change *= -1;
    }
  }
  
  void move1() {
    x+= change;
    y = 40*sin(x/20)+centery;
    if (x > width - w || x < 0) {
      change*=-1;
    }
    if (y > height - h) {
      centery--;
    }
    if (y < 0) {
      centery++;
    }
  }
  
  void move2() {
 
    if (line == 0) {
      x+=1;
    }
    if (line == 1) {
      y+=1;
    }
    if (line == 2) {
      x-=1;
    }
    if (line == 3) {
      y-=1;
    }
    change++;
    if (change > 300) {
      line++;
      if (line > 3) {
        line = 0;
      }
      change = 0;
    }
    if (x < 0) {
      line = 0;
    }
    if (x > width - w) {
      line = 2;
    }
    if (y < 0) {
      line = 1;
    }
    if (y > height - h) {
      line = 3;
    }
  }
  
  void move3() {
    angle += 0.025;

    if (y >= height-h || y <= 0){
      yi *= -1;
    }
  
    if (x >= width-w || x <= 0){
      xi *= -1;
    }

    x = xspeed/15* pow(cos(angle),3) + x;
    y = yspeed/15* pow(sin(angle),3) + y;
    
  }
  
}

class Ball extends Thing implements Moveable,Collideable {
  Ball(float x, float y) {
    super(x, y);
    size = (int)random(40)+ 40;
    dx = (int)random(2,3);if((int)random(2) == 0){dx *= -1;}
    dy = (int)random(2,3);if ((int)random(2) == 0){dy *= -1;}
    c = color((int)random(256),(int)random(256),(int)random(256));
    radius = size/2;
    speed = 1;
    direction = random(2*PI);
  }
  Ball(float x, float y, float dx, float dy){
    this(x,y);
    this.dx = dx;
    this.dy = dy;
  }
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
  void collide(){
    for (Collideable coll : ListOfCollideables){
      if (coll != this && coll.isTouching(this)){
        PVector v = new PVector(dx,dy);
        if (v.mag() > 4){v.setMag(v.mag()*.5);}
        PVector f = new PVector(getX() - coll.getX(),getY() - coll.getY());
        f.normalize();
        v.add(f);
        dx = v.x;
        dy = v.y;
      }
    }
  }
  void move() {
    if (x <= size/2 || x > width - size/2 - 5){
      dx*=-1; //dy*=random(.9,1.1);
    }
    else if (y <= size/2 || y > height - size/2 - 5){
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
  }else if( x < 0){
    return PI + atan(y/x);
  }else if (x > 0){
    if (y > 0){return atan(y/x);}
    else if (y < 0){return 2*PI + atan(y/x);}
  }
  return 0.0;
}
float calculateBounce(float dx, float dy, float sx, float sy){
  println("\n dx: "+dx + " dy: " + dy);
  float angleOfNormal = atan2(sx,sy); 
  float angleOfIncidence = atan2(dy,dx); println("indcidence: "+degrees(angleOfIncidence));
  //if (sy < 0){angleOfNormal+=PI; angleOfIncidence+=PI;}
  println("norm:" + degrees(angleOfNormal)%360);
  float angleOfReflection = 2*(angleOfNormal) - angleOfIncidence;
  return angleOfReflection;
}

void setup() {
  //println(slopeToRadians(1,1));
  //println(calculateBounce(0,1,1,0));
  //println(PI*3/2);
  size(1000, 600);
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollideables = new ArrayList<Collideable>();
  Ball b = new Ball(60, 60,1,1);
  thingsToDisplay.add(b);
  thingsToMove.add(b);
  ListOfCollideables.add(b);
  b = new Ball(width-60, height-60,-1,-1);
  thingsToDisplay.add(b);
  thingsToMove.add(b);
  ListOfCollideables.add(b);
  
  for (int i = 0; i < 10; i++) {
    b = new Ball(60+random(width-100), 60+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    ListOfCollideables.add(b);
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
  clearrock = loadImage("rock.png");
  clearrock2 = loadImage("rock2.png");
  tick = 0;
}
void draw() {
  background(255);
  for (Collideable c: ListOfCollideables){
    c.collide();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  for (Displayable thing : thingsToDisplay) {
    thing.display();
  } 
  tick++;
}
