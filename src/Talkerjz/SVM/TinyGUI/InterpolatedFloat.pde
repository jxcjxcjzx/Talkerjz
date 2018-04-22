class InterpolatedFloat
{
  class VarKey
  { float position, value; }
  private float _defaultValue;
  private boolean _useLookupTable;
  private float _lookupMin, _lookupMax;
  private float[] _lookupTable;
  private float _XMin, _XMax, _YMin, _YMax;
  private boolean _limitXMin, _limitXMax, _limitYMin, _limitYMax;
  private int _interpolationMethod;
  
  ArrayList keysList;
  
  InterpolatedFloat(float defaultValue)
  {
    _defaultValue = defaultValue;
    _useLookupTable = false;
    keysList = new ArrayList();
    _interpolationMethod = 0;
    
    _XMin = 0; _YMin = 0; _XMax = 1; _YMax = 1;
    _limitXMin = _limitXMax = _limitYMin = _limitYMax = false;
  }
  
  void setXMin(float v) { _limitXMin=true; _XMin=v; } boolean limitXMin() { return _limitXMin; } float getXMin() { return _XMin; }
  void setXMax(float v) { _limitXMax=true; _XMax=v; } boolean limitXMax() { return _limitXMax; } float getXMax() { return _XMax; }
  void setYMin(float v) { _limitYMin=true; _YMin=v; } boolean limitYMin() { return _limitYMin; } float getYMin() { return _YMin; }
  void setYMax(float v) { _limitYMax=true; _YMax=v; } boolean limitYMax() { return _limitYMax; } float getYMax() { return _YMax; }
  
  int getInterpolation() { return _interpolationMethod; }
  void setInterpolation(int i) { _interpolationMethod = i%5; }
  
  int size() { return keysList.size(); }
  void clear() { keysList.clear(); update(); }
  void remove(int index) { keysList.remove(index); update(); }
  
  int add(float pos, float val)
  {
    if(_limitXMin) pos = max(_XMin, pos);
    if(_limitXMax) pos = min(_XMax, pos);
    if(_limitYMin) val = max(_YMin, val);
    if(_limitYMax) val = min(_YMax, val);
    
    VarKey newVar = new VarKey();
    newVar.position = pos;
    newVar.value = val;
    
    int size = keysList.size();
    for(int i=0; i<size; i++)
    {
      VarKey v = (VarKey)keysList.get(i);
      if(v.position == pos) // don't add, just update 
      { v.value = val; update(); return i; }
    }
    
    keysList.add(newVar);
    update();
    return size;
  }
  
  void set(int index, float pos, float val)
  {  
    VarKey var = (VarKey)keysList.get(index);
    if(_limitXMin) pos = max(_XMin, pos);
    if(_limitXMax) pos = min(_XMax, pos);
    if(_limitYMin) val = max(_YMin, val);
    if(_limitYMax) val = min(_YMin, val);
    var.position = pos;
    var.value = val;
    update();
  }
  
  void setValue(int index, float val)
  { 
    if(_limitYMin) val = max(_YMin, val);
    if(_limitYMax) val = min(_YMin, val);
    ((VarKey)keysList.get(index)).value = val; 
    update(); 
  }
  
  void setPosition(int index, float pos)
  { 
    if(_limitXMin) pos = max(_XMin, pos);
    if(_limitXMax) pos = min(_XMax, pos);
    ((VarKey)keysList.get(index)).position = pos; 
    update(); 
  }
  
  float getPosition(int index)
  { return ((VarKey)keysList.get(index)).position; }
  
  float getValue(int index)
  { return ((VarKey)keysList.get(index)).value; }
  
  int getPrev(float pos)
  {
    int size = keysList.size();
    int best = -1;
    float bestPos = pos;
    for(int i=0; i<size; i++)
    {
      float p = getPosition(i);
      if(p < pos && (bestPos <= p || bestPos == pos))
      {
        bestPos = p;
        best = i;
      }
    }
    
    return best;
  }
  
  int getPrev(int index) { return getPrev(getPosition(index)); }
  
  int getNext(float pos)
  {
    int size = keysList.size();
    int best = -1;
    float bestPos = pos;
    for(int i=0; i<size; i++)
    {
      float p = getPosition(i);
      if(p > pos && (bestPos >= p || bestPos == pos))
      {
        bestPos = p;
        best = i;
      }
    }
    
    return best;
  }
  
  int getNext(int index) { return getNext(getPosition(index)); }
  
  float get(float pos)
  {
    int size = keysList.size();
    if(size == 0)  return _defaultValue;
    if(size == 1) return ((VarKey)keysList.get(0)).value;
    
    if(_useLookupTable)
    {
      float p = map(pos, _lookupMin, _lookupMax, 0, 1)*_lookupTable.length;
      int i = constrain(floor(p), 0, _lookupTable.length-1);
      return _lookupTable[i];
    }
    
    TreeMap sorted = getSortedMap();
    
    if(_interpolationMethod != 4 && sorted.containsKey(pos))
      return (Float)sorted.get(pos);
      
    SortedMap left, right;
    left = sorted.headMap(pos);
    if(left.size() == 0) return (Float)sorted.get(sorted.firstKey());
    right = sorted.tailMap(pos);
    if(right.size() == 0) return (Float)sorted.get(sorted.lastKey());
    
    float leftKey, rightKey;
    leftKey = (Float)left.lastKey();
    rightKey = (Float)right.firstKey();
    
    float amt = (pos-leftKey)/(rightKey-leftKey);
    
    float leftValue, rightValue;
    leftValue = (Float)sorted.get(leftKey);
    rightValue = (Float)sorted.get(rightKey);
    
    switch(_interpolationMethod)
    {
      case 0:
      default:
        return lerp(leftValue, rightValue, (1-cos(amt*PI))/2);
      case 1:
        return lerp(leftValue, rightValue, amt);
      case 2:
        return rightValue;
      case 3:
        return leftValue;
      case 4:
        return amt<0.5?leftValue:rightValue;
        //return (leftValue+rightValue)/2;
    }
  }
  
  // prepare a lookup table used in following calls of "get"
  void useLookupTable(int size, float from, float to)
  {
    _lookupMin = from;
    _lookupMax = to;
    _lookupTable = new float[size];
    _useLookupTable = true;
    update();
  }
  
  void useLookupTable(int size) { useLookupTable(size, _XMin, _XMax); }
  
  // compute a lookup table, not kept
  float[] getTable(int size, float from, float to)
  {
    float[] v = new float[size];
    boolean b = _useLookupTable;
    _useLookupTable = false;
    for(int i=0; i<size; i++)
    {
      float p = map(i, 0, size-1, from, to);
      v[i] = get(p);
    }
    _useLookupTable = b;
    return v;
  }
  
  float[] getTable(int size) { return getTable(size, _XMin, _XMax); }
  
  private TreeMap getSortedMap()
  {
    int size = keysList.size();
    if(size == 0) return null; 
    TreeMap mp = new TreeMap();
    
    for(int i=0; i<size; i++)
    {
      VarKey v = (VarKey)keysList.get(i);
      mp.put(v.position, v.value);
    }
    
    return mp;
  }
  
  private void update()
  {
    updateLimits();
    if(!_useLookupTable) return;
    _useLookupTable = false;
    for(int i=0; i<_lookupTable.length; i++)
    {
      float p = map(i, 0, _lookupTable.length-1, _lookupMin, _lookupMax);
      _lookupTable[i] = get(p);
    }
    _useLookupTable = true;
  }
  
  private void updateLimits()
  {
    float tXMin=_XMin, tXMax=_XMax, tYMin=_YMin, tYMax=_YMax;
    int size = keysList.size();
    if(size <= 1)
    {
      if(size == 0) {
        tXMin = 0; tXMax = 1;
      }
      else
      {
        float p = getPosition(0);
        tXMin = p - 0.5; tXMax = p + 0.5;
      }
      
      float v = getValue(0);
      tYMin = v - 0.5; tYMax = v + 0.5;
    }
    else
    {
      tXMin = tXMax = getPosition(0);
      tYMin = tYMax = getValue(0);
      for(int i=1; i<size; i++)
      {
        float p = getPosition(i);
        if(p < tXMin) tXMin = p;
        else if(p > tXMax) tXMax = p;
        
        float v = getValue(i);
        if(v < tYMin) tYMin = v;
        else if(v > tYMax) tYMax = v;
      }
    }
    
    if(!_limitXMin) _XMin = tXMin;
    if(!_limitXMax) _XMax = tXMax;
    if(!_limitYMin) _YMin = tYMin;
    if(!_limitYMax) _YMax = tYMax;
  }
}

