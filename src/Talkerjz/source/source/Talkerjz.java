import processing.core.*; 
import processing.xml.*; 

import java.awt.datatransfer.Clipboard; 
import java.awt.Toolkit; 
import java.awt.datatransfer.Transferable; 
import java.awt.datatransfer.DataFlavor; 
import java.awt.datatransfer.StringSelection; 
import java.util.regex.*; 
import ddf.minim.*; 

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

public class Talkerjz extends PApplet {








answer answerit = new answer();
lister abc = new lister();
signal sig = new signal();
dictionary dicdic = new dictionary();
timer showtime = new timer();
paster pase = new paster();
searchengine search = new searchengine();
linuz foryou = new linuz();
dialogmode mainmode = new dialogmode();
notereminder note = new notereminder();
systemcall systemfunc = new systemcall();
Writingpass writer = new Writingpass();
Swarm firstimport = new Swarm();
Writingpass pass120 = new Writingpass();
Passin loginhere = new Passin();
syscenter centerone = new syscenter();
usrcenter centertwo = new usrcenter();
timerecor timeone = new timerecor();


  public void setup()
  {
    size(300, 600);
    noStroke();
    frameRate(90);
    smooth();
    // initialize work
    sig.initial();
    mainmode.handle_in_setup();
    pass120.handle_in_setup();
    note.handle_in_setup();
    loginhere.handle_in_setup();
    sig.sys_vectorjudge();
    centerone.handle_in_setup();
    centertwo.handle_in_setup();
    
    // initial work for time management
    sig.minim = new Minim(this);
    sig.groove = sig.minim.loadFile("sunset.mp3", 1024);
    Timer timer = new Timer();
    timer.schedule(new MyTask(),45*60*1000,60*60*1000);
  }
  
  public void draw()
  { 
    //  time management part
    /*
    timeone.handle_in_draw();
    */
   // the head of code
    if(!loginhere.login||!loginhere.alter){
    loginhere.handle_in_draw();
    }
    else{
          if(!sig.onedelay){
          delay(1900);
          sig.onedelay = true;
          }    
          if (sig.m_mousepressed) {
            sig.m_mousepresslocx = mouseX;
            sig.m_mousepresslocy = mouseY;
          }
          if (sig.m_mousedragged) {
            sig.sys_scroll = mouseX-sig.m_mousepresslocx;
            sig.sys_scroll2 = mouseY-sig.m_mousepresslocy;
          }  
          if(sig.m_mousereleased){
            sig.scrolldecide+=sig.sys_scroll;
               if((sig.m_mousepresslocy>30||sig.m_mousepresslocy<-30)&&!sig.centerused){
                  sig.scrolldecide2+=sig.sys_scroll2;
               }
    }
    
  
     // the software center altering func
        if(sig.scrolldecide2>height/2){
             sig.centerused = true;
             sig.centerstate = true;
             centerone.handle_in_draw();
        }
        if(sig.scrolldecide2<-height/2){
             sig.centerused = true;
             sig.centerstate = true;
             centertwo.handle_in_draw();
        }
        
    // initial for signals
     sig.sys_vectorjudge();
     
     if(!sig.centerused){
         // process for scroll in apps,core codes for the system
     if(mainmode.inpower()){  
        mainmode.handle_in_draw();
     }
     if(note.inpower()){
       note.handle_in_draw();
     } 
     if(pass120.inpower()){
       pass120.handle_in_draw();
     }
      else{
     }
     
     
     }
   }
   
   
   
   // the reset of mouse and key signals
     sig.m_mousepressed = false;
     sig.m_mousereleased = false;
     sig.m_mousedragged = false;
}
  
  
  
  // actions for key and mouse events
  public void keyPressed()
  {  
    sig.m_keypressed = true;
  }
  
  public void mousePressed()
  {
    sig.m_mousepressed = true;
  }
  
  public void mouseReleased()
  {
    sig.m_mousereleased = true;
  }
  
