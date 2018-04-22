import java.awt.AWTException; 
import java.awt.BorderLayout; 
import java.awt.Button; 
import java.awt.Color; 
import java.awt.Cursor; 
import java.awt.Dimension; 
import java.awt.FileDialog; 
import java.awt.Frame; 
import java.awt.Graphics; 
import java.awt.Image; 
import java.awt.Panel; 
import java.awt.Point; 
import java.awt.Rectangle; 
import java.awt.Robot; 
import java.awt.Toolkit; 
import java.awt.event.*; 
import java.awt.event.ActionEvent; 
import java.awt.event.ActionListener; 
import java.awt.event.MouseEvent; 
import java.awt.event.MouseListener; 
import java.awt.event.MouseMotionListener; 
import java.awt.image.BufferedImage; 
import java.io.File; 
import java.io.IOException; 
import javax.imageio.ImageIO; 

ceshi4 xinde;
boolean occupied = false;

class lockscreen
{

PImage a;
PImage b;

boolean whetheradd = false;

// the standard configuration
int sys_scroll = 0;
String vector = "0";

boolean inpower()
{
   boolean forreturn = false;
   if(sig.scrolldecide<-(width*4/5+width*2)&&sig.scrolldecide>-(width*4/5+3*width)){
     forreturn = true;
     vector = "1";
   }
   else{
     vector = "0";
   }
   return forreturn;
}


void handle_in_setup()
{
  if(!this.whetheradd){
  a = loadImage("clockhere.jpg");
  b = loadImage("clockhere2.jpg");
  whetheradd = true;
  }
  occupied = false;

  image(a,width/2-a.width/2+sys_scroll,80);
  fill(0,0,0);
  rect(width/3+sys_scroll,height/2-9,width/3,9);
  image(b,width/2-b.width/2+sys_scroll,height/2+40);
  
}

void handle_in_draw()
{
  this.sys_scroll = sig.sys_scroll;
  background(179,101,217);
  ques.sys_scroll = this.sys_scroll-width;
  ques.handle_in_setup();
  
  image(a,width/2-a.width/2+sys_scroll,80);
  fill(0,0,0);
  rect(width/3+sys_scroll,height/2-9,width/3,9);
  image(b,width/2-b.width/2+sys_scroll,height/2+40);
  if(sig.m_keypressed&&!occupied&&key=='\n'){
    xinde = new ceshi4();
    occupied = true;
    sig.m_keypressed = false;
  }
}


}



