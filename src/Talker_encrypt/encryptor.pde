//  本类为主要的加密类，提供的功能主要是
// 加密和解密，具体形式如下：
//  public void getKey(String strKey)   在构造函数中调用
//  public void encrypt(String file, String destFile) throws Exception   加密函数
//   public void decrypt(String file, String dest) throws Exception     解密函数

class encryptor
{
  // 首先是预先定义的变量及数组， 首先写成的C++代码，然后改写为java代码
    int []encrypt_key = new int[64];
   
    int [][]SubKey = new int[17][48];  //  得到的用于加密的密钥

    int [][]encrypt_C = new int[17][28]; // 用于中途产生前半部分密钥
    int [][]encrypt_D = new int[17][28]; // 用于中途产生后半部分密钥 
    
    int [][]data_C = new int[17][32]; // 用于存放中间数据的数组
    int [][]data_D = new int[17][32];  // 后半部分
    
    int []data_altered = new int[64];
    int []for_S_alter = new int[32];  // 用于存放S盒变换产生的结果
    int []alter_to_P = new int[32];   // 用于转换S盒的结果，采用P置换
    int []result_of_not_or = new int[48];
    int []for_choose = new int[48];    // 选择运算的结果
    
    int []final_check = new int[64];
    
    int []not_in_use = {8,16,24,32,40,48,56,64}; //密钥中用于奇偶校验的位

// 一些程序中需要使用到的数组，固定不变
      int []P =
      {
          16, 7, 20, 21,
          29, 12, 28, 17,
          1, 15, 23, 26,
          5, 18, 31, 10,
          2, 8, 24, 14,
          32, 27, 3, 9,
          19, 13, 30, 6,
          22, 11, 4, 25
      };  // P置换矩阵
      
     int []change_table_1_L = {
        57,49,41,33,25,17,9,
      
        1,58,50,42,34,26,18,
      
        10,2,59,51,43,35,27,
      
        19,11,3,60,52,44,36
      
      };//置换IP矩阵,产生C0
       int []change_table_1_R = {
        63,55,47,39,31,23,15,
      
        7,62,54,46,38,30,22,
      
        14,6,61,53,45,37,29,
      
        21,13,5,28,20,12,4
      
      };//置换IP矩阵,产生D0
      
     int []left_shift_count = {
        1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1
      };  // 循环左移的位数
      
     int []change_table_2 = {
          14,17,11,24,1,5,
      
          3,28,15,6,21,10,
      
          23,19,12,4,26,8,
          
          16,7,27,20,13,2,
      
          41,52,31,37,47,55,
      
          30,40,51,45,33,48,
      
          44,49,39,56,34,53,
      
          46,42,50,36,29,32
      };  // 置换矩阵2
      
      int []data_change_table = {
          58,50,42,34,26,18,10,2,
      
          60,52,44,36,28,20,12,4,
      
          62,54,46,38,30,22,14,6,
      
          64,56,48,40,32,24,16,8,
      
          57,49,41,33,25,17,9,1,
      
          59,51,43,35,27,19,11,3,
      
          61,53,45,37,29,21,13,5,
      
          63,55,47,39,31,23,15,7
      };  //  输入数据的初始的置换矩阵
      
      int []choose_table = {
          32,1,2,3,4,5,
      
          4,5,6,7,8,9,
      
          8,9,10,11,12,13,
      
          12,13,14,15,16,17,
      
          16,17,18,19,20,21,
      
          20,21,22,23,24,25,
      
          24,25,26,27,28,29,
      
          28,29,30,31,32,1
      };
      
       int []RIP =
      {
          40, 8, 48, 16, 56, 24, 64, 32,
          39, 7, 47, 15, 55, 23, 63, 31,
          38, 6, 46, 14, 54, 22, 62, 30,
          37, 5, 45, 13, 53, 21, 61, 29,
          36, 4, 44, 12, 52, 20, 60, 28,
          35, 3, 43, 11, 51, 19, 59, 27,
          34, 2, 42, 10, 50, 18, 58, 26,
          33, 1, 41, 9, 49, 17, 57, 25,
      };  // 逆置换IP      
    
