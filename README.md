# MKS22X-Things
-----------------------------------------------------------------Day 1----------------------------------------------------------------
Goal: 
    Come up with creative ways to display and move the object. 

Free Form Group Lab:
    Groups of 4. One person creates a repo, and adds the others ad collaborators)
    Each Person in the group is responsible for one thing:
        Rock (display only)
        LivingRock (move only)
        Ball (display only)
        Ball (move only)
    Each group should work in pairs, where each member is paired up with someone doing the opposite method (display + move pair up)
    Each pair should help eachother because you are both responsible for understanding drawing and moving!
    If you are done with your method feel free to work on another method with someone!
    

GUIDELINES:
    Do not edit setup/draw
    You MAY edit the class methods, and add extra instance variables to the classes.
    Move:
        Keep the objects on the screen.
    Display:
        Keep the objects size appriximately 50 by 50 but not larger.

PROGRESSION:
Move:
    a) Random Movement to test it out
    b) A simple path (may need some instance variables from here onward)
    c) A more complex path
    d) Randomly choose between several paths.  (you may need a new constructor for this)
    
Display: 
    a) A simple shape
    b) A series of shapes (may need some instance variables from here onward)
    c) An Image 
    d) Choose randomly: Simple, Complex, or Image  (you may need a new constructor for this)
    
--------------------------------------------------------Day 2------------------------------------------------------------

GIT README:
0. In your git readme indicate 
-Which individuals are responsible for code written independantly (Yesterday) 
-Which pair worked on what code today. (Update over time as you do things)
-Any help/outside sources

ROCK CHANGES
1. Make the rock use an image of a rock. 
    -Loading an image file into a PImage takes time, you should only do this once per image. When many copies of the image are needed: load the image once, and pass the reference to it into the rock constructor.
2. Each Rock chooses between 2 different image files randomly upon construction.

LIVING ROCK CHANGES
3. Make the living rock draw eyes on top of that image.      
    -DO NOT write redundant code. Discuss with the group how to do this.

GENERAL CHANGES
4. Make an interface Collideable with a single method:
    boolean isTouching(Thing other)

How to check if a single thing is touching any of the collideables:
ball b = new Ball(100,100);
for( Collideable c : ListOfCollideables) {
   if ( c.isTouching(b){
        // do something to the ball
    }
}
5. Add all Rock + LivingRockto the list of collideables. 

BALL CHANGES
OPTIONALLY: It makes sense to have instance variables for xspeed and yspeed.
6. Do not use random colors every frame. This is silly. Store a random color and use that all the time. 
7. Put bounce code in your Ball so they stay on the screen by bouncing off the walls, try adding a little bit of randomness to the bounce.
8. As long as a ball is  colliding with any Rock it changes color to red / (or mostly red). It reverts back to normal color when it is no longer touching.
9. Make 2 subclasses of ball, each with a different style of movement/colliding.
    Suggestions: 
    -make them bounce differently, 
    -change to different colors when colliding (red vs blue)
    -change the visuals so they look a little different.

SETUP CHANGES
10. Modify the setup to change the ball creation. Create half as one of the subclasses, and the other half should be the other subclass.

------------------------------------------------------------Credits----------------------------------------------------------------
    
 Theodore: made balls move and bounce and have different speeds. added first rock image. made living rocks stretch when they moved. made collision system. Added 1 subclass of Ball
 <br>Rafsan: fixed mistakes and added aliens (which were later deleted). Added Collideables and made proper changes in the setup. Fixed merge problems and bugs. Added 1 subclass of Ball</br>
 Ball: Rafsan and Theodore
 
 Sharon: I worked on the display method for Rock and made simple and complex shapes. Then I modified the constructor and   display method to randomly pick which of the three to show for a certain rock. Added one style of movement.

 Rock: Jackson and Sharon
