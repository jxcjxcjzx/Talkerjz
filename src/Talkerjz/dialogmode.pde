import java.text.SimpleDateFormat;

 PImage a1;
 PImage a2;
 PImage a3;

class dialogmode
{
  boolean whetherentermode = true;
  boolean whetheradd = false;
  
  // the standard configuration
  int sys_scroll = 0;
  int sys_scroll2 = 0;
  String vector = "0";


  // this is for tip-help system
  String tipcontent[] = {"provide  easy  access  to    time,  input  what  is  the  time  to  know","I  know  the  letters  you   want  to  know,  input          dic:words  to know",
  "To  find  any  files  in your  computer,  input  where     is  the  (filename) ","Input  box,  see  payback       at  the  top"};
  int []tiplocx = {102,131,170,202,236,272,49,261};
  int []tiplocy = {448,476,447,477,445,478,494,552};
  int widthadjustvalue = 0;


  
  boolean inpower()
{
   boolean forreturn = false;
   if(sig.scrolldecide<=width*4/5&&sig.scrolldecide>=-width*4/5){
     forreturn = true;
     vector = "1";
   }
   else  {
     vector = "0";
   }
   return forreturn;
}
  
  
  void handle_in_setup()
 {
    if(!whetheradd){
     answerit.getfilename(sig.askadd,sig.answeradd);
     answerit.datain();
     abc.getlist(sig.listhere);
     abc.addcontent("");
     abc.addcontent("");
     abc.addcontent("");
     abc.addcontent("");
     a1 = loadImage("Clock.jpg");
     a2 = loadImage("Dic.jpg");
     a3 = loadImage("Diskmap.jpg");
     whetheradd = true;
    }
    
    // initial drawing work
         fill(255,255,255);
         systemfunc.roundrect(sig.x+sys_scroll,sig.y,sig.x+sig.changdu+sys_scroll,sig.y+sig.gaodu);
         fill(0,0,0);
         if(!sig.receiveforstore){
         text(sig.show,sig.x+20+sig.leftedgeforshow+sys_scroll,sig.y+40);
         }
         if(sig.receiveforstore){
         text(sig.answerstring,sig.x+20+sys_scroll,sig.y+40);
         }
         systemfunc.showtext(sig.getanswer);
         fill(255,255,255);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+sig.gaodutwo+10+sig.top,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*2+sig.top);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+2*sig.gaodutwo+10+sig.top,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*3+sig.top);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+3*sig.gaodutwo+10+sig.top,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*4+sig.top);
         if(sig.gaodutwo+sig.top>0)
         sig.top--;
         if(sig.gaodutwo+sig.top<=0){
         sig.top = -sig.gaodutwo;
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+3*sig.gaodutwo+10,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*4);
         }
         abc.listcontent();
       //clear for tip system
        this.widthadjustvalue = 0;
 }

  void handle_in_draw()
  {
     this.sys_scroll = sig.sys_scroll;
     this.sys_scroll2 = sig.sys_scroll2;
     background(70,224,220);
     // this is for the app show    in shu
     if(sig.m_mousepresslocy>30||sig.m_mousepresslocy<-30){
        centerone.sys_scroll = this.sys_scroll2 - height;
        centertwo.sys_scroll = this.sys_scroll2 + height;
        centerone.handle_in_setup();
        centertwo.handle_in_setup();
     }
     
     // this is for the app show    in heng
     note.sys_scroll = this.sys_scroll-width;
     note.handle_in_setup();
     pass120.sys_scroll = this.sys_scroll+width;
     pass120.handle_in_setup();

    //this is the sub-function showing area
    image(a1,90+sys_scroll,440+sys_scroll2);
    image(a2,90+a2.width+20+sys_scroll,440+sys_scroll2);
    image(a3,90+a2.width+a3.width+40+sys_scroll,440+sys_scroll2);
     
     if(whetherentermode){
       // handle with key and mouse Messages
          if(sig.m_keypressed){
            // this is showing control in keyPressed function
            if(sig.update){
             answerit.datain();
             sig.update = false;
           }
           // 自动缩进操作控制
           if(keyCode==37){
             sig.leftedgeforanswer+=3;
          }
           if(keyCode==39){
            sig.leftedgeforanswer-=3;
          }
           if(keyCode==38){
            sig.key_of_up_arrow = true;
          }
           if(keyCode==40){
            sig.key_of_down_arrow = true;
          }
          foryou.tools(); 
          if(key ==' '||(key >= 'a'&&key<= 'z')||(key>='A'&&key<='Z')
          ||key==','||key=='?'||key=='\''||key=='.'||key=='!'||key==':'){
           sig.leftedgeforshow-=3;
           if(!sig.receiveforstore){ 
            sig.show+=key;
           }
           else{
            sig.answerstring+=key;
           }  
        }
          if(key =='\n')
            {    
                 if(!sig.receiveforstore){
                 sig.orderarray.add(sig.show);
                 sig.ordercount++;
                 }
                 sig.leftedgeforshow = 50;
                 if(sig.show.contains("good bye"))
                    exit();
                 if(!sig.occupied&&dicdic.entermode(sig.show)){
                       sig.getanswer = dicdic.handle();  
                       sig.show ="";
                       sig.occupied = true;
               }
                 if(!sig.occupied&&showtime.entermode(sig.show)){
                       sig.getanswer = showtime.handle();  
                       sig.show ="";
                       sig.occupied = true;
               }
                 if(!sig.occupied&&pase.entermode(sig.show)){
                       sig.store[0] = pase.handle();  
                       // set the name of the file
                       SimpleDateFormat sdf_copy = new SimpleDateFormat("yyy_MM_dd_HH_mm_ss");
                       String ss_copy = sdf_copy.format(new java.util.Date());
                       saveStrings("content_"+ss_copy+".txt",sig.store);
                       sig.getanswer = "content is in content_"+ss_copy+".txt file now";
                       sig.show ="";
                       sig.occupied = true;
               }
                 if(!sig.occupied&&search.entermode(sig.show)){
                   if(search.searchname.length()<2){
                           String newname = pase.handle();
                           sig.getanswer = search.handle(newname); 
                        } 
                        else{
                         sig.getanswer = search.handle();   
                      }
                         sig.show ="";
                         sig.occupied = true;      
           }
                 if(sig.receiveforstore&&!sig.occupied){
                      answerit.addanswer(sig.askstring,sig.answerstring);
                      sig.receiveforstore = false;
                      sig.getanswer = "ok, I know how to handle with you..dododo";
                      sig.update = true;
                      sig.answerstring = "";
                 }     
                     else{
                            if(!answerit.haveanswer(sig.show)&&!sig.receiveforstore&&!sig.occupied){
                             sig.askstring = sig.show;
                             sig.getanswer = "how to answer you,deal?";
                             sig.show ="";
                             sig.receiveforstore = true; 
                          }
                           else{
                                    // search for answer and add answer
                                  if(answerit.haveanswer(sig.show)&&!sig.receiveforstore&&!sig.occupied){
                                  sig.getanswer = answerit.getanswer();
                                  abc.addcontent(sig.show);  
                                  // say it out
                                  sayit.sayContent(sig.getanswer);
                                  sig.show = "";
                                  sig.top = 0;
                                }
                           }
            
            }
        }
          if(key== '\b'){
             sig.leftedgeforshow+=3;
            if(!sig.receiveforstore){
            if(sig.show.length()-1>=0){
            sig.showback = sig.show.substring(0,sig.show.length()-1);
            sig.show = sig.showback; 
            }
            }
            else{
            if(sig.answerstring.length()-1>=0){
            sig.showback = sig.answerstring.substring(0,sig.answerstring.length()-1);
            sig.answerstring = sig.showback; 
            }
            }
          }
               sig.occupied = false;
               sig.reset();  
               
               // reset keystate
               sig.m_keypressed = false;
          }
       
       // pic in this mode in draw
         fill(255,255,255);
         systemfunc.roundrect(sig.x+sys_scroll,sig.y+sys_scroll2,sig.x+sig.changdu+sys_scroll,sig.y+sig.gaodu+sys_scroll2);
         fill(0,0,0);
         if(!sig.receiveforstore){
         text(sig.show,sig.x+20+sig.leftedgeforshow+sys_scroll,sig.y+40+sys_scroll2);
         }
         if(sig.receiveforstore){
         text(sig.answerstring,sig.x+20+sys_scroll,sig.y+40+sys_scroll2);
         }
         systemfunc.showtext(sig.getanswer);
         fill(255,255,255);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+sig.gaodutwo+10+sig.top+sys_scroll2,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*2+sig.top+sys_scroll2);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+2*sig.gaodutwo+10+sig.top+sys_scroll2,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*3+sig.top+sys_scroll2);
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+3*sig.gaodutwo+10+sig.top+sys_scroll2,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*4+sig.top+sys_scroll2);
         if(sig.gaodutwo+sig.top>0)
         sig.top--;
         if(sig.gaodutwo+sig.top<=0){
         sig.top = -sig.gaodutwo;
         systemfunc.roundrect(width*2/15+sys_scroll,sig.yy+3*sig.gaodutwo+10+sys_scroll2,20+sig.changdutwo+sys_scroll,sig.yy+sig.gaodutwo*4+sys_scroll2);
         }
         abc.listcontent();
     }
     else{
     }
     
     
         // this is for tip-help system
        for(int tipi=0;tipi<this.tipcontent.length;tipi++){
          if(mouseX>tiplocx[tipi*2]&&mouseX<tiplocx[tipi*2+1]&&mouseY>tiplocy[tipi*2]&&mouseY<tiplocy[tipi*2+1]){      
          systemfunc.showtip(this.tipcontent[tipi],this.widthadjustvalue,140);
          }
        }
        this.widthadjustvalue++;
        if(this.widthadjustvalue>150){
          this.widthadjustvalue = 151;
        }      
     
     
  }
           

}




