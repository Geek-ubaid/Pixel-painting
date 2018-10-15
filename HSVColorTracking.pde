import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
ParticleSystem ps;

Capture video;
OpenCV opencv;
PImage src, colorFilteredImage;
ArrayList<Contour> contours;
PImage img = createImage(640,480,RGB);
int rangeLow = 255;
int rangeHigh = 255;

void setup() {
  video = new Capture(this, 640, 480);
  video.start();
  
  opencv = new OpenCV(this, video.width, video.height);
  contours = new ArrayList<Contour>();
  
  size(1280, 480, P2D);
  ps = new ParticleSystem(new PVector(width/2, 50));

}

void draw() {
  
  if (video.available()) {
    video.read();
  }
  opencv.loadImage(video);
  
  opencv.useColor();

  src = opencv.getSnapshot();
  opencv.useColor(HSB);
  
  opencv.setGray(opencv.getH().clone());
  
  
  opencv.inRange(rangeLow, rangeHigh);
  opencv.open(10);
  opencv.close(16);
  
  colorFilteredImage = opencv.getSnapshot(); 
  contours = opencv.findContours(true, true);
  
  if (keyPressed) {
    if (key == 'c' || key == 'C') {
      println("Image captured!!");
      img = src.copy();
    }
  } 
  image(src, src.width,0);
  
  
  if (contours.size() > 0) {
    Contour biggestContour = contours.get(0);
    

    Rectangle r = biggestContour.getBoundingBox();
       
    noStroke(); 
    fill(255,10);
    ellipse(r.x + r.width/2, r.y + r.height/2, 60, 60);
    ps.addParticle(r.x+r.width/2, r.y+r.height/2,img);
    ps.run();
  }
}

void mousePressed() {
  
  color c = get(mouseX, mouseY);
  println("r: " + red(c) + " g: " + green(c) + " b: " + blue(c));
   
  int hue = int(map(hue(c), 0, 255, 0, 180));
  println("hue to detect: " + hue);

  rangeLow = hue - 5;
  rangeHigh = hue + 5;
}
  
