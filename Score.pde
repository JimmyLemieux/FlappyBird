class Score {

  PVector first_digit_vec;
  PVector second_digit_vec;

  PImage ones_digit_img;
  PImage tens_digit_img;
  Score() {
      //INIT
  }


  void temp_rectangle_place(int score) {
    // The first digit will go in the center
    // When the score reaches double digits
    if (score < 10) {
      first_digit_vec = new PVector(width/2, height/2 - 180);
      //rect(first_digit_vec.x, first_digit_vec.y, 40, 75);
    } else {
      //These vectors will be used for rendering the images
      first_digit_vec = new PVector(width/2 + 10, height/2 - 180);
      second_digit_vec = new PVector(width/2 - 30, height/2 - 180);
    }
  }

  void update_score(int score) {
    int ones_digit = 0;
    int tens_digit = 0;
    if (score < 10) {
      //Render at the first rectangle vec
      ones_digit = score;
      ones_digit_img = loadImage(score + "-score.png");
      image(ones_digit_img, first_digit_vec.x, first_digit_vec.y);
    } else {
      tens_digit = score / 10;
      ones_digit = score % 10;
      tens_digit_img = loadImage(tens_digit + "-score.png");
      image(tens_digit_img, second_digit_vec.x, second_digit_vec.y);
      ones_digit_img = loadImage(ones_digit + "-score.png");
      image(ones_digit_img, first_digit_vec.x, first_digit_vec.y);
    }
  }

  void render_score(int score) {
    temp_rectangle_place(score);
    update_score(score);
    if(score == 99){
      score = 0;
    }
  }
}