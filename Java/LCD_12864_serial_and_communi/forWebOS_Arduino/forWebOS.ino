// used variables
int back_posi_pin = 7; 
int back_nega_pin = 6;
int vcc_pin = 13;
int not_serial_pin = A1;
int light_control_pin = A0;
// the data pins
int data_pin_2 = 2;
int data_pin_3 = 8;
int data_pin_1 = 3;
int data_pin_0 = 12;
int data_pin_4 = 11;
int data_pin_5 = 10;
int data_pin_6 = 9;
int data_pin_7 = 5;
int reset_pin = 4;

int lightness = 200;
// these are the control pins
int rw_pin = A2;
int e_pin = A3;
int rs_pin = A4;
// this array set the data situation

int data_array[] = {1,0,0,1,0,1,0,0};
int cmd_array[] =  {0,0,1,1,0,0,0,0};

// the initial arrays
int funcset[] = {0,0,0,0,1,1,0,0};
int funcset2[] = {0,0,0,0,1,1,0,0};
int display_clear[] = {1,0,0,0,0,0,0,0};
int entry_mode_set[] = {1,1,1,0,0,0,0,0};  // not sure 
// the usual used commands


int extend_func_on[] = {0,0,1,0,1,1,0,0};
int extend_func_off[] = {0,0,0,0,1,1,0,0};
int paint_on[] = {0,1,1,0,1,1,0,0};
int paint_off[] = {0,0,1,0,1,1,0,0};

int open_show[]= {1,1,1,1,0,0,0,0};

// commands to control show


int add_addr[] = {0,1,1,0,0,0,0,0};

int temp[] = {0,0,0,0,0,0,0,0};

// extra variables for test:
int zicount = 0;



void setup()
{
 
  // first set the output and inout pin in mode
    pinMode(back_posi_pin,OUTPUT);   
    pinMode(vcc_pin,OUTPUT);       
    pinMode(back_nega_pin,OUTPUT); 
    pinMode(light_control_pin,OUTPUT); 
    
    pinMode(data_pin_0,OUTPUT);   
    pinMode(data_pin_1,OUTPUT); 
    pinMode(data_pin_2,OUTPUT); 
    pinMode(data_pin_3,OUTPUT); 
    pinMode(data_pin_4,OUTPUT); 
    pinMode(data_pin_5,OUTPUT); 
    pinMode(data_pin_6,OUTPUT); 
    pinMode(data_pin_7,OUTPUT);   
    
    pinMode(not_serial_pin,OUTPUT);
    
    pinMode(rw_pin,OUTPUT);  
    pinMode(rs_pin,OUTPUT);    
    pinMode(e_pin,OUTPUT);      
    pinMode(reset_pin,OUTPUT);      
    
    
    digitalWrite(vcc_pin,HIGH);
    digitalWrite(back_posi_pin,HIGH);
    digitalWrite(back_nega_pin,LOW);
    analogWrite(not_serial_pin,255); // set the mode to parallel
    digitalWrite(data_pin_2,HIGH);
    analogWrite(light_control_pin,lightness);
    

    

    // initial work
    delay(1000);
    digitalWrite(reset_pin,LOW);
    digitalWrite(reset_pin,HIGH);   // reset the system 
  
/*
     write_cmd_adapt(0x34);
     clean_screen();
     
     for(int i=10;i<20;i++)
        for(int j=10;j<20;j++)
          {
             super_draw_point(j,i);
             delay(1);
          }
     

    write_cmd_adapt(0x36);
    write_cmd_adapt(0x30);    
    
    Serial.begin(9600);
    */
}

void loop()
{
  // just a test
      //  clean_screen();
        if(Serial.available()){
          int shuzi = Serial.read();
          write_cmd_adapt(0x34);
          clean_screen();          
          super_draw_point(shuzi/100,shuzi%100);
          write_cmd_adapt(0x36);
          write_cmd_adapt(0x30);           
        }
     // delay(100); 
}

/*
void draw_point(int x,int y)  // this is the main function we draw
{
      write_cmd_adapt(0x80+y);
      write_cmd_adapt(0x80+x);     
      
      write_data_adapt(0x80); 
      write_data_adapt(0x80);           
}
*/

void super_draw_point(unsigned char x,unsigned char y)
{
   unsigned char x_byte,x_bit;
   unsigned char y_byte,y_bit;
   unsigned tmph,tmpl;
   x&=0x7f;
   y&=0x3f;
   x_byte = x/16;
   x_bit = x&0x0f;
   y_byte = y/32;
   y_bit = y&0x3f;
   write_cmd_adapt(0x34);
   write_cmd_adapt(0x34);
   write_cmd_adapt(0x80+y_bit);
   write_cmd_adapt(0x80+x_byte+8*y_byte); 
   read_data();
   tmph = read_data();
   tmpl = read_data();
   write_cmd_adapt(0x80+y_bit);  
   write_cmd_adapt(0x80+x_byte+8*y_byte);  
   if(x_bit<8){
     write_data_adapt(tmph|(0x01<<(7-x_bit)));
     write_data_adapt(tmpl);     
   }  
   else{
     write_data_adapt(tmph);      
     write_data_adapt(tmpl|(0x01<<(15-x_bit)));      
   }
    write_cmd_adapt(0x36);
    write_cmd_adapt(0x30);   
  //  write_data_adapt(tmpl|(0x01<<(15-x_bit)));    
}


void checkbusy()
{

}

