import peasy.*;
import processing.opengl.*;
import java.awt.event.*;

PeasyCam cam;
PShape map;

PVector position = new PVector(450, 450);
PVector movement = new PVector();
PVector rotation = new PVector();
PVector velocity = new PVector();
float rotationSpeed = 0.035;
float panningsSpeed = 0.035;
float movementSpeed = 0.05;
float scaleSpeed = 0.25;
float fScale = 2;

void setup(){
  
  
  map = loadShape("Mercator_Projection.svg");
  
  
  /*
  //Peasy Cam viewer
  size(1000,1000,P3D);
  cam = new PeasyCam(this, 250,250,100,500);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(1000);
  */
  
  //Manual Viewer
  // left mouse button + mouse drag = rotate
  // right mouse button + mouse drag = translate
  // mouse scroll wheel = scale
  size(900, 900, OPENGL);
  smooth();
  stroke(255, 255, 0);
  strokeWeight(1);
  fill(150, 200, 250);
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
  }});

}
 

 
void draw() {
  if (mousePressed) {
    if (mouseButton==LEFT) velocity.add( (pmouseY-mouseY) * 0.01, (mouseX-pmouseX) * 0.01, 0);
    if (mouseButton==RIGHT) movement.add( (mouseX-pmouseX) * movementSpeed, (mouseY-pmouseY) * movementSpeed, 0);
  }
  velocity.mult(0.95);
  rotation.add(velocity);
  movement.mult(0.95);
  position.add(movement);
  
  background(255);
  lights();
  
  translate(position.x, position.y, position.z);
  rotateX(rotation.x*rotationSpeed);
  rotateY(rotation.y*rotationSpeed);
  scale(fScale);
  
  /*
  //rotation debugging box
  box(90);
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
  */
  
  shape(map,-250,-250,1000,1000);
}
 
void mouseWheel(int delta) {
  fScale -= delta * scaleSpeed;
  fScale = max(0.5, fScale);
}




