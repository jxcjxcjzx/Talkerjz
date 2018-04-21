class notereminder
{
    String show = "";
    String backshow = "";
    ArrayList<String> showstore = new ArrayList();
    int qishix = 20;
    int qishiy = 40;
    int qishiwidth = 0;
    int qishiheight = 0;
    int regularwidth = 0; 
    int gap = 0;
    int gap2 = 0;
    
    // the standard configuration
    int sys_scroll = 0;
    String vector = "0";
    
    // this is for tip-help system
    String tipcontent[] = {"  input  your  agencies!     (when  five  pieces  fill     the board,  I  will  save   them  all,  next  time  you  want  to see,  input  what    do  I  need  to  do)"};
    int []tiplocx = {35,215};
    int []tiplocy = {50,84};
    int widthadjustvalue = 0;
    
    
    boolean inpower()
    {
       boolean forreturn = false;
       if(sig.scrolldecide>width*4/5&&sig.scrolldecide<(width*4/5+width)){
         forreturn = true;
         vector = "1";
       }
       else{
         vector = "0";
       }
       return forreturn;
    }
    
    void handle_in_setup()
    {
      // initializing work
      qishiwidth = 23*width/30;
      qishiheight = 5*height/60;
      regularwidth = 9*width/10;
      gap = height*7/60;
      gap2 = height/20;
      
      // for scroll look
      fill(0, 0, 0);
      text("notes here:", 40+sys_scroll, 26);
      fill(255, 255, 255);
      systemfunc.roundrect(qishix+sys_scroll, qishiy, qishix+sys_scroll+qishiwidth, qishiy+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap+qishiheight, qishix+sys_scroll+regularwidth, qishiy+gap+qishiheight*2);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2+qishiheight*2+gap, qishix+sys_scroll+regularwidth, qishiy+gap2+qishiheight*2+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*2+qishiheight*3+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*2+qishiheight*3+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*3+qishiheight*4+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*3+qishiheight*4+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*4+qishiheight*5+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*4+qishiheight*5+gap+qishiheight);
      //clear for tip system
      this.widthadjustvalue = 0;
    }
    
    void handle_in_draw()
    {
      this.sys_scroll = sig.sys_scroll;
      background(116, 249, 28);
    
      // this is for the right app show
         mainmode.sys_scroll = this.sys_scroll+width;
         mainmode.handle_in_setup();
         pianoplayer.sys_scroll = this.sys_scroll-width;
         pianoplayer.handle_in_setup();
      
      fill(0, 0, 0);
      text("notes here:", 40+sys_scroll, 26);
      fill(255, 255, 255);
      systemfunc.roundrect(qishix+sys_scroll, qishiy, qishix+sys_scroll+qishiwidth, qishiy+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap+qishiheight, qishix+sys_scroll+regularwidth, qishiy+gap+qishiheight*2);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2+qishiheight*2+gap, qishix+sys_scroll+regularwidth, qishiy+gap2+qishiheight*2+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*2+qishiheight*3+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*2+qishiheight*3+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*3+qishiheight*4+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*3+qishiheight*4+gap+qishiheight);
      systemfunc.roundrect(qishix+sys_scroll, qishiy+gap2*4+qishiheight*5+gap, qishix+sys_scroll+regularwidth, qishiy+gap2*4+qishiheight*5+gap+qishiheight);
      fill(0,0,0);
      text(this.show,qishix+sys_scroll+5,qishiy+height/24);
          for(int i=0;i<showstore.size();i++){
              text(showstore.get(i),qishix+sys_scroll+width/30,qishiy+gap2*i+qishiheight*(i+1)+gap+height/24);
            }
      if(sig.m_keypressed){
        if (key>='a'&&key<='z'||key>='A'&&key<='Z'||key==','
          ||key=='.'||key==' '||key=='?'||key=='\''||key=='!'
          ||key>='0'&&key<='9'||key==':'){
          show+=key;
        }
        if (key=='\b') {
              if (show.length()-1>=0) {
                backshow = show.substring(0, show.length()-1);
                show = backshow;
              }
         }  
        if(key=='\n'){
          showstore.add(show);
           if(show.contains("what")&&show.contains("need")&&show.contains("do")){
            String []forload = loadStrings("reminder.txt");
            showstore.clear();
            if(forload.length>4){
                  for(int count=0;count<5;count++){
                  showstore.add(forload[count]);
                  }
            }  else{
               }
          }          
          show= "";
          if(showstore.size()>5){
            String []forsave = new String[5];
            for(int count=0;count<5;count++){
            forsave[count] = showstore.get(count);
            }
            saveStrings("reminder.txt",forsave);
            showstore.clear();
            show="";
          }
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


