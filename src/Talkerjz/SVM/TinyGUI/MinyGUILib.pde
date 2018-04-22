class MinyGUI
{
  color bg, fg, selectColor;
  boolean drawBackground;
  
  private Rect _area;
  private int _totalH;
  private ArrayList properties;
  private ArrayList frames;
  private MinyWidget locked, focus;
  private VScrollbar scrollbar;
  private boolean _modAlt, _modShift, _modCtrl, _useScrollbar;
  private PGraphics _drawingSurface;
  
  MinyGUI(Rect r)
  {
    _area = r;
    
    _totalH = 0;
    
    locked = null;
    focus = null;
    bg = color(128);
    fg = color(0);
    selectColor = color(96);
    
    drawBackground = true;
    
    properties = new ArrayList();
    frames = new ArrayList();
    
    _modAlt = _modShift = _modCtrl = _useScrollbar = false;
    scrollbar = new VScrollbar(this, new Rect(_area.x+_area.w-15, _area.y, 14, _area.h-1));
  }
  
  MinyGUI(int x, int y, int w, int h) { this(new Rect(x,y,w,h)); }
  
  void setPosition(Rect r) { _area = r; }
  void setPosition(int x, int y, int w, int h) { _area = new Rect(x, y, w, h); }
  
  private void update()
  {
    if(_useScrollbar)
      scrollbar.update();
      
    if(locked != null)
      locked.update();
    
    if(locked == null)
    {
      if(overRect(_area))
      {  
        for(int i=0; i<properties.size(); i++)
          ((Property)properties.get(i)).update();
      }
      
      for(int i=0; i<frames.size(); i++)
        ((MinyFrame)frames.get(i)).update();
    }
  }
  
  void getLock(MinyWidget p)
  {
    if(locked == null)
      locked = p;
  }
  
  boolean hasLock(MinyWidget p) {
    return (locked==p);
  }
  
  boolean isLocked() {
    return locked != null;
  }
  
  void releaseLock(MinyWidget p) 
  {  
    if(locked == p)
      locked = null; 
  }
  
  void changeFocus(MinyWidget p)
  {
    if(focus == p) return;
    if(locked!=null && locked != p) return;
    
    if(focus != null)
      focus.lostFocus();
    focus = p;
    focus.getFocus();
  }
  
  void display()
  {
    update();
    
    noTint();
    imageMode(CORNERS);
    strokeWeight(1);
    
    if(drawBackground)
    {
      noStroke(); fill(bg);
      rect(_area);
    }
    
    _useScrollbar = false;
    _totalH = 0;
    for(int i=0; i<properties.size(); i++)
    {
      Property p = (Property)properties.get(i);
      _totalH += p.getHeight();
    }
    
    if(_totalH > _area.h)
      _useScrollbar = true;
    
    if(_drawingSurface == null || _drawingSurface.width != _area.w || _drawingSurface.height != _area.h)
      _drawingSurface = createGraphics(_area.w, _area.h, JAVA2D);
    _drawingSurface.beginDraw();
    _drawingSurface.background(color(255, 255, 255, 0));
    
    float y = 0;
    int w = _area.w;
    if(_useScrollbar)
    { 
      scrollbar.setPosition(new Rect(_area.x+_area.w-15, _area.y, 14, _area.h-1));
      scrollbar.display(_drawingSurface, 0);
      y = min(0, -(_totalH - _area.h) * scrollbar.pos);
      w -= 15;
    }
    
    for(int i=0; i<properties.size(); i++)
    {
      Property p = (Property)properties.get(i);
      Rect r = p.getRect();
      p.setPosition(_area.x, _area.y+floor(y), w);
      int h = p.getHeight();
      if(y+h > 0 && y<_area.h)
        p.display(_drawingSurface, floor(y));
      y += h;
    }
    
    _drawingSurface.endDraw();
    image(_drawingSurface, _area.x, _area.y);
    
    for(int i=0; i<frames.size(); i++)
      ((MinyFrame)frames.get(i)).display();
  }
  
  void onMousePressed()
  {
    if(mouseButton != LEFT)
      return;
      
    if(locked != null)
    {
      if(overRect(locked.getRect()))
      {
        locked.onMousePressed();
        return;
      }
      else
      {
        locked.lostFocus();
        if(focus == locked) 
          focus = null;
        locked = null;
      }
    }
    
    for(int i=frames.size()-1; i>=0; i--)
    {
      MinyFrame f = (MinyFrame)frames.get(i);
      if(overRect(f.getRect()))
      {
        if(focus != f)
        {
          if(focus != null)
            focus.lostFocus();
          focus = f;
          f.getFocus();
          putFrameOnTop(f);
        }
        f.onMousePressed();
        return;
      }
    }
    
    if(focus != null)
    {
      if(overRect(focus.getRect()))
      {
        focus.onMousePressed();
        return;
      }
      else
      {
        focus.lostFocus(); 
        focus = null;
      }
    }
    
    if(!overRect(_area))
      return;
      
    if(_useScrollbar && overRect(scrollbar.getRect()))
      scrollbar.onMousePressed();
    
    for(int i=0; i<properties.size(); i++)
    {
      Property p = (Property)properties.get(i);
      if(overRect(p.getRect()))
      {
        focus = p;
        p.getFocus();
        p.onMousePressed();
        return;
      }
    }
  }
  
  Rect getRect() { return _area; }
  
  void onKeyPressed()
  {
    if(key == CODED)
    {
      switch(keyCode)
      {
        case ALT:
          _modAlt = true;
          break;
        case SHIFT:
          _modShift = true;
          break;
        case CONTROL:
          _modCtrl = true;
          break;
      }
    }
    
    if(locked != null)
      locked.onKeyPressed();
    else if(focus != null)
      focus.onKeyPressed();
  }
  
  void onKeyReleased()
  {
    if(key == CODED)
    {
      switch(keyCode)
      {
        case ALT:
          _modAlt = false;
          break;
        case SHIFT:
          _modShift = false;
          break;
        case CONTROL:
          _modCtrl = false;
          break;
      }
    }
  }
  
  boolean getModShift() { return _modShift; }
  boolean getModCtrl() { return _modCtrl; }
  boolean getModAlt() { return _modAlt; }
  
  void addProperty(Property p)
  {
    properties.add(p);
    if(_useScrollbar)
      p.setPosition(_area.x, _area.y+_totalH, _area.w-15);
    else
      p.setPosition(_area.x, _area.y+_totalH, _area.w);
    _totalH += p.getHeight();
  }
  
  void addButton(String name, ButtonCallback callback)
  { addProperty(new PropertyButton(this, name, callback)); }
  
  void addDisplay(String name, MinyValue value)
  { addProperty(new PropertyDisplay(this, name, value)); }
  
  void addEditBox(String name, MinyString value)
  { addProperty(new PropertyEditString(this, name, value)); }
  
  void addEditBox(String name, MinyInteger value)
  { addProperty(new PropertyEditInteger(this, name, value)); }
  
  void addEditBox(String name, MinyFloat value)
  { addProperty(new PropertyEditFloat(this, name, value)); }
  
  void addSlider(String name, MinyInteger value, int mini, int maxi)
  { addProperty(new PropertySliderInteger(this, name, value, mini, maxi)); }
  
  void addSlider(String name, MinyFloat value, float mini, float maxi)
  { addProperty(new PropertySliderFloat(this, name, value, mini, maxi)); }
  
  void addCheckBox(String name, MinyBoolean value)
  { addProperty(new PropertyCheckBox(this, name, value)); }
  
  void addList(String name, MinyInteger value, String choices)
  { addProperty(new PropertyList(this, name, value, choices)); }
  
  void addColorChooser(String name, MinyColor value)
  { addProperty(new PropertyColorChooser(this, name, value)); }
  
  void addGraph(String name, InterpolatedFloat value)
  { addProperty(new PropertyGraph(this, name, value)); }
  
  void addGradient(String name, ColorGradient value)
  { addProperty(new PropertyGradient(this, name, value)); }
  
  void addFrame(MinyFrame frame)
  {
    frames.add(frame);
  }
  
  void removeFrame(MinyFrame frame)
  {
    frame.onClose();
    for(int i=0; i<frames.size(); i++)
    {
      if(frames.get(i) == frame)
      {
        frames.remove(i);
        if(focus == frame) focus = null;
        if(locked == frame) locked = null;
        return;
      }
    }
  }
  
  void putFrameOnTop(MinyFrame frame)
  {
    for(int i=0; i<frames.size(); i++)
    {
      if(frames.get(i) == frame)
      {
        frames.remove(i);
        break;
      }
    }
    frames.add(frame);
  }
}

