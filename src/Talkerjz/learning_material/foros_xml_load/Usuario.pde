class Usuario implements Visualizable{
  int id;
  String nombre;
  String mail;
  Equipo equipo;

  boolean representado;
  VerletParticle2D particle;

  public Usuario(int _id, String _nombre, String _mail, Equipo _e) {
    this.equipo=_e;
    this.id=_id;
    this.nombre=_nombre;
    this.mail=_mail;
  }
  List<Comentario> comentarios=new ArrayList();
  public void addComentario(Comentario c) {
    comentarios.add(c);
  }
  void pinta(Capa pg) {
   pg.g.pushStyle();
    pg.g.noStroke();
        pg.g.fill(hue(equipo.c),70,70);
    int incremento=(comentarios.size()+1);

    pg.g.ellipse(particle.x, particle.y, incremento*20, incremento*20);
    pg.g.popStyle();

     /* if(!representado){
    pg.g.pushStyle();
    pg.g.noStroke();
    pg.g.fill(equipo.c, tonito);
          int incremento=(comentarios.size()+1);

    pg.g.ellipse(x, y, incremento*20, incremento*20);
    pg.g.popStyle();
    }
    if (tonito<limite) {
      tonito+=1;
    } else {
      representado=true;
    }
    */
  
  }
  int inicio=10;
  int limite=17;
  float tonito=inicio;

  void repinta(Capa pg) {

    reset(pg,14);

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
}