  public void mouseDragged()
  {
    sig.m_mousedragged = true;
  }






class MyTask extends java.util.TimerTask{
public void run() {
// TODO Auto-generated method stub
  sig.minim.stop();
  sig.groove = sig.minim.loadFile("sunset.mp3", 1024);
  sig.groove.play();
}
}
class Passin{

String usrname = "";
String passwd = "";
String passshow = "";
int rectwidth = 0;
int rectheight = 0;
int height2 = 0;
int height3 = 0;
boolean usrnamein = false;
PImage a;
boolean login = false;
boolean alter = false;

public void handle_in_setup()
{
  rectwidth = width-width/5;
  rectheight = height/15;
  height2 = width/6+rectheight+width/30;
  height3 = width/6+rectheight+width/10;
  a = loadImage("talkerjz.jpg");
}

public void handle_in_draw()
{
  if(login&&!alter){
              background(204,184,102);
              fill(0,0,0);
              text("loading   for   you  .......",width/4,height/2-a.height);
              image(a,width/2-a.width/2,height/2);
              alter = true;
  }
  if(!login&&!alter){
   background(204,184,102);
   fill(255,255,255);
   rect(width/6,height/6,rectwidth,rectheight);
   rect(width/6,height/6+height2,rectwidth,rectheight);
   fill(0,0,0);
   text("Please input you name: ",width/10,height/10);
   text("Please input you passwd: ",width/10,height/10+height3);
               if(sig.m_keypressed){
                   if (key>='a'&&key<='z'||key>='A'&&key<='Z'||key>='0'&&key<='9') {
                     if(!usrnamein){ 
                     usrname+=key;
                     }
                     else if(usrnamein){
                         passwd+=key;
                         passshow+="x";
                     }
                    }
                   if(key=='\n'){
                     if(!usrnamein){
                         usrnamein = true;
                     }
                     else  {
                     if(usrname.equals("jxc")&&passwd.equals("talkerjz")){
                       login = true;
                     }
                           else{
                             usrname="";
                             passwd= "";
                             passshow = "";
                             usrnamein = false;
                            }
                     }
                   } 
               sig.m_keypressed = false;
               }
   image(a,width/2-a.width/2,height/2);
   fill(0,0,0);
   text(usrname,width/5,height/5);
   text(passshow,width/5,height/5+height2);
  }
 }



}

class Swarm
{
particle[] Z = new particle[6000];
float colour = random(1);

public void handle_in_setup() {
  smooth();  
  background(255);
  
  for(int i = 0; i < Z.length; i++) {
    Z[i] = new particle( random(width), random(height), 0, 0, 1 );
  }
  
  frameRate(60);
  colorMode(RGB,255);

}

public void handle_in_draw() {
  
  filter(INVERT);

  float r;

  stroke(0);
  fill(255);
  rect(0,0,width,height);
  
  colorMode(HSB,1);
  for(int i = 0; i < Z.length; i++) {
    if( mousePressed && mouseButton == LEFT ) {
      Z[i].gravitate( new particle( mouseX, mouseY, 0, 0, 1 ) );
    }
    else if( mousePressed && mouseButton == RIGHT ) {
      Z[i].repel( new particle( mouseX, mouseY, 0, 0, 1 ) );
    }
    else {
      Z[i].deteriorate();
    }
    Z[i].update();
    r = PApplet.parseFloat(i)/Z.length;
    stroke( colour, pow(r,0.1f), 1-r, 0.15f );
    Z[i].display();
  }
  colorMode(RGB,255);
  
  colour+=random(0.01f);
  if( colour > 1 ) { 
    colour = colour%1;
  }

  filter(INVERT);
  
}
}

class particle {
  
  float x;
  float y;
  float px;
  float py;
  float magnitude;
  float angle;
  float mass;
  
  particle( float dx, float dy, float V, float A, float M ) {
    x = dx;
    y = dy;
    px = dx;
    py = dy;
    magnitude = V;
    angle = A;
    mass = M;
  }
  
  public void reset( float dx, float dy, float V, float A, float M ) {
    x = dx;
    y = dy;
    px = dx;
    py = dy;
    magnitude = V;
    angle = A;
    mass = M;
  }
  
  public void gravitate( particle Z ) {
    float F, mX, mY, A;
    if( sq( x - Z.x ) + sq( y - Z.y ) != 0 ) {
      F = mass * Z.mass;
      mX = ( mass * x + Z.mass * Z.x ) / ( mass + Z.mass );
      mY = ( mass * y + Z.mass * Z.y ) / ( mass + Z.mass );
      A = findAngle( mX - x, mY - y );
      
      mX = F * cos(A);
      mY = F * sin(A);
      
      mX += magnitude * cos(angle);
      mY += magnitude * sin(angle);
      
      magnitude = sqrt( sq(mX) + sq(mY) );
      angle = findAngle( mX, mY );
    }
  }

  public void repel( particle Z ) {
    float F, mX, mY, A;
    if( sq( x - Z.x ) + sq( y - Z.y ) != 0 ) {
      F = mass * Z.mass;
      mX = ( mass * x + Z.mass * Z.x ) / ( mass + Z.mass );
      mY = ( mass * y + Z.mass * Z.y ) / ( mass + Z.mass );
      A = findAngle( x - mX, y - mY );
      
      mX = F * cos(A);
      mY = F * sin(A);
      
      mX += magnitude * cos(angle);
      mY += magnitude * sin(angle);
      
      magnitude = sqrt( sq(mX) + sq(mY) );
      angle = findAngle( mX, mY );
    }
  }
  
  public void deteriorate() {
    magnitude *= 0.925f;
  }
  
  public void update() {
    
    x += magnitude * cos(angle);
    y += magnitude * sin(angle);
    
  }
  
