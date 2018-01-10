class Pipes {
  float translate_speed = 2f;
  PImage bottomPipe, topPipe;
  PVector pipes_pos;
  PVector score_gate_pos;
  int Width, Height;
  
  //Hit_rectangles
  PVector hit_rects;

  //Lets add in our Images 
  PImage pipe_img;
  int flip = 1;

  Pipes(PVector pos, int Width, int Height, int flip) {
    this.Width = Width;
    this.Height = Height;
    this.pipes_pos = pos;
    this.hit_rects = pos;
    
    //init the pipe images
    this.flip = flip;
    pipe_img = loadImage("pipe.png");
  }


  void render_score_gate() {
    //Get the current pipes positions
    score_gate_pos = new PVector(pipes_pos.x + Width /2, height/2);
    rect(score_gate_pos.x, score_gate_pos.y, 10, height - 100);
  }


  void translate_pipe(float speed) {
    pipes_pos.x -= speed;
  }

  boolean pipe_off_screen(int pipe_pos_x) {
    //When this is triggered. Remove from arraylist
    return (pipe_pos_x == 20);
  }

  void render_pipes() {
    //draw rectangles around the pipes that will be used for hit detection
    //The pipe already has a position along with width and height.
    //It should be fairly easy
    translate_pipe(2f);

    
    
    
    scale(1, flip);
    image(pipe_img, pipes_pos.x, pipes_pos.y);
    
    pushMatrix();
    rectMode(CORNER);
    noFill();
    hit_rects = new PVector(pipes_pos.x,pipes_pos.y);
    rect(hit_rects.x,hit_rects.y,pipe_img.width,pipe_img.height);
    popMatrix();
  }
}




//Un used code - May be helpful later...


/*
  boolean spawnNewLocation() {
 return ((int)pipes_pos.x <= width );
 }
 */

/*
  void make_pipes(int number_pipes) {
 float temp_bottom_pipe_y = 0;
 for (int i = 1; i<=number_pipes; i++) {
 //Make the bottom pipe reach a random coordinate
 if(i % 2 != 0){
 temp_bottom_pipe_y = random(340, 800);
 pipes_stack.add(new Pipes(new PVector(300,temp_bottom_pipe_y), 10,700));
 }
 //The top pipe will be based off the bottom pipes coordinates
 float top_pipe_y = 0;                                                           //Up -> Down 6,5,4,3,2,1      Left -> Right 0,1,2,3,4,5,6
 if (i % 2 == 0) {
 top_pipe_y = temp_bottom_pipe_y;
 top_pipe_y += 100;
 
 pipes_stack.add(new Pipes(new PVector(300, top_pipe_y), 10, 450));
 }
 println(temp_bottom_pipe_y);
 }
 }
 
 */


/*
  void init_pipes(int number_pipes) {
 for (int i = 1; i<=number_pipes; i++) {
 float bottomPipeY = random(340, 800);
 float topPipeY = 0;
 if (i % 2 == 0) {
 if (bottomPipeY - 300 >= 10 && bottomPipeY - 300 <=80) {
 topPipeY = bottomPipeY - 550;
 } else {
 topPipeY = bottomPipeY - 750;
 }
 pipes_stack.add(new Pipes(new PVector(300, topPipeY), 10, 450));
 }
 pipes_stack.add(new Pipes(new PVector(300, bottomPipeY), 10, 700));
 }
 }
 */




// print(pipes_stack.size());
/*
    for (int i =0; i<pipes_stack.size(); i++) {
 Pipes temp_pipe = pipes_stack.get(i); 
 rect(temp_pipe.pipes_pos.x,temp_pipe.pipes_pos.y,temp_pipe.Width,temp_pipe.Height);
 temp_pipe.translate_pipe(2f);
 // println(temp_pipe.pipes_pos.y);
 }
 */
/*
    if (pipes_stack.get(0).spawnNewLocation()) {
 pipes_stack.remove(0);
 if (pipes_stack.size() <= 2) {
 init_pipes(2);
 }
 }
 */