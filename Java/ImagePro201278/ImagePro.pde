int sizex = 600;
int sizey = 650;
String imgaddr = "E:/July fly/Image-project/ImagePro/Pictures/forexpand.bmp";

//  action  map for you till now : "greyimg"(得到灰度图),"rimfind"（自己写的边缘寻找算法）,"middlefilter"(中值滤波法),"rot"(图像的腐蚀),"differentialonce"（一阶微分边缘检测）,"differentialtwice"（二阶微分边缘检测）
//  "Prewittrimfind"(Prewitt算子边缘检测),"movavrsmoooth"(移动平均去噪声图像平滑),"expand"(图像的膨胀)

void setup()
{
  size(sizex,sizey);
  MyImage a = new MyImage();
  ImageReader b = new ImageReader();
  b.imageaddr = imgaddr;
  b.readimage();
  a.getimage(b.returnArrayR(),b.returnArrayG(),b.returnArrayB(),b.returnGrey(),b.imagehere);
  Dealer mysmartkid = new Dealer(a.pixelsR,a.pixelsG,a.pixelsB,a.grey,a.imagehere);



    mysmartkid.action("expand",0,0,true);


 /*
  a.show(0,0);
*/
}

