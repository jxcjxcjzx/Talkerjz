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

void handle_in_setup()
{
  rectwidth = width-width/5;
  rectheight = height/15;
  height2 = width/6+rectheight+width/30;
  height3 = width/6+rectheight+width/10;
  a = loadImage("talkerjz.jpg");
}

void handle_in_draw()
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