       int [][][]S = 
      {
          //S[1]
         { {14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7},
          {0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8},
          {4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0},
          {15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13}   },
       
          //S[2]
         { {15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10},
          {3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5},
          {0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15},
          {13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9}   },
           
          //S[3]
         { {10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8},
          {13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1},
          {13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7},
          {1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12}   },
          
          //S[4]
         { {7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15},
          {13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9},
          {10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4},
          {3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14}   },
          
          //S[5]
         { {2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9},
          {14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6},
          {4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14},
          {11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3}   },
          
          //S[6]
         { {12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11},
          {10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8},
          {9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6},
          {4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13}   },
           
          //S[7]
         { {4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1},
          {13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6},
          {1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2},
          {6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12}   },
           
          //S[8]
         { {13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7},
          {1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2},
          {7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8},
          {2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11}  }
      };  // S盒置换函数
      

      
      
      void initial()  // 初始化函数
      {
        int i,j;
        for(i=0;i<17;i++)
          for(j=0;j<48;j++)
          {
            SubKey[i][j] = 0;
          }
        for(i=0;i<17;i++)
          for(j=0;j<28;j++)
          {
            encrypt_C[i][j] = 0;
          }
        for(i=0;i<17;i++)
          for(j=0;j<28;j++)
          {
            encrypt_D[i][j] = 0;
          }
        for(i=0;i<17;i++)
          for(j=0;j<32;j++)
          {
            data_C[i][j] = 0;
          }
        for(i=0;i<17;i++)
          for(j=0;j<32;j++)
          {
            data_D[i][j] = 0;
          }
      
        for(j=0;j<64;j++)
          {
            data_altered[j] = 0;
          }
        for(j=0;j<32;j++)
          {
            for_S_alter[j] = 0;
          }
        for(j=0;j<48;j++)
          {
            result_of_not_or[j] = 0;
          }
        for(j=0;j<48;j++)
          {
            for_choose[j] = 0;
          }
        for(j=0;j<64;j++)
          {
            final_check[j] = 0;
          }
      }

  public boolean getkey(String miyao)
  {
    boolean forreturn = false;
    // miyao 及为加密的密钥
    // 判断密钥的位数，在DES中，密钥的位数需要是64位，当然字母的形式只需要8位，如果不足
    // 则采用系统的默认的密钥handsome并提示用户，这里不建议使用补全的方式扩充密钥，在网上也没有找到这种做法
    if(8!=miyao.length()){
      forreturn = true;
      miyao = "handsome";  
    }
      int []tmp = new int[8];
      byte []trans = miyao.getBytes();
      for(int i=0;i<8;i++)
      {
        tmp[i] = trans[i];  
      }
      for(int w=0,j=0;w<8;w++){  
          for (int k = 7; k >= 0; k--,j++)
            {
                encrypt_key[j] = (tmp[w] >> k) & 1;
            }
      } 

    return forreturn;
  }

  
  
        void LR(int in[], int out[], int ls)//  循环左移位函数
      {
          int i;
          for (i = 0; i < ls; i++)
              out[28 - ls + i] = in[i];
          for (i = ls; i < 28; i++)
              out[i-ls] = in[i];
      }





      void CreateSubKey_clockwise(int key[])  // 这个是加密过程中使用的,key数组shi 64位的
      {
      
        // 实验中产生的密钥安放在SbuKey数组中
        //定义的临时数组用于求和，组合两边的密钥
        int []for_sum = new int[56];
        int i,j;
        int count = 0;
      
        for(i=0;i<28;i++)
        {
           encrypt_C[0][i] = key[change_table_1_L[i]-1];
        }
        
        for(i=0;i<28;i++)
        {
           encrypt_D[0][i] = key[change_table_1_R[i]-1];
        }
        // 这样产生了需要的初始的c0和d0
       
      
        for(count=0;count<16;count++)
        {
            LR(encrypt_C[count],encrypt_C[count+1],left_shift_count[count]);
            LR(encrypt_D[count],encrypt_D[count+1],left_shift_count[count]);
            // 组合两边的密钥
            for(j=0;j<28;j++)
            {
              for_sum[j] = encrypt_C[count+1][j];
            }
            for(j=28;j<56;j++)
            {
              for_sum[j] = encrypt_D[count+1][j-28];
            }
            // 产生密钥
            for(j=0;j<48;j++)
            {
              SubKey[count][j] = for_sum[change_table_2[j]-1];
            }
        }
       // testing point      
      }
      
      
      
