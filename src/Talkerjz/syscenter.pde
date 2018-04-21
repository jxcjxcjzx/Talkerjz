class syscenter
{
  
boolean m_mousepressed = false;
PImage []a = new PImage[6];
int []locx = {30,170,30,170,30,170};
int []locy = {70,70,250,250,430,430};
int picwidth = 0;
int sys_scroll = 0;
boolean whetheradd = false;
String []appname = {"Dialog","Notereminder","Writer","catchyou","txtReader","ViewerRecord"};
int []tome = {0,sig.screenwidth,-sig.screenwidth,sig.screenwidth*3,sig.screenwidth*4,sig.screenwidth*5};


// this is for tip-help system
String tipcontent[] = {"  click  this  like  buttons,  you  will get  into  the   corresponding  app"};
int []tiplocx = {39,107};
int []tiplocy = {83,145};
int widthadjustvalue = 0;


void handle_in_setup()
{
    if(!this.whetheradd){
         a[0] = loadImage("Dia.jpg");
         a[1] = loadImage("Not.jpg");
         a[2] = loadImage("Wri.jpg");
         a[3] =  loadImage("catchyou.jpg");
         a[4] = loadImage("Reader.jpg");
         a[5] = loadImage("Viewer.jpg");
         picwidth = a[0].width;
     whetheradd = true;
  }  
   // initial draw
   for(int i=0;i<6;i++){
   image(a[i],locx[i],locy[i]-sys_scroll);
   }
   
     //clear for tip system
     this.widthadjustvalue = 0;
}

void handle_in_draw()
{
   background(67,71,89);
   for(int i=0;i<6;i++){
   image(a[i],locx[i],locy[i]);
   if(mouseX>locx[i]&&mouseX<locx[i]+picwidth
   &&mouseY>locy[i]&&mouseY<locy[i]+picwidth){
     fill(120,120,120);
     rect(locx[i]-1,locy[i]+picwidth+2,picwidth+2,picwidth/4);
     fill(255,255,255);
     text(appname[i],locx[i]+5,locy[i]+picwidth+16);
     if(sig.m_mousepressed){
       // choose the apps you want
       sig.scrolldecide =tome[i];
       
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
