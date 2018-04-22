/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/11032*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/*
* TinyGUI by Christophe Guebert
* A small example to illustrate the MinyGUI Library.
* Now with color chooser, gradient and graph editors !
* (it's Ctrl+click to add new points in graphs and gradients)
* Sorry for the lack of comments in the code...
*/

MinyGUI gui;

float time, lastTime;
MinyBoolean running;
MinyInteger speed;
MinyFloat stWidth, rSize;
MinyString timeCaption;
MinyColor borderColor;

InterpolatedFloat rotation;
ColorGradient gradient;

void mousePressed() { gui.onMousePressed();  }
void keyPressed()   { gui.onKeyPressed();    }
void keyReleased()  { gui.onKeyReleased();   }

void setup()
{
  size(600, 400);
  smooth();
  
  time = 0;
  running = new MinyBoolean(true);
  speed = new MinyInteger(2);
  timeCaption = new MinyString("0.0");
  stWidth = new MinyFloat(2.0);
  rSize = new MinyFloat(1.0);
  borderColor = new MinyColor(color(192));
  rotation = new InterpolatedFloat(1);
  rotation.add(0, 0);
  rotation.add(1.5, -PI);
  rotation.add(3.0, PI);
  rotation.add(4.0, 2*PI);
  rotation.add(6.0, 0);
  
  gradient = new ColorGradient(color(0));
  gradient.add(0, color(0, 1));
  gradient.add(0.25, color(255, 0, 0));
  gradient.add(0.5, color(0, 255, 0));
  gradient.add(0.75, color(0, 0, 255));
  gradient.add(1, color(255));
  
  gui = new MinyGUI(0, 0, 200, height);
  gui.addButton("Start", new TestButton());
  gui.addCheckBox("Running", running);
  gui.addList("Speed", speed, "slowest;slow;normal;fast;fastest");
  gui.addDisplay("Time", timeCaption);
  gui.addEditBox("Border width", stWidth);
  gui.addSlider("Rect size", rSize, 0.5, 2.0);
  gui.addColorChooser("Fill color", borderColor);
  gui.addGraph("Rotation", rotation);
  gui.addGradient("gradient", gradient);
  
  gui.fg = color(0);
  gui.bg = color(255);
  gui.selectColor = color(196);
}

class TestButton implements ButtonCallback
{ void onButtonPressed() { time = 0; running.setValue(true); } }

void draw()
{
  background(0);
  
  float t = millis() / 1000.0;
  float dt = t-lastTime;
  dt *= pow(2, speed.getValue()-2);
  if(running.getValue()) time += dt;
  
  float m = rotation.getXMax();
  if(m == 0) m = 1;
  if(time > m) running.setValue(false);
  lastTime = t;
  timeCaption.setValue(nf(time, 0, 2));

  pushMatrix();
  translate(400, 200);
  rotate(rotation.get(time));
  scale(rSize.getValue());
  stroke(borderColor.getValue());
  strokeWeight(stWidth.getValue());
  fill(gradient.get(time / m));
  rect(-50, -30, 100, 60);
  popMatrix();
  
  gui.display();
}
