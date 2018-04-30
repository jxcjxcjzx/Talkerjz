 // this class manage the pics 
import java.io.*;

 picManager picask = new picManager();
 int comlink = 0;


class MAkePossible
{
        boolean change = false;  // set the require to redownload the pic
        // handle for the drag action
        int excursion_x = 0;  // the drift of x for mouse
        int excursion_y = 0;  // the drift of y for mouse
        int old_mouse_x = 0;
        int old_mouse_y = 0;
        // num to count the nums of finishing downlaoad
        int finishcount = 0;
        PImage b;   // the background image
        boolean loaded = false;
        // control for map inter change
        boolean start_show = false;
        boolean reload = false;  // reload the pics
        String movstate = "notmove";
        // the standard num for counting link nums
        String forshow = "";
       
       
        int sys_scroll = 0;
        String vector = "0";
        boolean whetheradd = false;
        
        
boolean inpower()
{
   boolean forreturn = false;
   if(sig.scrolldecide<-(width*4/5+width*3)&&sig.scrolldecide>-(width*4/5+4*width)){
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
     // the  primier position
     // get all the position
      if(!this.whetheradd){     
        picask.pic_setup();         
    // the main address we use here
       for(int i=0;i<picask.picscale;i++){
         picask.picaddr[i] = "http://maps.google.com/maps/api/staticmap?center="+String.valueOf(picask.lol[i])+","+String.valueOf(picask.lal[i])+"&zoom="+String.valueOf(picask.zoom)+"&size=640x640&sensor=false";
       }    
       for(int count = 0;count<picask.picscale;count++){
              // later you can import the hash way to manage the large mount of pics
              new loadThread(String.valueOf(count),picask.picaddr[count],String.valueOf(new Float(picask.lal[count]).hashCode())+"_"+String.valueOf(new Float(picask.lol[count]).hashCode())).start();            
        }      
     // pre set the pic manager
      for(int i=0;i<picask.picscale;i++){
       picask.addone(picask.lal[i],picask.lol[i]);
     }   
     // load the backfround
      b = loadImage("mapbackpic.jpg");
     // load with multi process
        for(int count = 0;count<picask.picscale;count++){
            if(!picask.existed(picask.lal[count],picask.lol[count])){
              // later you can import the hash way to manage the large mount of pics
              new loadThread(String.valueOf(count),picask.picaddr[count],String.valueOf(new Float(picask.lal[count]).hashCode())+"_"+String.valueOf(new Float(picask.lol[count]).hashCode())).start();
              picask.addone(picask.lal[count],picask.lol[count]);
            }            
        }  
      whetheradd = true;
      comlink = 0;
      }
      
     image(b,0+sys_scroll,0);

}
  
  
void handle_in_draw()
{
            background(b);
          
            lockit.sys_scroll = this.sys_scroll+width;
            lockit.handle_in_setup();
  
            if(start_show){
                // load pic the first time
                if(!loaded){
                  picask.reloadpic();
                  finishcount = 0;
                  loaded = true;
                }
                
              if(reload){                  
                if(movstate.equals("left")){
                  //testing point              
                  while (!picask.finished());
                    picask.reloadpic();
                    excursion_x = 0;   
                }
                if(movstate.equals("right")){
                  while (!picask.finished());
                    picask.reloadpic();
                    excursion_x = 0;              
                }
                if(movstate.equals("up")){
                  while (!picask.finished());
                    picask.reloadpic();
                    excursion_y = 0;  
                }
                if(movstate.equals("down")){
                  while (!picask.finished());
                    picask.reloadpic();
                    excursion_y = 0;     
                }    
                // change the place
                if(movstate.equals("middle")){
                    while (!picask.finished());
                    picask.reloadpic();
                    excursion_y = 0;     
                    excursion_x = 0;     
                }
                reload = false;        
             }
              if(!reload){   
                  picask.showpic(excursion_x+sys_scroll,excursion_y);
              }
            }
          
             if(forshow!=""){
               fill(255,255,255);
               rect(0,height-30,width,30);
               fill(0,0,0);
               text(forshow,width/2-15+sys_scroll,height-15);
             }  
          
          
          if(sig.m_mousepressed)
          {
            if(!start_show){
              start_show = true;
            }
            // the moving - pic function
            if(mouseButton==LEFT){
              old_mouse_x = mouseX;
              old_mouse_y = mouseY;
            }
            sig.m_mousepressed = false;
          }
          
          if(sig.m_mousedragged)
          {
             if(mouseY<30){
               sig.applock = false;
             }
             else{
                     sig.applock = true;
                     if((mouseX-old_mouse_x)>1||(mouseX-old_mouse_x)<-1){
                       excursion_x+=mouseX-old_mouse_x;
                       old_mouse_x = mouseX;
                     } 
                     if((mouseY-old_mouse_y)>1||(mouseY-old_mouse_y)<-1){
                       excursion_y+=mouseY-old_mouse_y;
                       old_mouse_y = mouseY;
                     }      
                     // judge between the reload of image situation
                     if(excursion_x>picask.pic[0].width){
                       // alter the loc
                       picask.lal[0]-=picask.intermi_lal;
                       picask.adapt();
                       picask.getlinknum();    
                       picask.reloadpicaddr();
                       comlink = 0;
                       picask.downpic();
                       // reload pic
                       movstate = "left";
                       reload = true;     
                       // re-handle the mouse pos
                       old_mouse_x+=excursion_x;
                  //     excursion_x = 0;
                     }
                     if(excursion_x<-picask.pic[0].width){
                       // alter the loc
                       picask.lal[0]+=picask.intermi_lal;
                       picask.adapt();
                       picask.getlinknum();    
                       picask.reloadpicaddr();
                       comlink = 0;                       
                       picask.downpic();
                       // reload pic
                       movstate = "right";
                       reload = true;     
                       // re-handle the mouse pos
                       old_mouse_x+=excursion_x; 
                     }   
                     if(excursion_y>picask.pic[0].height){
                       // alter the loc
                       picask.lol[0]+=picask.intermi_lol;
                       picask.adapt();
                       picask.getlinknum();    
                       picask.reloadpicaddr();
                       comlink = 0;                       
                       picask.downpic();
                       // reload pic
                       movstate = "up";
                       reload = true;     
                       // re-handle the mouse pos
                       old_mouse_y+=excursion_y;
                     }  
                     if(excursion_y<-picask.pic[0].height){
                       // alter the loc
                       picask.lol[0]-=picask.intermi_lol;
                       picask.adapt();
                       picask.getlinknum();    
                       picask.reloadpicaddr();
                       comlink = 0;                       
                       picask.downpic();
                       // reload pic
                       movstate = "down";
                       reload = true;     
                       // re-handle the mouse pos
                       old_mouse_y+=excursion_y;
                     }
             }
             sig.m_mousedragged = false;
          }
          
          if(sig.m_keypressed)
          {
            // set a different loc
            if(key>='a'&&key<='z'||key>='A'||key<='Z'){
               forshow+=key;
            }
            if(key=='\n'){
              Testmap t = new Testmap();
              String chaxun = t.getLatlng(forshow);
              String []fenge = chaxun.split(",");
              if(!fenge[2].equals("0")&&!fenge[3].equals("0")){
                 picask.lol[0] = new Float(fenge[2]);
                 picask.lal[0] = new Float(fenge[3]);
                 picask.adapt();
                 picask.getlinknum();    
                 picask.reloadpicaddr();
                 picask.downpic();
                 movstate = "middle";
                 reload = true;     
              }
              forshow = ""; 
            }
            if(key=='\b'){
               if(forshow.length()-1>=0){
                String showback = forshow.substring(0,forshow.length()-2);
                forshow = showback; 
               }
            }
            sig.m_keypressed = false;
          }


}


}



// saved  data format

//float intermi_lal = 0.055;   // the inter distance between two pics in lal scaled 640*640
//float intermi_lol = 0.042;   // the inter distance between two pics in lol scaled 640*640






// classes listed:
interface picmanage
{
  boolean existed(float lal,float lol);
  void addone(float lal,float lol);
}

class picManager implements picmanage
{
  ArrayList<Integer> lalTable = new ArrayList<Integer>();
  ArrayList<Integer> lolTable = new ArrayList<Integer>();
  