// useful classes: dictionary,lister,paster,searchengine,timer,answer

class dictionary
{
  String forhandle;
  String word;
  String []lineshere;
  
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String readinadd = "dic.txt";
     String forjudge = "dic:";
     if(a.contains(forjudge)){
        forreturn = true;
        this.forhandle = a;
        String []lines = loadStrings(readinadd);
        this.lineshere = lines;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  String handle()
  {
     String wordhere = "";
     String forreturn = "search failure";
     java.util.regex.Pattern p = java.util.regex.Pattern.compile("dic:(.*)");
      Matcher m = p.matcher(this.forhandle);
	if(m.find()){
         wordhere = m.group(1);
      }
    this.word = wordhere;
    for(int i=0;i<this.lineshere.length;i+=2){
        if(this.word.equals(this.lineshere[i]))
          forreturn = this.lineshere[i+1];
     }
    return forreturn; 
   }
}



//variables: ArrayList<Stirng> listit
//functions: getlist(ArrayList<String>),roundrect(int,int,int,int)

class lister
{
  ArrayList<String> listit = new  ArrayList();
 
  void getlist(ArrayList<String> a)
  {
    this.listit = a; 
  }
  
  void addcontent(String b)
  {
    this.listit.add(b);
  }

  void listcontent()
  {
        
    int changdu = this.listit.size();
    String showone = this.listit.get(changdu-1);
    String showtwo = this.listit.get(changdu-2);
    String showthree = this.listit.get(changdu-3);

    fill(0,0,0);
    text(showone,width/5+mainmode.sys_scroll,sig.yy+sig.gaodutwo*3+10+sig.top+sig.gaodutwo/2+mainmode.sys_scroll2);
    text(showtwo,width/5+mainmode.sys_scroll,sig.yy+sig.gaodutwo*2+10+sig.top+sig.gaodutwo/2+mainmode.sys_scroll2);
    text(showthree,width/5+mainmode.sys_scroll,sig.yy+sig.gaodutwo*1+10+sig.top+sig.gaodutwo/2+mainmode.sys_scroll2);

}
  
