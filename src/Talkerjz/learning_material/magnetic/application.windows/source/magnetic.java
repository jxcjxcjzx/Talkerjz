import processing.core.*; 
import processing.xml.*; 

import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class magnetic extends PApplet {

/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6884*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */


/////////////////////////////
//                         //
//    Magnetic Bubbles     //
//                         //
/////////////////////////////

// (c) Martin Schneider 2010


int  bg0 = 0, bg1 = 255, c1 = 0xffff6666, c2 = 0xff6666ff;
boolean dark = true;
int maxiter = 10;
int minsize = 8;
int maxsize = 50;
int cellwall = 8;

ArrayList bubbles = new ArrayList();
float x1, y1, r;
float w, h;


public void setup() {
  size(1200, 660);
  w = width/2;
  h = height/2;
  background(dark ? bg0: bg1);
  smooth();
}


public void draw() {
  
  int n = bubbles.size();

  noStroke();
  fill(dark ? bg0 : bg1, 100);
  rect(0, 0, width, height);
    
  // move bubbles
  for(int i=0; i<n; i++) getBubble(i).move();
  
  // resolve collisions
  boolean c = true;
  for(int cc=0; cc<maxiter & c; cc++) {
    c = false;
    for(int i=0; i<n; i++) c |= getBubble(i).collide();
  } 
 
  // draw bubbles
  for(int i=0; i<n; i++) getBubble(i).draw();
  
  interact();
}


/// user interaction 

public void interact() {
  if(mousePressed) {
   bubble(x1, y1, r, mouseButton == LEFT ? c1 : c2); 
  }
}

public void mousePressed() {
  x1 = mouseX;
  y1 = mouseY;
  r = minsize;
}

public void mouseDragged() {
  r = constrain(dist(x1, y1, mouseX, mouseY), minsize, maxsize);
}

public void mouseReleased() {
  bubbles.add(new Bubble(x1, y1, r, mouseButton==LEFT ? +1: -1));
}

public void keyPressed() {
  switch(key) {
    case 'r': bubbles = new ArrayList(); break;
    case 'w': dark = !dark; break;
  }
}


// helper functions

public Bubble getBubble(int i) {
  return (Bubble) bubbles.get(i);
}

public void bubble(float x, float y, float r, int c) {
  fill(c);
  strokeWeight(cellwall); stroke(c, 128);
  ellipse(x, y, 2*r-cellwall, 2*r-cellwall);
}




class Bubble {
  
  float x, y, r;
  int c;
 
  Bubble(float _x, float _y, float _r, int _c) {
    x = _x;
    y = _y;
    r = _r;
    c = _c; 
  }

  public void move() {
    
    // attract to opposite charges
    int n = bubbles.size();
    for(int i=0; i<n; i++)  {
      Bubble a = getBubble(i);
      if(a==this) continue;
      float d = dist(x, y, a.x, a.y);
      float dd = min(500 / d, 1) * a.r * a.r / r / r; 
      float f = (c != a.c) ? dd : -dd;
      float dir = atan2(a.y-y, a.x-x);
      x += f * cos(dir) ;
      y += f * sin(dir) ;
    }
   
  }
  
  public boolean collide() {
    
    boolean c = false;
  
    // bubble collisions
    for(int i=0; i<bubbles.size(); i++)  {
      c |= collide(getBubble(i));
    }
   
    // wall collisions
    if(x<r)  { x=r ; c = true; }
    if(x>width-r) { x = width-r; c = true; }
    if(y<r) { y = r; c = true; }
    if(y>height-r) { y = height-r; c = true; }
      
    return c;
    
  }
  
  public boolean collide(Bubble a) {
    
    if(a == this) return false;  // no self collision

    float d = dist(x, y, a.x, a.y);
    float rr =  r + a.r;
    
    // correct bubble positions
    if (d<rr) {
      float t = (rr-d)/rr;
      float dx =  t * (x-a.x);
      float dy =  t * (y-a.y);
      x += dx; y += dy;
      a.x -= dx; a.y -= dy;
      return true;
    }
    return false;
  }
     
  public void draw() {
    bubble(x, y, r, c>0 ? c1 : c2);
  }
  
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "magnetic" });
  }
}
