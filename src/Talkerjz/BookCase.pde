
class BookCase{

BookCaseManager readhelper = new BookCaseManager();
ChineseIn zhong = new ChineseIn();
boolean InputChinese = false;
boolean handlein = false;
String show = "";
String showback = "";
int startingx = 60;
int startingy = 100;
int internelx = 30;
int heighty = 90;
int intercut = 4;
boolean curtain = false;
int curtainy = 0;
String fileaddr = "C:/Users/Administrator/Desktop/talkerjz5/bookcase.xml";
String showstore = "";

// needed variables
int sys_scroll = 0;
String vector = "0";
boolean whetheradd = false;
int test = 0;

boolean inpower()
{
   boolean forreturn = false;
     if(sig.scrolldecide>(width*4/5+4*width)&&sig.scrolldecide<(width*4/5+5*width)){
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
    // draw the bookcase
    drawcase();
    if(!this.whetheradd){
      try{
      readhelper.loadXML(fileaddr);      
      }
      catch(Exception e){      
      }
      // provide the choice if not successfully loaded the file
      if(readhelper.getState().contains("无法载入")){
         fileaddr = new FileOpen2().getresult();
      }
    whetheradd = true;
    }
}

void handle_in_draw()
{
    background(0,154,80);
    this.sys_scroll = sig.sys_scroll;
  //  readbooks.sys_scroll = this.sys_scroll+width;
 //   readbooks.handle_in_setup();
    
    // the choice between the ChineseIn and the EnglishIn 
    if(!InputChinese){
     text("英",270,30);
   }
   if(InputChinese){
     text("中",270,30);
     // the input box
      zhong.paint();
   }
 
   drawcase();
   
   if(curtain){
     curtainy++;
     fill(192,133,0);     
     rect(50,startingy+heighty,200,curtainy);
     if(curtainy>120){
       curtainy = 122;
       splitshow(showstore);
     }
   }
   
   if(!curtain){
     curtainy--;
     if(curtainy<2){
       curtainy = 0;
     }
     fill(192,133,0);     
     rect(50,startingy+heighty,200,curtainy);
   }
   
    // import the xml manager here
   if(handlein){
     bardown();
     handlein = false;
   }

   fill(0,0,0);
   text("$: "+show,50+this.sys_scroll,560);  



 if(sig.m_mousepressed)
{
  if(mouseX<290&&mouseX>260&&mouseY<40&&mouseY>10){
    InputChinese = (InputChinese == false)?true:false;    
  }  
  else{
    barup();
    show = "";  
  }
  sig.m_mousepressed = false;
}

 if(sig.m_keypressed)
{  
  if(!InputChinese){  
        if(key ==' '||(key >= 'a'&&key<= 'z')||(key>='A'&&key<='Z')||(key>='0'&&key<='9')){
          show+=key;
        }
        if(key =='\n'){   
             handlein = true;   
             showstore = handleintext(show);
        }     
        if(key== '\b'){
          if(show.length()-1>=0){
          showback = show.substring(0,show.length()-1);
          show = showback; 
          }
        }   
  }

 if(InputChinese){
        if(key =='\n'){  
              handlein = true; 
              showstore = handleintext(show);
          }
        if(key== '\b'){
          if(show.length()-1>=0){
          showback = show.substring(0,show.length()-1);
          show = showback; 
          }
        }
        else{
          if(zhong.jiexi().equals("success")){
          show+=zhong.getvalue();
         }
        }
  }
      sig.m_keypressed = false;     
}


}

void bardown()
{
   curtain = true;
}

void barup()
{
  if(curtain){
   curtain = false;
  }  
}

void drawcase()
{
    fill(129,89,0);
    rect(30+this.sys_scroll,startingy+heighty,240,5);
    fill(243,113,113);
    rect(startingx+this.sys_scroll,startingy,internelx-intercut,heighty);
    fill(101,188,217);
    rect(startingx+internelx+this.sys_scroll,startingy,internelx-intercut,heighty);
    fill(243,243,113);
    rect(startingx+internelx*2+this.sys_scroll,startingy,internelx-intercut,heighty);
    fill(101,217,101);
    rect(startingx+internelx*3+this.sys_scroll,startingy,internelx-intercut,heighty);
    fill(255,229,153);
    rect(startingx+internelx*4+this.sys_scroll,startingy,internelx-intercut,heighty);
    fill(255,51,195);
    rect(startingx+internelx*5+this.sys_scroll,startingy,internelx-intercut,heighty);
    
    fill(47,91,237);
    text("System  shells:",100+this.sys_scroll,350);
    text("ls : 查看已有文件",100+this.sys_scroll,350+20);
    text("del : 删除制定文件",100+this.sys_scroll,350+20*2);
    text("add : 增加记录",100+this.sys_scroll,350+20*3);
    text("update : 更新记录",100+this.sys_scroll,350+20*4);
}

String handleintext(String order)
{
  String forreturn = "";
  String []splitit = order.split(" ");
  if(splitit[0].equals("ls")&&splitit.length==2){
    String temp = readhelper.lookForOneNode(splitit[1],fileaddr);
    forreturn = readhelper.handlestate+" "+"名称是："+splitit[1]+" "+"进度是："+temp;
  }
  if(splitit[0].equals("del")&&splitit.length==2){
    readhelper.deleteOneNode(splitit[1],fileaddr);
    forreturn = readhelper.handlestate+" "+"名称是："+splitit[1]+" "+"Good_bye_this_cruel_world";
  }
  if(splitit[0].equals("add")&&splitit.length==3){
    readhelper.addOneNode(splitit[1],splitit[2],fileaddr);
    forreturn = readhelper.handlestate+" "+"名称是："+splitit[1]+" "+"进度是："+splitit[2];
  }
  if(splitit[0].equals("update")&&splitit.length==3){
    readhelper.updateOneNode(splitit[1],splitit[2],fileaddr);
    forreturn = readhelper.handlestate+" "+"名称是："+splitit[1]+" "+"进度是："+splitit[2];
  }  
  return forreturn;
}

void splitshow(String a){
  String []b = a.split(" ");
  if(b.length==3){
   fill(0,0,0);
   text(b[0],80+this.sys_scroll,220);
   text(b[1],80+this.sys_scroll,260);
   text(b[2],80+this.sys_scroll,300);
  }
}





}





// classes used

// This is a open interface built for the easy access
// to the XML files.
// The XML files can be viewed as a database for datas
// The function are listed as follows:
//1.Document loadXML(String fileaddr)   :  to load an XML  file
//2. void addOnenode(String name,String process,String fileaddr)   :  to add a record
//3.void deleteOneNode(String name,String fileaddr)   : to delete one record
//4.String lookForOneNode(String name,String fileaddr)   :  to find a set record
//5. void updateOnenode(String name,String process,String fileaddr)    :  to update a record
//6.  void saveXML(Document doc,String fileaddr)  :  to save a XML file , this one is usually not used
// in addition, we provide perfect support for Chiniese in, thank you!
// And for you to keep in mind 
// follows are the provided example set for our bookstore
/*
<?xml version="1.0" encoding="UTF-8" standalone="no"?><bookcase>
  <book>
    <name>李华</name>
    <process>14</process>
  </book>
  <book>
    <name>张三</name>
    <process>16</process>
  </book>
</bookcase>
*/

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;
 
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
 
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;


class BookCaseManager
{   
  String handlestate = "success";
  
