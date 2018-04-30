float x1;
float y1;
int i = 0;
int ceshix;
int ceshiy;
int top = 200;
int current = 0;
float newposx;
float newposy;
float mousexalter;
float mouseyalter;
int currentposalter;
int currentwordrecord;
String []reading;
int rellength;
int leftedge = 10;
String []text = {"ballad","barrel","barren","beast","bed","bend","benefit","bestow","verse","via","vibrant","wagon","vow","vote","volume"};
node []noderel = new node[60];
String requireword = "abandon";
String inputfile = "wordnet2.txt";
ArrayList Nodes = new ArrayList();
speakOut sayit = new speakOut();

void setup()       //可以改进的地方，将绝对坐标全部转化为相对坐标
{
  size(1320,630);
  smooth();
  reading = posgene(requireword);
  background(55,182,219);
  node nodeexp = (node)Nodes.get(0);
  nodeexp.getradius(random(100.0,120.0));
  newposx = width/2+random(80.0);
  newposy = height/2+random(20.0);
  nodeexp.paintme();
  rellength = nodeexp.wordsrelated.length;
   for(i=1;i<nodeexp.wordsrelated.length;i++)
   {
    noderel[i] = (node)Nodes.get(i);
    noderel[i].getradius(random(70.0,90.0));
    noderel[i].posx = nodeexp.posx+cos(PI/6*i)*((i*10)+220);
    noderel[i].posy = nodeexp.posy+sin(PI/6*i)*((i*10)+220);
    noderel[i].paintme();
    line(nodeexp.posx,nodeexp.posy,noderel[i].posx,noderel[i].posy);
   }
   PFont cli = loadFont("Corbel-Italic-29.vlw");  //here we load the font
   textFont(cli);
    for(int i=0;i<reading.length;i+=2)
   {
      text(reading[i],leftedge,i*20+top);
   }   
   // initial work for the speaker
   sayit.init();
}

void draw()
{   
    background(55,182,219);
    node nodeexp = (node)Nodes.get(0);
    nodeexp.paintme();
    for(i=1;i<nodeexp.wordsrelated.length;i++)
   {
    noderel[i] = (node)Nodes.get(i);
    if((mouseX-noderel[i].posx)*(mouseX-noderel[i].posx)+(mouseY-noderel[i].posy)*(mouseY-noderel[i].posy)<noderel[i].radius*noderel[i].radius)
    {
      noderel[i].altercolor = true;
      if(mousePressed&&mouseButton==RIGHT){
              //speak it out
              sayit.sayContent(noderel[i].mainword);
      }
    }
    else
    {
      noderel[i].altercolor = false;
    }
    noderel[i].paintme();
    line(nodeexp.posx,nodeexp.posy,noderel[i].posx,noderel[i].posy);
   }
  listwords(leftedge,reading,70,2000);
}


String [] posgene(String require)  //the position generator
{
  textreader reader = new textreader();
  reader.getfilename(inputfile);
  reader.datain();
  reader.engineforNJU(require);
  node nodeforjxc = new node();
  nodeforjxc.getword(reader.mainword);
  nodeforjxc.getrelwords(reader.wordsrelated);
  nodeforjxc.getradius(random(120.0));
  nodeforjxc.getpos(width/2+random(80.0),height/2+random(20.0));
  Nodes.add(nodeforjxc);
  for(int i = 1;i<nodeforjxc.wordsrelated.length;i++)
  {
    node alsoforjxc = new node();
    alsoforjxc.getword(nodeforjxc.wordsrelated[i]);
    Nodes.add(alsoforjxc);
  }
  return reader.lines;
}

void listwords(int leftedge,String []results,int rate,int secondrate)
 {
   top-=10;
   for(int i=0;i<results.length;i+=2)
   {
     if((i*20+top>0)&&(i*20+top<height))
     text(results[i],leftedge,i*20+top); 
   }
     if((results.length*20+top)<height/10){
      top = 200;
     }
     if(mouseX<100){
      delay(secondrate);
      textinitial(results,top);
      }
   else{
   delay(rate);
     }  
 }

void mousePressed()
{
   mousexalter = 0;
   mouseyalter = 0;
   x1 = mouseX;
   y1 = mouseY;
   if(mouseButton==LEFT&&mouseX<100){
   int index = mouseY/(height/15);
   reading = gettextandpaint(index);
   }
   else{
     
   }
}

void mouseDragged()
{
   for(int i=1;i<rellength;i++)
   {    
     if(noderel[i].altercolor)
         currentposalter = i;
   }
   noderel[currentposalter].posx -= mousexalter;
   noderel[currentposalter].posy -= mouseyalter;
   mousexalter = mouseX - x1;
   mouseyalter = mouseY - y1;
   noderel[currentposalter].posx += mousexalter;
   noderel[currentposalter].posy += mouseyalter;
   
}

String[] gettextandpaint(int indexoflist)
 {
   String[] success;
   Nodes = new ArrayList();
   success =posgene(text[indexoflist]);
   initial(success,(node)Nodes.get(0));
   return success;
 }


void initial(String []relshuzu,node nodeexp)
{
  rellength = nodeexp.wordsrelated.length;
  nodeexp.getradius(random(100.0,120.0));
  newposx = width/2+random(80.0);
  newposy = height/2+random(20.0);
  for(int i=1;i<nodeexp.wordsrelated.length;i++)
   {
    noderel[i] = (node)Nodes.get(i);
    noderel[i].getradius(random(70.0,90.0));
    noderel[i].posx = nodeexp.posx+cos(PI/6*i)*((i*10)+220);
    noderel[i].posy = nodeexp.posy+sin(PI/6*i)*((i*10)+220);
    noderel[i].paintme();
    line(nodeexp.posx,nodeexp.posy,noderel[i].posx,noderel[i].posy);
   }

}


void textinitial(String []succeed,int high)
{
  int forjudge;
  for(int i=0;i<succeed.length;i+=2)
   {
     forjudge = (i*20+high)*15/height;
     if(forjudge>=0&&forjudge<15){
       text[forjudge] = succeed[i];
     }
   }
}
