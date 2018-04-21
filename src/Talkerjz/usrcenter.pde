class usrcenter
{
boolean whetheradd = false;  
boolean m_mousepressed = false;
PImage []a = new PImage[6];
int []locx = {30,170,30,170,30,170};
int []locy = {70,70,250,250,430,430};
int picwidth = 0;
int sys_scroll = 0;
String []appname = {"PianoSir","I know","Analyser","Security"};
int []toyou = {sig.screenwidth*2,-sig.screenwidth*2,0,0};


// this is for tip-help system
String tipcontent[] = {"  click  this  like  buttons,  you  will get  into  the  corresponding  app"};
int []tiplocx = {45,104};
int []tiplocy = {83,146};
int widthadjustvalue = 0;



void handle_in_setup()
{
    if(!this.whetheradd){
       a[0] = loadImage("piano.jpg");
       a[1] = loadImage("ask.jpg");
       a[2] = loadImage("Analyser.jpg");
       a[3] = loadImage("Security.jpg");
       picwidth = a[0].width;
     whetheradd = true;
  }
   
   // initial draw
   for(int i=0;i<2;i++){
   image(a[i],locx[i],locy[i]-sys_scroll);
   }
     //clear for tip system
     this.widthadjustvalue = 0;
}

void handle_in_draw()
{
   background(207,136,132);
   for(int i=0;i<2;i++){
   image(a[i],locx[i],locy[i]);
   if(mouseX>locx[i]&&mouseX<locx[i]+picwidth
   &&mouseY>locy[i]&&mouseY<locy[i]+picwidth){
     fill(120,120,120);
     rect(locx[i]-1,locy[i]+picwidth+2,picwidth+2,picwidth/4);
     fill(255,255,255);
     text(appname[i],locx[i]+5,locy[i]+picwidth+16);
     if(sig.m_mousepressed){
         // choose the apps
       sig.scrolldecide = toyou[i];

       sig.scrolldecide2 = 0;
       sig.m_mousepressed = false;
       sig.centerused = false;
     }
   }
   }
   
   
    // this is for tip-help system
        for(int tipi=0;tipi<this.tipcontent.length;tipi++){
          if(mouseX>tiplocx[tipi*2]&&mouseX<tiplocx[tipi*2+1]&&mouseY>tiplocy[tipi*2]&&mouseY<tiplocy[tipi*2+1]){      
          systemfunc.showtip(this.tipcontent[tipi],this.widthadjustvalue,450);
          }
        }
        this.widthadjustvalue++;
        if(this.widthadjustvalue>150){
          this.widthadjustvalue = 151;
        }  
   
}

}
