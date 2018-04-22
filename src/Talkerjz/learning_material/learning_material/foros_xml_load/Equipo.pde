class Equipo implements Visualizable {
  //TODO: tener en cuenta los espacios
  int widthEscala=500;
  int heightEscala=319;

  String nombre;

  
  int id;
  color c;
  boolean representado;
  VerletParticle2D particle;
  public Equipo(int _id, String _n, int _x, int _y) {
    this.id=_id;
    this.nombre=_n;
    particle=new VerletParticle2D(map(_x, 0, widthEscala, 0, width),map(_y, 0, heightEscala, 0, height));

  }
  void setColor(TColor colo){
    this.c=color(mapeaValor(colo.hue()), mapeaValor(colo.saturation()),mapeaValor(colo.brightness()) );
  }
  float mapeaValor(float ta){
      return   map(ta,0,1,0,100);
  }
  List<Usuario> usuarios=new ArrayList();
  public Usuario addUsuario(Usuario u) {
    for (Usuario usu:usuarios)
      if (usu.id==u.id)return usu;
    usuarios.add(u);
    return u;
  }

  int inicio=3;
  int limite=10;
  float tonito=inicio;

  void repinta(Capa pg) {

    reset(pg,7);

  }
  void reset(Capa pg) {
    
    reset(pg,limite);
  }
  void reset(Capa pg, float limiteBucle) {
    tonito=inicio;
    representado=false;
    for (int i=0; i<limiteBucle-inicio;i++) {
      pinta(pg);
    }
    representado=false;
  }
  void pinta(Capa pg) {
   pg.g.pushStyle();
      pg.g.noStroke();
      pg.g.fill(c, 100);
      int incremento=(usuarios.size()+7);
      pg.g.ellipse(particle.x, particle.y, incremento*10, incremento*10);
      pg.g.popStyle();
  /*  if (!representado) {
      pg.g.pushStyle();
      pg.g.noStroke();
      pg.g.fill(c, tonito);
      int incremento=(usuarios.size()+7);
      pg.g.ellipse(particle.x, particle.y, incremento*10, incremento*10);
      pg.g.popStyle();
    }
    if (tonito<limite ) {
      tonito+=1;
  
    }
    else {
      representado=true;
    }
    */
  }
}

