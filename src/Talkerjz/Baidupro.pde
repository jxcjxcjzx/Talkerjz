import java.util.regex.*;

class Baidupro{

int []button1 = {60,106,60+181,106+68};
int []button2 = {104,232,208,273};
int []button1textloc = {94,143};
int []button2textloc = {125,250};
boolean showit = false;
String toshow = "";
int scrollforsecond = 0;

int sys_scroll = 0;
String vector = "0";
boolean whetheradd = false;

// this is for tip-help system
String tipcontent[] = {"click  and  input  the  thing  you  want  to  know","click  me  to see!"};
int []tiplocx = {64,236,109,201};
int []tiplocy = {109,167,235,265};
int widthadjustvalue = 0;

boolean inpower()
{
   boolean forreturn = false;
   if(sig.scrolldecide<-(width*4/5+width)&&sig.scrolldecide>-(width*4/5+2*width)){
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
  // the initial drawing part
  fill(255,255,255);
  systemfunc.roundrect(button1[0]+sys_scroll,button1[1],button1[2]+sys_scroll
  ,button1[3]);
  fill(240,144,27);
  systemfunc.roundrect(button2[0]+sys_scroll,button2[1],button2[2]+sys_scroll
  ,button2[3]);
  fill(0,0,0);
  text("单击输入你想知道的",button1textloc[0]+sys_scroll,button1textloc[1]);
  text("我就知道",button2textloc[0]+sys_scroll,button2textloc[1]);
  
  if(!this.whetheradd){
  mouseWheelSetup();
  whetheradd = true;
  }
  //clear for tip system
  this.widthadjustvalue = 0;
}

void handle_in_draw()
{    
  if(!showit){
  this.sys_scroll = sig.sys_scroll;
  background(57,108,178);
  
  pass120.sys_scroll = this.sys_scroll-width;
  pass120.handle_in_setup();
  lockit.sys_scroll = this.sys_scroll+width;
  lockit.handle_in_setup();
  
  fill(255,255,255);
  systemfunc.roundrect(button1[0]+sys_scroll,button1[1],button1[2]+sys_scroll
  ,button1[3]);
  fill(240,144,27);
  systemfunc.roundrect(button2[0]+sys_scroll,button2[1],button2[2]+sys_scroll
  ,button2[3]);
  fill(0,0,0);
  text("单击输入你想知道的",button1textloc[0]+sys_scroll,button1textloc[1]);
  text("我就知道",button2textloc[0]+sys_scroll,button2textloc[1]);
  if(sig.m_mousepressed){
   if(mouseX>button1[0]&&mouseX<button1[2]
   &&mouseY>button1[1]&&mouseY<button1[3]){
      // deal with the open notepad part
      systemfunc.opennotepad();
      scrollforsecond = 0;
   } 
   if(mouseX>button2[0]&&mouseX<button2[2]
   &&mouseY>button2[1]&&mouseY<button2[3]){
      // deal with the launching search part
      
     StringBuffer store = new StringBuffer();
     try{
      String chaxun = pase.handle();
      BufferedReader buf = systemfunc.gethtmltext(addengine(chaxun),"nothing");
       BufferedReader test = null;
                           String ruleone = ".*百科名片.*";
                           String ruletwo = ".*目录.*";
			   boolean kaishi = false;
			   boolean jieshu = false;
			   jiexi jiexione = new jiexi(ruleone);
			   jiexi jiexitwo = new jiexi(ruletwo);
                           String readin = "";
                           if(buf!=null){
				 while((readin=buf.readLine())!=null){
					 if(jiexione.whethermatch(readin)){
					   kaishi = true;
					 }
					 if(kaishi){
					   store.append(jiexione.replacetags(readin));
					 }
					 if(jiexitwo.whethermatch(readin)){
						   jieshu = true;
						 }
						 if(jieshu){
						   break;
						 }
					 
				 }
                           }
            }
	    catch (IOException e) {            
	        println("Can not open the stream.");
	      }    
      
      toshow = store.toString();
      showit = true;
   } 
   sig.m_mousepressed = false;
  }
  
  }
  if(showit){
    systemfunc.textshow(scrollforsecond,toshow); 
    if(sig.m_keypressed){
      if(key =='\b'){
         showit = false;
      }
      sig.m_keypressed = false;
    }
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


  String addengine(String require)
 {
             String strUrl = require;
             URL url=null;
             String find = null;
             String str = null;
      try{
           java.util.regex.Pattern p2 = java.util.regex.Pattern.compile("http...baike.baidu.com.view.([0-9]+?).htm");
           url = new URL("http://www.baidu.com/s?wd="+strUrl);                              
           InputStreamReader isr = new InputStreamReader(url.openStream());
           BufferedReader br = new BufferedReader(isr); 
           while ((str = br.readLine() )!= null) {   
           Matcher m = p2.matcher(str);
           if (m.find()) {
           find = m.group(1);
           find = "http://baike.baidu.com/view/"+find+".htm"; 
           break;
           }
           else{
           continue;
           }			        
         }
        }               catch (IOException e) {            
	            find = "对不起，你的要求太过分了";
	        }  
     return find;
 }
 
 
  void mouseWheelSetup()
{
    addMouseWheelListener( // the rest of of this is acutally the argument list for the function call
            new java.awt.event.MouseWheelListener() 
            {
                 public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) 
                 {
                   scrollforsecond -= 9*evt.getWheelRotation();
                 }
            }
   ) // this is the end of the argument list
   ;    // this single semicolon is the entire, complete function body
}   


}
