class Passin{

String usrname = "";
String passwd = "";
String passshow = "";
int rectwidth = 0;
int rectheight = 0;
int height2 = 0;
int height3 = 0;
boolean usrnamein = false;
PImage a;
PImage b;
PImage c;
boolean login = false;
boolean alter = false;
String []date = {"","","","",""};
String []weather = {"","","","",""};
String []temp = {"","","","",""};
String []wind = {"","","","",""};
boolean whetherconnected = true;


// this is for tip-help system
String tipcontent[] = {"Your   name,  please","  passwrd, I  will not  keep  it  for  you","Hello, I'm  talkerjz4,       welcome!"};
int []tiplocx = {56,200,55,200,100,202};
int []tiplocy = {103,133,205,232,311,412};
int widthadjustvalue = 0;


void handle_in_setup()
{
  rectwidth = width-width/5;
  rectheight = height/15;
  height2 = width/6+rectheight+width/30;
  height3 = width/6+rectheight+width/10;
  a = loadImage("talkerjz.jpg");
  b = loadImage("ie1.jpg");
  c = loadImage("ie2.jpg");
  getweather();
  //clear for tip system
  this.widthadjustvalue = 0;
}

void handle_in_draw()
{
  if(login&&!alter){
              background(204,184,102);
              fill(0,0,0);
              if(whetherconnected){
              text("南京天气：",50,20);
              }
              // show the weather information
              for(int j=0;j<5;j++){
                text(this.date[j],30,50+j*80);
                text(this.weather[j],30,70+j*80);
                text(this.temp[j],30,90+j*80);
                text(this.wind[j],30,110+j*80);
              }
              
              text("loading   for   you  .......",50,550);
              alter = true;
              if(whetherconnected){
                image(b,200,500);
              }
              if(!whetherconnected){
                image(c,200,500);
              }
  }
  if(!login&&!alter){
   background(204,184,102);
   fill(255,255,255);
   rect(width/6,height/6,rectwidth,rectheight);
   rect(width/6,height/6+height2,rectwidth,rectheight);
   fill(0,0,0);
   text("Please input you name: ",width/10,height/10);
   text("Please input you passwd: ",width/10,height/10+height3);
               if(sig.m_keypressed){
                   if (key>='a'&&key<='z'||key>='A'&&key<='Z'||key>='0'&&key<='9') {
                     if(!usrnamein){ 
                     usrname+=key;
                     }
                     else if(usrnamein){
                         passwd+=key;
                         passshow+="x";
                     }
                    }
                   if(key=='\n'){
                     if(!usrnamein){
                         usrnamein = true;
                     }
                     else  {
                     if(usrname.equals("jxc")&&passwd.equals("talkerjz")){
                       login = true;
                     }
                           else{
                             usrname="";
                             passwd= "";
                             passshow = "";
                             usrnamein = false;
                            }
                     }
                   } 
               sig.m_keypressed = false;
               }
   image(a,width/2-a.width/2,height/2);
   fill(0,0,0);
   text(usrname,width/5,height/5);
   text(passshow,width/5,height/5+height2);
   
   
   // this part will deal with the weather getting   
  }
  
  
          // this is for tip-help system
        for(int tipi=0;tipi<this.tipcontent.length;tipi++){
          if(mouseX>tiplocx[tipi*2]&&mouseX<tiplocx[tipi*2+1]&&mouseY>tiplocy[tipi*2]&&mouseY<tiplocy[tipi*2+1]){      
          systemfunc.showtip(this.tipcontent[tipi],this.widthadjustvalue,500);
          }
        }
        this.widthadjustvalue++;
        if(this.widthadjustvalue>150){
          this.widthadjustvalue = 151;
        }  
  
  
 }


void getweather()
{
   String readin = null;
		try { 
			String strUrl = "http://qq.ip138.com/weather/jiangsu/NanJing.htm";     
			URL url = new URL(strUrl);  
			InputStreamReader isr = new InputStreamReader(url.openStream(),"gbk");
			InputStreamReader isr2 = new InputStreamReader(url.openStream(),"gbk");
			   BufferedReader store = new BufferedReader(isr);
			   BufferedReader store2 = new BufferedReader(isr2);
			   String kaishi = "江苏南京地区今天和未来几天天气趋势预报";
               String col1 = "日";
               String col2= "天气";
               String col3 = "气温";
               String col4 = "风向";
               boolean zhai = false;
			   jiexi rol1 = new jiexi(col1);
			   int i =0;
			   
			     while((readin=store.readLine())!=null){

					 if(readin.contains(kaishi)){
					   zhai = true;
					 }
					 if(zhai){
						 
				     if(readin.contains(col1)){					 
							for(i=0;i<5;i++){
							     date[i] = rol1.replacetags(store.readLine());
							}
					     }
					 }
				}
				 while((readin=store2.readLine())!=null){

					 if(readin.contains(kaishi)){
					   zhai = true;
					 }
					 if(zhai){
						 
					 if(readin.contains(col2)){
						   for(i=0;i<5;i++){
						     weather[i] = rol1.replacetags(store2.readLine());
						   }
						 }
					 
					 if(readin.contains(col3)){
						   for(i=0;i<5;i++){
						     temp[i] = rol1.replacetags(store2.readLine());
						   }
						 }
					 
					 if(readin.contains(col4)){
						   for(i=0;i<5;i++){
						     wind[i] = rol1.replacetags(store2.readLine());
						   }
						 }	 
					 
				   }
					 else{
					 }
					 
				 }
				 store2.close();
		         store.close();

	        }
					 catch (IOException e) {           
	             whetherconnected = false;  
	      }    
  }

}

