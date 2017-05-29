import remixlab.dandelion.core.*;
import remixlab.proscene.*;
import remixlab.dandelion.geom.*;


public Scene scene;
InteractiveFrame Avion;

PShape plane;

float speed=0;
float maxSpeed=0.3;
float angle=5;

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
  size(600,600,P3D);
  scene = new Scene(this);
  plane = loadShape("A10.obj");
  plane.rotateZ(PI);
  Avion = new InteractiveFrame(scene, plane);
  Avion.setTrackingEyeDistance(30);
  Avion.setTrackingEyeAzimuth(PI);
  Avion.setTrackingEyeInclination(PI);
  scene.setAvatar(Avion);
  scene.showAll();
  Avion.setPosition(new Vec(0, 0, 0));
  Avion.setRotation(radians(orX),orY,radians(orZ),0);
  print(Avion.info());
}

void draw(){
  if (speed<0){
  speed=0;}
  Avion.setOrientation(orX,orY,orZ,0);
  background(255);
  lights();
  scene.drawFrames();
  translate(width/2,height/2);
  rotateZ(PI);
  moving();
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == SHIFT && speed<maxSpeed) {//ACELERADOR
      speed+=0.1;
    }
    if (keyCode == CONTROL && speed>0.1){//FRENO setear en 0.2 ya uqe nunca puede quedase quieto
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
  if (rightYaw){
    posX+=speed;
    posZ-=0.25*speed;
  }
  else{
  posX+=speed;
}
  
  Avion.setPosition(new Vec(posX, posY, posZ));
}