
class systemcall
{
  
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

  void showtext(String s)
  {
    text(s,20+sig.leftedgeforanswer+mainmode.sys_scroll,50+mainmode.sys_scroll2);
  }
  
  void textshow(int sys_scroll,String buf)
  {
      background(120,120,120);
      fill(255,255,255);
      int sublength = buf.length()/16+1;
      for(int j=0;j<sublength-1;j++)
      {
        text(buf.substring(j*16,j*16+15),50,50+j*20+sys_scroll);
      }
      text(buf.substring((sublength-1)*16,buf.length()),50,50+(sublength-1)*20+sys_scroll);
  }
  
  
    BufferedReader gethtmltext(String addr,String theway)
    {
       BufferedReader forshow = null;
       String forshowone = null;
      try{ 
       URL url = new URL(addr);   
       InputStreamReader isr = new InputStreamReader(url.openStream());
       if(theway.equals("gbk")){       
       isr = new InputStreamReader(url.openStream(),"gbk");
       }
       if(theway.equals("utf-8")){       
       isr = new InputStreamReader(url.openStream(),"utf-8");
       }
       forshow = new BufferedReader(isr);  
      }
      catch (IOException e) {            
        println("Can not open the stream, sorry.");
      }  
      return forshow;
    }
  
  void opennotepad()
  {
    try{
      Runtime.getRuntime().exec("notepad");
    } 
    catch(Exception e){
        println("无法打开notepad");   
    }
  }
  
  
    void showtip(String a,int widthadjust,int starty)
   {
       int linecount = 0;
       int i = 0;
       linecount = a.length()/29+1;
       for(i=0;i<linecount-1;i++){
           fill(162,145,80);
           rect(sig.screenwidth-widthadjust,starty+30*i,widthadjust,3);
           fill(0,0,0);
           text(a.substring(29*i,29*(i+1)),sig.screenwidth-widthadjust,starty+30*i-2);
       }
       fill(162,145,80);
       rect(sig.screenwidth-widthadjust,starty+30*i,widthadjust,3);
       fill(0,0,0);
       text(a.substring(29*i,a.length()),sig.screenwidth-widthadjust,starty+30*i-2);
   }
  
  
}