  // the initial variables
  int picscale = 9;
  PImage []pic = new PImage[picscale];
  String []picaddr = new String[picscale];
  float []lol = new float[picscale];  // the  longitude
  float []lal = new float[picscale];  // the  latitude
  float intermi_lal = 0.055;   // the inter distance between two pics in lal scaled 640*640
  float intermi_lol = 0.042;   // the inter distance between two pics in lol scaled 640*640
  int zoom = 14;  // the zoom level
//  E:\SOFT HOME2\processing-2.0b3\OSxm_test\Talkerjz\data
  // the folder for the file addr
  String fileaddr = "E:/SOFT HOME2/processing-2.0b3/OSxm_test/Talkerjz/data/";
  int linknum = 0;
  
  // pre-get the download link count
  void getlinknum()
  {
       this.linknum = 0;
       for(int count = 0;count<picask.picscale;count++){
            if(!picask.existed(picask.lal[count],picask.lol[count])){
              // later you can import the hash way to manage the large mount of pics
              this.linknum++;
            }            
        }
  }

  void pic_setup()
  {
      this.lol[0] = 40.714728;
      this.lal[0] = -73.998672;
      this.adapt(); 
  }
  boolean existed(float lal,float lol)
  {
     boolean forreturn =false;     
     for(int j=0;j<this.lalTable.size();j++){
       if(this.lalTable.get(j)==new Float(lal).hashCode()
       &&this.lolTable.get(j)==new Float(lol).hashCode()){
         forreturn = true;
         break;
       }      
     }
     return forreturn;
  }
  void addone(float lal,float lol)
  {
      this.lalTable.add(new Float(lal).hashCode());
      this.lolTable.add(new Float(lol).hashCode());
  }
  
