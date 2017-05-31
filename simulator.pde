import remixlab.dandelion.core.*;
import remixlab.proscene.*;
import remixlab.dandelion.geom.*;

public Scene scene;
InteractiveFrame Avion, Piso, Fondo, Cerca, Cielo;

Quat q = new Quat();
Vec dir= new Vec();

PShape plane, floor, LeftHorizon, RightHorizon, Ceiling;
PFont font;

float speed=0;
float maxSpeed=0.3;
float angle=5;
float aux=0;
float top=0;
float bottom=0;
float eyeAux=0;

float posZ=0;
float posX=0;
float posY=0;
float orX=-180;
float orY=90;
float orZ=0;
float eyeInc=150;
float eyeDist=30;
float angleA=0;
float angleB=0;

boolean shifter = false;
boolean shifter2 = false;


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
  //Avion.setRotation(radians(orX),orY,radians(orZ),0);
  
  q.fromEulerAngles(radians(orX),radians(orY),radians(orZ));
  Avion.rotate(q);
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
  //Avion.setOrientation(orX,orY,orZ,0);  
  background(0);
  lights();
  scene.drawFrames();
  translate(width/2,height/2);
  rotateZ(PI);
  moving();
  drawText();
  moveEye(); 
  //Avion.setPosition(0,0,20);
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == SHIFT && speed<maxSpeed) {//ACELERADOR
      speed+=0.01;
      //eyeDist+=0.5;
    }
    if (keyCode == CONTROL && speed>=0){//FRENO setear en 0.2 ya uqe nunca puede quedase quieto
      speed-=0.01;
      //eyeDist-=0.5;
  }
  }
  if(key == 'W'){//PITCH DOWN
    orY+=angle;
    angleA-=angle;
    q.fromEulerAngles(radians(angle),0,0);
    Avion.rotate(q);
    bottom-=angle/2;
    shifter=true;
  }
  if(key == 'S'){//PITCH UP
    orY-=angle;
    angleA+=angle;
    q.fromEulerAngles(-radians(angle),0,0);
    Avion.rotate(q);
    bottom-=angle/2;
    shifter2=true;
  }
  if(key == 'E'){//RIGHT YAW
    orZ-=angle;
    angleB-=angle;
    q.fromEulerAngles(0,-radians(angle),0);
    Avion.rotate(q);
  }
  if(key == 'Q'){//LEFT YAW
    orZ+=angle;
    angleB+=angle;
    q.fromEulerAngles(0,radians(angle),0);
    Avion.rotate(q);
  } 
  if(key == 'D'){//RIGHT ROLL
    orX+=angle;
    q.fromEulerAngles(0,0,radians(angle));
    Avion.rotate(q);
  }
  if(key == 'A'){//LEFT ROLL
    orX-=angle;
    q.fromEulerAngles(0,0,-radians(angle));
    Avion.rotate(q);
  }
  if (key== 'R'){
  reset();}
}

void moving(){
  posX+=speed*(cos(radians(angleA))*cos(radians(angleB)));
  posY+=speed*(sin(radians(angleA)));
  posZ+=speed*(sin(radians(angleB))*cos(radians(angleA)));
  
  Avion.setPosition(new Vec(posX,posY,posZ));
}

void  drawText(){
  fill(255);
  scene.beginScreenDrawing();
  text("speed: " + (float)speed,5,20);
  text("shifter: "+shifter,5,180);
  text("top: "+top,5,200);
  text("bottom: "+bottom,5,220);
  scene.endScreenDrawing();
}


void reset(){
  speed=0;
  maxSpeed=0.3;
  angle=5;
  aux=0;
  bottom=0;
  posZ=0;
  posX=0;
  posY=0;
  orX=-90;
  orY=0;
  orZ=90;
  eyeInc=150;
  eyeDist=30;
}

void moveEye(){
  aux=norm(speed,0,maxSpeed);
  aux*=20;
  aux+=30;
  if(eyeDist<aux){
    eyeDist+=0.1;
  }else if (aux<eyeDist){
    eyeDist-=0.1;
  }
}