  public void display() {
    line(px,py,x,y);
    px = x;
    py = y;
  }
  
  
}

public float findAngle( float x, float y ) {
  float theta;
  if(x == 0) {
    if(y > 0) {
      theta = HALF_PI;
    }
    else if(y < 0) {
      theta = 3*HALF_PI;
    }
    else {
      theta = 0;
    }
  }
  else {
    theta = atan( y / x );
    if(( x < 0 ) && ( y >= 0 )) { theta += PI; }
    if(( x < 0 ) && ( y < 0 )) { theta -= PI; }
  }
  return theta;
}

class Writingpass
{
int chushix = 0;
int chushiy = 0;
int titlex = 0;
int titley = 0;
int titlewidth = 0;
int titleheight = 0;
int rectwidth = 0;
int rectheight = 0;
int showindex = 0;
int i = 0;
int j = 0;  
int uparrowpos = 0;
int downarrowpos = 0;
int mousepressloc = 0;
String show ="";
String backshow ="";
String title = "";
boolean titlentered = false;
ArrayList<String> showstore = new ArrayList();
boolean bottomstop = false;
boolean whetheradd = false;

// the standard configuration
int sys_scroll = 0;
String vector = "0";


public boolean inpower()
{
   boolean forreturn = false;
   if(sig.scrolldecide<-width*4/5){
     forreturn = true;
     vector = "1";
   }
   else{
     vector = "0";
   }
   return forreturn;
}

public void handle_in_setup()
{
  chushix = width/12;
  chushiy = height/5;
  titlex = chushix;
  titley = 40;
  rectwidth = width-width/6;
  rectheight = height-height/4;
  titlewidth = rectwidth;
  titleheight = 40;
  showindex = height/60;
  if(!this.whetheradd){
  this.showstore.add("here are the text:");
  whetheradd = true;
  }
  
  fill(255, 255, 255);
  text("title:", width/2-width/14+sys_scroll, height/27); 
  fill(255, 255, 255);
  systemfunc.roundrect(titlex+sys_scroll, titley, titlex+sys_scroll+titlewidth, titley+titleheight);
  systemfunc.roundrect(chushix+sys_scroll, chushiy, chushix+sys_scroll+rectwidth, chushiy+rectheight);
}

public void handle_in_draw()
{
  this.sys_scroll = sig.sys_scroll;
  background(120, 120, 120);
  
  // this is for the left app show
     mainmode.sys_scroll = this.sys_scroll-width;
     mainmode.handle_in_setup();
     
  fill(255, 255, 255);
  text("title:", width/2-width/14+sys_scroll, height/27); 
  fill(255, 255, 255);
  systemfunc.roundrect(titlex+sys_scroll, titley, titlex+sys_scroll+titlewidth, titley+titleheight);
  systemfunc.roundrect(chushix+sys_scroll, chushiy, chushix+sys_scroll+rectwidth, chushiy+rectheight);
  fill(0,0,0);
  text(title,width*13/100+sys_scroll, titley+height*11/300);
  if (sig.m_keypressed) {
    if (key>='a'&&key<='z'||key>='A'&&key<='Z'||key==','
      ||key=='.'||key==' '||key=='?'||key=='\''||key=='!'||key>='0'&&key<='9'||key==':') {
      show+=key;
    }
    if (key=='\n') {
      // handle for command to save the file
      if(show.contains("save it")){
        int savelength = showstore.size();
        String []forsave = new String[savelength-1];
        for(int count=0;count<savelength-1;count++)
        forsave[count] = showstore.get(count+1);
        if(title!=null){
        saveStrings(title+".txt",forsave);
        }
        else{
        }
        showstore.clear();
        showstore.add("here are the text:");
        show= "";
        title = "";
        titlentered = false;
      }  else{
              if(!titlentered){
                title = show;
                show = "";
                titlentered = true;
              }  else{
                      showstore.add(show);
                      if(showstore.size()>16){
                        bottomstop = true;
                      }
                      show = "";
                  }
              }
    }     
    if (key== '\b') {
      if (show.length()-1>=0) {
        backshow = show.substring(0, show.length()-1);
        show = backshow;
      }
    }      
    sig.m_keypressed = false;
  }
  fill(120,120,120);
  if(!bottomstop){
  systemfunc.roundrect(width/6-width/30+sys_scroll,height/4+(showstore.size()+1)*height/28+showindex-height/25
  ,width/6-width/12+width-width/30+sys_scroll,height/4+(showstore.size()+1)*height/28+showindex-height/25+40);
  }
  else if(bottomstop){
  systemfunc.roundrect(width/6-width/30+sys_scroll,height/4+(16+1)*height/28+showindex-height/25
  ,width/6-width/12+width-width/30+sys_scroll,height/4+(16+1)*height/28+showindex-height/25+40);
  }
  fill(0, 0, 0);
  if(!bottomstop){
  for (i=0;i<showstore.size();i++) {
    text(showstore.get(i), width/6+sys_scroll, height/4+i*height/28);
  }
  }
  else  if(bottomstop){
  i = 0;
  for (j=showstore.size()-15;j<showstore.size();j++) {
    text(showstore.get(showstore.size()-15+i), width/6+sys_scroll, height/4+i*height/28);
    i++;
  }
  }
  fill(0, 0, 0);
  if(!bottomstop){
  text(show, width/6+sys_scroll, height/4+(showstore.size()+1)*height/28+showindex);
  }
  else  if(bottomstop){
  text(show, width/6+sys_scroll, height/4+(16+1)*height/28+showindex);
  }
  
}


}
class bookmark
{




}
class dialogmode
{
  boolean whetherentermode = true;
  boolean whetheradd = false;
  
  // the standard configuration
  int sys_scroll = 0;
  int sys_scroll2 = 0;
  String vector = "0";
  
