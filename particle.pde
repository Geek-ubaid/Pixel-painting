
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  PImage frog;

  Particle(float x,float y,PImage img) {
    frog = loadImage("frog.jpg");
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 2), random(-2, 1));
    position = new PVector(x,y);
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }

  //hod to display
  void display() {
    noStroke();
    color c = img.get(int(position.x),int(position.y));
    fill(c ,lifespan);
    ellipse(position.x, position.y, 10, 10);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
