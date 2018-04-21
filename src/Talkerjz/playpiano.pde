import ddf.minim.*;

class playpiano
{
        int spazio = 50;
        int value;
        // for piano playing
        ddf.minim.AudioPlayer public_song;
        
        int sys_scroll = 0;
        String vector = "0";
        
        
        // this is for tip-help system
        String tipcontent[] = {"  This  is  drived  by  key  'a'  to  'j'  in  your        keyboard,  press  them  to  fun !"};
        int []tiplocx = {14,275};
        int []tiplocy = {5,276};
        int widthadjustvalue = 0;


   
      boolean inpower()
      {
         boolean forreturn = false;
         if(sig.scrolldecide>(width*4/5+width)&&sig.scrolldecide<(width*4/5+2*width)){
           forreturn = true;
           vector = "1";
         }
         else{
           vector = "0";
         }
         return forreturn;
      }   
        
        void handle_in_setup(){
          // initial drawing
        
        fill(255);
        for(int i=0;i<7;i++){
          rect(i*width/7+sys_scroll,height/2,width/7,height/2);
        }
        fill(0);
        for(int i=1;i<7;i++){
          rect(i*width/7+sys_scroll,height/2,4,height/2);
        }
        rect(0+sys_scroll,0,width,height/2);
        
         //clear for tip system
         this.widthadjustvalue = 0;      
          
        }
        
      void handle_in_draw(){
        this.sys_scroll = sig.sys_scroll;
        background(0);
        note.sys_scroll = this.sys_scroll+width;
        note.handle_in_setup(); 
        cameraone.sys_scroll = this.sys_scroll-width;
        cameraone.handle_in_setup(); 

        fill(255);
        for(int i=0;i<7;i++){
          rect(i*width/7+sys_scroll,height/2,width/7,height/2);
        }
        fill(0);
        for(int i=1;i<7;i++){
          rect(i*width/7+sys_scroll,height/2,4,height/2);
        }
        rect(0+sys_scroll,0,width,height/2);
//do
       if(sig.m_keypressed){
      if (key == 'a'){
         public_song = sig.public_minim.loadFile("Re1.mp3");
         public_song.play();
        fill(38,222,57);
        rect(0*width/7+sys_scroll,height/2,width/7,height/2);
      }
      if ( key == 's'){
           public_song = sig.public_minim.loadFile("Mi1.mp3");
           public_song.play();
        fill(38,222,57);
        rect(1*width/7+sys_scroll,height/2,width/7,height/2);
      } 
      if ( key == 'd'){
          public_song = sig.public_minim.loadFile("Fa1.mp3");
          public_song.play();
        fill(38,222,57);
        rect(2*width/7+sys_scroll,height/2,width/7,height/2);        
      }
      if (key == 'f'){
           public_song = sig.public_minim.loadFile("Sol1.mp3");
           public_song.play();
        fill(38,222,57);
        rect(3*width/7+sys_scroll,height/2,width/7,height/2);
      }
      if (key == 'g'){
           public_song = sig.public_minim.loadFile("La1.mp3");
           public_song.play();
        fill(38,222,57);
        rect(4*width/7+sys_scroll,height/2,width/7,height/2);        
      }

      if (key == 'h'){
          public_song = sig.public_minim.loadFile("Si1.mp3");
          public_song.play();
        fill(38,222,57);
        rect(5*width/7+sys_scroll,height/2,width/7,height/2);        
      }
      if (key == 'j'){
          public_song = sig.public_minim.loadFile("Do2.mp3");
          public_song.play();
        fill(38,222,57);
        rect(6*width/7+sys_scroll,height/2,width/7,height/2);
      }    
      sig.m_keypressed = false;
      
      }
      
      
       // this is for tip-help system
        for(int tipi=0;tipi<this.tipcontent.length;tipi++){
          if(mouseX>tiplocx[tipi*2]&&mouseX<tiplocx[tipi*2+1]&&mouseY>tiplocy[tipi*2]&&mouseY<tiplocy[tipi*2+1]){      
          systemfunc.showtip(this.tipcontent[tipi],this.widthadjustvalue,400);
          }
        }
        this.widthadjustvalue++;
        if(this.widthadjustvalue>150){
          this.widthadjustvalue = 151;
        }   

}

}
