interface MinyValue
{
  String getString();
}

class MinyInteger implements MinyValue
{
  private Integer _v;
  MinyInteger(Integer v) { _v = v; }
  Integer getValue() { return _v; }
  void setValue(Integer v) { _v = v; }
  String getString() { return _v.toString(); }
}

class MinyFloat implements MinyValue
{
  private Float _v;
  MinyFloat(Float v) { _v = v; }
  Float getValue() { return _v; }
  void setValue(Float v) { _v = v; }
  String getString() { return _v.toString(); }
}

class MinyBoolean implements MinyValue
{
  private Boolean _v;
  MinyBoolean(Boolean v) { _v = v; }
  Boolean getValue() { return _v; }
  void setValue(Boolean v) { _v = v; }
  String getString() { return _v.toString(); }
}

class MinyString implements MinyValue
{
  private String _v;
  MinyString(String v) { _v = v; }
  String getValue() { return _v; }
  void setValue(String v) { _v = v; }
  String getString() { return _v; }
}

class MinyColor implements MinyValue
{
  private color _v;
  MinyColor(color v) { _v = v; }
  color getValue() { return _v; }
  void setValue(color v) { _v = v; }
  String getString() { return "0x"+hex(_v); }
  int getAlpha() { return (_v >> 24) & 0xFF; }
  int getRed() { return (_v >> 16) & 0xFF; }
  int getGreen() { return (_v >> 8) & 0xFF; }
  int getBlue() { return _v & 0xFF; }
  void setAlpha(int a) { _v = (_v & 0x00FFFFFF) + ((a & 0xFF) << 24); }
  void setRed(int r) { _v = (_v & 0xFF00FFFF) + ((r & 0xFF) << 16); }
  void setGreen(int g) { _v = (_v & 0xFFFF00FF) + ((g & 0xFF) << 8); }
  void setBlue(int b) { _v = (_v & 0xFFFFFF00) + (b & 0xFF); }
}