  public boolean inpower()
{
   boolean forreturn = false;
   if(sig.scrolldecide<=width*4/5&&sig.scrolldecide>=-width*4/5){
     forreturn = true;
     vector = "1";
   }
   else  {
     vector = "0";
   }
   return forreturn;
}
  
  
  public void handle_in_setup()
 {
    if(!whetheradd){
     answerit.getfilename(sig.askadd,sig.answeradd);
     answerit.datain();
     abc.getlist(sig.listhere);
     abc.addcontent("");
     abc.addcontent("");
     abc.addcontent("");
     abc.addcontent("");
     whetheradd = true;
    }
    
    // initial drawing work
         fill(255,255,255);
         systemfunc.roundrect(sig.x+sys_scroll,sig.y,sig.x+sig.changdu+sys_scroll,sig.y+sig.gaodu);
         fill(0,0,0);
         if(!sig.receiveforstore){
         text(sig.show,sig.x+20+sig.leftedgeforshow+sys_scroll,sig.y+40);
         }
         if(sig.receiveforstore){
         text(sig.answerstring,sig.x+20+sys_scroll,sig.y+40);
         }
         systemfunc.showtext(sig.getanswer);
         fill(255,255,255);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+sig.gaodutwo+10+sig.top,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*2+sig.top);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+2*sig.gaodutwo+10+sig.top,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*3+sig.top);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+3*sig.gaodutwo+10+sig.top,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*4+sig.top);
         if(sig.gaodutwo+sig.top>0)
         sig.top--;
         if(sig.gaodutwo+sig.top<=0){
         sig.top = -sig.gaodutwo;
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+3*sig.gaodutwo+10,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*4);
         }
         abc.listcontent();
     
 }

  public void handle_in_draw()
  {
     this.sys_scroll = sig.sys_scroll;
     this.sys_scroll2 = sig.sys_scroll2;
     background(70,224,220);
     // this is for the app show    in shu
     if(sig.m_mousepresslocy>30||sig.m_mousepresslocy<-30){
        centerone.sys_scroll = this.sys_scroll2 - height;
        centertwo.sys_scroll = this.sys_scroll2 + height;
        centerone.handle_in_setup();
        centertwo.handle_in_setup();
     }
     // this is for the app show    in heng
     note.sys_scroll = this.sys_scroll-width;
     note.handle_in_setup();
     pass120.sys_scroll = this.sys_scroll+width;
     pass120.handle_in_setup();

     
     if(whetherentermode){
       // handle with key and mouse Messages
          if(sig.m_keypressed){
            // this is showing control in keyPressed function
            if(sig.update){
             answerit.datain();
             sig.update = false;
           }
           // \u81ea\u52a8\u7f29\u8fdb\u64cd\u4f5c\u63a7\u5236
           if(keyCode==37){
             sig.leftedgeforanswer+=3;
          }
           if(keyCode==39){
            sig.leftedgeforanswer-=3;
          }
           if(keyCode==38){
            sig.key_of_up_arrow = true;
          }
           if(keyCode==40){
            sig.key_of_down_arrow = true;
          }
          foryou.tools(); 
          if(key ==' '||(key >= 'a'&&key<= 'z')||(key>='A'&&key<='Z')
          ||key==','||key=='?'||key=='\''||key=='.'||key=='!'||key==':'){
           sig.leftedgeforshow-=3;
           if(!sig.receiveforstore){ 
            sig.show+=key;
           }
           else{
            sig.answerstring+=key;
           }  
        }
          if(key =='\n')
            {    
                 if(!sig.receiveforstore){
                 sig.orderarray.add(sig.show);
                 sig.ordercount++;
                 }
                 sig.leftedgeforshow = 50;
                 if(sig.show.contains("good bye"))
                    exit();
                 if(!sig.occupied&&dicdic.entermode(sig.show)){
                       sig.getanswer = dicdic.handle();  
                       sig.show ="";
                       sig.occupied = true;
               }
                 if(!sig.occupied&&showtime.entermode(sig.show)){
                       sig.getanswer = showtime.handle();  
                       sig.show ="";
                       sig.occupied = true;
               }
                 if(!sig.occupied&&pase.entermode(sig.show)){
                       sig.store[0] = pase.handle();  
                       saveStrings("content.txt",sig.store);
                       sig.getanswer = "content is in content.txt file now";
                       sig.show ="";
                       sig.occupied = true;
               }
                 if(!sig.occupied&&search.entermode(sig.show)){
                   if(search.searchname.length()<2){
                           String newname = pase.handle();
                           sig.getanswer = search.handle(newname); 
                        } 
                        else{
                         sig.getanswer = search.handle();   
                      }
                         sig.show ="";
                         sig.occupied = true;      
           }
                 if(sig.receiveforstore&&!sig.occupied){
                      answerit.addanswer(sig.askstring,sig.answerstring);
                      sig.receiveforstore = false;
                      sig.getanswer = "ok, I know how to handle with you..dododo";
                      sig.update = true;
                      sig.answerstring = "";
                 }     
                     else{
                            if(!answerit.haveanswer(sig.show)&&!sig.receiveforstore&&!sig.occupied){
                             sig.askstring = sig.show;
                             sig.getanswer = "how to answer you,deal?";
                             sig.show ="";
                             sig.receiveforstore = true; 
                          }
                           else{
                                    // search for answer and add answer
                                  if(answerit.haveanswer(sig.show)&&!sig.receiveforstore&&!sig.occupied){
                                  sig.getanswer = answerit.getanswer();
                                  abc.addcontent(sig.show);  
                                  sig.show = "";
                                  sig.top = 0;
                                }
                           }
            
            }
        }
          if(key== '\b'){
             sig.leftedgeforshow+=3;
            if(!sig.receiveforstore){
            if(sig.show.length()-1>=0){
            sig.showback = sig.show.substring(0,sig.show.length()-1);
            sig.show = sig.showback; 
            }
            }
            else{
            if(sig.answerstring.length()-1>=0){
            sig.showback = sig.answerstring.substring(0,sig.answerstring.length()-1);
            sig.answerstring = sig.showback; 
            }
            }
          }
               sig.occupied = false;
               sig.reset();  
               
               // reset keystate
               sig.m_keypressed = false;
          }
       
       // pic in this mode in draw
         fill(255,255,255);
         systemfunc.roundrect(sig.x+sys_scroll,sig.y+sys_scroll2,sig.x+sig.changdu+sys_scroll,sig.y+sig.gaodu+sys_scroll2);
         fill(0,0,0);
         if(!sig.receiveforstore){
         text(sig.show,sig.x+20+sig.leftedgeforshow+sys_scroll,sig.y+40+sys_scroll2);
         }
         if(sig.receiveforstore){
         text(sig.answerstring,sig.x+20+sys_scroll,sig.y+40+sys_scroll2);
         }
         systemfunc.showtext(sig.getanswer);
         fill(255,255,255);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+sig.gaodutwo+10+sig.top+sys_scroll2,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*2+sig.top+sys_scroll2);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+2*sig.gaodutwo+10+sig.top+sys_scroll2,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*3+sig.top+sys_scroll2);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+3*sig.gaodutwo+10+sig.top+sys_scroll2,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*4+sig.top+sys_scroll2);
         if(sig.gaodutwo+sig.top>0)
         sig.top--;
         if(sig.gaodutwo+sig.top<=0){
         sig.top = -sig.gaodutwo;
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+3*sig.gaodutwo+10+sys_scroll2,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*4+sys_scroll2);
         }
         abc.listcontent();
     }
     else{
     }
  }

}




