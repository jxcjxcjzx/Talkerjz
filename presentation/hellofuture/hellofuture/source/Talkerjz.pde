import ddf.minim.*;
int x;
int y;
int yy=100;
int top = 0;
int gaodu;
int changdu;
int gaodutwo;
int changdutwo;
String show = "";
String showback = "";
String getanswer = "";
boolean answer = false;
String askadd = "ask.txt";
String answeradd = "answer.txt";
answer answerit = new answer();
ArrayList<String> listhere = new  ArrayList();
lister abc = new lister();


Minim minim;

AudioPlayer groove;


void setup()
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
   
    minim = new Minim(this);
   groove = minim.loadFile("1.mp3", 1024);
    
}

void draw()
{ 
   background(70,224,220);
   fill(255,255,255);
   roundrect(x,y,x+changdu,y+gaodu);
   fill(0,0,0);
   text(show,x+20,y+40);
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

void keyPressed()
{
  if(key ==' '||(key >= 'a'&&key<= 'z')||(key>='A'&&key<='Z')||key==','||key=='?')
    show+=key;
  if(key =='\n')
    {
      // search for answer and add answer
    if(answerit.haveanswer(show)){
    getanswer = answerit.getanswer();
    abc.addcontent(show);
    
    if(show.contains("music"))
       groove.play();
    
    show = "";
    }
    top = 0;
    }
  if(key== '\b'){
    if(show.length()-1>=0){
    showback = show.substring(0,show.length()-1);
    show = showback; 
    }
  }
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
  text(s,20,50);
}