      void AlterDataIn(int pre_data[], int after_data[])  // 产生初始的数据
      {
         // 这个函数对输入的数据进行变换，根据的是置换IP
         int i=0;
         for(i=0;i<64;i++)
         {
           after_data[i] = pre_data[data_change_table[i]-1];
         }
      }
      
      void choose_calculate(int data_in[])  // 选择运算函数,产生的结果在指定的for_choose数组中
      {
          int i=0;
        for(i=0;i<48;i++)
        {
          for_choose[i] = data_in[choose_table[i]-1];
        }
      
        //testing point
      
      }
      
      void oparate_not_or(int in_1[], int in_2[])  // 异或运算(48位), 结果在result_of_not_or 中
      {
          int i;
        for(i=0;i<48;i++)
        {
          result_of_not_or[i] = in_1[i]^in_2[i];
        }
      
        // testing point  
      
      
      }
      
      void encrypt_function(int data_in_1[])   // 关键加密函数部分
      {
        // 这个函数开始是参照别人的，搞得很蛋疼，在这里出错了。。。。
          // 入口的两个参数均为48位的
          int i,x,y,z;
          int data_in_pointer = 0;
        for(i=0;i<8;i++)
        {
      
          x = (data_in_1[0+data_in_pointer]<<1) + (data_in_1[5+data_in_pointer]);
          y = (data_in_1[1+data_in_pointer]<<3) + (data_in_1[2+data_in_pointer]<<2)
          + (data_in_1[3+data_in_pointer]<<1) + (data_in_1[4+data_in_pointer]);
          z = S[i][x][y];  
      
          for_S_alter[0+4*i] = (z >> 3) & 1;
            for_S_alter[1+4*i] = (z >> 2) & 1;
            for_S_alter[2+4*i] = (z >> 1) & 1;
            for_S_alter[3+4*i] = z & 1;
          data_in_pointer += 6;
          
        }
      
          for(i=0;i<32;i++)
        {
          alter_to_P[i] = for_S_alter[P[i]-1];
        }
      
      
      
      }
      
      void build_encrypt()   // 逆置换IP得到最终的加密的结果
      {
         // 这里直接处理前面得到的for_S_alter
          int i,j;
        for(i=0;i<32;i++)
        {
          data_C[0][i] = data_altered[i];
            data_D[0][i] = data_altered[i+32];
        } 
      
      
          for(j=0;j<16;j++)   // 16轮的加密过程
        {
            for(i=0;i<32;i++)
            {
              data_C[j+1][i] = data_D[j][i];
            }
            choose_calculate(data_D[j]);
              oparate_not_or(for_choose,SubKey[j]);
              encrypt_function(result_of_not_or);
            for(i=0;i<32;i++)
            {
              data_D[j+1][i] = data_C[j][i]^alter_to_P[i];
            }
      
        }
      
        // 第十六轮有一些特殊
                 for(i=0;i<32;i++)
            {
              data_D[16][i] = data_D[15][i];
            }
            choose_calculate(data_D[15]);
              oparate_not_or(for_choose,SubKey[15]);
              encrypt_function(result_of_not_or);
            for(i=0;i<32;i++)
            {
              data_C[16][i] = data_C[15][i]^alter_to_P[i];
            }
      
        // 最终得到的结果为L16, 和R16
        // 经过最后的逆置换Ip
        
          int []combine_last = new int[64];
        for(i=0;i<32;i++)
        {
          combine_last[i] = data_C[16][i];
          combine_last[i+32] = data_D[16][i];
        }
        for(j=0;j<64;j++)
        {
           final_check[j] = combine_last[RIP[j]-1]; 
        }
        
      }
      
      
      void build_decrypt()   // 逆置换IP得到最终的解密的结果
      {
         // 这里直接处理前面得到的for_S_alter
          int i,j;
        for(i=0;i<32;i++)
        {
          data_C[0][i] = data_altered[i];
            data_D[0][i] = data_altered[i+32];
        } 
      
          for(j=0;j<15;j++)   // 16轮的解密过程
        {
            for(i=0;i<32;i++)
            {
              data_C[j+1][i] = data_D[j][i];
            }
               choose_calculate(data_D[j]);
             oparate_not_or(for_choose,SubKey[15-j]);
               encrypt_function(result_of_not_or);
            for(i=0;i<32;i++)
            {
              data_D[j+1][i] = data_C[j][i]^alter_to_P[i];
            }
        }
        // 最终得到的结果为L16, 和R16
        // 经过最后的逆置换Ip
      
          // 第十六轮有一些特殊
                 for(i=0;i<32;i++)
            {
              data_D[16][i] = data_D[15][i];
            }
            choose_calculate(data_D[15]);
              oparate_not_or(for_choose,SubKey[0]);
              encrypt_function(result_of_not_or);
            for(i=0;i<32;i++)
            {
              data_C[16][i] = data_C[15][i]^alter_to_P[i];
            }
        
          int []combine_last = new int[64];
        for(i=0;i<32;i++)
        {
          combine_last[i] = data_C[16][i];
          combine_last[i+32] = data_D[16][i];
        }
        for(j=0;j<64;j++)
        {
           final_check[j] = combine_last[RIP[j]-1]; 
        }
        
      }
      
