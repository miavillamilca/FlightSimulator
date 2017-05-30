import remixlab.dandelion.core.*;
import remixlab.proscene.*;
import remixlab.dandelion.geom.*;


public Scene scene;
InteractiveFrame Avion, Piso, Fondo, Cerca, Cielo;

PShape plane, floor, LeftHorizon, RightHorizon, Ceiling;
PFont font;

float speed=0;
float maxSpeed=0.3;
float angle=5;
float aux=0;
float aux2=0;

float posZ=0;
float posX=0;
float posY=0;
float orX=-90;
float orY=0;
float orZ=90;
float pitchAngle=0;
float eyeInc=150;
float eyeDist=30;

boolean up = false;
boolean down = false;
boolean leftRoll = false;
boolean rightRoll = false;
boolean leftYaw = false;
boolean rightYaw= false;
boolean shifter = false;


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
  img.resize(100,100);
  floor = createShape();
  floor.beginShape();
  floor.textureMode(IMAGE);
  floor.texture(img);
  floor.vertex(0, 0, -50, 0 ,0);
  floor.vertex(600, 0, -50,100 ,0);
  floor.vertex(600, 0, 50, 100,100);
  floor.vertex(0, 0, 50, 0 ,100);

  floor.endShape(CLOSE);
 
//Bosque fondo 
  PImage img2 = loadImage("fondo.jpg");
  img2.resize(100,100);
  LeftHorizon = createShape();
  LeftHorizon.beginShape();
  LeftHorizon.textureMode(IMAGE);
  LeftHorizon.texture(img2);
 
  LeftHorizon.vertex(0, 0, 50, 0, 0);
  LeftHorizon.vertex(0, 70, 50, 0, 100);
  LeftHorizon.vertex(600, 70, 50, 100, 100);
  LeftHorizon.vertex(600, 0, 50, 100, 0);
  LeftHorizon.endShape(CLOSE);
  
  //BosqueCerca
  
  RightHorizon = createShape();
  RightHorizon.beginShape();
  RightHorizon.textureMode(IMAGE);
  RightHorizon.texture(img2);
  RightHorizon.vertex(0, 0, -50, 0, 0);
  RightHorizon.vertex(0, 70, -50, 0, 100);
  RightHorizon.vertex(600, 70, -50, 100, 100);
  RightHorizon.vertex(600, 0, -50, 100, 0);
  RightHorizon.endShape(CLOSE);
  
  PImage img3 = loadImage("sky.jpg");
  img3.resize(100,100);
  Ceiling = createShape();
  Ceiling.beginShape();
  Ceiling.textureMode(IMAGE);
  Ceiling.texture(img3);
  Ceiling.vertex(0, 70, 50, 0, 0);
  Ceiling.vertex(0, 70, -50, 0, 100);
  Ceiling.vertex(600, 70, -50, 100, 100);
  Ceiling.vertex(600, 70, 50, 100, 0);
  Ceiling.endShape(CLOSE);
  
  
  
  //Creacion IFrames en la escena
 
  Piso = new InteractiveFrame(scene, floor);
 
  Cielo = new InteractiveFrame (scene, Ceiling);
  Cerca = new InteractiveFrame(scene, RightHorizon); 
  Fondo = new InteractiveFrame(scene, LeftHorizon);
  Piso.removeBindings();
  Cerca.removeBindings();
  Fondo.removeBindings();
  Cielo.removeBindings();
  
  Avion = new InteractiveFrame(scene, plane);
  Avion.setTrackingEyeDistance(eyeDist);
  Avion.setTrackingEyeAzimuth(PI);
  Avion.setTrackingEyeInclination(radians(eyeInc));
  
  Avion.setPosition(new Vec(0, 0, 0));
  Avion.setRotation(radians(orX),orY,radians(orZ),0);
  scene.setAvatar(Avion);
  scene.showAll();
  print(Avion.info());
  
  

}

