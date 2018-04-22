import java.awt.FileDialog; 
import java.awt.Frame;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;


ArrayList<String> bookcontent;
ArrayList<String> booknamelist;
ArrayList<String> bookposlist;
boolean opened = false;
int booklistindex = 0;

class happyReader
{

PImage a;
PImage bookmark;
PImage ascroll;
PImage bookmarkscroll;
PImage []load = new PImage[136];
PImage currentbackground;
int loc;
int lastmouse = 0;
int currentpic = 1;
String picname;
boolean change = false;
int movepixel = 0;
boolean showmark = false;
int loadfilenum = 0;
boolean enterpicmode = true;
boolean entertextmode = false;
int viewadjust = 0;
int []pos = new int[6];
int colorchoice = 0;

boolean whetheradd = false;

// the standard configuration
int sys_scroll = 0;
String vector = "0";

boolean inpower()
{
   boolean forreturn = false;
     if(sig.scrolldecide>(width*4/5+3*width)&&sig.scrolldecide<(width*4/5+4*width)){
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
    if(!this.whetheradd){
      
       for(int i=1;i<136;i++)
       {
        picname = "y"+i+".jpg";
        load[i] = loadImage(picname); 
       }
       a = loadImage("note.jpg");
       bookmark = loadImage("smallicon.jpg");
       currentbackground = load[currentpic];
       ascroll = loadImage("notescroll.jpg");
       bookmarkscroll = loadImage("smalliconscroll.jpg");
       booknamelist = new ArrayList<String>();
       bookposlist = new ArrayList<String>();
       // initial work for this reader
       booknamelist.add("Welcome");
       bookposlist.add("Welcome");
       booknamelist.add("Introduction");
       bookposlist.add("Introduction");
       for(int weizhi = 0;weizhi<6;weizhi++){
       pos[weizhi] = 150*weizhi-300;
       }
       mouseWheelSetup2();
       whetheradd = true;
    }
           // initial drawing 

       image(ascroll,0+sys_scroll,height/8);   
       image(bookmarkscroll,0+sys_scroll,450);
       image(bookmarkscroll,150+sys_scroll,450);
   
}

void handle_in_draw()
{
    this.sys_scroll = sig.sys_scroll;
    background(currentbackground);
    cameraone.sys_scroll = this.sys_scroll+width;
    cameraone.handle_in_setup();
    bookmarket.sys_scroll = this.sys_scroll-width;
    bookmarket.handle_in_setup();  

  // nackground changing ad altering
  if(change){
   currentbackground = load[currentpic];
   change = false;  
  }
    
   if(opened){
   // 进行文字信息的显示  
   enterpicmode = false;
   entertextmode = true;
   opened = false;
   showmark = true;
   }     
   // picmode  area
   if(enterpicmode){
    showimage(a,currentbackground,0+sys_scroll,height/8);   
    for(int mark = 0;mark<6;mark++){
         showimage(bookmark,currentbackground,pos[mark]+movepixel+sys_scroll,450);
       }
    fill(0,0,0);   
    if(booknamelist.get(booklistindex).length()<6){
    text(booknamelist.get(booklistindex),40+sys_scroll,480);
    }else{
    text(booknamelist.get(booklistindex).substring(0,5)+"...",40+sys_scroll,480);
    }
    if(booknamelist.get(booklistindex).length()<6){
    text(booknamelist.get(booklistindex+1),190+sys_scroll,480);
    }else{
    text(booknamelist.get(booklistindex+1).substring(0,5)+"...",190+sys_scroll,480);
    }  
   }
   // textmode  area
   if(entertextmode){
       showtext(bookcontent,colorchoice);
   }
   


if(sig.m_mousepressed)
{
  if(mouseX>68&&mouseY>113&&mouseX<224&&mouseY<271&&enterpicmode){
    // 打开文件,纸上为打开文件热区
     new FileOpen();
  }
    // the icon open file fuunction
  // the first loadin
  if(mouseX>47&&mouseY>500&&mouseX<101&&mouseY<539){
    if(booklistindex==0){
    bookcontent = new ArrayList<String>();
    bookcontent.add("你好，这是由卷心菜编写的-悦读者-9号，请放心使用，已通过"
    +"Talkerjz4 system soft center 进入批准，非商业用途，如果能够对阁下的工作"
    +"或是生活有一些帮助，请告诉我们，卷心菜祝您天天好心情！");
    opened = true;
    }else{
     if(booklistindex==1){
     bookcontent = new ArrayList<String>();
    bookcontent.add("您好！此软件专用于阅读.txt文档，点击最大的笔记本图标"
    +"就可以选阁下电脑中的任意一个txt文档并进入阅读页面。"
    +"当然，按下Backspace（退格）键就可以回到起始页面"
    +"在下面我们提供了下拉条，按住鼠标拖动就可以华东书目栏"
    +"当看到您喜欢的图书的时候，只需点击相应小图标的正中就可以打开文件"
    +"在阅读时，请安静.....哈哈，这个看场合啦。通过键盘上的方向键可以"
    +"任意变换字体颜色及背景，最后，卷心菜祝您使用愉快！");
    opened = true;
     }
     else{ 
     openicon(bookposlist.get(booklistindex));
     opened = true;
     }  
  }
  }
  // the second loadin
  if(mouseX>201&&mouseY>500&&mouseX<251&&mouseY<539){
    if(booklistindex==0){
    bookcontent = new ArrayList<String>();
    bookcontent.add("您好！此软件专用于阅读.txt文档，点击最大的笔记本图标"
    +"就可以选阁下电脑中的任意一个txt文档并进入阅读页面。"
    +"当然，按下Backspace（退格）键就可以回到起始页面"
    +"在下面我们提供了下拉条，按住鼠标拖动就可以华东书目栏"
    +"当看到您喜欢的图书的时候，只需点击相应小图标的正中就可以打开文件"
    +"在阅读时，请安静.....哈哈，这个看场合啦。通过键盘上的方向键可以"
    +"任意变换字体颜色及背景，最后，卷心菜祝您使用愉快！");
    opened = true;
    }else{
    openicon(bookposlist.get(booklistindex+1));
    opened = true;
    }
  }
  
  lastmouse = mouseX;
  sig.m_mousepressed = false;
}


 if(sig.m_keypressed)
{
  if(keyCode==39){
    currentpic++;
    if(currentpic==136){
    currentpic=1;
    }
  }
  
  // choose the color
  if(keyCode==37){
    currentpic--;
    if(currentpic==0){
    currentpic = 135;
    }
  }
  
  if(keyCode==38){
    colorchoice++;
    if(colorchoice==5){
    colorchoice = 0;
    }
  }
  
  if(keyCode==40){
     colorchoice--;
    if(colorchoice==-1){
    colorchoice = 4;
    }
  }
  // altering between the picmode and the textmode
  if(key=='\b'){
    if(enterpicmode){
    enterpicmode = false;
    entertextmode = true;
    }
    else{
    enterpicmode = true;
    entertextmode = false;
    }
  }
  change = true;
  sig.m_keypressed = false;
}

 if(sig.m_mousedragged)
{
  if(mouseY>363&&mouseY<438){
      if(booklistindex<booknamelist.size()-2&&(mouseX-lastmouse)>-151&&(mouseX-lastmouse)<0){
      movepixel = mouseX-lastmouse;
      }
      if(booklistindex>0&&(mouseX-lastmouse)<151&&(mouseX-lastmouse)>0){
      movepixel = mouseX-lastmouse;
      }
      else{
      }
     // sig.sys_scroll = sig.screenwidth*4;
     sig.applock = true;
  }
  else{
    sig.applock = false;
  }
  sig.m_mousedragged = false;
}

  if(sig.m_mousereleased)
{
  if(movepixel>90&&booklistindex>0){
    movepixel = 150;
    booklistindex--;
  }
  else{   
      if(movepixel<-90&&booklistindex<booknamelist.size()-2){
        movepixel = -150;
        booklistindex++;
      }
      else{
      movepixel = 0;
      }
  }
  sig.m_mousereleased = false;
}


}

// 特效显示图标
void showimage(PImage a,PImage backimage,int anchorx,int anchory)
{
      int loc;
      image(a,anchorx,anchory);
      for(int i=0;i<a.width;i++)
          for(int j=0;j<a.height;j++)
            {
              loc = i+j*a.width;
              if((int)red(a.pixels[loc])+(int)red(a.pixels[loc])
              +(int)red(a.pixels[loc])==255*3){
                if((i+anchorx)>0&&(i+anchorx)<backimage.width&&(j+anchory)>0&&(j+anchory)<backimage.height){
                set(i+anchorx,j+anchory,color(backimage.pixels[i+anchorx+(j+anchory)*backimage.width]));
                }
              }
            }
}

void showtext(ArrayList<String> a,int colorcode)
{
   // show the text
   String xianshi = a.toString();
   
       int linecount = 0;
       int i = 0;
       int widthadjust = 22;
       int leftadjust = 15;
       
     //  fill(162,145,80);
     //  rect(0,0,width,height);
       
       linecount = xianshi.length()/widthadjust+1;
       for(i=0;i<linecount-1;i++){
           if(colorcode == 0){
           fill(0,0,0);
           }
           if(colorcode == 1){
           fill(255,255,255);
           }
           if(colorcode == 2){
           fill(129,115,211);
           }
           if(colorcode == 3){
           fill(120,120,120);
           }
           if(colorcode == 4){
           fill(215,240,63);
           }           
           text(xianshi.substring(widthadjust*i,widthadjust*(i+1)),leftadjust,30*(i+1)-2+viewadjust);
       }
       if(colorcode == 0){
       fill(0,0,0);
       }
       if(colorcode == 1){
       fill(255,255,255);
       }
       if(colorcode == 2){
       fill(129,115,211);
       }
       if(colorcode == 3){
       fill(120,120,120);
       }
       if(colorcode == 4){
       fill(215,240,63);
       }  
       text(xianshi.substring(widthadjust*i,xianshi.length()),leftadjust,30*(i+1)-2+viewadjust);
   
}

  // function when icon clicked
   void openicon(String filepos)
   {
        String readincontent = "";
        bookcontent = new ArrayList<String>();
           try{
              URL url = new URL("file:///"+filepos);         
              InputStreamReader isr = new InputStreamReader(url.openStream(),"gbk");
              BufferedReader br = new BufferedReader(isr); 
              while((readincontent = br.readLine())!=null){
                    bookcontent.add(readincontent);   
              }
            }    
           catch (IOException e){
      	   e.printStackTrace();    
           }        
     
   }



  void mouseWheelSetup2()
{
    addMouseWheelListener( // the rest of of this is acutally the argument list for the function call
            new java.awt.event.MouseWheelListener() 
            {
                 public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) 
                 {
                    viewadjust -= 9*evt.getWheelRotation();
                 }
            }
   ) // this is the end of the argument list
   ;    // this single semicolon is the entire, complete function body
}   



}


