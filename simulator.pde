import remixlab.dandelion.core.*;
PShape plane;
float speed=0;
float posZ=0;
float posX=0;
float posY=0;
float eyeZ=520;

void setup(){
  size(600,600,P3D);
  plane = loadShape("A10.obj");
}

void draw(){
  background(255);
  lights();
  translate(width/2,height/2);
  rotateZ(PI);
  scale(25);
  shape(plane);
  fill(0);
  textSize(1.5);
  textMode(SHAPE);
  rotateZ(PI);
  text(str(posZ),8,-10,0);
  rotateZ(-PI);
  moving();
  
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == SHIFT) {
      speed+=0.001;
      //posZ-=speed;
      //plane.translate(posX,posY,posZ);
      //camera(-400, 0, 0, 0,0,20, 1,1,-1);
    }
  }
  if(key == 'w'){
     //camera(width/2.0, height/2.0, (height/1.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  } 
}

void moving(){
  posZ-=speed;
  plane.translate(posX,posY,posZ);
  eyeZ=520-posZ;
  camera(width/2.0, height/2.0, eyeZ, width/2.0, height/2.0,0 , 0, 1, 0);
}