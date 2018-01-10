import processing.sound.*;
int Width = 440;
int Height = 700;
int pointsLimiter = 0;
int actualPoints = 0;
//The actual Bird Class
Bird bird;

//The Pipe Class
Pipes pipes;
ArrayList<Pipes> pipe_list;

//The score
Score score;
int score_points = 0;

PImage background;

PImage base;

SoundFile flap_sound;
SoundFile point_sound;


void setup() {

  //I need to change how the file is stored and parsed
  //flap_sound = new SoundFile(this,"/Users/jameslemieux/Desktop/DMOJ/Flapcessing/wave.mp3");
  //FIXED --> I needed to create a data folder in the source files to fix the path problem!

  //This load is more efficient
  flap_sound = new SoundFile(this, "wing.mp3");
  point_sound = new SoundFile(this, "point.mp3");



  pipe_list = new ArrayList<Pipes>();
  bird = new Bird(new PVector((int)width/2, (int)height/2));
  score = new Score();
  //pipes = new Pipes(new PVector(width/2, height/2), 5, 1000);
  size(440, 700);
  background(255);
  create_pipes(2);

  background = loadImage("background-day.png");
  base = loadImage("base.png");
}

void create_pipes(int number_pipes) {
  float bottom_pipe_loc = 0;
  float top_pipe_loc = 0;
  for (int i = 1; i<=number_pipes; i++) {

    if (i == 1) {
      bottom_pipe_loc = random(320, 550);
      //Draw the bottom pipe at this location
      pipe_list.add(new Pipes(new PVector(300, bottom_pipe_loc), 90, 500, 1));
    } else {
      if (height - bottom_pipe_loc <= 250) {
        top_pipe_loc = top_pipe_loc - bottom_pipe_loc + 300;
      } else {
        top_pipe_loc = top_pipe_loc - bottom_pipe_loc + 200;
      }
      pipe_list.add(new Pipes(new PVector(300, top_pipe_loc), 90, 1500, -1));
    }
  }
}

boolean did_score(PVector bird_pos, float pipe_pos_gate) {
  //The vector is drawing at the corner of the gate and the bird
  //score_gate_pos.x = score_gate_pos.x - width / 2;
  return (pipe_pos_gate == bird_pos.x);
}

//Collision will just be held here.
//It will be best to have the flappy detect if it hits anywhere inside the box around the pipes

boolean is_hit_pipe(PVector bird_pos, PVector hit_rect,float hit_width,float hit_height) {
  return (hit_width - bird_pos.x <= hit_width || hit_height - bird_pos.y >= hit_height);
}

void remove_pipes() {
  //When you remove a pipe
  //The next pipe in the stack is pushed to index 0

  //Remove in reverse to bypass annoying index shuffle
  for (int i = pipe_list.size() - 1; i >= 0; i--) {
    pipe_list.remove(i);
  }
}

void mousePressed() {
  bird.bird_impulse(); 
  bird.reset_rotation();
  flap_sound.play();
}

void draw() {
  imageMode(CORNER);

  background(255);
  background.resize(width, height);
  image(background, 0, 0);


  fill(0);
  frameRate(60);
  rectMode(CORNER);
  bird.renderBird();
  //Just check if the first pipe in the stack is off screen
  if (pipe_list.get(0).pipe_off_screen((int)pipe_list.get(0).pipes_pos.x)) {
    println("CALL");
    //Remove the pipe from the stack
    // pipe_list.remove(0);
    remove_pipes();
    //Without creating pipes right after call, there is an index exception
    //We need to add more to the stack
    create_pipes(2);
  }



  for (Pipes p : pipe_list) {
    p.render_pipes();
    if (did_score(bird.birdPos, p.pipes_pos.x)) {
      println("HIT");
      score_points++;
      point_sound.play();
    }
    
    //Need the hit_vectors of where the rectangle is around the image in the pipe class
    println(p.hit_rects);
    
    score.render_score(score_points);
    pushMatrix();
    base.resize(width, 50);
    image(base, 0, height - 50);
    popMatrix();
  }
}