  void showpic(int pos_x,int pos_y)
  {
       int wei_x = -(pic[0].width/2-width/2)+pos_x+pic[0].width*0;
       int wei_y = -(pic[0].height/2-height/2)+pos_y+pic[0].height*0;
       image(pic[0],wei_x,wei_y);
       image(pic[1],wei_x+pic[0].width*-1,wei_y+pic[0].height*0);
       image(pic[2],wei_x+pic[0].width*1,wei_y+pic[0].height*0);
       image(pic[3],wei_x+pic[0].width*0,wei_y+pic[0].height*-1);
       image(pic[4],wei_x+pic[0].width*0,wei_y+pic[0].height*1);
       image(pic[5],wei_x+pic[0].width*-1,wei_y+pic[0].height*-1);
       image(pic[6],wei_x+pic[0].width*1,wei_y+pic[0].height*-1);
       image(pic[7],wei_x+pic[0].width*-1,wei_y+pic[0].height*1);
       image(pic[8],wei_x+pic[0].width*1,wei_y+pic[0].height*1);     
  }
  // needs rewrite
  void reloadpic(){
       for(int k=0;k<picscale;k++){
          this.pic[k] = loadImage(String.valueOf(new Float(picask.lal[k]).hashCode())+"_"+String.valueOf(new Float(picask.lol[k]).hashCode())+".jpg");
         }    
  }
  
  boolean finished()
  {
     boolean forreturn = false;
     if(comlink==this.linknum){
       forreturn = true;
     }
     return forreturn;
  }
  
  void downpic()
  {
         // load with multi process
       for(int count = 0;count<picask.picscale;count++){
            if(!picask.existed(picask.lal[count],picask.lol[count])){
              // later you can import the hash way to manage the large mount of pics
               new loadThread(String.valueOf(count),picaddr[count],String.valueOf(new Float(picask.lal[count]).hashCode())+"_"+String.valueOf(new Float(picask.lol[count]).hashCode())).start();
               this.addone(picask.lal[count],picask.lol[count]);
            }            
        }

  }
  
  //     new loadThread(String.valueOf(count),picaddr[count],String.valueOf(new Float(picask.lal[count]).hashCode())+"_"+String.valueOf(new Float(picask.lol[count]).hashCode())).start();
  void reloadpicaddr()
  {
      for(int i=0;i<picask.picscale;i++){
       picask.picaddr[i] = "http://maps.google.com/maps/api/staticmap?center="+String.valueOf(picask.lol[i])+","+String.valueOf(picask.lal[i])+"&zoom="+String.valueOf(picask.zoom)+"&size=640x640&sensor=false";
     }
  }
  