void clean_screen()
{
  settemp(0,0,1,0,1,1,0,0);
  write_cmd(temp);
    for(int i=0;i<32;i++){
      write_cmd_adapt(0x80+i);
      write_cmd_adapt(0x80);   
      
      for(int j=0;j<16;j++){
        write_data_adapt(0x00);
      }
      
    }
   
    
   for(int i=0;i<32;i++){
      write_cmd_adapt(0x80+i);
      write_cmd_adapt(0x88);     
      
      for(int j=0;j<16;j++){
      write_data_adapt(0x00);  
      }
      
    }  
}

void write_data_adapt(unsigned char b){
   int adapt[] = {bitRead(b,0),bitRead(b,1),bitRead(b,2),bitRead(b,3),
   bitRead(b,4),bitRead(b,5),bitRead(b,6),bitRead(b,7)};
   write_data(adapt);
}

void write_cmd_adapt(unsigned char b){
   int adapt[] = {bitRead(b,0),bitRead(b,1),bitRead(b,2),bitRead(b,3),
   bitRead(b,4),bitRead(b,5),bitRead(b,6),bitRead(b,7)};
   write_cmd(adapt);
}


void write_data(int b[])
{
  //delay(2);
  delayMicroseconds(500);  
  set_e();
  set_rs();
  clear_rw();
  set_data(b);
  set_e();
  clear_e();
}


unsigned char read_data()
{
    unsigned char Rdata;
    pinMode(data_pin_0,INPUT);   
    pinMode(data_pin_1,INPUT); 
    pinMode(data_pin_2,INPUT); 
    pinMode(data_pin_3,INPUT); 
    pinMode(data_pin_4,INPUT); 
    pinMode(data_pin_5,INPUT); 
    pinMode(data_pin_6,INPUT); 
    pinMode(data_pin_7,INPUT);    
    set_rs();
    set_rw();
    clear_e();
    set_e();
    delayMicroseconds(500);  
    Rdata = digitalRead(data_pin_0)+digitalRead(data_pin_0)*2+digitalRead(data_pin_0)*4
    +digitalRead(data_pin_0)*8+digitalRead(data_pin_0)*16+digitalRead(data_pin_0)*32
    +digitalRead(data_pin_0)*64+digitalRead(data_pin_0)*128;
    clear_e();
    return Rdata;
}

void write_cmd(int a[])
{
  //delay(2);
  delayMicroseconds(500);
  set_e();
  clear_rs();
  clear_rw();
  set_data(a);
  set_e();
  clear_e();
}

void settemp(int a,int b,int c,int d,int e,int f,int g,int h)
{
  temp[0] = a;
  temp[1] = b;
  temp[2] = c;
  temp[3] = d;  
  temp[4] = e;
  temp[5] = f;
  temp[6] = g;
  temp[7] = h;
  
}

void set_data(int data_array[])
{
    pinMode(data_pin_0,OUTPUT);   
    pinMode(data_pin_1,OUTPUT); 
    pinMode(data_pin_2,OUTPUT); 
    pinMode(data_pin_3,OUTPUT); 
    pinMode(data_pin_4,OUTPUT); 
    pinMode(data_pin_5,OUTPUT); 
    pinMode(data_pin_6,OUTPUT); 
    pinMode(data_pin_7,OUTPUT);  
    
   if(data_array[0]==1){
   digitalWrite(data_pin_0,HIGH);
   }
   else{
   digitalWrite(data_pin_0,LOW);   
   }
   
   if(data_array[1]==1){
   digitalWrite(data_pin_1,HIGH);
   }
   else{
   digitalWrite(data_pin_1,LOW);   
   }

   if(data_array[2]==1){
   digitalWrite(data_pin_2,HIGH);
   }
   else{
   digitalWrite(data_pin_2,LOW);   
   }

   if(data_array[3]==1){
   digitalWrite(data_pin_3,HIGH);
   }
   else{
   digitalWrite(data_pin_3,LOW);   
   }

   if(data_array[4]==1){
   digitalWrite(data_pin_4,HIGH);
   }
   else{
   digitalWrite(data_pin_4,LOW);   
   }

   if(data_array[5]==1){
   digitalWrite(data_pin_5,HIGH);
   }
   else{
   digitalWrite(data_pin_5,LOW);   
   }

   if(data_array[6]==1){
   digitalWrite(data_pin_6,HIGH);
   }
   else{
   digitalWrite(data_pin_6,LOW);   
   }

   if(data_array[7]==1){
   digitalWrite(data_pin_7,HIGH);
   }
   else{
   digitalWrite(data_pin_7,LOW);   
   }

}

// functions to control the control signals
void set_rw()
{
   analogWrite(rw_pin,255);
}

void clear_rw()
{
   analogWrite(rw_pin,0);
}

void set_rs()
{
   analogWrite(rs_pin,255);
}

void clear_rs()
{
   analogWrite(rs_pin,0);
}

void set_e()
{
   analogWrite(e_pin,255);
}

void clear_e()
{
   analogWrite(e_pin,0);
}




//drawing modle:
/*
void loop()
{
  // analogWrite(light_control_pin,lightness);
  // just a test
        write_cmd(extend_func_on);
      //  clean_screen();
        draw_point(10,10);
        if(Serial.available()){
          int shuzi = Serial.read();
          draw_point(shuzi%10,shuzi%20);
        }
        write_cmd(paint_on);

delay(100);
}
*/


