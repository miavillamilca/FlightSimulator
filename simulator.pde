import remixlab.dandelion.core.*;
import remixlab.proscene.*;
import remixlab.dandelion.geom.*;


public Scene scene;
InteractiveFrame Avion, Piso, fondo;

PShape plane, floor, LeftHorizon;
PFont font;

float speed=0;
float maxSpeed=0.3;
float angle=5;
float aux=0;

float posZ=0;
float posX=0;
float posY=0;
float orX=-90;
float orY=0;
float orZ=90;

boolean up = false;
boolean down = false;
boolean leftRoll = false;
boolean rightRoll = false;
boolean leftYaw = false;
boolean rightYaw= false;


void setup(){
  font = loadFont("FreeSans-13.vlw");
  textFont(font);
  size(600,600,P3D);
  scene = new Scene(this);
  plane = loadShape("A10.obj");
  plane.rotateZ(PI);
  plane.translate(0,-1,0);
  
  //Piso carretera tesxture
  PImage img = loadImage("img.jpg");
  img.resize(150,100);
  floor = createShape();
  floor.beginShape();
  floor.textureMode(IMAGE);
  floor.texture(img);
  floor.vertex(0, 0, -50, 0 ,0);
  floor.vertex(600, 0, -50,100 ,0);
  floor.vertex(600, 0, 50, 100,100);
  floor.vertex(0, 0, 50, 0 ,100);

  floor.endShape(CLOSE);
  //s.translate(50, 50);
  PImage fondo = loadImage("fondo.jpg");
  fondo.resize(100,100);
  LeftHorizon = createShape();
  LeftHorizon.beginShape();
  LeftHorizon.textureMode(IMAGE);
  LeftHorizon.texture(img);
  LeftHorizon.fill(0,255,0);
  LeftHorizon.vertex(0, 0, 50);
  LeftHorizon.vertex(0, 70, 50);
  LeftHorizon.vertex(600, 70, 50);
  LeftHorizon.vertex(600, 0, 50);
  LeftHorizon.endShape(CLOSE);
  
  //fondo = new InteractiveFrame(scene, LeftHorizon);
  Piso = new InteractiveFrame(scene, floor);
  Avion = new InteractiveFrame(scene, plane);
  Avion.setTrackingEyeDistance(30);
  Avion.setTrackingEyeAzimuth(PI);
  Avion.setTrackingEyeInclination(radians(150));
  //scene.setAvatar(Avion);
  scene.showAll();
  Avion.setPosition(new Vec(0, 0, 0));
  Avion.setRotation(radians(orX),orY,radians(orZ),0);
  print(Avion.info());
  

}

void draw(){
  if (speed<0){
  speed=0;}
  Avion.setOrientation(orX,orY,orZ,0);
  background(0);
  lights();
  scene.drawFrames();
  translate(width/2,height/2);
  rotateZ(PI);
  moving();
  drawText();
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == SHIFT && speed<maxSpeed) {//ACELERADOR
      speed+=0.1;
    }
    if (keyCode == CONTROL && speed>=0){//FRENO setear en 0.2 ya uqe nunca puede quedase quieto
      speed-=0.1;
  }
  }
  if(key == 'W'){//PITCH UP
    //verticalAngle+=angle;
    orY+=angle;
    if (orY>0){
    up = true;}
    if (orY==0){
    up= false;}
  }
  if(key == 'S'){//PITCH DOWN
    //verticalAngle-=angle;
    orY-=angle;
    if (orY<0){
    down=true;}
    if (orY==0){
    down=false;}
  }
  if(key == 'E'){//RIGHT YAW
    //yawAngle+=angle;
    orZ+=angle;
    if(orZ>0){
    rightYaw=true;}
    if(orZ==0){
    rightYaw=false;}
  }
  if(key == 'Q'){//LEFT YAW
    orZ-=angle;
    if(orZ<0){
    leftYaw=true;}
    if(orZ==0){
    leftYaw=false;}
  } 
  if(key == 'D'){//RIGHT ROLL
    orX+=angle;
    if(orX>0){
    rightRoll=true;}
    if(orX==0){
    rightRoll=false;}
  }
  if(key == 'A'){//LEFT ROLL
    orX-=angle;
    if(orX<0){
    leftRoll=true;}
    if(orX==0){
    leftRoll=false;}
  }
 
}

void moving(){
 if (leftYaw){
    aux=norm(orZ,-90,0);
    posZ-=(1-aux)*speed;
    posX+=aux*speed;
  }
  if(rightYaw){
  aux=norm(orZ,0,90);
  posZ+=(1-aux)*speed;
  posX+=aux*speed;
}
  else{
  posX+=speed;
}
  
  Avion.setPosition(new Vec(posX, posY, posZ));
}


void  drawText(){
  fill(255);
  scene.beginScreenDrawing();
  text("speed: " + (float)speed,5,20);
  text("yaw angle: " + (float)orZ,5,40);
  text("roll angle: " + (float)orX,5,60);
  text("aux: "+ (float)aux,5,80);
  scene.endScreenDrawing();
}