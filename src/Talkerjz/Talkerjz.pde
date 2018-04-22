import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import java.awt.datatransfer.Clipboard;
import java.awt.Toolkit;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.util.regex.*;
import java.util.Timer;


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
Writingpass pass120 = new Writingpass();
Baidupro ques = new Baidupro();
Passin loginhere = new Passin();
syscenter centerone = new syscenter();
usrcenter centertwo = new usrcenter();
playpiano pianoplayer = new playpiano();
screenshot cameraone = new screenshot();
lockscreen lockit = new lockscreen();
BookCase bookmarket = new BookCase();
happyReader readbooks = new happyReader();
Sys_timer timerhere = new Sys_timer();
Sys_speaker sayit = new Sys_speaker();
MAkePossible mapme = new MAkePossible();


PImage screenprotect;
boolean suoping = false;

  void setup()
  {
    size(300, 600);
    noStroke();
    frameRate(90);
    smooth();
    // initialize work
    // first initial the signals
    sig.initial();
    sig.sys_vectorjudge();
    // initial work of apps
    mainmode.handle_in_setup();
    loginhere.handle_in_setup();
    pass120.handle_in_setup();
    note.handle_in_setup();
    cameraone.handle_in_setup();
    lockit.handle_in_setup();
    readbooks.handle_in_setup();
    bookmarket.handle_in_setup();
    mapme.handle_in_setup();
    // initial part of software center
    centerone.handle_in_setup();
    centertwo.handle_in_setup();
    timerhere.init_timer();

    //  time management part
    /*
    timeone.handle_in_draw();
    */
    
    // for the piano
    sig.public_minim = new ddf.minim.Minim(this);
    // initial work for time management
    sig.main_minim = new ddf.minim.Minim(this);
    Timer timer = new Timer();
    timer.schedule(new MyTask(),9*1000,60*60*1000);
    sayit.init_speak();
    sayit.sayContent("hello,jxc,welcome!");   
    sayit.sayContent("I am talker jz, and I will play role well..");
    // testing point 

  }
  
  void draw()
  {    
   if(!suoping){ 
   // the head of code
    if(!loginhere.login||!loginhere.alter){
    loginhere.handle_in_draw();
    }
    else{
          if(!sig.onedelay){
          delay(9900);
          sig.onedelay = true;
          }    
          if (sig.m_mousepressed) {
            sig.m_mousepresslocx = mouseX;
            sig.m_mousepresslocy = mouseY;
          }
          if (sig.m_mousedragged&&!sig.applock) {
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
     if(ques.inpower()){
       ques.handle_in_draw();
     }
     if(pianoplayer.inpower()){
       pianoplayer.handle_in_draw();
     }
     if(cameraone.inpower()){
       cameraone.handle_in_draw();
     }
     if(lockit.inpower()){
       lockit.handle_in_draw();
     }
     if(readbooks.inpower()){
       readbooks.handle_in_draw();
     }
     if(bookmarket.inpower()){
       bookmarket.handle_in_draw();
     }
     if(mapme.inpower()){
       mapme.handle_in_draw();
     }
      else{
     }
     
     
     }
   }
   
   
   
   // the reset of mouse and key signals
     sig.m_mousepressed = false;
     sig.m_mousereleased = false;
     sig.m_mousedragged = false;
     
   // show the mouse location info, for designing work
   fill(0,0,0);
   text(mouseX,width/15,height-height/60);
   text(mouseY,width*4/15,height-height/60);
  
 }
   
   // this function lock the screen
   if(suoping){
     image(screenprotect,0,0);
   }
   
}
  
  
  
  // actions for key and mouse events
  void keyPressed()
  {  
    sig.m_keypressed = true;
    
    if(keyCode==120){
     saveFrame("screenlock.png");
     screenprotect = loadImage("screenlock.png");
     suoping = (suoping == false)?true:false;
     sig.m_keypressed = false;
   }
   
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
      timerhere.action_performed();
    }
    }