      void engine_two(int content_in[], int key_in[])  // 解密的函数
      {
         // 64位密文输入
          AlterDataIn(content_in,data_altered);
          CreateSubKey_clockwise(key_in);  
        build_decrypt();  // 最终的输出结果在final_check数组中，去那里看看吧！
      
      }
      
      void engine_one(int content_in[], int key_in[])   // content 是64位的,输出也是64位的,加密的函数
      {
          // 64位明文输入
          AlterDataIn(content_in,data_altered);
          CreateSubKey_clockwise(key_in);  
          build_encrypt();  // 最终的输出结果在final_check数组中，去那里看看吧！
      }
      
      //  一个转换函数， 二进制转换为字符串
      public String byte_to_hex(byte[] b)
      {
        String hs = "";
        String stmp = "";
        for(int n=0;n<b.length;n++)
        {
          stmp = (java.lang.Integer.toHexString(b[n]&0xFF));
            if(stmp.length()==1)
              hs = hs + "0" + stmp;
            else
              hs = hs + stmp;
         }
         return hs;
      }

      public void encrypt(ArrayList<Integer> input,String destFile) throws Exception 
      {
            BufferedWriter   out=new   BufferedWriter(  new   FileWriter(new File(destFile) ,true));       
            int []data_loadin = new int[64];
            int count = 0;
            String xieru = "";// 用于写入
            int loopcount = 0;
            
            loopcount = input.size()/64;             
                               
             for(int i=0;i<loopcount-1;i++){
                    for(int j=0;j<64;j++)
                    {
                       data_loadin[j] = input.get(j+i*64);
                    }
                    engine_one(data_loadin,encrypt_key);
                    // 每一小次加密后写入
                    for(count=0;count<64;count++)
                    {
                      xieru += String.valueOf(final_check[count]);
                    }                                         
                    out.write(xieru);   
                    xieru = "";
             }
            out.close();

      }

      public void for_decrypt()
      {
        
      }

      public void decrypt(ArrayList<Integer> in_put, String destFile) throws Exception
      {
            BufferedWriter   out=new   BufferedWriter(  new   FileWriter(new File(destFile) ,true)); 
            byte[] b_for_one = new byte[1];   
            byte[] b_for_two = new byte[2];               
            String ming = "";
            for(int i=0;i<in_put.size()-1;i++){
                if(in_put.get(i)>0){
                  b_for_one[0] = in_put.get(i).byteValue();
                  ming = new String(b_for_one,"gbk"); 
                  out.write(ming); 
                }
                if(in_put.get(i)<0){
                  b_for_two[0] = in_put.get(i).byteValue();
                  b_for_two[1] = in_put.get(i+1).byteValue();
                  ming = new String(b_for_two,"gbk"); 
                  out.write(ming); 
                  i++;
                }

            }            
            out.close();            
      }
      
      
      
