import remixlab.dandelion.core.*;
import remixlab.proscene.*;

import remixlab.dandelion.geom.*;
public Scene scene;
InteractiveFrame Avion;
PShape plane;
float speed=0;
float posZ=0;
float posX=0;
float posY=0;
float eyeZ=520;
float angle=0.01;
float verticalAngle=0;
float yawAngle=0;
float rollAngle= 0;
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
  Avion = new InteractiveFrame(scene, plane);
  
  Avion.scale(5);
 // Ecuaciones para movimiento no borrar
 // Avion.setTrackingEyeDistance(50);
  //Avion.setTrackingEyeAzimuth(PI);
  //Avion.setTrackingEyeInclination(PI);
  //scene.setAvatar(Avion);
    scene.showAll();
  
  
   //scene = new Scene(this); // create a Scene instance
  // models = plane;
  
}

void draw(){
  background(255);
  lights();
  
  scene.drawFrames();
  
  translate(width/2,height/2);
  rotateZ(PI);
  scale(25);
  
  fill(0);
  textSize(1);
  //textAlign(LEFT);
  textMode(SHAPE);
  rotateZ(PI);
  text("speed "+str(speed),3,-10,0);
  text("posZ "+str(posZ),5,-8,0);
  rotateZ(-PI);
  moving();
  
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == SHIFT) {//ACELERADOR
      speed+=0.001;
      //posZ-=speed;
      //plane.translate(posX,posY,posZ);
      //camera(-400, 0, 0, 0,0,20, 1,1,-1);
    }
    if (keyCode == CONTROL){//FRENO
      speed-=0.001;
    }
  }
  if(key == 'w'){//PITCH UP
    verticalAngle+=angle;
    plane.rotateX(angle);
    if (verticalAngle>0){
    up = true;}
    if (verticalAngle==0){
    up= false;}
  }
  if(key == 's'){//PITCH DOWN
    verticalAngle-=angle;
    plane.rotateX(-angle);
    if (verticalAngle<0){
    down=true;}
    if (verticalAngle==0){
    down=false;}
  }
  if(key == 'e'){//RIGHT YAW
    yawAngle+=angle;
    plane.rotateY(angle);
    if(yawAngle>0){
    rightYaw=true;}
    if(yawAngle==0){
    rightYaw=false;}
  }
  if(key == 'q'){//LEFT YAW
    yawAngle-=angle;
    plane.rotateY(-angle);
    if(yawAngle<0){
    leftYaw=true;}
    if(yawAngle==0){
    leftYaw=false;}
  } 
  if(key == 'd'){//RIGHT ROLL
    rollAngle+=angle;
    plane.rotateZ(angle);
    if(rollAngle>0){
    rightRoll=true;}
    if(rollAngle==0){
    rightRoll=false;}
  }
  if(key == 'a'){//LEFT ROLL
    rollAngle-=angle;
    plane.rotateZ(-angle);
    if(rollAngle<0){
    leftRoll=true;}
    if(rollAngle==0){
    leftRoll=false;}
  }
}

void moving(){
  /*
  if(up == true){
  posX+=speed*cos(verticalAngle);
  posZ+=speed*sin(verticalAngle);}
  if(down == true){
  posX-=speed*cos(verticalAngle);
  posZ-=speed*sin(verticalAngle);}
  
  */
  shape(plane);
  posZ-=speed;
  plane.translate(posX,posY,posZ);
  //eyeZ=-posZ;
  
}