interface ButtonCallback
{
  void onButtonPressed();
}

interface MinyWidget
{
  Rect getRect();
  void update();
  void getFocus();
  void lostFocus();
  void onMousePressed();
  void onKeyPressed();
}

class Property implements MinyWidget
{
  protected MinyGUI _parent;
  String _name;
  protected int _x, _y, _w;
  protected boolean _hasFocus;
  
  Property(MinyGUI parent, String name)
  {
    _parent = parent;
    _name = name;
    _hasFocus = false;
  }
  
  void setPosition(int x, int y, int w)
  {
    _x = x;
    _y = y;
    _w = w;
  }
  
  int getHeight() { return 20; }
  Rect getRect() { return new Rect(_x, _y, _w, getHeight()); }
  
  void update() {}
  void display(PGraphics pg, int y)
  {
    pg.textAlign(LEFT, CENTER);
    pg.fill(_parent.fg);
    pg.text(_name, 5, y, _w * 0.4 - 7, getHeight()); 
  }
  void getFocus() { _hasFocus=true; }
  void lostFocus() { _hasFocus=false; }
  void onMousePressed() {}
  void onKeyPressed() {}
}

class MinyFrame implements MinyWidget
{
  protected Rect _box;
  protected MinyGUI _parent;
  protected int _minW, _minH;
  private boolean _moveable, _resizeable, _hasFocus, _movingFrame;
  private Rect _saved;
  private int _resizing, _clickX, _clickY;
  String _name;
  
  MinyFrame(MinyGUI parent, String name)
  {
    _parent = parent;
    _name = name;
    _moveable = _resizeable = _hasFocus = _movingFrame = false;
    _resizing = -1;
    _minW = 80;
    _minH = 60;
  }
  
  void onClose() {}
  void onResize() {}
  
  void setRect(Rect r) { _box = r; }
  Rect getRect() { return _box; }
  
  void setMoveable(boolean b) { _moveable = b; }
  void setResizeable(boolean b) { _resizeable = b; }
  
  void setClientAreaSize(int w, int h)
  {
    _box.w = w+2;
    _box.h = h+2;
    if(_moveable)
      _box.h+=18;
    if(_resizeable)
    {
      _box.w += 6;
      _box.h += 6;
    }
    
    validatePosition();
  }
  
  Rect getClientArea()
  {
    Rect r = new Rect(_box);
    r.grow(-1);
    if(_resizeable)
      r.grow(-3);
    if(_moveable)
    {
      r.y+=18; 
      r.h-=18;
    }
    return r;
  }
  
  void placeAt(int x, int y, int w, int h)
  {      
    w = w+2;
    h = h+2;
    if(_moveable)
     h+=18;
    if(_resizeable)
    {
      w += 6;
      h += 6;
    }
    
    if(x+w > width - 5)
      x = width - w - 5;
    if(y+h > height - 5)
      y = height - h - 5;
      
    _box = new Rect(x, y, w, h);
    validatePosition();
  }
  