  void roundrect(int x1,int y1,int x2,int y2)
{
  int radiushere = 20;
  rect(x1,y1+radiushere,x2-x1,y2-y1-2*radiushere);
  rect(x1+radiushere,y1,x2-x1-2*radiushere,y2-y1);
  ellipse(x1+radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x1+radiushere,y2-radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y1+radiushere,radiushere*2,radiushere*2);
  ellipse(x2-radiushere,y2-radiushere,radiushere*2,radiushere*2);
}
}




class paster
{
  String forpaste = "";
  
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String forjudge = "copy";   // here you can something else
     String forjudgetwo = "for";
     String forjudgethree = "me";
     if(a.contains(forjudge)&&a.contains(forjudgetwo)&&a.contains(forjudgethree)){
        forreturn = true;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  String handle()
  {
     String forreturn = "";
     Clipboard sysClip = Toolkit.getDefaultToolkit().getSystemClipboard();
	  Transferable clipTf = sysClip.getContents(null);
	  if(clipTf!=null){
		    //检查文本类型
		    if(clipTf.isDataFlavorSupported(DataFlavor.stringFlavor)){
		    	try{
		    	  this.forpaste = (String)clipTf.getTransferData(DataFlavor.stringFlavor);
		    	}
		    	catch (Exception e) 
		        {            
		          e.printStackTrace();    
		        }   
		    }
		  }  
     forreturn = this.forpaste;
     return forreturn; 
   }
}



class searchengine
{  
  String searchname = " ";
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String []forjudge = {"where","is","file","search","for","file"};
     if((a.contains(forjudge[0])&&a.contains(forjudge[1])
     &&a.contains(forjudge[2]))||(a.contains(forjudge[3])
     &&a.contains(forjudge[4])&&a.contains(forjudge[5]))){
        forreturn = true;        
        java.util.regex.Pattern p = java.util.regex.Pattern.compile(".*file ([^/?]+)+?|.*file (.*)$");
        Matcher m = p.matcher(a);
	if(m.find()){
          this.searchname = m.group(1);            
        } 
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  String handle()
  {
    String readinadd = "diskmap.txt";
    String forreturn = "对不起，我没有找到你要的东西";
    String []lookinto = loadStrings(readinadd);
    for(int i=0;i<lookinto.length;i++){
      if(lookinto[i].contains(this.searchname)){
        forreturn = "A ha, it's in: "+lookinto[i];
        break;
      }
      else{      
      }
    }
    return forreturn; 
   }
   
   String handle(String name)
   {   
         String forreturn = "对不起，我没有找到你要的东西";
     try{
           int lengthofarray = 0;  
           String readincontent = "";
           URL url = new URL("file:///E://SOFT HOME2/processing-1.5.1/for_summer/Talkerjz/diskmap.txt");         
           InputStreamReader isr = new InputStreamReader(url.openStream(),"gbk");
           BufferedReader br = new BufferedReader(isr); 
            while((readincontent = br.readLine())!=null){
                 lengthofarray++;
                 if(readincontent.contains(name)){
                   forreturn = "A ha, it's in: "+readincontent;
                   break;
                 }
                 else{
                 }
           }
     }
     catch (IOException e){
	   e.printStackTrace();    
     }    

    return forreturn; 
   
   }
}



class timer
{  
  boolean entermode(String a)
  {
     boolean forreturn = false;
     String forjudge = "time";
     String forjudgetwo = "what";
     if(a.contains(forjudge)&&a.contains(forjudgetwo)){
        forreturn = true;
     }
     else{
        forreturn = false; 
     }
     return forreturn;
  }
  
