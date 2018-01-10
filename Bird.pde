//The main properties of the Bird.
class Bird {
  float gravity = 1.3;
  float velocity = 1.0;
  float impulse = 0.3;
  float flare = 2.3;
  float bird_angle = 0;
  PVector birdPos;
  ArrayList<PImage> ani;
  int ani_index = 0;
  int ani_frame = 0;

  float tempX, tempY;
  float angle_change = 45;


  Bird(PVector position) {
    this.birdPos = position;
    ani = init_animation(3);
  }


  //Load each keyframe of the animation into a PImage array.
  //This will be the main init step of ani
  ArrayList init_animation(int frames) {
    ani = new ArrayList<PImage>();
    for (int i =0; i<frames; i++) {
      imageMode(CORNER);
      ani.add(loadImage(i +".png"));
      ani.get(i).resize(45, 30);
    }
    return ani;
  }

  int ani_ticker(int frames) {
    ani_index++;
    if (ani_index == frames) {
      ani_index = 0;
    }
    return ani_index;
  }

  float angle_bird_damping(float vel) {
    float angle = vel/10;    
    return angle;
  }


  //This will be the gravity being applied to the bird
  float bird_Y_phys(float tempY) {
    velocity += gravity;
    tempY += velocity;
    return tempY;
  }

  //This will happen when the mouse is pressed
  void bird_impulse() {
    gravity = 0;
    velocity -= flare + 2;
    bird_angle += 15;
  }

  void reset_rotation() {
    rotate(radians(0));
  }

  boolean isOffScreen(int tempY) {
    return (tempY >= height - 25 || tempY <= 0);
  }


  void renderBird() {



    gravity = 0.1; 
    bird_angle = angle_bird_damping(velocity);
    //Lets draw a rectangle around the bird
    tempX = birdPos.x;
    tempY = birdPos.y;
    //rect(tempX,tempY,30,30);

    pushMatrix();
    translate(tempX, tempY);
    rotate(radians(velocity * 5));
    fill(22);
    //This is the rectagle that is rotated
    //rect(0,0,30,30);
    image(ani.get(ani_ticker(3)), 0, 0);

    //Get the angle between the rotating shape and the current static shape
    // PVector dynRect = new PVector(0,0);
    //PVector statRect = new PVector(tempX,tempY);
    //float rot_angle = PVector.angleBetween(dynRect,statRect);
    popMatrix();
    // image(ani.get(ani_ticker(3)),birdPos.x,birdPos.y);
    birdPos.y = bird_Y_phys(birdPos.y);
    if (isOffScreen((int)birdPos.y)) {
      gravity = 0;
      velocity = 0; 
      flare = 0;
      //Game over
    }
  }
}