  void validatePosition()
  {
    _box.w = constrain(_box.w, _minW, width-1);
    _box.h = constrain(_box.h, _minH, height-1);
    _box.x = max(0, _box.x);
    _box.y = max(0, _box.y);
    if(_box.x + _box.w + 1 > width)
      _box.x = width - _box.w - 1;
    if(_box.y + _box.h + 1 > height)
      _box.y = height - _box.h - 1;
  }
  
  void update()
  {
    if(!_parent.hasLock(this))
    {
      if(_resizeable)
      {
        Rect r = new Rect(_box);
        r.grow(-4);
        if(overRect(_box) && !overRect(r))
          cursor(CROSS);
        else
          cursor(ARROW);
      }
      return;
    }
    
    if(mousePressed)
    {
      int oldW = _box.w, oldH = _box.h;
      if(_resizing != -1 && (pmouseX != mouseX || pmouseY != mouseY))
      {
        if((_resizing & 1) != 0)
        {
          _box.x = min(_saved.x+_saved.w-_minW, _saved.x + mouseX - _clickX);
          _box.w = max(_minW, _saved.w - mouseX + _clickX);
        }
        else if((_resizing & 2) != 0)
        {
          _box.x = _saved.x;
          _box.w = max(_minW, _saved.w + mouseX - _clickX);
        }
        if((_resizing & 4) != 0)
        {
          _box.y = min(_saved.y+_saved.h-_minH, _saved.y + mouseY - _clickY);
          _box.h = max(_minH, _saved.h - mouseY + _clickY);
        }
        else if((_resizing & 8) != 0)
        {
          _box.y = _saved.y;
          _box.h = max(_minH, _saved.h + mouseY - _clickY);
        }
      }
      
      if(_movingFrame)
      {
        _box.x = _saved.x + mouseX - _clickX;
        _box.y = _saved.y + mouseY - _clickY;
      }
      
      validatePosition();
      if(_box.w != oldW || _box.h != oldH)
        onResize();
    }
    else if(_resizing!=-1 || _movingFrame)
    {
      _parent.releaseLock(this);
      _resizing = -1;
      _movingFrame = false;
      cursor(ARROW);
    }
  }
  
  void display()
  {
    fill(_parent.bg); stroke(_parent.fg);
    Rect r = new Rect(_box);
    if(_resizeable && _moveable) 
    {
      noFill(); 
      rect(r);
      r.grow(-1);
      stroke(_parent.bg);
      rect(r); r.grow(-1);
      rect(r); r.grow(-1);
      r.y+=18; r.h-=18; 
      stroke(_parent.fg); fill(_parent.bg);
      rect(r);
    } 
    else if(_resizeable) 
    {
      rect(r);
      r = new Rect(_box);
      r.grow(-3);
      noFill();
      rect(r);
    } 
    else if(_moveable) 
    {
      r.y+=18; r.h-=18; 
      rect(r);
    } 
    else
      rect(r);

    if(_moveable)
    {
      r = new Rect(_box);
      if(_resizeable)
        r.grow(-3);
      r.h = 18;
      
      r.y++; r.h--; r.w -= r.h;
      noStroke();
      if(_hasFocus) fill(_parent.selectColor); else fill(_parent.bg);
      rect(r);
      
      r.y--; r.w += r.h; r.h++;
      noFill(); stroke(_parent.fg);
      rect(r);
      
      fill(_parent.fg); noStroke();
      r.x += 5;
      r.w -= 10;
      textAlign(LEFT);
      text(_name, r);
      
      r.x = _box.x + _box.w - r.h;
      if(_resizeable) r.x-=3;
      r.w = r.h;
      noFill();
      if(_hasFocus) stroke(_parent.selectColor); else stroke(_parent.bg);
      r.grow(-1);
      rect(r);
      r.grow(-1);
      rect(r);
      r.grow(-1);
      rect(r);
      
      fill(_parent.bg); stroke(_parent.fg);
      rect(r);
      noFill();
      r.grow(-2);
      line(r.x, r.y, r.x+r.w, r.y+r.h);
      line(r.x+r.h, r.y, r.x, r.y+r.h);
    }
  }
  
  void getFocus() { _hasFocus=true; }
  void lostFocus() { _hasFocus=false; }
  void onMousePressed()
  {
    _clickX = mouseX;
    _clickY = mouseY;
    _saved = new Rect(_box);
    if(_resizeable)
    {
      Rect r = new Rect(_box);
      r.grow(-4);
      if(overRect(_box) && !overRect(r))
      {
        _parent.getLock(this);
        cursor(CROSS);
        _resizing = 0;
        if(mouseX - _box.x < 4)
          _resizing += 1;
        if(_box.x+_box.w - mouseX < 4)
          _resizing += 2;
        if(mouseY - _box.y < 4)
          _resizing += 4;
        if(_box.y+_box.h - mouseY < 4)
          _resizing += 8;
        return;
      }
    }
    
    if(_moveable)
    {
      Rect r = new Rect(_box);
      if(_resizeable) r.grow(-3);
      r.h = 18;
      
      Rect r2 = new Rect(r);
      r2.x = _box.x + _box.w - r2.h;
      if(_resizeable) r2.x-=3;
      r2.w = r2.h;
      r2.grow(-3);
      if(overRect(r2))
      {
        _parent.removeFrame(this);
        return;
      }

      if(overRect(r))
      {
        cursor(MOVE);
        _movingFrame = true;
        _parent.getLock(this);
        return;
      }
    }
  }
  
  void onKeyPressed()
  {
  }
}

interface FrameCreator
{
  void onCloseFrame(MinyFrame frame);
}

class PropertyButton extends Property
{
  private ButtonCallback _callback;
  private boolean _pressed;
  
