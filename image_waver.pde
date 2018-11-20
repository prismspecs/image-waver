PImage img;
PGraphics pg;

float scaleBy;

float theta = 0.0;
float speed = .75;
float amp = 22.0;
float waveWidth = 140.0;

int columns = 12 * 4;

void setup() {
  img = loadImage("bb2.png");

  pg = createGraphics(1728, int(648 + (amp*2)));
  size(800, 800);

  scaleBy = 800.0/2000.0;

  pg.beginDraw();
  //pg.imageMode(CENTER);
  pg.endDraw();

  //imageMode(CENTER);
}

void draw() {

  background(255);

  theta += speed;

  // draw the offset for diagnostic purposes
  for (int i = 0; i < width; i++) {
    float offset = cos(theta + i/waveWidth) * amp;
    line(i, 20 + offset, i, 20);
  }

  // figure out how big slices are
  int columnWidth = img.width / columns;

  pg.beginDraw();
  pg.background(255);
  // loop thru columns
  for (int i = 0; i < columns; i++) {
    int sx = i*columnWidth;
    int sy = 0;
    int sw = columnWidth;
    int sh = img.height;

    PImage colImg = img.get(sx, sy, sw, sh); 

    pg.pushMatrix();
    pg.translate(i*columnWidth, amp);  // use amp as offset to get full image
    //pg.scale(scaleBy);
    pg.image(colImg, 0, cos(theta + i) * amp);
    pg.popMatrix();
  }

  pg.endDraw();

  //pg.beginDraw();
  //pg.image(img, pg.width/2, pg.height/2);
  //pg.endDraw();

  imageMode(CENTER);
  translate(width/2, height/2);
  scale(scaleBy);
  image(pg, 0, 0);
}
