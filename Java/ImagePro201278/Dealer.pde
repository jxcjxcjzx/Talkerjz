class Dealer
{
   String[] mapfordeal = {"greyimg","rimfind","middlefilter","rot","differentialonce","differentialtwice","Prewittrimfind","moveavrsmooth","expand"};
   PImage imagehere;
   int []pixelsR; 
   int []pixelsG;
   int []pixelsB;
   int []grey;

   Dealer(int []R,int []G,int []B,int []grey,PImage img)
  {
    this.imagehere = img;
    this.pixelsR = R.clone();
    this.pixelsG = G.clone();
    this.pixelsB = B.clone();
    this.grey = grey.clone();
  }
  void action(String mapdes,int locationx,int locationy,boolean show)
  {    // the followings are the code that will handle with the image
     boolean find = false;
     if(mapdes.equals(this.mapfordeal[0]))
       this.greyimg();
     if(mapdes.equals(this.mapfordeal[1]))
       this.rimfind();  
     if(mapdes.equals(this.mapfordeal[2]))
       this.middlefilterimaging();
     if(mapdes.equals(this.mapfordeal[3]))
       this.rotting();  
     if(mapdes.equals(this.mapfordeal[4]))
       this.differentialrimfindonce();
     if(mapdes.equals(this.mapfordeal[5]))
       this.differentialrimfindtwice();
     if(mapdes.equals(this.mapfordeal[6]))
       this.differentialwithPrewitt();
     if(mapdes.equals(this.mapfordeal[7]))
       this.differentialwithPrewitt();
     if(mapdes.equals(this.mapfordeal[8]))
       this.imageexpanding();
     for(int i=0;i<mapfordeal.length;i++)
     {  
       if(mapdes.equals(mapfordeal[i]))
         find = true;
     }
      if(!find){       
        println("Can not apply the "+mapdes+" to image,you may develop it yourself,Thanks!(jxc)");
       }  
       if(show){
            image(this.imagehere,locationx,locationy);    
       }  
       else{
       }
}

  void greyimg()
 {
    int loc;
    for(int i=0;i<this.imagehere.width;i++)
    for(int j=0;j<this.imagehere.height;j++)
    {
      loc = i+j*this.imagehere.width;
      this.imagehere.pixels[loc] = color(this.grey[loc],this.grey[loc],this.grey[loc]);
    }
 }
 
 void rimfind()
  {
     int loc;
     int loc2;
     int loc3;
     int door = 5;
     this.greyimg();
     for(int i=0;i<this.imagehere.width;i++)
        for(int j=1;j<this.imagehere.height-1;j++)
          {
            loc = i+j*this.imagehere.width;
            loc2 = i+1+j*this.imagehere.width;
            loc3 = i-1+j*this.imagehere.width;
            if((this.grey[loc]-this.grey[loc2]>door)||(this.grey[loc]-this.grey[loc3]>door)){
               }
            else{
              this.imagehere.pixels[loc] = color(0,0,0);
            }   
               
          }
  }

          
         void middlefilterimaging()
         {
            int i,j;
            int []c = new int[9];
            int xsize = this.imagehere.width;
            int ysize = this.imagehere.height;
            int dat;
             for(j=1;j<ysize-1;j++)
                 for(i=1;i<xsize-1;i++)
                   {
                      c[0] = this.grey[(j-1)*xsize+i-1];
                      c[1] = this.grey[(j-1)*xsize+i];
                      c[2] = this.grey[(j-1)*xsize+i+1];
                      c[3] = this.grey[j*xsize+i-1];
                      c[4] = this.grey[j*xsize+i];
                      c[5] = this.grey[j*xsize+i+1];
                      c[6] = this.grey[(j+1)*xsize+i-1];
                      c[7] = this.grey[(j+1)*xsize+i];
                      c[8] = this.grey[(j+1)*xsize+i+1];
                      dat = this.median_value(c);
                      this.imagehere.pixels[j*xsize+i] = color(dat,dat,dat);
                   }
         }

   int median_value(int []c)   // 此函数供中值滤波函数使用
   {
        int i,j,buf;
        for(j=0;j<8;j++)
          for(i=0;i<8;i++)
            {
              if(c[i+1]<c[i]){
                buf = c[i+1];
                c[i] = buf;
              }
            }
         return c[4];   
    } 

   void rotting()
   {
      int i,j;
      int dat;
      int xsize = this.imagehere.width;
      int ysize = this.imagehere.height;
      for(j=1;j<ysize-1;j++)
         for(i=1;i<xsize-1;i++)
           {
              dat = this.grey[j*xsize+i];
              this.imagehere.pixels[j*xsize+i] = color(dat,dat,dat);
              if(this.grey[(j-1)*xsize+i-1]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
              if(this.grey[(j-1)*xsize+i]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
              if(this.grey[(j-1)*xsize+i+1]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
              if(this.grey[j*xsize+i-1]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
              if(this.grey[j*xsize+i]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
              if(this.grey[j*xsize+i+1]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
              if(this.grey[(j+1)*xsize+i-1]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
              if(this.grey[(j+1)*xsize+i]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
              if(this.grey[(j+1)*xsize+i+1]==0)
                  this.imagehere.pixels[j*xsize+i] = color(0,0,0);
           }
   }

   void differentialrimfindonce()   // amp为输出像素值倍数
  {
    int xsize = this.imagehere.width;
    int ysize = this.imagehere.height;
    int []cx = {0,0,0,0,1,0,0,0,-1};
    int []cy = {0,0,0,0,0,1,0,-1,0};
    int []d = new int[9];
    int i,j,dat;
    float xx,yy,zz;
    float amp = 1.2;
    for(j=1;j<ysize-1;j++)
       for(i=1;i<xsize-1;i++)
         {
            xx = yy = zz = 0;
            d[0] = this.grey[(j-1)*xsize+i-1];
            d[1] = this.grey[(j-1)*xsize+i];
            d[2] = this.grey[(j-1)*xsize+i+1];
            d[3] = this.grey[j*xsize+i-1];
            d[4] = this.grey[j*xsize+i];
            d[5] = this.grey[j*xsize+i+1];
            d[6] = this.grey[(j+1)*xsize+i-1];
            d[7] = this.grey[(j+1)*xsize+i];
            d[8] = this.grey[(j+1)*xsize+i+1];
         
              for(int k=0;k<9;k++)
                {
                  xx += (float)(cx[k]*d[k]);
                  yy += (float)(cy[k]*d[k]);
                  zz = (float)(amp*sqrt(xx*xx+yy*yy));
                  dat = (int)zz;
                  if(dat>255)
                     this.imagehere.pixels[j*xsize+i] = color(255,255,255);         
                }
         }
  }




  void differentialrimfindtwice()   // amp为输出像素值倍数
  {
    int xsize = this.imagehere.width;
    int ysize = this.imagehere.height;
    int []c = {-1,-1,-1,-1,8,-1,-1,-1,-1};
    int []d = new int[9];
    int i,j,dat;
    float z,zz;
    float amp = 1.2;
    for(j=1;j<ysize-1;j++)
       for(i=1;i<xsize-1;i++)
         {
            z = zz = 0;
            d[0] = this.grey[(j-1)*xsize+i-1];
            d[1] = this.grey[(j-1)*xsize+i];
            d[2] = this.grey[(j-1)*xsize+i+1];
            d[3] = this.grey[j*xsize+i-1];
            d[4] = this.grey[j*xsize+i];
            d[5] = this.grey[j*xsize+i+1];
            d[6] = this.grey[(j+1)*xsize+i-1];
            d[7] = this.grey[(j+1)*xsize+i];
            d[8] = this.grey[(j+1)*xsize+i+1];
         
              for(int k=0;k<9;k++)
                {
                  z += (float)(c[k]*d[k]);
                  zz = z*amp;
                  dat = (int)zz;
                  if(dat>255)
                     dat = 255;         
                  if(dat<0)
                      dat = -dat;
                    this.imagehere.pixels[j*xsize+i] = color(dat,dat,dat);  
              }
         }
  }



   void differentialwithPrewitt()
    {
        int xsize = this.imagehere.width;
        int ysize = this.imagehere.height;
        int []d = new int[9];
        int i,j,k,maxnum,dat;
        int []m = new int[8];
        float amp = 0.35;
        float zz;
        for(j=1;j<ysize-1;j++)
          for(i=1;i<xsize-1;i++)
           {
            d[0] = this.grey[(j-1)*xsize+i-1];
            d[1] = this.grey[(j-1)*xsize+i];
            d[2] = this.grey[(j-1)*xsize+i+1];
            d[3] = this.grey[j*xsize+i-1];
            d[4] = this.grey[j*xsize+i];
            d[5] = this.grey[j*xsize+i+1];
            d[6] = this.grey[(j+1)*xsize+i-1];
            d[7] = this.grey[(j+1)*xsize+i];
            d[8] = this.grey[(j+1)*xsize+i+1];
            
            m[0] = d[0]+d[1]+d[2]+d[3]-2*d[4]+d[5]-d[6]-d[7]-d[8];
            m[1] = d[0]+d[1]+d[2]+d[3]-2*d[4]-d[5]+d[6]-d[7]-d[8];
            m[2] = d[0]+d[1]-d[2]+d[3]-2*d[4]-d[5]+d[6]+d[7]-d[8];
            m[3] = d[0]-d[1]-d[2]+d[3]-2*d[4]-d[5]+d[6]+d[7]+d[8];
            m[4] = d[0]-d[1]-d[2]+d[3]-2*d[4]+d[5]+d[6]+d[7]+d[8];
            m[5] = d[0]-d[1]+d[2]-d[3]-2*d[4]+d[5]+d[6]+d[7]+d[8];
            m[6] = d[0]+d[1]+d[2]-d[3]-2*d[4]+d[5]-d[6]+d[7]+d[8];
            m[7] = d[0]+d[1]+d[2]-d[3]-2*d[4]-d[5]-d[6]-d[7]+d[8];
    
            maxnum = 0;
              for(k=0;k<8;k++)
                  if(maxnum<m[k])
                    maxnum = m[k];
                  zz = amp*(float)(maxnum);
                  dat = (int)zz;
                  if(dat>255)
                     dat = 255;         
                    this.imagehere.pixels[j*xsize+i] = color(dat,dat,dat);  
              }
        }


         void imagesmoothwithmoveandaveraging()
         {
           int i,j,buf;
           int dat;
           int xsize = this.imagehere.width;
           int ysize = this.imagehere.height;
              for(j=1;j<ysize-1;j++)
                   for(i=1;i<xsize-1;i++)
                     {
                        buf =this.grey[(j-1)*xsize+i-1]
                        + this.grey[(j-1)*xsize+i]
                        + this.grey[(j-1)*xsize+i+1]
                        + this.grey[j*xsize+i-1]
                        + this.grey[j*xsize+i]
                        + this.grey[j*xsize+i+1]
                        + this.grey[(j+1)*xsize+i-1]
                        + this.grey[(j+1)*xsize+i]
                        + this.grey[(j+1)*xsize+i+1];
                       dat = buf/9; 
                       this.imagehere.pixels[j*xsize+i] = color(dat,dat,dat);
                     }
         }
         
         
            void imageexpanding()
         {
            int i,j;
            int dat;
            int xsize = this.imagehere.width;
            int ysize = this.imagehere.height;
              for(j=1;j<ysize-1;j++)
                   for(i=1;i<xsize-1;i++)
                     {
                        dat = this.grey[j*xsize+i];
                        this.imagehere.pixels[j*xsize+i] = color(dat,dat,dat);
                        if(this.grey[(j-1)*xsize+i-1]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                        if(this.grey[(j-1)*xsize+i]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                        if(this.grey[(j-1)*xsize+i+1]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                        if(this.grey[j*xsize+i-1]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                        if(this.grey[j*xsize+i]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                        if(this.grey[j*xsize+i+1]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                        if(this.grey[(j+1)*xsize+i-1]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                        if(this.grey[(j+1)*xsize+i]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                        if(this.grey[(j+1)*xsize+i+1]==252)
                            this.imagehere.pixels[j*xsize+i] = color(255,255,255);
                     }
         
         
         }
         
         
         
         
         
        
}