class GraphFrame extends MinyFrame
{
  private int _selected, _over;
  private InterpolatedFloat _value;
  private boolean _drawGrid;
  private float _minX, _maxX, _minY, _maxY;
  private final float bigIncrement = 0.1, smallIncrement = 0.01;
  private float[] _graphValues;  
  private FrameCreator _property;
  
  GraphFrame(MinyGUI parent, String name, InterpolatedFloat value, FrameCreator property)
  {
    super(parent, name);
    _value = value;
    _property = property;
    _selected = _over = -1;
    _drawGrid = false;
    setMoveable(true); 
    setResizeable(true);
    _minW = 300; _minH = 200;
    _minX = _value.getXMin(); _maxX = _value.getXMax();
    _minY = _value.getYMin(); _maxY = _value.getYMax();
  }

  void placeAt(int x, int y) { placeAt(x, y, 350, 250); updateGraph(); }
  void onClose() { _property.onCloseFrame(this); }
  void onResize() { updateGraph(); }
  
  Rect getGraphArea()
  {
    Rect r = getClientArea();
    r.x+=40; r.w-=45;
    r.y+=10; r.h-=40;    
    return r;
  }
  
  void setGrid(boolean b) { _drawGrid = b; }
  
  void updateGraph()
  {
    Rect r = getGraphArea();
    _graphValues = _value.getTable(r.w, _minX, _maxX);
    for(int x=0; x<_graphValues.length; x++)
      _graphValues[x] = map(_graphValues[x], _minY, _maxY, r.h, 0);
  }
  
