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
import java.awt.event.ActionEvent; 
import java.awt.event.ActionListener; 
import java.awt.event.MouseEvent; 
import java.awt.event.MouseListener; 
import java.awt.event.MouseMotionListener; 
import java.awt.image.BufferedImage; 
import java.io.File; 
import java.io.IOException; 
import javax.imageio.ImageIO; 

import javax.media.Buffer;
import javax.media.CannotRealizeException;
import javax.media.CaptureDeviceInfo;
import javax.media.CaptureDeviceManager;
import javax.media.Manager;
import javax.media.MediaLocator;
import javax.media.NoPlayerException;
import javax.media.Player;
import javax.media.control.FrameGrabbingControl;
import javax.media.format.VideoFormat;
import javax.media.util.BufferToImage;

PImage a;
Player player=null;
 
public class ceshi2{
 private CaptureDeviceInfo captureDeviceInfo=null;
 private MediaLocator mediaLocator=null;
 
 public ceshi2()
 {
  String str="vfw:Microsoft WDM Image Capture (Win32):0";
  captureDeviceInfo=CaptureDeviceManager.getDevice(str);
  mediaLocator=new MediaLocator("vfw://0");

  
  try {
   player=Manager.createRealizedPlayer(mediaLocator);
   player.start();
   
  } catch (NoPlayerException e)
  {
   e.printStackTrace();
  } catch (CannotRealizeException e)
  {
   e.printStackTrace();
  } catch (IOException e)
  {
   e.printStackTrace();
  }  
 } 
}


public void savetheimage(Image imagehere)
{
                                  SimpleDateFormat sdf;
                                  String ss;
                                  String picName;
                                  int w = imagehere.getWidth(this); 
                                  int h = imagehere.getHeight(this);
                                  BufferedImage bi = new BufferedImage(w, h, BufferedImage.TYPE_3BYTE_BGR);
                                    sdf = new SimpleDateFormat("yyy_MM_dd_HH_mm_ss");
                                    ss = sdf.format(new java.util.Date());
                                          picName="head_"+ss+".jpg";
                                                  Graphics g = bi.getGraphics(); 
                                		try {
                                		File dateDir = new File("f:\\Pictures\\screenshot");
                                                 g.drawImage(imagehere, 0, 0, null);
                                			if (!dateDir.exists()) {
                                	              dateDir.mkdir();
                                	         }
                                			File f = new File("f:\\Pictures\\screenshot\\" + picName);
                                			//将得到的文件转化为jpg格式
                                			ImageIO.write(bi, "jpg", f);
                                		} catch (Exception ex) {
                                			System.out.println("Can not record the screen, sorry...");
                                		}  
}



class screenshot
{

  Timer timer = new Timer(); 
  Timer timer2 = new Timer(); 
  String currentstate = "in";
  
  // this is for tip-help system
  String tipcontent[] = {"  press  the  'Enter'  key   in   your  keyboard  to       catch  the screen,  really  fun !"};
  int []tiplocx = {83,209};
  int []tiplocy = {254,351};
  int widthadjustvalue = 0;
  
  
  int sys_scroll = 0;
  String vector = "0";
  boolean whetheradd = false;


  boolean inpower()
  {
     boolean forreturn = false;
     if(sig.scrolldecide>(width*4/5+2*width)&&sig.scrolldecide<(width*4/5+3*width)){
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
     a = loadImage("pic.jpg");    
     whetheradd = true;
     }
     image(a,width/2-a.width/2+sys_scroll,height/2-a.height/2);
       //clear for tip system
     this.widthadjustvalue = 0;
  }
  