  String getState(){
    return this.handlestate;
  }
  
  void setState(String a){
    
    this.handlestate = a;
  }
  
  Document loadXML(String fileaddr) throws Exception{   
     Document document = null;
     try{
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();
      document = builder.parse(new File(fileaddr));
     }catch(Exception e){
       this.setState("对不起，无法载入相应的文件");
     }    
    return document;

  }
  
  void addOneNode(String name,String process,String fileaddr)
  {
    try{
      Document document = this.loadXML(fileaddr);
      NodeList nodeList = document.getElementsByTagName("bookcase");
      Node bookNode = document.createElement("book");
      Node nameNode = document.createElement("name");
      nameNode.appendChild(document.createTextNode(name));
      Node processNode = document.createElement("process");
      processNode.appendChild(document.createTextNode(process));      
      bookNode.appendChild(nameNode);
      bookNode.appendChild(processNode);
      nodeList.item(0).appendChild(bookNode);
      this.saveXML(document,fileaddr);
       // tip area
       this.setState("已成功增加一条记录！");
    }
    catch(Exception e){
       this.setState("增加记录失败.....");
     
    } 

  }
  
  
  void deleteOneNode(String name,String fileaddr)
  {
    try{
       Document document = this.loadXML(fileaddr);        
       NodeList nodeList = document.getElementsByTagName("book");
       for(int i=0;i<nodeList.getLength();i++){
        String value = nodeList.item(i).getFirstChild().getTextContent();
        if(name!=null && name.equalsIgnoreCase(value)){
         Node parentNode = nodeList.item(i).getParentNode();
         //nodeList.item(i).removeChild(parentNode);
         nodeList.item(i).getParentNode().removeChild(nodeList.item(i));
         this.setState("已成功删除一条记录！");    
         break;
        }
       }
       this.saveXML(document,fileaddr);
    }
      catch(Exception e){
      e.printStackTrace();
         this.setState("删除记录失败.....");          
    } 
    
  }
  