  void adapt()
  {
        lol[1] = lol[0];
        lal[1] = lal[0]-intermi_lal;
        lol[2] = lol[0];
        lal[2] = lal[0]+intermi_lal;
        lol[3] = lol[0]+intermi_lol;
        lal[3] = lal[0];
        lol[4] = lol[0]-intermi_lol;
        lal[4] = lal[0];
        lol[5] = lol[3];
        lal[5] = lal[1];
        lol[6] = lol[3];
        lal[6] = lal[2];
        lol[7] = lol[4];
        lal[7] = lal[1];
        lol[8] = lol[4];
        lal[8] = lal[2];  
  }


}




class loadThread extends Thread {
    String webaddr = "";
    String name = "";
    Picdown down = new Picdown(); 

    public loadThread(String threadName,String addr,String filename) {
        super(threadName);
        this.webaddr = addr;
        this.name = filename;
    }
    public void run() {
        downpic();
        comlink++;
    }
    
    void downpic(){
       try {
        this.delFile("E:/SOFT HOME2/processing-2.0b3/OSxm_test/Talkerjz/data",this.name+".jpg");
        this.down.load(webaddr, "E:/SOFT HOME2/processing-2.0b3/OSxm_test/Talkerjz/data/"+this.name+".jpg");
        } catch (Exception e) {
          e.printStackTrace();
        }        
    }
    
    void delFile(String path,String filename) {
       File file=new File(path + "/" + filename);
       if(file.exists() && file.isFile())
       file.delete();
       }
}




class Picdown{
  void load(String addr,String saveaddr){
    try{
        URL url = new URL(addr);
        File outFile = new File(saveaddr);
        OutputStream os = new FileOutputStream(outFile);
        InputStream is = url.openStream();
        byte[] buff = new byte[1024];
        while(true) {
          int readed = is.read(buff);
          if(readed == -1) {
            break;
          }
          byte[] temp = new byte[readed];
          System.arraycopy(buff, 0, temp, 0, readed);
          os.write(temp);
        }
        is.close(); 
        os.close();
    }
    catch (Exception e){
    }
  }
}




import java.io.BufferedReader;

import java.io.IOException;

import java.io.InputStreamReader;

import java.io.UnsupportedEncodingException;

import java.net.HttpURLConnection;

import java.net.MalformedURLException;

import java.net.URL;

import java.net.URLEncoder;

import java.text.MessageFormat;



public class Testmap {

    /**
* 利用googlemap api 通过 HTTP 进行地址解析
* @param address 地址
* @return HTTP状态代码,精确度（请参见精确度常数）,纬度,经度
*/

    private String getLatlng(String address){

       String ret = "";

       if(address != null && !address.equals("")){

        try {

         address = URLEncoder.encode(address,"UTF-8");//进行这一步是为了避免乱码

        } catch (UnsupportedEncodingException e1) {

        }

        //q 是查询的目标地址，output 是响应格式，key 是要使用此 Web 服务的关键字字符串
     //在此响应内，200 是 HTTP 状态代码，表明解析成功；4 是精度常量；41.879535 是经度；-87.624333 是纬度。
   

        String[] arr = new String[4];

        arr[0] = address;

        arr[1] = "csv";

        arr[2] = "true";

        arr[3] = "ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA";

        //http://maps.google.com/maps/geo?q=Chicago&output=cvs&key=ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA

        String url = MessageFormat.format("http://maps.google.com/maps/geo?q={0}&output={1}&sensor={2}&key={3}",arr);

        URL urlmy = null;

        try {

         urlmy = new URL(url);

         HttpURLConnection con = (HttpURLConnection) urlmy.openConnection();

         con.setFollowRedirects (true );

         con.setInstanceFollowRedirects(false );

         con.connect();

         BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));

         String s = "";

         StringBuffer sb = new StringBuffer("");

         while ((s = br.readLine()) != null ) {

          sb.append(s+"\r\n");

         }

         ret = ""+sb;

        } catch (MalformedURLException e) {

        } catch (IOException e) {

        }

       }

       return ret;

    }

}

