import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class NXC051 extends PApplet {

// nxC051 for NXA006PD
// Miquel Parera 
// December.2013
// License: CC-BY-SA

int d = day();    
int m = month();  
int y = year();
int h = hour();
int minut = minute();
int s = second();

float numFrames = 1;

int width = 1440;
int height = 900;
float radius = 1;

int angsum = PApplet.parseInt(random(10,100));
int radiusum = PApplet.parseInt(random(0.5f,10));
int centX = PApplet.parseInt(random(10,width));
int centY = PApplet.parseInt(random(10,height));
int stro = PApplet.parseInt(random(1,50));

public void setup() {
  size(width, height);
  frameRate(64);
  noCursor();
}

public void draw() {
  background(255);
  strokeWeight(stro);
  stroke(0,0,0,random(1,10));
  smooth();
  for(int i = 0; i < 50; i = i + 1){
  float radius = random(1,200);
  float x, y;
  float lastx = -999;
  float lasty = -999;
  for(float ang = 0; ang<=height*random(1,100); ang+=angsum){  
    radius += radiusum;
    float rad = radians(ang);
    x = centX + (radius * sin(rad));
    y = centY + (radius * cos(rad));
    if (lastx > -999) {
  line(x,y,lastx,lasty);
  }
  lastx = x;
  lasty = y;
  }
  }
  if (frameCount <= numFrames) {
  saveFrame("GRAPH-"+y+"-"+m+"-"+d+"_"+h+"-"+minut+"-"+s+"-##.jpg");
  exit();  
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "NXC051" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