  String lookForOneNode(String name,String fileaddr){
     String forreturn = "";
     boolean biaoji = false;
        try{
               Document document = this.loadXML(fileaddr);
               NodeList nodeList = document.getElementsByTagName("book");
               for(int i=0;i<nodeList.getLength();i++){
                String value = nodeList.item(i).getFirstChild().getTextContent();
                if(name!=null && name.equalsIgnoreCase(value)){
                 forreturn = nodeList.item(i).getLastChild().getTextContent();
                 biaoji = true;
                 break;
                }
               }
                if(!biaoji){
                this.setState("未找到记录，不好意思....");    
                }
                if(biaoji){
                this.setState("已成功找到一条记录！");   
                }
        }
        catch(Exception e){
          this.setState("查找记录失败.....");    
       }
     return forreturn;
  }
  
  void updateOneNode(String name,String process,String fileaddr)
  {
        boolean biaoji = false;
        try{
               Document document = this.loadXML(fileaddr);
               NodeList nodeList = document.getElementsByTagName("book");
               for(int i=0;i<nodeList.getLength();i++){
                String value = nodeList.item(i).getFirstChild().getTextContent();
                if(name!=null && name.equalsIgnoreCase(value)){
                 nodeList.item(i).getLastChild().setTextContent(process);
                 biaoji = true;
                 this.setState("已成功更新一条记录！");   
                 break;
                }
               }
                if(biaoji){
                this.saveXML(document,fileaddr);
                }
                else{
                this.setState("未找到记录，不好意思....");   
                }
        }
        catch(Exception e){
        this.setState("更新记录失败.......");   
       }
   
  }
  