  PropertyButton(MinyGUI parent, String name, ButtonCallback callback)
  { 
    super(parent, name);
    _callback = callback;
    _pressed = false;
  }
  
  Rect getBox()
  { return new Rect((int)(_x+_w*0.2), _y+1, (int)(_w*0.6), 18); }
  
  void onMousePressed()
  {
    if(overRect(getBox()))
      _pressed = true;
  }
  
  void update()
  {
    if(_pressed && !mousePressed)
    {
      _pressed = false;
      if(overRect(getBox()))
        _callback.onButtonPressed();
    }
  }
  
  void display(PGraphics pg, int y)
  {
    pg.stroke(_parent.fg); pg.fill(_parent.bg);
    Rect b = getBox();
    b.x-=_x; b.y += y-_y;
    if(_pressed && overRect(getBox()))
      pg.strokeWeight(2);
    rect(pg, b);
    pg.strokeWeight(1);
    b.grow(-1);
    pg.textAlign(CENTER, TOP);
    pg.fill(_parent.fg);
    text(pg, _name, b);
  }
}

class PropertyDisplay extends Property
{
  private MinyValue _value;
  PropertyDisplay(MinyGUI parent, String name, MinyValue value)
  {
    super(parent, name);
    _value = value;
  }
  
  void display(PGraphics pg, int y)
  {
    super.display(pg, y);
    pg.text(_value.getString(), _w*0.4 + 3, y, _w *0.6 - 8, 20);
  }
}

class PropertyEdit extends Property
{
  private int cursorPos, cursorTime, selectionStart, selectionEnd;
  private boolean cursorOn, selectioning;
  private String editText;
  
  PropertyEdit(MinyGUI parent, String name)
  {
    super(parent, name);
    cursorPos = 0;
    cursorTime = 0;
    cursorOn = true;
    selectioning = false;
    selectionStart = selectionStart = -1;
    editText = new String();
  }
  
  Rect getBox()
  { return new Rect((int)(_x+_w*0.4+3), _y+1, (int)(_w*0.6-8), 18); }
  
  int findCursorPos()
  {
    float tc = mouseX - (int)(_x+_w*0.4+4); 
    int closestPos = editText.length();
    float closestDist = _w;
    for(int i=editText.length(); i>=0; i--)
    {
      float tw = textWidth(editText.substring(0,i));
      float d = abs(tc-tw);
      if(d < closestDist)
      {
        closestDist = d;
        closestPos = i;
      }
      else
        break;
    }
    return closestPos;
  }
  
  void onMousePressed()
  {
    if(overRect(getBox()))
    {
      if(!_parent.hasLock(this))
      {
        _parent.getLock(this);
        cursorTime = millis()+500;
        cursorOn = true;
        editText = getValue();
      }
           
      cursorPos = findCursorPos();
      selectioning = true;
      selectionStart = cursorPos;
    }
  }
  
  void onKeyPressed()
  {
    switch(key)
    {
      case CODED:
      switch(keyCode)
      {
        case LEFT:
          if(_parent.getModShift())
          {
            if(selectionStart != -1)
            {
              if(cursorPos == selectionStart)
                selectionStart = max(selectionStart-1, 0);
              else if(cursorPos == selectionEnd)
                selectionEnd = max(selectionEnd-1, 0);
              cursorPos = max(cursorPos-1, 0);
            }
            else if(cursorPos > 0)
            {
              selectionEnd = cursorPos;
              cursorPos--;
              selectionStart = cursorPos;
            }
          }
          else if(selectionStart != -1)
          {
            cursorPos = selectionStart;
            selectionStart = selectionEnd = -1;
          }
          else
            cursorPos = max(cursorPos-1, 0);
          break;
        case RIGHT:
          if(_parent.getModShift())
          {
            if(selectionStart != -1)
            {
              if(cursorPos == selectionStart)
                selectionStart = min(selectionStart+1, editText.length());
              else if(cursorPos == selectionEnd)
                selectionEnd = min(selectionEnd+1, editText.length());
              cursorPos = min(cursorPos +1, editText.length());
            }
            else if(cursorPos < editText.length()-1)
            {
              selectionStart = cursorPos;
              cursorPos++;
              selectionEnd = cursorPos;
            }
          }
          else if(selectionStart != -1)
          {
            cursorPos = selectionEnd;
            selectionStart = selectionEnd = -1;
          }
          else
            cursorPos = min(cursorPos +1, editText.length());
          break;
      }
      break;
    case RETURN:
    case ENTER:
      lostFocus();
      break;
    case DELETE:
      if(!selectioning && (selectionStart != -1))
      {
        editText = editText.substring(0, selectionStart) + editText.substring(selectionEnd);
        cursorPos = selectionStart;
        selectionStart = selectionEnd = -1;
      }
      else if(cursorPos < editText.length())
        editText = editText.substring(0, cursorPos) + editText.substring(cursorPos+1);
      break;
    case BACKSPACE:
      if(!selectioning && (selectionStart != -1))
      {
        editText = editText.substring(0, selectionStart) + editText.substring(selectionEnd);
        cursorPos = selectionStart;
        selectionStart = selectionEnd = -1;
      }
      else if(cursorPos > 0)
      {
        editText = editText.substring(0, cursorPos-1) + editText.substring(cursorPos);
        cursorPos--;
      }
      break;
    default:
      if(_parent.getModCtrl() || _parent.getModAlt())
        break;
      if(!selectioning && (selectionStart != -1))
      {
        editText = editText.substring(0, selectionStart) + editText.substring(selectionEnd);
        cursorPos = selectionStart;
        selectionStart = selectionEnd = -1;
      }
      String tempText = editText.substring(0, cursorPos) + key + editText.substring(cursorPos);
      if(validate(tempText))
      {
        editText = tempText;
        cursorPos++;
      }
      break;
    }
  }
  