  void drawAxis()
  {
    Rect r = getGraphArea();
    stroke(_parent.fg); fill(_parent.fg);
    NumberFormat formatter = new DecimalFormat("0.##E0");
    int alpha = (_parent.fg >> 24) & 0xFF;
    alpha = alpha / 3;
    color gridColor = _parent.fg & 0x00FFFFFF + (alpha << 24);
    
 // Positions  
    textAlign(CENTER);
    float l = log(_maxX - _minX)/log(10);
    l = l<0?-ceil(abs(l)):floor(l);
    float xn = pow(10, l);    
    int nb = ceil((_maxX-_minX)*1.001/xn);
    
    if(nb <= 2) xn/=5;
    else if(nb < 5) xn/=2;
    else if(nb > 10) xn*=2;
    
    float x1 = ceil(_minX / xn)*xn;
    float x2 = floor(_maxX / xn)*xn;
    nb = ceil((x2-x1)/xn)+1;

    for(int i=0; i<nb; i++)
    {
      float x = x1+xn*i;
      if(x > _maxX) break;
      float sx = r.x+map(x, _minX, _maxX, 0, r.w);
      if(_drawGrid) { stroke(gridColor); line(sx, r.y, sx, r.y+r.h); }
      stroke(_parent.fg);
      line(sx, r.y+r.h, sx, r.y+r.h+5);
      String caption = nf(x, 0, 0);
      //pushMatrix();
      //rotate(90);
      if(caption.length() > 4)
        caption = formatter.format(x);
      text(caption, sx-25, r.y+r.h+10, 50, 20);
      //popMatrix();
    }
    
 // Values   
    l = log(_maxY - _minY)/log(10);
    l = l<0?-ceil(abs(l)):floor(l);
    float yn = pow(10, l);
    nb = ceil((_maxY-_minY)*1.001/yn);
    
    if(nb <= 2) yn/=5;
    else if(nb < 5) yn/=2;
    else if(nb > 10) yn*=2;
    
    float y1 = ceil(_minY / yn)*yn;
    float y2 = floor(_maxY / yn)*yn;
    nb = ceil((y2-y1)/yn)+1;
    
    Rect area = getClientArea();
    for(int i=0; i<nb; i++)
    {
      float y = y1+yn*i;
      if(y > _maxY) break;
      float sy = r.y+map(y, _minY, _maxY, r.h, 0);
      if(_drawGrid) { stroke(gridColor); line(r.x, sy, r.x+r.w, sy); }
      stroke(_parent.fg);
      line(r.x-5, sy, r.x, sy);
      String caption = nf(y, 0, 0);
      if(caption.length() > 4)
      {
        caption = formatter.format(y);
        textAlign(LEFT);
        text(caption, area.x, sy-10, 100, 20);
      }
      else
      {
        textAlign(RIGHT);
        text(caption, area.x, sy-10, r.x-area.x-10, 20);
      }
    }
    
    textAlign(LEFT);
  }
  