void draw(){
  Avion.setTrackingEyeDistance(eyeDist);
  Avion.setTrackingEyeAzimuth(PI);
  Avion.setTrackingEyeInclination(radians(eyeInc));
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
  check();
  
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == SHIFT && speed<maxSpeed) {//ACELERADOR
      speed+=0.01;
      eyeDist+=0.5;
    }
    if (keyCode == CONTROL && speed>=0){//FRENO setear en 0.2 ya uqe nunca puede quedase quieto
      speed-=0.01;
      eyeDist-=0.5;
  }
  }
  if(key == 'W'){//PITCH UP
    //verticalAngle+=angle;
    orY+=angle;
    //pitchAngle-=1;
    //plane.rotateX(radians(pitchAngle));
    //if (orY>0){
    //down = true;}
    //if (orY==0){
    //down= false;}
    check();
  }
  if(key == 'S'){//PITCH DOWN
    //verticalAngle-=angle;
    orY-=angle;
    //pitchAngle+=1;
    //plane.rotateX(-radians(pitchAngle));
    //if (orY<0){
    //up=true;}
    //if (orY==0){
    //up=false;}
    check();
  }
  if(key == 'E'){//RIGHT YAW
    //yawAngle+=angle;
    orZ+=angle;
    //if(orZ>0){
    //rightYaw=true;}
    //if(orZ==0){
    //rightYaw=false;}
  }
  if(key == 'Q'){//LEFT YAW
    orZ-=angle;
    //if(orZ<90){
    //leftYaw=true;}
    //if(orZ==90){
    //leftYaw=false;}
  } 
  //if(key == 'D'){//RIGHT ROLL
  //  orX+=angle;
  //  if(orX>0){
  //  rightRoll=true;}
  //  if(orX==0){
  //  rightRoll=false;}
  //}
  //if(key == 'A'){//LEFT ROLL
  //  orX-=angle;
  //  if(orX<0){
  //  leftRoll=true;}
  //  if(orX==0){
  //  leftRoll=false;}
  //}
  if (key== 'R'){
  reset();}

}

void moving(){
  if (leftYaw){
    aux=norm(orZ,90,180);
    posX-=(1-aux)*speed;
    posZ+=aux*speed;
  }
  if(rightYaw){
  aux=norm(orZ,0,90);
  posZ+=(1-aux)*speed;
  posX+=aux*speed;
}
  if(!up && !down && !leftYaw && !rightYaw){
  posX+=speed;
}
  if(up){
    aux2=norm(orY,-90,0);
    posY+=aux2*speed;
    posX+=aux2*speed;
  }
  if (down){
    aux2=norm(orY,0,90);
    posY-=aux2*speed;
    posX+=speed;
  }
  
  Avion.setPosition(new Vec(posX, posY, posZ));
}


void  drawText(){
  fill(255);
  scene.beginScreenDrawing();
  text("speed: " + (float)speed,5,20);
  text("yaw angle: " + (float)orZ,5,40);
  text("pitch angle: " + (float)orY,5,60);
  text("aux: "+ (float)aux,5,80);
  text("up: "+up,5,100);
  text("down: "+down,5,120);
  text("left: "+leftYaw,5,140);
  text("right: "+rightYaw,5,160);
  scene.endScreenDrawing();
}

void check(){
  if (orY<0){
    up=true;}
    if (orY==0){
    up=false;}
if (orY>0){
    down=true;}
    if (orY==0){
    down=false;}
    if(orZ<90){
    leftYaw=true;}
    if(orZ==90){
    leftYaw=false;}
    if(orZ>90){
    rightYaw=true;}
    if(orZ==90){
    rightYaw=false;}
}

void reset(){
  speed=0;
  maxSpeed=0.3;
  angle=5;
  aux=0;
  aux2=0;

  posZ=0;
  posX=0;
  posY=0;
  orX=-90;
  orY=0;
  orZ=90;
  pitchAngle=0;
  eyeInc=150;
  eyeDist=30;
}