  boolean validate(String test) { return true; }
  void saveValue(String val) {}
  String getValue() { return ""; }
  
  void lostFocus()
  {
    if(validate(editText))
      saveValue(editText);
    cursorPos = 0;
    cursorOn = true;
    selectioning = false;
    cursor(ARROW);
    _parent.releaseLock(this);
  }
  
  void update()
  {
    if(!_parent.hasLock(this))
      return;
      
    if(millis() > cursorTime)
    {
      cursorOn = !cursorOn;
      cursorTime = millis() + 500;
    }
    
    if(!mousePressed)
    {
      selectioning = false;
      if(selectionStart != selectionEnd)
      {
        int start = min(selectionStart, selectionEnd);
        int end = max(selectionStart, selectionEnd);
        selectionStart = start;
        selectionEnd = end;
      }
      else
        selectionStart = selectionEnd = -1;
    }
      
    if(overRect(getBox()))
      cursor(TEXT);
    else
      cursor(ARROW);
      
    if(selectioning)
      cursorPos = selectionEnd = findCursorPos();
  }
  
  void display(PGraphics pg, int y)
  {
    super.display(pg, y);
    
    pg.noFill(); pg.stroke(_parent.fg);
    Rect b = getBox();
    b.y += y-_y; b.x -= _x;
    if(_parent.hasLock(this))
      pg.strokeWeight(2);
    rect(pg, b);
    pg.strokeWeight(1);
    b.grow(-1);
    pg.textAlign(LEFT, CENTER);
    if(_parent.hasLock(this))
    {
      if(selectionStart != selectionEnd)
      {
        float tw1, tw2, tw;
        tw1 = textWidth(editText.substring(0, selectionStart));
        tw2 = textWidth(editText.substring(0, selectionEnd));
        tw = tw2-tw1;
        
        pg.fill(_parent.selectColor); pg.noStroke();
        pg.rect(b.x+tw1, b.y+1, tw, b.h-2);
        pg.noFill();
      }
      
      pg.fill(_parent.fg);
      text(pg, editText, b);
      pg.stroke(_parent.fg);
      if(cursorOn)
      {
        float tw = textWidth(editText.substring(0, cursorPos));
        pg.line(_w*0.4+4+tw, y+4, _w*0.4+4+tw, y+17);
      }
    }
    else
      text(pg, getValue(), b);
  }
}

class PropertyEditString extends PropertyEdit
{
  private MinyString _value;
  
  PropertyEditString(MinyGUI parent, String name, MinyString value)
  {
    super(parent, name);
    _value = value;
  }
  
  boolean validate(String test)
  { return textWidth(test) < getBox().w-2; }
  
  void saveValue(String val)
  { _value.setValue(val); }
  
  String getValue()
  { return _value.getValue(); }
}

class PropertyEditInteger extends PropertyEdit
{
  private MinyInteger _value;
  
  PropertyEditInteger(MinyGUI parent, String name, MinyInteger value)
  {
    super(parent, name);
    _value = value;
  }
  
  boolean validate(String test)
  { 
    if(test.length() == 0) 
      return true;
    if(test.equals("-"))
      return true;
    try
    {
      Integer.parseInt(test);
      return true;
    }
    catch(NumberFormatException e)
    { return false; }
  }
  
  void saveValue(String val)
  { 
    if(val.length() == 0)
      _value.setValue(0);
    else try
      { _value.setValue(Integer.parseInt(val)); }
      catch(NumberFormatException e) {} 
  }
  
  String getValue()
  { return _value.getValue().toString(); }
}

class PropertyEditFloat extends PropertyEdit
{
  private MinyFloat _value;
  
  PropertyEditFloat(MinyGUI parent, String name, MinyFloat value)
  {
    super(parent, name);
    _value = value;
  }
  
  boolean validate(String test)
  {
    if(test.length() == 0)
      return true; 
    if(test.equals("-"))
      return true;
    try
    {
      if(test.substring(test.length()-1).compareToIgnoreCase("e") == 0)
      {
        Float.parseFloat(test.substring(0, test.length()-1));
        return true;
      }
    
      Float.parseFloat(test);
      return true;
    }
    catch(NumberFormatException e)
    { return false; }
  }
  
  void saveValue(String val)
  { 
    if(val.length() == 0)
      _value.setValue(0.0);
    else try
      { _value.setValue(Float.parseFloat(val)); }
      catch(NumberFormatException e) {} 
  }
  
  String getValue()
  { return _value.getValue().toString(); }
}

class PropertySlider extends Property
{
  private boolean _over;
  
  PropertySlider(MinyGUI parent, String name)
  {
    super(parent, name);    
  }
  
  float getPos() { return 0.0; }
  void setPos(float v) {}
  
  private Rect getBox()
  {
    float fpos = (_x + _w*0.4 + 8) + (_w*0.6 - 18) * getPos();
    return new Rect((int)fpos-5, _y+8, 10, 10);
  }
  
  void update()
  {
    if(mousePressed) 
    {
      if(_over)
        _parent.getLock(this);
    }
    else
      _parent.releaseLock(this);
     
    if(_parent.hasLock(this))
    {
      float t = mouseX - (_x + _w*0.4 + 8);
      t /= _w*0.6 - 18;
      setPos(t);
    }
    else
      _over = overRect(getBox()) && !mousePressed;
  }
  
  void onMousePressed()
  {
    if(overRect(getBox()))
    {
      _over = true;
      _parent.getLock(this);
    }
    else if(overRect((int)(_x + _w*0.4 + 3), _y+8, _x + _w-5, _y+15))
    {
      float t = mouseX - (_x + _w*0.4 + 8);
      t /= _w*0.6 - 18;
      setPos(t);
    }
  }
  