  void display()
  {
    super.display();
    
    noFill(); stroke(_parent.fg);
    Rect r = getGraphArea();
    rect(r);
    
    float lastY = r.y+_graphValues[0];
    for(int x=1; x<r.w; x++)
    {
      float y = r.y+_graphValues[x];
      line(r.x+x-1, lastY, r.x+x, y);
      lastY = y;
    }

    drawAxis();

    // Draw selection handles
    for(int i=0; i<_value.size(); i++)
    {
      float x = r.x + map(_value.getPosition(i), _minX, _maxX, 0, r.w);
      float y = r.y + map(_value.getValue(i), _minY, _maxY, r.h, 0);
      if(_selected == i) fill(_parent.selectColor); else fill(_parent.bg);
      ellipse(x, y, 6, 6);
    }
  }
  
  void update()
  {
    super.update();
    
    Rect r = getGraphArea();
    if(mousePressed)
    {
      if(_selected != -1)
      {
        if(pmouseX != mouseX)
        {
          if(mouseX < r.x && !_value.limitXMin())
          {
            float t = max(0,map(pmouseX-mouseX, 0, r.w, 0, _maxX-_minX));
            if(t > 0)
            {
              float v = _value.getPosition(_selected) - t;
              _value.setPosition(_selected, v);
              _minX = v;
            }
          }
          else if(mouseX > r.x+r.w && !_value.limitXMax())
          {
            float t = max(0,map(mouseX-pmouseX, 0, r.w, 0, _maxX-_minX));
            if(t > 0)
            {
              float v = _value.getPosition(_selected) + t;
              _value.setPosition(_selected, v);
              _maxX = v;
            }
          }
          else
          {
            float p = constrain( map(mouseX, r.x, r.x+r.w, _minX, _maxX), _minX, _maxX);
            _value.setPosition(_selected, p);
          }
          updateGraph();
        }
        if(pmouseY != mouseY)
        {
          if(mouseY < r.y && !_value.limitYMax())
          {
            float t = max(0,map(pmouseY-mouseY, 0, r.h, 0, _maxY-_minY));
            if(t > 0)
            {
              float v = _value.getValue(_selected) + t;
              _value.setValue(_selected, v);
              _maxY = v;
            }
          }
          else if(mouseY > r.y+r.h && !_value.limitYMin())
          {
            float t = max(0,map(mouseY-pmouseY, 0, r.h, 0, _maxY-_minY));
            if(t > 0)
            {
              float v = _value.getValue(_selected) - t;
              _value.setValue(_selected, v);
              _minY = v;
            }
          }
          else
          {
            float v = constrain( map(mouseY, r.y+r.h, r.y, _minY, _maxY), _minY, _maxY);
            _value.setValue(_selected, v);
          }
          updateGraph();
        }
      }
    }
    else
    {
      _over = -1;
      for(int i=0; i<_value.size(); i++)
      {
        float x = r.x + map(_value.getPosition(i), _minX, _maxX, 0, r.w);
        float y = r.y + map(_value.getValue(i), _minY, _maxY, r.h, 0);
        if(dist(mouseX, mouseY, x, y) < 5)
        {
          _over = i;
          break;
        }
      }
    }
  }
  
  void onMousePressed()
  {
    super.onMousePressed();
    _selected = -1;
    if(_over != -1)
    {
      _selected = _over;
      return;
    }
    
    if(_parent.getModCtrl())
    {
      Rect r = getGraphArea();
      float p = constrain( map(mouseX, r.x, r.x+r.w, _minX, _maxX), _minX, _maxX);
      float v = constrain( map(mouseY, r.y+r.h, r.y, _minY, _maxY), _minY, _maxY);
      _selected = _value.add(p, v);
      updateGraph();
    }
  }
  