  void handle_in_draw()
  {
     this.sys_scroll = sig.sys_scroll;
     background(211,198,154);
     pianoplayer.sys_scroll = this.sys_scroll+width;
     pianoplayer.handle_in_setup(); 
     readbooks.sys_scroll = this.sys_scroll-width;
     readbooks.handle_in_setup();
    
    image(a,width/2-a.width/2+sys_scroll,height/2-a.height/2);
    if(sig.m_keypressed&&key=='\n'){
      new ceshi3();
      sig.m_keypressed = false;
    }
    
    
     // this is for tip-help system
        for(int tipi=0;tipi<this.tipcontent.length;tipi++){
          if(mouseX>tiplocx[tipi*2]&&mouseX<tiplocx[tipi*2+1]&&mouseY>tiplocy[tipi*2]&&mouseY<tiplocy[tipi*2+1]){      
          systemfunc.showtip(this.tipcontent[tipi],this.widthadjustvalue,450);
          }
        }
        this.widthadjustvalue++;
        if(this.widthadjustvalue>150){
          this.widthadjustvalue = 151;
        }  
   
       if(sig.m_mousepressed&&mouseX>86&&mouseY>86&&mouseX<209&&mouseY<119){
         if(currentstate.equals("in")){
              currentstate = "out";
                 timer = new Timer(); 
                 timer.schedule(new extratask(),9000,2000);
                 new ceshi2();
                 timer2 = new Timer(); 
                 timer2.schedule(new hao(),10000,30000);
         }
         else{
           if(currentstate.equals("out")){
              currentstate = "in";
                 timer.cancel();
                 timer2.cancel();
         }
           else{
           }   
         }  
         sig.m_mousepressed = false;
       }
      
       fill(85,240,228);
       systemfunc.roundrect(73+sys_scroll,79,221+sys_scroll,130); 
       fill(237,208,134);
       text(currentstate,(73+221)/2-9+sys_scroll,(79+130)/2+2);
    
  }


}



                                class extratask extends java.util.TimerTask{
                                  SimpleDateFormat sdf;
                                  String ss;
                                  String picName;
                                  Dimension d;
                                 public void run() {
                                // TODO Auto-generated method stub
                                    
                                    
                                    sdf = new SimpleDateFormat("yyy_MM_dd_HH_mm_ss");
                                    ss = sdf.format(new java.util.Date());
                                    
                                    d = Toolkit.getDefaultToolkit().getScreenSize();
                                          picName=ss+".jpg";
                                		try {
                                		BufferedImage screenshot = (new Robot()).createScreenCapture(new Rectangle(0, 0,(int) d.getWidth(), (int) d.getHeight()));
                                		File dateDir = new File("f:\\Pictures\\screenshot");
                                			if (!dateDir.exists()) {
                                	              dateDir.mkdir();
                                	         }
                                			File f = new File("f:\\Pictures\\screenshot\\" + picName);
                                			//将得到的文件转化为jpg格式
                                			ImageIO.write(screenshot, "jpg", f);
                                		} catch (Exception ex) {
                                			System.out.println("Can not record the screen, sorry...");
                                		}
                                }
                                }
                                
                                
                                public class hao extends java.util.TimerTask
                                {                                  
                                   private Buffer buffer=null;
                                   private VideoFormat videoFormat=null;
                                   private BufferToImage bufferToImage=null;
                                   private Image image=null;
                                   private FrameGrabbingControl fgc;
                                  
                                  public void run()
                                  {            
                                         fgc=(FrameGrabbingControl)player.getControl("javax.media.control.FrameGrabbingControl");
                                         buffer=fgc.grabFrame();
                                         bufferToImage=new BufferToImage((VideoFormat)buffer.getFormat());
                                         image=bufferToImage.createImage(buffer);
               
                                         
                                          while(image==null){
                                         fgc=(FrameGrabbingControl)player.getControl("javax.media.control.FrameGrabbingControl");
                                         buffer=fgc.grabFrame();
                                         bufferToImage=new BufferToImage((VideoFormat)buffer.getFormat());
                                         image=bufferToImage.createImage(buffer);
                                          }
                                         savetheimage(image);
                                  }
                                }
 
                                
                                