  void display(PGraphics pg, int y)
  {
    super.display(pg, y);
    
    pg.fill(_parent.bg); pg.stroke(_parent.fg);
    pg.line(_w*0.4 + 3, y+13, _w-5, y+13);
    if(_over || _parent.hasLock(this)) pg.strokeWeight(2); 
    Rect b = getBox();
    b.x -= _x; b.y += y-_y;
    rect(pg, b);
    pg.strokeWeight(1);
  }
}

class PropertySliderInteger extends PropertySlider
{
  private MinyInteger _value;
  private int _mini, _maxi;
  
  PropertySliderInteger(MinyGUI parent, String name, MinyInteger value, int mini, int maxi)
  {
    super(parent, name);    
    _value = value;
    _mini = mini;
    _maxi = maxi;
  }
  
  float getPos() 
  { return (_value.getValue() - _mini) / (float)(_maxi - _mini); }
  
  void setPos(float v) 
  { _value.setValue(round(constrain(_mini+v*(_maxi-_mini), _mini, _maxi))); }
  
  void update()
  {
    super.update();
    _value.setValue(constrain(_value.getValue(), _mini, _maxi));
  }
}

class PropertySliderFloat extends PropertySlider
{
  private MinyFloat _value;
  private float _mini, _maxi;
  
  PropertySliderFloat(MinyGUI parent, String name, MinyFloat value, float mini, float maxi)
  {
    super(parent, name);    
    _value = value;
    _mini = mini;
    _maxi = maxi;
  }
  
  float getPos() 
  { return (_value.getValue() - _mini) / (_maxi - _mini); }
  
  void setPos(float v) 
  { _value.setValue(constrain(_mini+v*(_maxi-_mini), _mini, _maxi)); }
  
  void update()
  {
    super.update();
    _value.setValue(constrain(_value.getValue(), _mini, _maxi));
  }
}

class PropertyCheckBox extends Property
{
  private MinyBoolean _value;
  
  PropertyCheckBox(MinyGUI parent, String name, MinyBoolean value)
  {
    super(parent, name);
    _value = value;
  }
  
  Rect getBox()
  { return new Rect((int)(_x + _w*0.4 + 3), _y + 8, 10, 10); }
  
  void display(PGraphics pg, int y)
  {
    super.display(pg, y);
    
    pg.stroke(_parent.fg); pg.fill(_parent.bg);
    Rect b = getBox();
    b.x -= _x; b.y += y-_y;
    rect(pg, b);
    
    if(_value.getValue())
    {
      pg.fill(_parent.fg);
      b.grow(-2);
      rect(pg, b);
    }
  }
  
  void onMousePressed()
  {
    if(overRect(getBox()))
      _value.setValue(!_value.getValue());
  }
}

class VScrollbar implements MinyWidget
{
  private MinyGUI _parent;
  private float pos;
  private Rect _area;
  private boolean _over;
  
  VScrollbar(MinyGUI parent, Rect area)
  {
    _parent = parent;
    _area = area;
    pos = 0;
    _over = false;
  }
  
  Rect getRect() { return _area; }
  void setPosition(Rect r) { _area = r; }
  Rect getBox()
  { return new Rect(_area.x+2, (int)(_area.y+2+pos*(_area.h-24)), _area.w-4, 20); }
  
  void onMousePressed()
  {
    if(overRect(getBox()))
    {
      _over = true;
      _parent.getLock(this);
    }
    else
    {
      float t = mouseY - (_area.y + 12);
      t /= _area.h-24;
      pos = constrain(t, 0, 1);
    }
  }
  
  void update()
  {
    if(mousePressed) 
    {
      if(_over)
        _parent.getLock(this);
    }
    else
      _parent.releaseLock(this);
      
    if(_parent.hasLock(this))
    {
      float t = mouseY - (_area.y + 12);
      t /= _area.h-24;
      pos = constrain(t, 0, 1);
    }
    else
      _over = overRect(getBox()) && !mousePressed;
  }
  
  void display(PGraphics pg, int y)
  {
    pg.noFill(); pg.stroke(_parent.fg);
    Rect r = new Rect(_area);
    Rect pr = _parent.getRect();
    r.x -= pr.x; r.y -= pr.y;
    rect(pg, r);
    
    pg.fill(_parent.bg);
    Rect b = getBox();
    b.x -= pr.x; b.y -= _area.y;
    if(_over || _parent.hasLock(this))
    {  
      b.x++; b.w--; b.y++; b.h--;
      pg.strokeWeight(2);
      rect(pg, b);
      pg.strokeWeight(1);
    }
    else
      rect(pg, b);
  }
  
  void getFocus() {}
  void lostFocus() { _over = false; }
  void onKeyPressed() {}
}

class PropertyList extends Property
{
  private MinyInteger _value;
  private String[] _choices;
  
  PropertyList(MinyGUI parent, String name, MinyInteger value, String choices)
  {
    super(parent, name);
    _value = value;
    _choices = split(choices, ';');
  }
  
  Rect getBox()
  { return new Rect((int)(_x+_w*0.4+3), _y+2, (int)(_w*0.6-8), 18); }
  
  void onMousePressed()
  {
    if(overRect(getBox()))
    {
      Rect p = _parent.getRect();
      Rect b = getBox();
      boolean below = true;
      if(b.y+b.h+(b.h-1)*_choices.length > p.y+p.h) below = false;
      
      Rect r = new Rect(b.x, b.y+(below?b.h:-(b.h-2)*_choices.length-2), b.w, 2+(b.h-2)*(_choices.length));
      PropertyListFrame frame = new PropertyListFrame(_parent, _name, _value, _choices);
      frame.setRect(r);
      _parent.addFrame(frame);
      _parent.changeFocus(frame);
    }
  }
  