class FileOpen
{
  FileDialog fileopen;
  String fileopenloc;
  String filename;
  
    FileOpen()
  {
   fileopen = new FileDialog(new Frame(),"打开文件对话框",FileDialog.LOAD);   
   fileopen.addWindowListener(new WindowAdapter()
   {
     public void windowClosing(WindowEvent e)
     {
       fileopen.setVisible(false);
     }
   });
   open();
  }
    public void open()
  {
    fileopen.setVisible(true);
    fileopenloc = fileopen.getDirectory();
    filename = fileopen.getFile();
    String []passage = loadStrings(fileopenloc+filename);
    bookcontent = new ArrayList<String>();
    String readincontent = "";
    if(filename!=null&&filename.contains(".txt")){
      
          try{
          URL url = new URL("file:///"+fileopenloc+filename);         
          InputStreamReader isr = new InputStreamReader(url.openStream(),"gbk");
          BufferedReader br = new BufferedReader(isr); 
          while((readincontent = br.readLine())!=null){
                bookcontent.add(readincontent);   
          }
          opened = true;  
          booknamelist.add(filename);
          bookposlist.add(fileopenloc+filename);
          booklistindex = booknamelist.size()-2; 
        }    
           catch (IOException e){
      	   e.printStackTrace();    
           }  
    }
    else{
    }
    
  } 

}
