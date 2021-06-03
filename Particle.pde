// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A circular particle

class Particle {

  // We need to keep track of a Body and a radius
  Body body;
  float r;
  float n;

  color col;

  Particle(float x, float y) {
    r = 20;
    n = r/8;
    ChainShape chain = new ChainShape();

    // Make the body's shape a circle   //I neded:  Polygon shapes
    //CircleShape cs = new CircleShape();  
    //cs.m_radius = box2d.scalarPixelsToWorld(r);
    PolygonShape ps = new PolygonShape();
    
    //egg shape vertexs
    Vec2[] vertices = new Vec2[19];  // An array of 19 vectors
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(0, 20*n-r));  //coordPixelsToWorld ? vectorPixelsToWorld
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(3*n, 19.2*n-r));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(4*n, 18.5*n-r));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(5.2*n, 17*n-r));
    vertices[4] = box2d.vectorPixelsToWorld(new Vec2(6.8*n, 14*n-r));
    vertices[5] = box2d.vectorPixelsToWorld(new Vec2(8*n, 8*n-r));
    vertices[6] = box2d.vectorPixelsToWorld(new Vec2(7.2*n, 4*n-r));
    vertices[7] = box2d.vectorPixelsToWorld(new Vec2(5*n, 1.5*n-r));
    vertices[8] = box2d.vectorPixelsToWorld(new Vec2(2.5*n, 0.3*n-r));
    vertices[9] = box2d.vectorPixelsToWorld(new Vec2(0, 0-r));
    vertices[10] = box2d.vectorPixelsToWorld(new Vec2(-2.5*n, 0.3*n-r));
    vertices[11] = box2d.vectorPixelsToWorld(new Vec2(-5*n, 1.5*n-r));
    vertices[12] = box2d.vectorPixelsToWorld(new Vec2(-7.2*n, 4*n-r));
    vertices[13] = box2d.vectorPixelsToWorld(new Vec2(-8*n, 8*n-r));
    vertices[14] = box2d.vectorPixelsToWorld(new Vec2(-6.8*n, 14*n-r));
    vertices[15] = box2d.vectorPixelsToWorld(new Vec2(5.2*n, 17*n-r));
    vertices[16] = box2d.vectorPixelsToWorld(new Vec2(4*n, 18.5*n-r));
    vertices[17] = box2d.vectorPixelsToWorld(new Vec2(3*n, 19.2*n-r));
    vertices[18] = box2d.vectorPixelsToWorld(new Vec2(0, 20*n-r));
    
    
    ps.set(vertices, vertices.length);
    
    //chain.createChain(vertices, vertices.length);

    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    FixtureDef fd = new FixtureDef();
    //fd.shape = chain; //ps;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.5;       //chandable
    fd.restitution = 0.3;    //bouncing

    // Attach fixture to body
    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));

    col = color(175);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    
    //Fixture f = body.getFixtureList();
    //PolygonShape ps = (PolygonShape) f.getShape();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    noFill();
    stroke(0);
    strokeWeight(1);
    //ellipse(0,0,r*2,r*2);
    // Let's add a line so we can see the rotation
    //line(0,0,r,0);
    beginShape();
    vertex(0, 20*n-r);
    bezierVertex(5*n, 20*n-r, 8*n, 13*n-r, 8*n, 8*n-r);
    bezierVertex(8*n, 3*n-r, 5*n, 0-r, 0, 0-r);
    bezierVertex(-5*n, 0-r, -8*n, 3*n-r, -8*n, 8*n-r);
    bezierVertex(-8*n, 13*n-r, -5*n, 20*n-r, 0, 20*n-r);
    endShape();
    popMatrix();
  }
}