  void saveXML(Document doc,String fileaddr) throws Exception
  {
       try{
          TransformerFactory tf = TransformerFactory.newInstance();
          Transformer tfer = tf.newTransformer();
          DOMSource dsource = new DOMSource(doc);
          StreamResult sr = new StreamResult(new File(fileaddr));
          tfer.transform(dsource, sr);
         }catch(Exception e){
          e.printStackTrace();
         }
   
  }

}







// typicle use of this class are coded as follows
// if(zhong.jiexi().equals("success")){
//          show+=zhong.getvalue();
//         }

class ChineseIn{

String Ch_chaxun = "";
int Ch_printindex = 0;
int Ch_choosecount = 0;
int Ch_returnvalue = 0;
boolean Ch_printit = false;
boolean Ch_xianshi = false;
boolean Ch_pageback = false;
boolean Ch_pageforward = false;
String []Ch_currentword = new String[6];
ArrayList<String> Ch_jieguo = new ArrayList();
ArrayList<String> Ch_zifuchuan = new ArrayList();
boolean Ch_chushi = false;
String Ch_returnvalue2 = "";

void paint()
{
   fill(222,197,197); 
   rect(10,440,width-10,70);  
   showindex();
}

String getvalue()
{
  return this.Ch_returnvalue2;  
}

String jiexi()
{
   String forreturn = "";
   readChar();
   if(!Ch_chushi){
     int returnvalue = loadmaterial();
     Ch_chushi = true;
   } 
   if(Ch_chaxun!=""&&Ch_xianshi&&Ch_returnvalue==0){
       handle(Ch_chaxun);                    
   }
   else{
       Ch_xianshi = false;
   }
         // get the choosing result
       if(Ch_printit){
          // giving out the result
           Ch_returnvalue2 = forreturn = Ch_currentword[Ch_printindex-1];
           Ch_printit = false;
       } 
   if(forreturn!=""){
     forreturn = "success";
   } 
   else{
     forreturn = "failure";
   }
   return forreturn;
}

void handle(String chaxun)
{
                String []fenge = new String[2];
                for(int i=0;i<Ch_zifuchuan.size();i++)
                 {
                       fenge = Ch_zifuchuan.get(i).split(",");
                       if(fenge[1].startsWith(chaxun)&&fenge[0].length()==1){
                         Ch_jieguo.add(fenge[0]);
                       }
                       else{
                             if(fenge[1].startsWith(chaxun)&&fenge[0].length()>1){
                                Ch_jieguo.add(fenge[0].substring(0,fenge[0].length()-1));
                             } 
                             else{
                             }
                       }
                  }
}


int loadmaterial()
{
       try{
            String readincontent = "";
            URL url = new URL("file:///C:/Users/Administrator/Desktop/talkerjz5/ziku3.txt");         
            InputStreamReader isr = new InputStreamReader(url.openStream(),"gbk");
            BufferedReader br = new BufferedReader(isr); 
            while((readincontent = br.readLine())!=null){
             Ch_zifuchuan.add(readincontent);
            }
            return 0;
     }
     catch (IOException e){
           return -1;
     }  
}

void readChar()
{
  if((key>='a'&&key<='z')||(key>='A'&&key<='Z'))
  {
    Ch_chaxun+=key;
    Ch_jieguo.clear();
    Ch_xianshi = true;
  }
  if(keyCode==39){
  Ch_pageforward = true;
  Ch_choosecount++;
  }
  if(keyCode==37&&Ch_choosecount>0){
  Ch_pageback = true;
  Ch_choosecount--;
  }
  if(key=='\b'&&Ch_chaxun.length()>0){
  Ch_chaxun = Ch_chaxun.substring(0,Ch_chaxun.length()-1);
  Ch_jieguo.clear();
  Ch_xianshi = true;
  }
  if(key=='\n')
  {
    Ch_chaxun="";
    Ch_jieguo.clear();
    Ch_choosecount = 0;
  }
  if(key>='1'&&key<='6'){
    Ch_printit = true;
    Ch_printindex = key-'0';
    Ch_chaxun="";
    Ch_jieguo.clear();
    Ch_choosecount = 0;
  }
  if(keyCode==32){
    Ch_printindex = 1;
    Ch_printit = true;
    Ch_chaxun="";
    Ch_jieguo.clear();
    Ch_choosecount = 0;
  }
}


void showindex()
{
  int roundcount = 0;
  fill(0,0,0);  
  if(!Ch_jieguo.isEmpty()){
      roundcount = Ch_jieguo.size()/6-1;
      text(Ch_chaxun,20,460);
      if(Ch_jieguo.size()>6){
        // the choosing bar for user
        // providing the function of choosing Chinese words
        if(Ch_choosecount<=roundcount){
                for(int choose1=0+6*Ch_choosecount;choose1<3+6*Ch_choosecount;choose1++){
                  text(choose1-6*Ch_choosecount+1+".",20+80*(choose1-6*Ch_choosecount)-9+30,485);
                  text(Ch_jieguo.get(choose1),20+80*(choose1-6*Ch_choosecount)+30,485);
                  Ch_currentword[choose1-6*Ch_choosecount] = Ch_jieguo.get(choose1);
                }
                for(int choose2=3+6*Ch_choosecount;choose2<6+6*Ch_choosecount;choose2++){
                  text(choose2-6*Ch_choosecount+1+".",20+80*(choose2-3-6*Ch_choosecount)-9+30,500);
                  text(Ch_jieguo.get(choose2),20+80*(choose2-3-6*Ch_choosecount)+30,500);
                  Ch_currentword[choose2-6*Ch_choosecount] = Ch_jieguo.get(choose2);
                }
                
                
        }
        else{
          if(Ch_choosecount==roundcount+1&&Ch_jieguo.size()%6!=0){
              for(int choose3=(roundcount+1)*6;choose3<Ch_jieguo.size();choose3++){
                Ch_currentword[choose3-(roundcount+1)*6] = Ch_jieguo.get(choose3);
              }  
              for(int choose4=Ch_jieguo.size()%6;choose4<6;choose4++){
                Ch_currentword[choose4] = "";
              }
              
                for(int choose5=0;choose5<3;choose5++){
                  text(choose5+1+".",20+80*choose5+30-9,485);
                  text(Ch_currentword[choose5],20+80*choose5+30,485);
                }
                for(int choose6=3;choose6<6;choose6++){
                  text(choose6+1+".",20+80*(choose6-3)+30-9,500);
                  text(Ch_currentword[choose6],20+80*(choose6-3)+30,500);
                }
                
          }
          else{
           Ch_choosecount--;
          }  
        }
      }
      else{
           for(int j=0;j<Ch_jieguo.size();j++){
            text(j+1+".",20+40*j+30-9,500);
            text(Ch_jieguo.get(j),20+40*j+30,500);
            Ch_currentword[j] = Ch_jieguo.get(j);
           }
      }
  }
  else{
  Ch_chaxun="";
  }
  
}



}




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
    if(filename!=null&&filename.contains(".xml")){
      forreturn = fileopenloc+filename;
    }
    return forreturn;
  }

}