  void display(PGraphics pg, int y)
  {
    super.display(pg, y);
    pg.noFill(); pg.stroke(_parent.fg);
    Rect b = getBox();
    b.x -= _x; b.y += y-_y;
    b.w-=14;
    rect(pg, b);
    b.grow(-1);
    pg.fill(_parent.fg);
    pg.textAlign(LEFT, CENTER);
    text(pg, _choices[(int)_value.getValue()], b);
    
    b = getBox();
    b.x -= _x; b.y += y-_y;
    b.x += b.w-14;
    b.w = 14;
    pg.noFill();
    rect(pg, b);
    pg.line(b.x+3, b.y+3, b.x+b.w/2, b.y+b.h-4);
    pg.line(b.x+b.w/2, b.y+b.h-4, b.x+b.w-3, b.y+3);
  }
}

class PropertyListFrame extends MinyFrame
{
  private MinyInteger _value;
  private String[] _choices;
  private boolean _moving, _over;
  private int _selected;
  
  PropertyListFrame(MinyGUI parent, String name, MinyInteger value, String[] choices)
  {
    super(parent, name);
    _value = value;
    _choices = choices;
    _selected = value.getValue();
    _moving = true;
    _over = false;
    _parent.getLock(this);
  }
  
  void lostFocus()
  {
    _parent.removeFrame(this);
  }
  
  void onMousePressed()
  {
    _parent.removeFrame(this); 
    _parent.releaseLock(this);
 
    Rect b = getClientArea();
    b.h /= _choices.length;
    for(int i=0; i<_choices.length; i++)
    {
      if(overRect(b))
        _value.setValue(i);
      b.y+=b.h;
    }
  }
  
  void update()
  {
    _value.setValue(constrain(_value.getValue(), 0, _choices.length));
    
    if(_moving)
    {
      if(!mousePressed)
      {
        if(_over)
        {
          _value.setValue(_selected);
          _parent.releaseLock(this);
          _parent.removeFrame(this);
          return;
        }
        _moving = false;
      }
      
      _over = false;
      Rect b = getClientArea();
      b.h /= _choices.length;
      for(int i=0; i<_choices.length; i++)
      {
        if(overRect(b))
        {
          _selected = i;
          _over = true;
          break;
        }
        b.y+=b.h;
      }
      
      if(!_over) _selected = _value.getValue();
    }
  }
  
  void display()
  {
    super.display();
    
    Rect b = getClientArea();
    b.h /= _choices.length;
    noStroke(); fill(_parent.selectColor);
    Rect bs = new Rect(b);
    bs.y += bs.h*_selected;
    bs.w++; bs.h++;
    rect(bs);
    fill(_parent.fg);
    textAlign(LEFT, CENTER);
    for(int i=0; i<_choices.length; i++)
    {
      text(_choices[i], b);
      b.y+=b.h;
    }
  }
}

class PropertyColorChooser extends Property implements FrameCreator
{ 
  private MinyColor _value;
  private PImage _imgChecker;
  private ColorChooserFrame _frame;
  PropertyColorChooser(MinyGUI parent, String name, MinyColor value)
  {
    super(parent, name);    
    _value = value;
    int h = getHeight()-3;
    _imgChecker = createImage(h, h, RGB);
    _imgChecker.loadPixels();
    for(int x=0; x<h; x++)
    {
      for(int y=0; y<h; y++)
      {
        boolean b = (x%h < h/2);
        if(y%h < h/2) b = !b;
        _imgChecker.pixels[y*h+x]=b?color(160):color(95);
      }
    }
    _imgChecker.updatePixels();
  }
  
  Rect getBox()
  { return new Rect((int)(_x+_w*0.4+3), _y+1, (int)(_w*0.6-8), 18); }
  
  void onMousePressed()
  {
    if(overRect(getBox()))
    {
      if(_frame == null)
      {
        _frame = new ColorChooserFrame(_parent, _name, _value, this);
        _frame.placeAt(mouseX, mouseY);
        _parent.addFrame(_frame);
      }
      _parent.changeFocus(_frame);
      _parent.putFrameOnTop(_frame);
    }
  }
  
  void display(PGraphics pg, int y)
  {
    super.display(pg, y);
    
    Rect r = getBox();
    r.x -= _x; r.y += y-_y;
    int h = getHeight()-3;
    int x;
    for(x=1; x+h<r.w; x+=h)
      pg.image(_imgChecker, r.x+x, r.y+1);
    int w = r.w - x;
    pg.copy(_imgChecker, 0, 0, w, h, r.x+x, r.y+1, w, h);
      
    pg.noFill(); pg.stroke(_parent.fg);
    rect(pg, r);
    
    // Bug if calling fill(color) if alpha = 0
//    fill(_value.getValue());
    pg.fill(_value.getRed(), _value.getGreen(), _value.getBlue(), _value.getAlpha()); 
    pg.noStroke();
    r.x++; r.y++; r.w--; r.h--;
    rect(pg, r);
  }
  
  void onCloseFrame(MinyFrame frame) { _frame = null; }
}

class ColorChooserFrame extends MinyFrame
{
  private MinyColor _value;
  private FrameCreator _property;
  private PImage _imgChecker, _imgA, _imgR, _imgG, _imgB;
  private int _editing;
  private PGraphics _pg;
  
  ColorChooserFrame(MinyGUI parent, String name, MinyColor value, FrameCreator property)
  {
    super(parent, name);
    _value = value;
    _property = property;
    _editing = -1;
    setMoveable(true);
    _imgChecker = createImage(256, 20, RGB);
    _imgA = createImage(256, 20, ARGB);
    _imgR = createImage(256, 20, RGB);
    _imgG = createImage(256, 20, RGB);
    _imgB = createImage(256, 20, RGB);
    _pg = createGraphics(256, 97, JAVA2D);
    
    _imgChecker.loadPixels();
    for(int x=0; x<256; x++)
    {
      for(int y=0; y<20; y++)
      {
        boolean b = (x%20 < 10);
        if(y%20 < 10) b = !b;
        _imgChecker.pixels[y*256+x]=b?color(160):color(95);
      }
    }
    _imgChecker.updatePixels();
    
    computeColorBoxes();
  }
  