  String handle()
  {
    String forreturn = "";
    SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
    String ss = sdf.format(new java.util.Date());
    String addtoss = "The time is: ";
    forreturn = addtoss+ss;
    return forreturn; 
   }
}




//variavles: filename,answerindex,[]lineshere
//functions: datain(),getfilename()
// boolean haveanswer(String),String getanswer(int)

class answer
{
  String askadd;
  String answeradd;
  int answerindex =1;
  String []ask;
  String []answer;
  void getfilename(String filename,String filenametwo)
   {
     this.askadd = filename;
     this.answeradd = filenametwo;
   }
   
   void datain()
   {
      this.ask = loadStrings(this.askadd);
      this.answer = loadStrings(this.answeradd);
   }
  boolean haveanswer(String b)
  {
    boolean jieguo = false;
    for(int i=0;i<this.ask.length;i++)
    {
      if(b.equals(this.ask[i])){
       this.answerindex = i;
       jieguo = true;
       break;
      }
      else{
      continue;
      }
    }
    return jieguo;
  }
  
  String getanswer()
  {
    return this.answer[this.answerindex];
  }

  void addanswer(String a,String b)
  {
     String []dd = loadStrings(this.askadd);
     String []ee = loadStrings(this.answeradd);
     String []aa = new String[dd.length+1];
     String []bb = new String[ee.length+1];
     for(int i =0;i<aa.length-1;i++){
        aa[i] = dd[i];
     }
     for(int i =0;i<bb.length-1;i++){
        bb[i] = ee[i];
     }
     aa[aa.length-1] = a;
     bb[bb.length-1] = b;
     saveStrings(this.askadd, aa);
     saveStrings(this.answeradd, bb);
  }

}

