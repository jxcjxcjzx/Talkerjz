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
}
