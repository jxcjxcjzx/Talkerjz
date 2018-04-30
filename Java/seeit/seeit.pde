int rate = 0;
int topforletter = 0;
int topforrect = 0;
float speed = 2.8;
int brim = 6;
String []xianshi;
lister listit = new lister();
int showlength = 0;
int countforletter = 0;
int countforrect = 0;
PrintWriter output;

void setup()
{
  size(500,680);
  noStroke();
  frameRate(30);
  smooth();
  PFont cli = loadFont("BodoniMT-Italic-28.vlw");  //here we load the font
  textFont(cli);
  output = createWriter("record.txt");
  reader me = new reader();
  me.getfilename("shuju.txt");
  me.datain();
  xianshi = me.lines;
  listit.get(xianshi);
  showlength = xianshi.length;
}


void draw()
{  
 background(99); // 边框颜色 
 
 fill(165,146,204);  //信息块颜色
 for(int i=0;i<showlength*9;i++){
    if(mouseY>topforrect+i*height/9&&mouseY<topforrect+(i+1)*height/9){
       fill(165,146,204);
       rect(0+brim,0+topforrect+i*height/9+brim,width-2*brim,height/10-2*brim);
    }
    else{
       rect(0,0+topforrect+i*height/9,width,height/10);
    }
 }
fill(200);
listit.listcontent(topforletter);

topforletter-=speed;
topforrect-=speed;
countforletter = xianshi.length*9-1;

if(countforletter*height/9+height/16+topforletter<height){
    output.close(); 
    exit();
  }
}

void mousePressed()
{
   for(int i=0;i<showlength*9;i++)
   {
     if(mouseX>(i-1)*height/9+height/16+topforletter&&mouseX<i*height/9+height/16+topforletter)
       output.println(xianshi[i%showlength]);
       output.flush();
   }

}

