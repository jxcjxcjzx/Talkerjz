class Rect
{
  int x, y, w, h;
  Rect(int nx, int ny, int nw, int nh)
  { x=nx; y=ny; w=nw; h=nh; }
  
  Rect(Rect r)
  { x=r.x; y=r.y; w=r.w; h=r.h; }
  
  void grow(int v)
  { x-=v; y-=v; w+=2*v; h+=2*v; }
}

boolean overRect(int x, int y, int width, int height) 
{
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) 
    return true;
  else
    return false;
}

boolean overRect(Rect r) 
{ return overRect(r.x, r.y, r.w, r.h); }

void rect(Rect r)
{ rect(r.x, r.y, r.w, r.h); }

void rect(PGraphics pg, Rect r)
{ pg.rect(r.x, r.y, r.w, r.h); }

void text(String t, Rect r)
{ text(t, r.x, r.y, r.w, r.h); } 

void text(PGraphics pg, String t, Rect r)
{ pg.text(t, r.x, r.y, r.w, r.h); } 