  void placeAt(int x, int y) { placeAt(x, y, 256+25, 105); }
  
  void computeColorBoxes()
  {
    int r,g,b,a;
    color c = _value.getValue();
    a = c & 0xFF000000; r = c & 0x00FF0000; g = c & 0x0000FF00; b = c & 0x000000FF;
    
    _imgR.loadPixels();
    for(int x=0; x<256; x++)
    {
      c = (x << 16) + g + b;
      for(int y=0; y<20; y++)
        _imgR.pixels[y*256+x] = c;
    }
    _imgR.updatePixels();
    
    _imgG.loadPixels();
    for(int x=0; x<256; x++)
    {
      c = r + (x << 8) + b;
      for(int y=0; y<20; y++)
        _imgG.pixels[y*256+x] = c;
    }
    _imgG.updatePixels();
    
    _imgB.loadPixels();
    for(int x=0; x<256; x++)
    {
      c = r + g + x;
      for(int y=0; y<20; y++)
        _imgB.pixels[y*256+x] = c;
    }
    _imgB.updatePixels();
    
    _imgA.loadPixels();
    for(int x=0; x<256; x++)
    {
      c = (x << 24) + r + g + b;
      for(int y=0; y<20; y++)
        _imgA.pixels[y*256+x] = c;
    }
    _imgA.updatePixels();
  }
  
  void display()
  {
    super.display();
    Rect area = getClientArea();
    
    int r,g,b,a;
    color c = _value.getValue();
    a = (c >> 24) & 0xFF; r = (c >> 16) & 0xFF; g = (c >> 8) & 0xFF; b = c & 0xFF;
    
    // draw colors
    int x=area.x+20, y=area.y+5;
    image(_imgR, x, y); y+= 25;
    image(_imgG, x, y); y+= 25;
    image(_imgB, x, y); y+= 25;
    image(_imgChecker, x, y);
    image(_imgA, x, y);
    
    // line for each color value
    _pg.beginDraw();
    _pg.background(color(255, 255, 255, 0));
    _pg.fill(color(0)); _pg.stroke(color(255)); 
    _pg.triangle(r,4, r-4,0, r+4,0);
    _pg.triangle(r,17, r-4,21, r+4,21);
    _pg.triangle(g,29, g-4,25, g+4,25);
    _pg.triangle(g,42, g-4,46, g+4,46);
    _pg.triangle(b,54, b-4,50, b+4,50);
    _pg.triangle(b,67, b-4,71, b+4,71);
    _pg.triangle(a,79, a-4,75, a+4,75);
    _pg.triangle(a,92, a-4,96, a+4,96);
    _pg.endDraw();
    image(_pg, area.x+20, area.y+4);
    
    // rectangles around each color area
    area.x += 19; area.w = 257; area.y += 4; area.h = 21;
    noFill(); stroke(_parent.fg);
    rect(area); area.y += 25;
    rect(area); area.y += 25;
    rect(area); area.y += 25;
    rect(area);
    
    // text
    area = getClientArea();
    area.x+=5; area.y+=5; area.w=20; area.h=20;
    noStroke(); fill(_parent.fg);
    text("R", area); area.y+=25;
    text("G", area); area.y+=25;
    text("B", area); area.y+=25;
    text("A", area);
  }
  
  void onClose() { _property.onCloseFrame(this); }
  void onKeyPressed() { _parent.removeFrame(this); }
  
  void onMousePressed()
  {
    super.onMousePressed();
    
    int r,g,b,a;
    color c = _value.getValue();
    a = (c >> 24) & 0xFF; r = (c >> 16) & 0xFF; g = (c >> 8) & 0xFF; b = c & 0xFF;
    
    Rect area = getClientArea();
    area.x+=20; area.y+=5; area.w=256; area.h=20;
    int v = constrain(mouseX-area.x, 0, 255);
    if(overRect(area)) {
      _value.setRed(v);   computeColorBoxes(); 
      _editing = 0; _parent.getLock(this);
      return; 
    }
    
    area.y+=25;
    if(overRect(area)) {
      _value.setGreen(v); computeColorBoxes(); 
      _editing = 1; _parent.getLock(this);
      return; 
    }
    
    area.y+=25;
    if(overRect(area)) {
      _value.setBlue(v);  computeColorBoxes(); 
      _editing = 2; _parent.getLock(this);
      return; 
    }
    
    area.y+=25;
    if(overRect(area)) {
      _value.setAlpha(v); computeColorBoxes(); 
      _editing = 3; _parent.getLock(this);
      return; 
    }
  }
  
  void update()
  {
    super.update();
    
    if(_editing == -1) 
      return;
    
    if(mousePressed)
    {
      int r,g,b,a,x,v;
      color c = _value.getValue();
      a = (c >> 24) & 0xFF; r = (c >> 16) & 0xFF; g = (c >> 8) & 0xFF; b = c & 0xFF;
      x = mouseX - getClientArea().x-20;
      v = constrain(x, 0, 255);
      
      switch(_editing)
      {
        case 0:
          _value.setRed(v);   computeColorBoxes(); break;
        case 1:
          _value.setGreen(v); computeColorBoxes(); break;
        case 2:
          _value.setBlue(v);  computeColorBoxes(); break;
        case 3:
          _value.setAlpha(v); computeColorBoxes(); break;
      }
    }
    else
    {
      _editing = -1;
      _parent.releaseLock(this);
    }
  }
}
