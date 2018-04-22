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

void handle_in_setup()
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

void handle_in_draw()
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