  void onKeyPressed()
  {
    super.onKeyPressed();
    switch(key)
    {
      case CODED:
        switch(keyCode)
        {
          case UP:
            if(_selected != -1)
            {
              float v = _value.getValue(_selected);
              if(_parent.getModShift())  v += (_maxY-_minY)*bigIncrement; else v += (_maxY-_minY)*smallIncrement;
              if(v > _maxY && !_value.limitYMax()) {
                _maxY = v;
                _value.setValue(_selected, v);
              }
              else
                _value.setValue(_selected,  min(v, _maxY));
              updateGraph();
            }
            break;
          case DOWN:
            if(_selected != -1)
            {
              float v = _value.getValue(_selected);
              if(_parent.getModShift())  v -= (_maxY-_minY)*bigIncrement; else v -= (_maxY-_minY)*smallIncrement;
              if(v < _minY && !_value.limitYMin()) {
                _minY = v;
                _value.setValue(_selected, v);
              }
              else
                _value.setValue(_selected,  max(v, _minY));
              updateGraph();
            }
            break;
          case LEFT:
            if(_selected != -1)
            {
              float p = _value.getPosition(_selected);
              if(_parent.getModShift())  p -= (_maxX-_minX)*bigIncrement; else p -= (_maxX-_minX)*smallIncrement;
              if(p < _minX && !_value.limitXMin()) {
                _minX = p;
                _value.setPosition(_selected, p);
              }
              else
                _value.setPosition(_selected,  max(p, _minX));
              updateGraph();
            }
            break;
          case RIGHT:
            if(_selected != -1)
            {
              float p = _value.getPosition(_selected);
              if(_parent.getModShift())  p += (_maxX-_minX)*bigIncrement; else p += (_maxX-_minX)*smallIncrement;
              if(p > _maxX && !_value.limitXMax()) {
                _maxX = p;
                _value.setPosition(_selected, p);
              }
              else
                _value.setPosition(_selected,  min(p, _maxX));
              updateGraph();
            }
            break;
        }
        break;
      case TAB:
        if(_parent.getModShift())
        {
          if(_selected != -1)
          {
            int temp = _value.getPrev(_selected);
            if(temp != -1) _selected = temp;
          }
          else
            _selected = _value.getPrev(_maxX+1.0);
        }
        else
        {
          if(_selected != -1)
          {
            int temp = _value.getNext(_selected);
            if(temp != -1) _selected = temp;
          }
          else
            _selected = _value.getNext(_minX-1.0);
        }
        break;
      case DELETE:
        if(_selected != -1)
        {
          float p = _value.getPosition(_selected);
          _value.remove(_selected);
          _selected = _value.getNext(p);
          updateGraph();
        }
        break;
      case BACKSPACE:
        if(_selected != -1)
        {
          float p = _value.getPosition(_selected);
          _value.remove(_selected);
          _selected = _value.getPrev(p);
          updateGraph();
        }
        break;
      case ' ':
        _minX = _value.getXMin(); _maxX = _value.getXMax();
        _minY = _value.getYMin(); _maxY = _value.getYMax();
        updateGraph();
        break;
      case 'g':
      case 'G':
        _drawGrid = !_drawGrid;
        break;
      case 'n':
      case 'N':
        _selected = _value.add((_maxX+_minX)/2,(_maxY+_minY)/2);
        updateGraph();
        break;
      case 'i':
      case 'I':
        _value.setInterpolation(_value.getInterpolation()+1);
        updateGraph();
        break;
      case 'q':
      case 'Q':
        _parent.removeFrame(this);
        break;
    }
  }
}


class PropertyGraph extends Property implements FrameCreator
{ 
  private InterpolatedFloat _value;
  private PGraphics _graph;
  private GraphFrame _frame;
  
  PropertyGraph(MinyGUI parent, String name, InterpolatedFloat value)
  {
    super(parent, name);    
    _value = value;
  }
  
  void updateGraph()
  {
    Rect r = getBox();
    r.x++; r.w--; r.y++; r.h--;
    if(_graph == null || _graph.width != r.w || _graph.height != r.h)
      _graph = createGraphics(r.w, r.h, JAVA2D);
    _graph.beginDraw();
    _graph.background(color(255, 255, 255, 0));
    _graph.stroke(_parent.fg);
    float[] v = _value.getTable(r.w);
    float YMin = _value.getYMin(), YMax = _value.getYMax();
    float lastY = map(v[0], YMin, YMax, r.h-1, 0);
    for(int x=1; x<r.w; x++)
    {
      float y = map(v[x], YMin, YMax, r.h-1, 0);
      _graph.line(x-1, lastY, x, y);
      lastY = y;
    }
    _graph.endDraw();
  }
  
  int getHeight() { return 40; }
  
  Rect getBox()
  { return new Rect((int)(_x+_w*0.4+3), _y+1, (int)(_w*0.6-8), getHeight()-2); }
  
  void onMousePressed()
  {
    if(overRect(getBox()))
    {
      if(_frame == null)
      {
        _frame = new GraphFrame(_parent, _name, _value, this);
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
    if(_graph == null || r.w-1 != _graph.width || _parent.fg != _graph.strokeColor)
      updateGraph();
    
    pg.noFill(); pg.stroke(_parent.fg);
    rect(pg, r);
    pg.image(_graph, r.x+1, r.y+1);
  }
  
  void onCloseFrame(MinyFrame frame) { _frame = null; updateGraph(); }
}