      ArrayList<Integer> Get_for_decrypt(String file)
      {
            String strUrl = "file:///"+file;
            String desString = "";
            ArrayList<Integer> forreturn = new ArrayList<Integer>();
            String temp = "";
            try{
                URL url = new URL(strUrl);        
                String str = "";            
                InputStreamReader isr = new InputStreamReader(url.openStream());
                BufferedReader br = new BufferedReader(isr); 
                StringBuilder built = new StringBuilder();
                while ((str = br.readLine() )!= null) {   
                  built.append(str);
                }    
                desString = built.toString();
                isr.close();
                br.close();
            }    
            catch (IOException e){            
              // error out here 
            } 
            int count = desString.length()/8;
            for(int i=0;i<count;i++){
               if(desString.substring(i*8,(i+1)*8).charAt(0)=='1'){
                 temp = "";
                 for(int j=0;j<8;j++){
                     if(desString.substring(i*8,(i+1)*8).charAt(j)=='1'){
                       temp += "0";
                     }
                     if(desString.substring(i*8,(i+1)*8).charAt(j)=='0'){
                       temp += "1";
                     }                                      
                 }
                 forreturn.add(Integer.parseInt(temp, 2)*(-1)-1);
               }
               else{
                 forreturn.add(Integer.parseInt(desString.substring(i*8,(i+1)*8), 2));
               }
            }
            return forreturn;      
      }
      
      ArrayList<Integer> Get_Input_Bytes(String file)
      {
        ArrayList<Integer> forreturn = new ArrayList<Integer>();
        ArrayList<String> temp = new ArrayList<String>();
        String strUrl = "file:///"+file;
        String desString = "";
        try{
            URL url = new URL(strUrl);        
            String str = "";            
            InputStreamReader isr = new InputStreamReader(url.openStream(),"gbk");
            BufferedReader br = new BufferedReader(isr); 
            StringBuilder built = new StringBuilder();
            while ((str = br.readLine() )!= null) {   
              built.append(str);
            }
            built.append("您好，欢迎阁下使用本软件，本软件是在talkerjz软件中心中免费发布，由Mr jxc开发的，希望能给您带来帮助！");
            desString = built.toString();
            byte[] store = desString.getBytes("gbk");  
            for(int i=0;i<store.length;i++){
              for(int j=0;j<8;j++){
                temp.add(String.valueOf(this.Judge_Byte(Integer.toBinaryString(store[i])).charAt(j)));
              }
            }         
            isr.close();
            br.close();
        }
        catch (IOException e){            
          // error out here 
        } 
        // here we can add some back handling 
        forreturn = this.Str2Inte(temp);
        return forreturn;
      }
      
      ArrayList<Integer> Str2Inte(ArrayList<String> forexch)
      {
         ArrayList<Integer> forreturn = new ArrayList<Integer>();
         for(int i=0;i<forexch.size();i++)
         {
           forreturn.add(Integer.parseInt(String.valueOf(forexch.get(i))));
         }
         return forreturn;
      }
      
      String Judge_Byte(String in_content)
      {
        StringBuilder returnit = new StringBuilder();
        int count = in_content.length();
        String[] forjudge = new String[count];
        String[] forreturn = new String[8];
        for(int i=0;i<count;i++){
          forjudge[i] = String.valueOf(in_content.charAt(i));
        }
        if(6==count){
           forreturn[0] = "0";
           forreturn[1] = "0";
           for(int i=0;i<6;i++)
           {
              forreturn[i+2] = forjudge[i];
           }
        }
        if(7==count){
           forreturn[0] = "0";
           for(int i=0;i<7;i++)
           {
              forreturn[i+1] = forjudge[i];
           }           
        }        
        if(count>7){
            forreturn[0] = "1";
              for(int i=0;i<7;i++)
              {
                forreturn[i+1] = forjudge[count-1-(6-i)];
              }
        }
        for(int i=0;i<8;i++){
           returnit.append(String.valueOf(forreturn[i]));
        }
        return returnit.toString();
      }


}
