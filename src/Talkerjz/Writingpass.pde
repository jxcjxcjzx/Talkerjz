class Writingpass
{
int chushix = 0;
int chushiy = 0;
int titlex = 0;
int titley = 0;
int titlewidth = 0;
int titleheight = 0;
int rectwidth = 0;
int rectheight = 0;
int showindex = 0;
int i = 0;
int j = 0;  
int uparrowpos = 0;
int downarrowpos = 0;
int mousepressloc = 0;
String show ="";
String backshow ="";
String title = "";
boolean titlentered = false;
ArrayList<String> showstore = new ArrayList();
boolean bottomstop = false;
boolean whetheradd = false;

// the standard configuration
int sys_scroll = 0;
String vector = "0";



// this is for tip-help system
String tipcontent[] = {"  expecting  you  smart       input  here,  type  in  save  it  when  it's  done"};
int []tiplocx = {57,239};
int []tiplocy = {183,209};
int widthadjustvalue = 0;


boolean inpower()
{
   boolean forreturn = false;
   if(sig.scrolldecide<-width*4/5&&sig.scrolldecide>-(width*4/5+width)){
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
  chushix = width/12;
  chushiy = height/5;
  titlex = chushix;
  titley = 40;
  rectwidth = width-width/6;
  rectheight = height-height/4;
  titlewidth = rectwidth;
  titleheight = 40;
  showindex = height/60;
  if(!this.whetheradd){
  this.showstore.add("here are the text:");
  whetheradd = true;
  }
  
  fill(255, 255, 255);
  text("title:", width/2-width/14+sys_scroll, height/27); 
  fill(255, 255, 255);
  systemfunc.roundrect(titlex+sys_scroll, titley, titlex+sys_scroll+titlewidth, titley+titleheight);
  systemfunc.roundrect(chushix+sys_scroll, chushiy, chushix+sys_scroll+rectwidth, chushiy+rectheight);
  //clear for tip system
  this.widthadjustvalue = 0;
}

void handle_in_draw()
{
  this.sys_scroll = sig.sys_scroll;
  background(120, 120, 120);
  
  // this is for the left app show
     mainmode.sys_scroll = this.sys_scroll-width;
     mainmode.handle_in_setup();
     ques.sys_scroll = this.sys_scroll+width;
     ques.handle_in_setup();
     
  fill(255, 255, 255);
  text("title:", width/2-width/14+sys_scroll, height/27); 
  fill(255, 255, 255);
  systemfunc.roundrect(titlex+sys_scroll, titley, titlex+sys_scroll+titlewidth, titley+titleheight);
  systemfunc.roundrect(chushix+sys_scroll, chushiy, chushix+sys_scroll+rectwidth, chushiy+rectheight);
  fill(0,0,0);
  text(title,width*13/100+sys_scroll, titley+height*11/300);
  if (sig.m_keypressed) {
    if (key>='a'&&key<='z'||key>='A'&&key<='Z'||key==','
      ||key=='.'||key==' '||key=='?'||key=='\''||key=='!'||key>='0'&&key<='9'||key==':') {
      show+=key;
    }
    if (key=='\n') {
      // handle for command to save the file
      if(show.contains("save it")){
        int savelength = showstore.size();
        String []forsave = new String[savelength-1];
        for(int count=0;count<savelength-1;count++)
        forsave[count] = showstore.get(count+1);
        if(title!=null){
        saveStrings(title+".txt",forsave);
        }
        else{
        }
        showstore.clear();
        showstore.add("here are the text:");
        show= "";
        title = "";
        titlentered = false;
        bottomstop = false;
      }  else{
              if(!titlentered){
                title = show;
                show = "";
                titlentered = true;
              }  else{
                      showstore.add(show);
                      if(showstore.size()>16){
                        bottomstop = true;
                      }
                      show = "";
                  }
              }
    }     
    if (key== '\b') {
      if (show.length()-1>=0) {
        backshow = show.substring(0, show.length()-1);
        show = backshow;
      }
    }      
    sig.m_keypressed = false;
  }
  fill(120,120,120);
  if(!bottomstop){
  systemfunc.roundrect(width/6-width/30+sys_scroll,height/4+(showstore.size()+1)*height/28+showindex-height/25
  ,width/6-width/12+width-width/30+sys_scroll,height/4+(showstore.size()+1)*height/28+showindex-height/25+40);
  }
  else if(bottomstop){
  systemfunc.roundrect(width/6-width/30+sys_scroll,height/4+(16+1)*height/28+showindex-height/25
  ,width/6-width/12+width-width/30+sys_scroll,height/4+(16+1)*height/28+showindex-height/25+40);
  }
  fill(0, 0, 0);
  if(!bottomstop){
  for (i=0;i<showstore.size();i++) {
    text(showstore.get(i), width/6+sys_scroll, height/4+i*height/28);
  }
  }
  else  if(bottomstop){
  i = 0;
  if(showstore.size()>16){
      for (j=showstore.size()-15;j<showstore.size();j++) {
        text(showstore.get(showstore.size()-15+i), width/6+sys_scroll, height/4+i*height/28);
        i++;
      }
  }
  }
  fill(0, 0, 0);
  if(!bottomstop){
  text(show, width/6+sys_scroll, height/4+(showstore.size()+1)*height/28+showindex);
  }
  else  if(bottomstop){
  text(show, width/6+sys_scroll, height/4+(16+1)*height/28+showindex);
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
