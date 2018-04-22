import java.awt.datatransfer.Clipboard;
import java.awt.Toolkit;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.util.regex.*;
import ddf.minim.*;
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


  void setup()
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
  
  void draw()
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
  void keyPressed()
  {  
    sig.m_keypressed = true;
  }
  
  void mousePressed()
  {
    sig.m_mousepressed = true;
  }
  
  void mouseReleased()
  {
    sig.m_mousereleased = true;
  }
  
  void mouseDragged()
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