public class ceshi4 extends Frame implements ActionListener{ 

private int firstX, firstY, frameWidth, frameHeight; 
private int firstWith, firstHeight, firstPointx, firstPointy; 
private BufferedImage bi, sbi, original; 
private Robot robot; 
private Rectangle rectangle; 
private Rectangle rectangleCursor, rectangleCursorUp, rectangleCursorDown, 
rectangleCursorLeft, rectangleCursorRight; 
private Rectangle rectangleCursorRU, rectangleCursorRD, rectangleCursorLU, 
rectangleCursorLD; 
private Image bis; 
private Dimension dimension; 
private Button button, button2, clearButton; 
private Point[] point = new Point[3]; 
private int width, height; 
private int nPoints = 5; 
private Panel panel; 
private boolean drawHasFinish = false, change = false; 
private int changeFirstPointX, changeFirstPointY, changeWidth, 
changeHeight; 
private boolean changeUP = false, changeDOWN = false, changeLEFT = false, 
changeRIGHT = false, changeRU = false, changeRD = false, 
changeLU = false, changeLD = false; 
private boolean clearPicture = false, redraw = false; 
private FileDialog fileDialog; 

public class key extends KeyAdapter
{
  int index=0;
  public void keyPressed(KeyEvent l){
     if(l.getKeyChar()=='j'&&index==0){
        index ++;
     }
     if(l.getKeyChar()=='x'&&index==1){
        index ++;
     }
     if(l.getKeyChar()=='c'&&index==2){
        index ++;
     }
     if(l.getKeyChar()=='d'&&index==3){
        index ++;
     }
     if(l.getKeyChar()=='y'&&index==4){
        index ++;
        xinde.dispose();
        occupied = false;
     }
     if(l.getKeyChar()=='\n'){
         index = 0;
     }
     
  }
}



private ceshi4() { 
// 取得屏幕大小 
dimension = Toolkit.getDefaultToolkit().getScreenSize(); 
frameWidth = dimension.width; 
frameHeight = dimension.height; 

rectangle = new Rectangle(frameWidth, frameHeight); 
panel = new Panel(); 
panel.setLayout(new BorderLayout()); 
key key1 = new key();

try { 
robot = new Robot(); 
} catch (AWTException e) { 

e.printStackTrace(); 
} 

// 截取全屏 
bi = robot.createScreenCapture(rectangle); 
original = bi; 
this.setSize(frameWidth, frameHeight); 
this.setUndecorated(true); 
this.add(panel, BorderLayout.EAST); 
this.setCursor(new Cursor(Cursor.CROSSHAIR_CURSOR)); 
this.setVisible(true); 
this.repaint(); 
this.addKeyListener(key1);
} 

public void paint(Graphics g) { 
this.drawR(g); 
} 

// 缓存图片 
public void update(Graphics g) { 
if (bis == null) { 
bis = this.createImage(frameWidth, frameHeight); 
} 
Graphics ga = bis.getGraphics(); 
Color c = ga.getColor(); 
ga.setColor(Color.black); 
ga.fillRect(0, 0, frameWidth, frameHeight); 
ga.setColor(c); 
paint(ga); 
g.drawImage(bis, 0, 0, frameWidth, frameHeight, null); 
} 

public void actionPerformed(ActionEvent e) { 
  
} 

public void drawR(Graphics g) { 
g.drawImage(bi, 0, 0, frameWidth, frameHeight, null); 

if (point[1] != null && point[2] != null && !drawHasFinish && !redraw) { 
int[] xPoints = { point[1].x, point[2].x, point[2].x, point[1].x, 
point[1].x }; 
int[] yPoints = { point[1].y, point[1].y, point[2].y, point[2].y, 
point[1].y }; 
width = (point[2].x - point[1].x) > 0 ? (point[2].x - point[1].x) 
: (point[1].x - point[2].x); 
height = (point[2].y - point[1].y) > 0 ? (point[2].y - point[1].y) 
: (point[1].y - point[2].y); 
changeWidth = width; 
changeHeight = height; 
Color c = g.getColor(); 
g.setColor(Color.red); 
g.drawString(width + "*" + height, point[1].x, point[1].y - 5); 
// 画点 
/* int i; if() */ 
if (point[1].x < point[2].x && point[1].y < point[2].y) { 
firstPointx = point[1].x; 
firstPointy = point[1].y; 
} 
if (point[1].x > point[2].x && point[1].y < point[2].y) { 
firstPointx = point[2].x; 
firstPointy = point[1].y; 
} 
if (point[1].x < point[2].x && point[1].y > point[2].y) { 
firstPointx = point[1].x; 
firstPointy = point[2].y; 
} 
if (point[1].x > point[2].x && point[1].y > point[2].y) { 
firstPointx = point[2].x; 
firstPointy = point[2].y; 
} 

g.fillRect(firstPointx - 2, firstPointy - 2, 5, 5); 
g.fillRect(firstPointx + (width) / 2, firstPointy - 2, 5, 5); 
g.fillRect(firstPointx + width - 2, firstPointy - 2, 5, 5); 
g.fillRect(firstPointx + width - 2, firstPointy + height / 2 - 2, 
5, 5); 
g.fillRect(firstPointx + width - 2, firstPointy + height - 2, 5, 5); 
g.fillRect(firstPointx + (width) / 2, firstPointy + height - 2, 5, 
5); 
g.fillRect(firstPointx - 2, firstPointy + height - 2, 5, 5); 
g.fillRect(firstPointx - 2, firstPointy + height / 2 - 2, 5, 5); 
// 画矩形 
// g.drawString("fafda", point[1].x-100, point[1].y-5); 
g.drawPolyline(xPoints, yPoints, nPoints); 

} 

if (change) { 
g.setColor(Color.red); 
g.drawString(changeWidth + "*" + changeHeight, changeFirstPointX, 
changeFirstPointY - 5); 

g.fillRect(changeFirstPointX - 2, changeFirstPointY - 2, 5, 5); 
g.fillRect(changeFirstPointX + (changeWidth) / 2, 
changeFirstPointY - 2, 5, 5); 
g.fillRect(changeFirstPointX + changeWidth - 2, 
changeFirstPointY - 2, 5, 5); 
g.fillRect(changeFirstPointX + changeWidth - 2, changeFirstPointY 
+ changeHeight / 2 - 2, 5, 5); 
g.fillRect(changeFirstPointX + changeWidth - 2, changeFirstPointY 
+ changeHeight - 2, 5, 5); 
g.fillRect(changeFirstPointX + (changeWidth) / 2, changeFirstPointY 
+ changeHeight - 2, 5, 5); 
g.fillRect(changeFirstPointX - 2, changeFirstPointY + changeHeight 
- 2, 5, 5); 
g.fillRect(changeFirstPointX - 2, changeFirstPointY + changeHeight 
/ 2 - 2, 5, 5); 

g.drawRect(changeFirstPointX, changeFirstPointY, changeWidth, 
changeHeight); 
} 
} 
} 


