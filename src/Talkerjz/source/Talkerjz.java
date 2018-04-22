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

public class Talkerjz extends PApplet {

int x;
int y;
int yy=100;
int top = 0;
int gaodu;
int changdu;
int gaodutwo;
int changdutwo;
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
answer answerit = new answer();
ArrayList<String> listhere = new  ArrayList();
lister abc = new lister();


public void setup()
{
   size(300,600);
   changdu = width*4/5;
   gaodu = height*2/15;
   changdutwo = width*4/5;
   gaodutwo = height*2/15;
   x = width/7;
   y = height*5/6;
   answerit.getfilename(askadd,answeradd);
   answerit.datain();
   noStroke();
   frameRate(70);
   smooth();
   println(changdu);
   abc.getlist(listhere);
   abc.addcontent("");
   abc.addcontent("");
   abc.addcontent("");
   abc.addcontent("");
}

public void draw()
{ 
   background(70,224,220);
   fill(255,255,255);
   roundrect(x,y,x+changdu,y+gaodu);
   fill(0,0,0);
   if(!receiveforstore){
   text(show,x+20,y+40);
   }
   if(receiveforstore){
   text(answerstring,x+20,y+40);
   }
   showtext(getanswer);
   fill(255,255,255);
   roundrect(width*2/15,yy+gaodutwo+10+top,20+changdutwo,yy+gaodutwo*2+top);
   roundrect(width*2/15,yy+2*gaodutwo+10+top,20+changdutwo,yy+gaodutwo*3+top);
   roundrect(width*2/15,yy+3*gaodutwo+10+top,20+changdutwo,yy+gaodutwo*4+top);
   if(gaodutwo+top>0)
   top--;
   if(gaodutwo+top<=0){
   top = -gaodutwo;
   roundrect(width*2/15,yy+3*gaodutwo+10,20+changdutwo,yy+gaodutwo*4);
   }
   abc.listcontent();
}

public void keyPressed()
{  
   if(update){
     answerit.datain();
     update = false;
   }
  if(key ==' '||(key >= 'a'&&key<= 'z')||(key>='A'&&key<='Z')||key==','||key=='?'){
   if(!receiveforstore){ 
    show+=key;
   }
   else{
    answerstring+=key;
   }  
}
  if(key =='\n')
    {    
         if(receiveforstore){
      answerit.addanswer(askstring,answerstring);
      receiveforstore = false;
      getanswer = "ok, I know how to handle with you..dododo";
      update = true;
      answerstring = "";
  }     
      else{
                    if(!answerit.haveanswer(show)&&!receiveforstore){
                     askstring = show;
                     getanswer = "how to answer you,deal?";
                     show ="";
                     receiveforstore = true; 
                  }
                   else{
                            // search for answer and add answer
                          if(answerit.haveanswer(show)&&!receiveforstore){
                          getanswer = answerit.getanswer();
                          abc.addcontent(show);  
                          show = "";
                          top = 0;
                        }
                   }
    
    }
}
  if(key== '\b'){
    if(!receiveforstore){
    if(show.length()-1>=0){
    showback = show.substring(0,show.length()-1);
    show = showback; 
    }
    }
    else{
    if(answerstring.length()-1>=0){
    showback = answerstring.substring(0,answerstring.length()-1);
    answerstring = showback; 
    }
    }
  }
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

public void showtext(String s)
{
  text(s,20,50);
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
    text(showone,width/5,yy+gaodutwo*3+10+top+gaodutwo/2);
    text(showtwo,width/5,yy+gaodutwo*2+10+top+gaodutwo/2);
    text(showthree,width/5,yy+gaodutwo*1+10+top+gaodutwo/2);

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
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "Talkerjz" });
  }
}
