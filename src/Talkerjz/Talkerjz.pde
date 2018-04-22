import java.awt.datatransfer.Clipboard;
import java.awt.Toolkit;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.util.regex.*;
answer answerit = new answer();
ArrayList<String> listhere = new  ArrayList();
lister abc = new lister();
signal sig = new signal();
dictionary dicdic = new dictionary();
timer showtime = new timer();
paster pase = new paster();

void setup()
{
   size(300,600);
   // initialize work
   sig.changdu = width*4/5;
   sig.gaodu = height*2/15;
   sig.changdutwo = width*4/5;
   sig.gaodutwo = height*2/15;
   sig.x = width/7;
   sig.y = height*5/6;
   answerit.getfilename(sig.askadd,sig.answeradd);
   answerit.datain();
   noStroke();
   frameRate(70);
   smooth();
   abc.getlist(listhere);
   abc.addcontent("");
   abc.addcontent("");
   abc.addcontent("");
   abc.addcontent("");
}

void draw()
{ 
   background(70,224,220);
   fill(255,255,255);
   roundrect(sig.x,sig.y,sig.x+sig.changdu,sig.y+sig.gaodu);
   fill(0,0,0);
   if(!sig.receiveforstore){
   text(sig.show,sig.x+20+sig.leftedgeforshow,sig.y+40);
   }
   if(sig.receiveforstore){
   text(sig.answerstring,sig.x+20,sig.y+40);
   }
   showtext(sig.getanswer);
   fill(255,255,255);
   roundrect(width*2/15,sig.yy+sig.gaodutwo+10+sig.top,20+sig.changdutwo,sig.yy+sig.gaodutwo*2+sig.top);
   roundrect(width*2/15,sig.yy+2*sig.gaodutwo+10+sig.top,20+sig.changdutwo,sig.yy+sig.gaodutwo*3+sig.top);
   roundrect(width*2/15,sig.yy+3*sig.gaodutwo+10+sig.top,20+sig.changdutwo,sig.yy+sig.gaodutwo*4+sig.top);
   if(sig.gaodutwo+sig.top>0)
   sig.top--;
   if(sig.gaodutwo+sig.top<=0){
   sig.top = -sig.gaodutwo;
   roundrect(width*2/15,sig.yy+3*sig.gaodutwo+10,20+sig.changdutwo,sig.yy+sig.gaodutwo*4);
   }
   abc.listcontent();
}

void keyPressed()
{  
   if(sig.update){
     answerit.datain();
     sig.update = false;
   }
  if(key ==' '||(key >= 'a'&&key<= 'z')||(key>='A'&&key<='Z')
  ||key==','||key=='?'||key=='\''||key=='.'||key=='!'||key==':'){
   if(!sig.receiveforstore){ 
    sig.show+=key;
   }
   else{
    sig.answerstring+=key;
   }  
}
  if(key =='\n')
    {    
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
}

void roundrect(int x1,int y1,int x2,int y2)
{
  int radiushere = 20;
  rect(x1,y1+radiushere,x2-x1,y2-y1-2*radiushere);
  rect(x1+radiushere,y1,x2-x1-2*radiushere,y2-y1);
  ellipse(x1+radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x1+radiushere,y2-radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y2-radiushere,radiushere*2,radiushere*2);
}

void showtext(String s)
{
  text(s,20+sig.leftedgeforanswer,50);
}