// useful classes: dictionary,lister,paster,searchengine,timer,answer

class dictionary
{
  String forhandle;
  String word;
  String []lineshere;
  
  public boolean entermode(String a)
  {
     boolean forreturn = false;
     String readinadd = "dic.txt";
     String forjudge = "dic:";
     if(a.contains(forjudge)){
        forreturn = true;
        this.forhandle = a;
        String []lines = loadStrings(readinadd);
        this.lineshere = lines;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  public String handle()
  {
     String wordhere = "";
     String forreturn = "search failure";
     Pattern p = Pattern.compile("dic:(.*)");
      Matcher m = p.matcher(this.forhandle);
	if(m.find()){
         wordhere = m.group(1);
      }
    this.word = wordhere;
    for(int i=0;i<this.lineshere.length;i+=2){
        if(this.word.equals(this.lineshere[i]))
          forreturn = this.lineshere[i+1];
     }
    return forreturn; 
   }
}



//variables: ArrayList<Stirng> listit
//functions: getlist(ArrayList<String>),roundrect(int,int,int,int)

class lister
{
  ArrayList<String> listit = new  ArrayList();
 
  public void getlist(ArrayList<String> a)
  {
    this.listit = a; 
  }
  
  public void addcontent(String b)
  {
    this.listit.add(b);
  }

  public void listcontent()
  {
        
    int changdu = this.listit.size();
    String showone = this.listit.get(changdu-1);
    String showtwo = this.listit.get(changdu-2);
    String showthree = this.listit.get(changdu-3);

    fill(0,0,0);
    text(showone,width/5+mainmode.sys_scroll,sig.yy+sig.gaodutwo*3+10+sig.top+sig.gaodutwo/2+mainmode.sys_scroll2);
    text(showtwo,width/5+mainmode.sys_scroll,sig.yy+sig.gaodutwo*2+10+sig.top+sig.gaodutwo/2+mainmode.sys_scroll2);
    text(showthree,width/5+mainmode.sys_scroll,sig.yy+sig.gaodutwo*1+10+sig.top+sig.gaodutwo/2+mainmode.sys_scroll2);

}
  
  public void roundrect(int x1,int y1,int x2,int y2)
{
  int radiushere = 20;
  rect(x1,y1+radiushere,x2-x1,y2-y1-2*radiushere);
  rect(x1+radiushere,y1,x2-x1-2*radiushere,y2-y1);
  ellipse(x1+radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x1+radiushere,y2-radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y2-radiushere,radiushere*2,radiushere*2);
}
}




class paster
{
  String forpaste = "";
  
  public boolean entermode(String a)
  {
     boolean forreturn = false;
     String forjudge = "copy";   // here you can something else
     String forjudgetwo = "for";
     String forjudgethree = "me";
     if(a.contains(forjudge)&&a.contains(forjudgetwo)&&a.contains(forjudgethree)){
        forreturn = true;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  public String handle()
  {
     String forreturn = "";
     Clipboard sysClip = Toolkit.getDefaultToolkit().getSystemClipboard();
	  Transferable clipTf = sysClip.getContents(null);
	  if(clipTf!=null){
		    //\u68c0\u67e5\u6587\u672c\u7c7b\u578b
		    if(clipTf.isDataFlavorSupported(DataFlavor.stringFlavor)){
		    	try{
		    	  this.forpaste = (String)clipTf.getTransferData(DataFlavor.stringFlavor);
		    	}
		    	catch (Exception e) 
		        {            
		          e.printStackTrace();    
		        }   
		    }
		  }  
     forreturn = this.forpaste;
     return forreturn; 
   }
}



class searchengine
{  
  String searchname = " ";
  public boolean entermode(String a)
  {
     boolean forreturn = false;
     String []forjudge = {"where","is","file","search","for","file"};
     if((a.contains(forjudge[0])&&a.contains(forjudge[1])
     &&a.contains(forjudge[2]))||(a.contains(forjudge[3])
     &&a.contains(forjudge[4])&&a.contains(forjudge[5]))){
        forreturn = true;        
        Pattern p = Pattern.compile(".*file ([^/?]+)+?|.*file (.*)$");
        Matcher m = p.matcher(a);
	if(m.find()){
          this.searchname = m.group(1);            
        } 
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  public String handle()
  {
    String readinadd = "diskmap.txt";
    String forreturn = "\u5bf9\u4e0d\u8d77\uff0c\u6211\u6ca1\u6709\u627e\u5230\u4f60\u8981\u7684\u4e1c\u897f";
    String []lookinto = loadStrings(readinadd);
    for(int i=0;i<lookinto.length;i++){
      if(lookinto[i].contains(this.searchname)){
        forreturn = "A ha, it's in: "+lookinto[i];
        break;
      }
      else{      
      }
    }
    return forreturn; 
   }
   
   public String handle(String name)
   {   
         String forreturn = "\u5bf9\u4e0d\u8d77\uff0c\u6211\u6ca1\u6709\u627e\u5230\u4f60\u8981\u7684\u4e1c\u897f";
     try{
           int lengthofarray = 0;  
           String readincontent = "";
           URL url = new URL("file:///E://SOFT HOME2/processing-1.5.1/for_summer/Talkerjz/diskmap.txt");         
           InputStreamReader isr = new InputStreamReader(url.openStream(),"gbk");
           BufferedReader br = new BufferedReader(isr); 
            while((readincontent = br.readLine())!=null){
                 lengthofarray++;
                 if(readincontent.contains(name)){
                   forreturn = "A ha, it's in: "+readincontent;
                   break;
                 }
                 else{
                 }
           }
     }
     catch (IOException e){
	   e.printStackTrace();    
     }    

    return forreturn; 
   
   }
}



class timer
{  
  public boolean entermode(String a)
  {
     boolean forreturn = false;
     String forjudge = "time";
     String forjudgetwo = "what";
     if(a.contains(forjudge)&&a.contains(forjudgetwo)){
        forreturn = true;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  public String handle()
  {
    String forreturn = "";
    SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
    String ss = sdf.format(new java.util.Date());
    String addtoss = "The time is: ";
    forreturn = addtoss+ss;
    return forreturn; 
   }
}




//variavles: filename,answerindex,[]lineshere
//functions: datain(),getfilename()
// boolean haveanswer(String),String getanswer(int)

class answer
{
  String askadd;
  String answeradd;
  int answerindex =1;
  String []ask;
  String []answer;
  public void getfilename(String filename,String filenametwo)
   {
     this.askadd = filename;
     this.answeradd = filenametwo;
   }
   
   public void datain()
   {
      this.ask = loadStrings(this.askadd);
      this.answer = loadStrings(this.answeradd);
   }
  public boolean haveanswer(String b)
  {
    boolean jieguo = false;
    for(int i=0;i<this.ask.length;i++)
    {
      if(b.equals(this.ask[i])){
       this.answerindex = i;
       jieguo = true;
       break;
      }
      else{
      continue;
      }
    }
    return jieguo;
  }
  
  public String getanswer()
  {
    return this.answer[this.answerindex];
  }

  public void addanswer(String a,String b)
  {
     String []dd = loadStrings(this.askadd);
     String []ee = loadStrings(this.answeradd);
     String []aa = new String[dd.length+1];
     String []bb = new String[ee.length+1];
     for(int i =0;i<aa.length-1;i++){
        aa[i] = dd[i];
     }
     for(int i =0;i<bb.length-1;i++){
        bb[i] = ee[i];
     }
     aa[aa.length-1] = a;
     bb[bb.length-1] = b;
     saveStrings(this.askadd, aa);
     saveStrings(this.answeradd, bb);
  }

}

class linuz
{
   String []dic={"order:","mkdir","su"};
   String forhandle = "";
   public boolean entermode(String a)
   {
      boolean forreturn = false;
         if(a.contains(this.dic[0])){
           forreturn = true;
           this.forhandle = a;
         }
         else{
         }         
      return forreturn;
   }
   
   public void tools()
   {
      if(sig.key_of_up_arrow){
          if(sig.ordercount>0){
          sig.show = sig.orderarray.get(sig.ordercount-1);
          sig.ordercount-=1;
          }
        else{
        }  
     }
       if(sig.key_of_down_arrow){
         if(sig.ordercount<sig.orderarray.size()-1){
            sig.show = sig.orderarray.get(sig.ordercount+1);
            sig.ordercount+=1;
         }
         else{
         }
       }
      
   }
   
   public String handle()
   {
       String forreturn = "\u6211\u80fd\u529b\u6709\u9650\uff0c\u6ca1\u80fd\u5b8c\u6210\u4efb\u52a1";
       return forreturn; 
   }
}
class notereminder
{
    String show = "";
    String backshow = "";
    ArrayList<String> showstore = new ArrayList();
    int qishix = 20;
    int qishiy = 40;
    int qishiwidth = 0;
    int qishiheight = 0;
    int regularwidth = 0; 
    int gap = 0;
    int gap2 = 0;
    
    // the standard configuration
    int sys_scroll = 0;
    String vector = "0";
    
    public boolean inpower()
    {
       boolean forreturn = false;
       if(sig.scrolldecide>width*4/5){
         forreturn = true;
         vector = "1";
       }
       else{
         vector = "0";
       }
       return forreturn;
    }
    
    public void handle_in_setup()
    {
      // initializing work
      qishiwidth = 23*width/30;
      qishiheight = 5*height/60;
      regularwidth = 9*width/10;
      gap = height*7/60;
      gap2 = height/20;
      
      // for scroll look
      fill(0, 0, 0);
      text("notes here:", 40+sys_scroll, 26);
      fill(255, 255, 255);
      systemfunc.roundrect(qishix+sys_scroll, qishiy, qishix+sys_scroll+qishiwidth, qishiy+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap+qishiheight, qishix+sys_scroll+regularwidth, qishiy+gap+qishiheight*2);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2+qishiheight*2+gap, qishix+sys_scroll+regularwidth, qishiy+gap2+qishiheight*2+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*2+qishiheight*3+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*2+qishiheight*3+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*3+qishiheight*4+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*3+qishiheight*4+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*4+qishiheight*5+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*4+qishiheight*5+gap+qishiheight);
    }
    
    public void handle_in_draw()
    {
      this.sys_scroll = sig.sys_scroll;
      background(116, 249, 28);
    
      // this is for the right app show
         mainmode.sys_scroll = this.sys_scroll+width;
         mainmode.handle_in_setup();
      
      fill(0, 0, 0);
      text("notes here:", 40+sys_scroll, 26);
      fill(255, 255, 255);
      systemfunc.roundrect(qishix+sys_scroll, qishiy, qishix+sys_scroll+qishiwidth, qishiy+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap+qishiheight, qishix+sys_scroll+regularwidth, qishiy+gap+qishiheight*2);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2+qishiheight*2+gap, qishix+sys_scroll+regularwidth, qishiy+gap2+qishiheight*2+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*2+qishiheight*3+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*2+qishiheight*3+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*3+qishiheight*4+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*3+qishiheight*4+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*4+qishiheight*5+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*4+qishiheight*5+gap+qishiheight);
      fill(0,0,0);
      text(this.show,qishix+sys_scroll+5,qishiy+height/24);
          for(int i=0;i<showstore.size();i++){
              text(showstore.get(i),qishix+sys_scroll+width/30,qishiy+gap2*i+qishiheight*(i+1)+gap+height/24);
            }
      if(sig.m_keypressed){
        if (key>='a'&&key<='z'||key>='A'&&key<='Z'||key==','
          ||key=='.'||key==' '||key=='?'||key=='\''||key=='!'
          ||key>='0'&&key<='9'||key==':'){
          show+=key;
        }
        if (key=='\b') {
              if (show.length()-1>=0) {
                backshow = show.substring(0, show.length()-1);
                show = backshow;
              }
         }  
        if(key=='\n'){
          showstore.add(show);
           if(show.contains("what")&&show.contains("need")&&show.contains("do")){
            String []forload = loadStrings("reminder.txt");
            showstore.clear();
            if(forload.length>4){
                  for(int count=0;count<5;count++){
                  showstore.add(forload[count]);
                  }
            }  else{
               }
          }          
          show= "";
          if(showstore.size()>5){
            String []forsave = new String[5];
            for(int count=0;count<5;count++){
            forsave[count] = showstore.get(count);
            }
            saveStrings("reminder.txt",forsave);
            showstore.clear();
            show="";
          }
        }
        sig.m_keypressed = false;
      }
    }
}


class signal
{
  int x;
  int y;
  int yy=100;
  int top = 0;
  int gaodu;
  int changdu;
  int gaodutwo;
  int changdutwo;
  int screenwidth = 500;
  int screenheight = 600;
  int leftedgeforanswer = 0;
  int leftedgeforshow = 50;
  int m_mousepresslocx = 0;
  int m_mousepresslocy = 0;
  int sys_scroll = 0;
  int sys_scroll2 = 0;
  boolean update = false;
  String show = "";
  String showback = "";
  String getanswer = "";
  String askstring = "";
  String answerstring = "";
  boolean answer = false;
  boolean receiveforstore = false;
  String askadd = "ask.txt";
  String answeradd = "answer.txt";
  boolean occupied = false;
  boolean key_of_up_arrow = false;
  boolean key_of_down_arrow = false;
  String []store = new String[1];
  ArrayList<String> listhere = new  ArrayList();
  ArrayList<String> orderarray = new  ArrayList();
  int ordercount = 0;
  boolean m_mousepressed =false;
  boolean m_mousedragged = false;
  boolean m_keypressed = false;
  boolean m_mousemoved = false;
  boolean m_mousereleased = false;
  boolean m_leftpressed = false;
  boolean m_rightpressed = false;
  boolean m_keyreleased = false;
  boolean m_occupied = false;
  boolean onedelay = false;
  int scrolldecide = 0;
  int scrolldecide2 = 0;
  String forjudge ="";
  boolean centerused = false;
  boolean centerstate = false;
  Minim minim;
  AudioPlayer groove;
  
  public void reset()
  {
    this.key_of_up_arrow = false;
    this.key_of_down_arrow = false;
  }
  
  public void initial()
  {
    this.changdu = width*4/5;
    this.gaodu = height*2/15;
    this.changdutwo = width*4/5;
    this.gaodutwo = height*2/15;
    this.x = width/7;
    this.y = height*5/6;
  }
  
  public void sys_vectorjudge()
  {
    String judge = null;
    judge = mainmode.vector + note.vector + pass120.vector;
    if(!forjudge.equals(judge)){
      forjudge = judge;
      sig.sys_scroll = 0;
    }    
    else{
    }
  }
}
class syscenter
{
  
boolean m_mousepressed = false;
PImage []a = new PImage[6];
int []locx = {30,170,30,170,30,170};
int []locy = {70,70,250,250,430,430};
int picwidth = 0;
int sys_scroll = 0;
boolean whetheradd = false;
String []appname = {"Writer","Notereminder","Time","Dialog"};

public void handle_in_setup()
{
    if(!this.whetheradd){
         a[0] = loadImage("Dia.jpg");
         a[1] = loadImage("Not.jpg");
         a[2] = loadImage("Wri.jpg");
         a[3] = loadImage("Tim.jpg");
         picwidth = a[0].width;
     whetheradd = true;
  }  
   // initial draw
   for(int i=0;i<4;i++){
   image(a[i],locx[i],locy[i]-sys_scroll);
   }
}

public void handle_in_draw()
{
   background(67,71,89);
   for(int i=0;i<4;i++){
   image(a[i],locx[i],locy[i]);
   if(mouseX>locx[i]&&mouseX<locx[i]+picwidth
   &&mouseY>locy[i]&&mouseY<locy[i]+picwidth){
     fill(120,120,120);
     rect(locx[i]-1,locy[i]+picwidth+2,picwidth+2,picwidth/4);
     fill(255,255,255);
     text(appname[i],locx[i]+5,locy[i]+picwidth+16);
     if(sig.m_mousepressed){
       if(i%2==0){
       sig.scrolldecide = -(i+1)*8*width/10;
       }
       if(i%2!=0){
       sig.scrolldecide = (i+1)*8*width/10;
       }
       sig.scrolldecide2 = 0;
       sig.m_mousepressed = false;
       sig.centerused = false;
     }
   }
   }
}

}
class systemcall
{
  public void roundrect(int x1,int y1,int x2,int y2)
  {
  int radiushere = 20;
  rect(x1,y1+radiushere,x2-x1,y2-y1-2*radiushere);
  rect(x1+radiushere,y1,x2-x1-2*radiushere,y2-y1);
  ellipse(x1+radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x1+radiushere,y2-radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y2-radiushere,radiushere*2,radiushere*2);
  }

  public void showtext(String s)
  {
    text(s,20+sig.leftedgeforanswer+mainmode.sys_scroll,50+mainmode.sys_scroll2);
  }
}
class timerecor
{
  
}
class usrcenter
{
boolean whetheradd = false;  
boolean m_mousepressed = false;
PImage []a = new PImage[6];
int []locx = {30,170,30,170,30,170};
int []locy = {70,70,250,250,430,430};
int picwidth = 0;
int sys_scroll = 0;
String []appname = {"Music","Player","Analyser","Security"};

public void handle_in_setup()
{
    if(!this.whetheradd){
       a[0] = loadImage("Music.jpg");
       a[1] = loadImage("Player.jpg");
       a[2] = loadImage("Analyser.jpg");
       a[3] = loadImage("Security.jpg");
       picwidth = a[0].width;
     whetheradd = true;
  }
   
   // initial draw
   for(int i=0;i<4;i++){
   image(a[i],locx[i],locy[i]-sys_scroll);
   }
}

public void handle_in_draw()
{
   background(207,136,132);
   for(int i=0;i<4;i++){
   image(a[i],locx[i],locy[i]);
   if(mouseX>locx[i]&&mouseX<locx[i]+picwidth
   &&mouseY>locy[i]&&mouseY<locy[i]+picwidth){
     fill(120,120,120);
     rect(locx[i]-1,locy[i]+picwidth+2,picwidth+2,picwidth/4);
     fill(255,255,255);
     text(appname[i],locx[i]+5,locy[i]+picwidth+16);
     if(sig.m_mousepressed){
       if(i%2==0){
       sig.scrolldecide = -(i+1)*8*width/10;
       }
       if(i%2!=0){
       sig.scrolldecide = (i+1)*8*width/10;
       }
       sig.scrolldecide2 = 0;
       sig.m_mousepressed = false;
       sig.centerused = false;
     }
   }
   }
}

}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "Talkerjz" });
  }
}