public class ceshi3 extends Frame implements MouseListener, 
MouseMotionListener, ActionListener{ 

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

private ceshi3() { 
// 取得屏幕大小 
dimension = Toolkit.getDefaultToolkit().getScreenSize(); 
frameWidth = dimension.width; 
frameHeight = dimension.height; 

fileDialog = new FileDialog(this, "screen capture", FileDialog.SAVE); 
rectangle = new Rectangle(frameWidth, frameHeight); 
panel = new Panel(); 
button = new Button("exit"); 
button.setCursor(new Cursor(Cursor.DEFAULT_CURSOR)); 
button.setBackground(Color.green);
button.addActionListener(this); 
button2 = new Button("catch"); 
button2.setBackground(Color.darkGray); 
button2.addActionListener(new MyTakePicture(this)); 
button2.setCursor(new Cursor(Cursor.DEFAULT_CURSOR)); 
clearButton = new Button("repaint"); 
clearButton.setBackground(Color.green); 
clearButton.setCursor(new Cursor(Cursor.DEFAULT_CURSOR)); 
clearButton.addActionListener(new MyClearPicture(this)); 
panel.setLayout(new BorderLayout()); 
panel.add(clearButton, BorderLayout.SOUTH); 

panel.add(button, BorderLayout.NORTH); 
panel.add(button2, BorderLayout.CENTER); 
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
this.addMouseListener(this); 
this.addMouseMotionListener(this); 
this.add(panel, BorderLayout.EAST); 
this.setCursor(new Cursor(Cursor.CROSSHAIR_CURSOR)); 
this.setVisible(true); 
this.repaint(); 
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

public void mouseClicked(MouseEvent e) { 

} 

public void mouseEntered(MouseEvent e) { 
// TODO Auto-generated method stub 

} 

public void mouseExited(MouseEvent e) { 
// TODO Auto-generated method stub 

} 

public void mousePressed(MouseEvent e) { 
// TODO Auto-generated method stub 

} 

public void mouseReleased(MouseEvent e) { 
if (!drawHasFinish) { 
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
changeFirstPointX = firstPointx; 
changeFirstPointY = firstPointy; 
if (point[1] != null && point[2] != null) { 
rectangleCursorUp = new Rectangle(firstPointx + 20, 
firstPointy - 10, width - 40, 20); 
rectangleCursorDown = new Rectangle(firstPointx + 20, 
firstPointy + height - 10, width - 40, 20); 
rectangleCursorLeft = new Rectangle(firstPointx - 10, 
firstPointy + 10, 20, height - 20); 
rectangleCursorRight = new Rectangle(firstPointx + width - 10, 
firstPointy + 10, 20, height - 20); 
rectangleCursorLU = new Rectangle(firstPointx - 10, 
firstPointy - 10, 30, 20); 
rectangleCursorLD = new Rectangle(firstPointx - 10, firstPointy 
+ height - 10, 30, 20); 
rectangleCursorRU = new Rectangle(firstPointx + width - 10, 
firstPointy - 10, 20, 20); 
rectangleCursorRD = new Rectangle(firstPointx + width - 10, 
firstPointy + height - 10, 20, 20); 
drawHasFinish = true; 
} 

} 
// 确定每边能改变大小的矩形 
if (drawHasFinish) { 
rectangleCursorUp = new Rectangle(changeFirstPointX + 20, 
changeFirstPointY - 10, changeWidth - 40, 20); 
rectangleCursorDown = new Rectangle(changeFirstPointX + 20, 
changeFirstPointY + changeHeight - 10, changeWidth - 40, 20); 
rectangleCursorLeft = new Rectangle(changeFirstPointX - 10, 
changeFirstPointY + 10, 20, changeHeight - 20); 
rectangleCursorRight = new Rectangle(changeFirstPointX 
+ changeWidth - 10, changeFirstPointY + 10, 20, 
changeHeight - 20); 
rectangleCursorLU = new Rectangle(changeFirstPointX - 2, 
changeFirstPointY - 2, 10, 10); 
rectangleCursorLD = new Rectangle(changeFirstPointX - 2, 
changeFirstPointY + changeHeight - 2, 10, 10); 
rectangleCursorRU = new Rectangle(changeFirstPointX + changeWidth 
- 2, changeFirstPointY - 2, 10, 10); 
rectangleCursorRD = new Rectangle(changeFirstPointX + changeWidth 
- 2, changeFirstPointY + changeHeight - 2, 10, 10); 
} 

} 

public void mouseDragged(MouseEvent e) { 
point[2] = e.getPoint(); 
// if(!drawHasFinish){ 
this.repaint(); 
// } 

// 托动鼠标移动大小 
if (change) { 
if (changeUP) { 
changeHeight = changeHeight + changeFirstPointY 
- e.getPoint().y; 
changeFirstPointY = e.getPoint().y; 

} 
if (changeDOWN) { 
changeHeight = e.getPoint().y - changeFirstPointY; 
} 
if (changeLEFT) { 
changeWidth = changeWidth + changeFirstPointX - e.getPoint().x; 
changeFirstPointX = e.getPoint().x; 
} 
if (changeRIGHT) { 
changeWidth = e.getPoint().x - changeFirstPointX; 
} 
if (changeLU) { 
changeWidth = changeWidth + changeFirstPointX - e.getPoint().x; 
changeHeight = changeHeight + changeFirstPointY 
- e.getPoint().y; 
changeFirstPointX = e.getPoint().x; 
changeFirstPointY = e.getPoint().y; 
} 
if (changeLD) { 
changeWidth = changeWidth + changeFirstPointX - e.getPoint().x; 
changeHeight = e.getPoint().y - changeFirstPointY; 
changeFirstPointX = e.getPoint().x; 

} 
if (changeRU) { 
changeWidth = e.getPoint().x - changeFirstPointX; 
changeHeight = changeHeight + changeFirstPointY 
- e.getPoint().y; 
changeFirstPointY = e.getPoint().y; 
} 
if (changeRD) { 
changeWidth = e.getPoint().x - changeFirstPointX; 
changeHeight = e.getPoint().y - changeFirstPointY; 

} 
this.repaint(); 
} 

} 

public void mouseMoved(MouseEvent e) { 
point[1] = e.getPoint(); 
// 改变鼠标的形状 
if (rectangleCursorUp != null && rectangleCursorUp.contains(point[1])) { 

this.setCursor(new Cursor(Cursor.N_RESIZE_CURSOR)); 
change = true; 
changeUP = true; 
} else if (rectangleCursorDown != null 
&& rectangleCursorDown.contains(point[1])) { 
this.setCursor(new Cursor(Cursor.S_RESIZE_CURSOR)); 
change = true; 
changeDOWN = true; 
} else if (rectangleCursorLeft != null 
&& rectangleCursorLeft.contains(point[1])) { 
this.setCursor(new Cursor(Cursor.W_RESIZE_CURSOR)); 
change = true; 
changeLEFT = true; 
} else if (rectangleCursorRight != null 
&& rectangleCursorRight.contains(point[1])) { 
this.setCursor(new Cursor(Cursor.W_RESIZE_CURSOR)); 
change = true; 
changeRIGHT = true; 
} else if (rectangleCursorLU != null 
&& rectangleCursorLU.contains(point[1])) { 
this.setCursor(new Cursor(Cursor.NW_RESIZE_CURSOR)); 
change = true; 
changeLU = true; 
} else if (rectangleCursorLD != null 
&& rectangleCursorLD.contains(point[1])) { 
this.setCursor(new Cursor(Cursor.SW_RESIZE_CURSOR)); 
change = true; 
changeLD = true; 
} else if (rectangleCursorRU != null 
&& rectangleCursorRU.contains(point[1])) { 
this.setCursor(new Cursor(Cursor.NE_RESIZE_CURSOR)); 
change = true; 
changeRU = true; 
} else if (rectangleCursorRD != null 
&& rectangleCursorRD.contains(point[1])) { 
this.setCursor(new Cursor(Cursor.SE_RESIZE_CURSOR)); 
change = true; 
changeRD = true; 
} else { 
this.setCursor(new Cursor(Cursor.CROSSHAIR_CURSOR)); 
changeUP = false; 
changeDOWN = false; 
changeRIGHT = false; 
changeLEFT = false; 
changeRU = false; 
changeRD = false; 
changeLU = false; 
changeLD = false; 
} 
redraw = false; 
} 


public void actionPerformed(ActionEvent e) { 
  // System.exit(0); 
  this.dispose();
} 


class MyTakePicture implements ActionListener { 
	ceshi3 aWTpicture; 

MyTakePicture(ceshi3 aWTpicture) { 
this.aWTpicture = aWTpicture; 
} 

// 保存图片 
public void actionPerformed(ActionEvent e) { 
fileDialog.setVisible(true); 
if (changeWidth > 0) { 
sbi = bi.getSubimage(changeFirstPointX, changeFirstPointY, 
changeWidth, changeHeight); 

File file = new File(fileDialog.getDirectory()); 
file.mkdir(); 

try { 
ImageIO.write(sbi, "jpeg", new File(file, fileDialog 
.getFile() 
+ ".jpg")); 
} catch (IOException e1) { 

e1.printStackTrace(); 
} 
} 

} 

} 

class MyClearPicture implements ActionListener { 
	ceshi3 aWTpicture; 

MyClearPicture(ceshi3 aWTpicture) { 
this.aWTpicture = aWTpicture; 
} 

public void actionPerformed(ActionEvent e) { 
drawHasFinish = false; 
change = false; 
redraw = true; 
rectangleCursorUp = null; 
rectangleCursorDown = null; 
rectangleCursorLeft = null; 
rectangleCursorRight = null; 
rectangleCursorRU = null; 
rectangleCursorRD = null; 
rectangleCursorLU = null; 
rectangleCursorLD = null; 
changeWidth = 0; 
changeHeight = 0; 

aWTpicture.repaint(); 

} 

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




