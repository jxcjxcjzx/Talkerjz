int buttonx = 50;
int buttonwidth = 200;
int buttony = 120;
int buttonheight = 50;
boolean passin = false;
String password = "";
String passwordback = "";
FileOpen2 openit = new FileOpen2();
String showpass = "";
int buttony2 = buttony+200;
boolean jiami = true;
int button2x = 100;
int button2y = 40;
int button2width = 100;
int button2height = 40;
String choice = "加密";
boolean defaultkey = false;
PImage a;

void setup()
{
  size(300,600);
  smooth();
  a = loadImage("11.jpg");
}

void draw()
{
  background(0,255,0);
  fill(255,255,255);
  rect(0,height-30,width,30);
  if(mouseX<buttonx+buttonwidth&&mouseX>buttonx
  &&mouseY<buttony+buttonheight&&mouseY>buttony){    
    defaultkey = false;
    fill(0,0,0);
    text("加密,请在下面框中输入密码并回车然后点击选择文件",10,height-10);
  }
  if(mouseX<button2x+button2width&&mouseX>button2x
  &&mouseY<button2y+button2height&&mouseY>button2y){  
    defaultkey = false;
    fill(0,0,0);
    text("点击下面的按钮可以改变加（解）密方式",50,height-10);
  }
  if(defaultkey)
  {
    fill(0,0,0);
    text("您的输入的密钥位数不合格（应该为8位），采用默认密钥handsome",50,height-10);    
  }
  fill(123,240,231);
  rect(buttonx,buttony,buttonwidth,buttonheight);
  fill(255,255,255);
  rect(buttonx+buttonwidth/4,buttony+buttonheight/4,buttonwidth/2,buttonheight/2);
  fill(0,0,0);
  text(showpass,buttonx+buttonwidth/3,buttony+buttonheight/2);
  fill(123,240,231);
  rect(button2x,button2y,button2width,button2height);
  fill(0,0,0);
  text(choice,button2x+button2width/3,button2y+button2height-button2height/2);
  image(a,width/2-a.width/2,190);
  
}

void mousePressed()
{
  if(mouseX<buttonx+buttonwidth&&mouseX>buttonx
  &&mouseY<buttony+buttonheight&&mouseY>buttony&&passin){    
    String fileaddr = openit.getresult(); 
    if(fileaddr == ""){
       showpass = "请再试一次吧";
       password = "";
       passin = false;
    }
    else{
        String fileaddr2 = openit.fileopenloc;
        String fileaddr3 = openit.filename.substring(0,openit.filename.length()-4);
        if(fileaddr.contains(".txt")&&passin){
          if(jiami){
              try{
              encryptor td = new encryptor();
              defaultkey = td.getkey(password);         
              td.encrypt(td.Get_Input_Bytes(fileaddr),fileaddr2+fileaddr3+"_"+"encrypt.txt");
              showpass = "加密成功";
              }
              catch (Exception e){
            	e.printStackTrace();
               showpass = "加密失败";
              }
              password = "";
              passin = false;
          }
          else{
              try{
              encryptor td = new encryptor();
              td.getkey(password);
              td.decrypt(fileaddr,fileaddr2+fileaddr3+"_"+"decrypt.txt");
              showpass = "解密成功";
              }
              catch (Exception e){
            	e.printStackTrace();
               showpass = "解密失败";
              }
              password = "";
              passin = false;
          }
        }
    }
  }
     if(mouseX<button2x+button2width&&mouseX>button2x
     &&mouseY<button2y+button2height&&mouseY>button2y){
       jiami = (jiami == false)?true:false; 
       choice = (choice == "加密")?"解密":"加密";   
     }
}

void keyPressed()
{
  if(key=='\n'){
   if(!passin){
     passin = true;     
     showpass = "密码输入成功";
   }
  }
   if (key>='a'&&key<='z'||key>='A'&&key<='Z'||key>='0'&&key<='9') {
     if(showpass.contains("成功")||showpass.contains("再试")){
       showpass = "";
     }
     password+=key;
     showpass+="*";
   }
   if (key=='\b') {
              if (password.length()-1>=0) {
                passwordback = password.substring(0, password.length()-1);
                password = passwordback;
                passwordback = showpass.substring(0, showpass.length()-1);
                showpass = passwordback;
              }
      }  
}

import java.awt.event.WindowAdapter;
import java.awt.FileDialog; 
import java.awt.event.WindowEvent;

class FileOpen2
{
  FileDialog fileopen;
  String fileopenloc;
  String filename;
  
    FileOpen2()
  {
   fileopen = new FileDialog(new Frame(),"打开文件对话框",FileDialog.LOAD);   
   fileopen.addWindowListener(new WindowAdapter()
   {
     public void windowClosing(WindowEvent e)
     {
       fileopen.setVisible(false);
     }
   });
  }
  
  String getresult()
  {
    String forreturn = "";
    fileopen.setVisible(true);
    fileopenloc = fileopen.getDirectory();
    filename = fileopen.getFile();
    if(filename!=null&&filename.contains(".txt")){
      forreturn = fileopenloc+filename;
    }
    return forreturn;
  }

}








