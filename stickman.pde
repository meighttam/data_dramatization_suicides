/* Ten plik zawiera klasy oraz funkcję, które są odpowiedzialne za animację naszych ludzików*/


/* Klasa Stickman tworzy poruszającego się patyczkowego ludzika.
Zawiera w sobie klasy odpowiadające ze kolano, stopę, rękę i łokieć. 
W/w klasy mają utworzoną metodę move(), która odpowiada za animację ruchu.
Klasa Stickman ma metodę stickman(), która odpowiada za generowanie całości.
Kod pobrany z https://gist.github.com/geotheory/5373003 */

class Stickman {
  int start = int(random(360));
  float t, tk, tf0, tf1, tw;
  float unit = 5; // Zmniejszenie jednostkowej wartości
  Knee[] knees = new Knee[2];
  Foot[] feet = new Foot[2];
  Elbow[] elbows = new Elbow[2];
  Hand[] hands = new Hand[2];
  
  
  
  Stickman(float UNIT) {
    for (int i=0; i<2; i++) {
      knees[i] = new Knee(i);
      feet[i] = new Foot(i);
      elbows[i] = new Elbow(i);
      hands[i] = new Hand(i);
    }
    unit = UNIT;
  }

  void stickman() {
    
    strokeWeight(2);
    fill(255);
    stroke(255);
    t = (frameCount + start) % 360;
    tk = sin(radians(t * 8));
    tf0 = sin(radians((t + 12) * 8));
    tf1 = sin(radians((t - 12) * 8));
    tw = sin(radians((t + 82) * 16));
    
    pushMatrix();
    translate(0, tw*0.1);
    pushMatrix();
    translate(0, -unit * 4.5);
    ellipse(0, 0, unit, unit);
    translate(0, unit * 0.5);
    for (Elbow e : elbows) e.move();
    line(0, 0, 0, unit * 1.7);
    translate(0, unit * 1.7);
    for (Knee k : knees) k.move();
    popMatrix();
    popMatrix();
    strokeWeight(1);
  }

  class Knee {
    int id, dir;
    PVector p = new PVector();

    Knee(int i) {
      id = i;
      if (i == 0) dir = 1;
      else dir = -1;
    }

    void move() {
      float angle = dir * radians(30 * tk);
      pushMatrix();
      rotate(angle);
      line(0, 0, 0, unit * 1.15);
      translate(0, unit * 1.15);
      feet[id].move();
      popMatrix();
    }
  }

  class Foot {
    float angle;
    int dir;
    PVector p = new PVector();

    Foot(int i) {
      if (i == 0) dir = 1;
      else dir = -1;
    }

    void move() {
      if (dir == -1) angle = radians(30 * tf0 + 25);
      else angle = radians(30 * tf1 + 25);
      pushMatrix();
      rotate(angle);
      line(0, 0, 0, unit * 1.15);
      popMatrix();
    }
  }

  class Elbow {
    int id, dir;
    PVector p = new PVector();

    Elbow(int i) {
      id = i;
      if (i == 0) dir = 1;
      else dir = -1;
    }

    void move() {
      float angle = -dir * radians(30 * tk);
      pushMatrix();
      rotate(angle);
      line(0, 0, 0, unit * 1.1);
      translate(0, unit * 1.1);
      hands[id].move();
      popMatrix();
    }
  }

  class Hand {
    float angle;
    int dir;
    PVector p = new PVector();

    Hand(int i) {
      if (i == 0) dir = 1;
      else dir = -1;
    }

  void move() {
    float angleOffset = -radians(30 * sin(radians(frameCount * 8))); // Zmiana kąta w zależności od czasu
    float angle = dir * (angleOffset + 25);
    pushMatrix();
    rotate(angle);
    line(0, 0, 0, unit * 1.1);
    popMatrix();
    }
  }
}


/* Klasa stickman2 odpowiada za utworzenie prostego, statycznego patyczkowego ludzika.
W funkcji odpowiadajcej za ruch jest rotowany i w efekcie ma symulować spadającego ludzika. */
class stickman2 {
  float unit = 5;

  stickman2(float UNIT) {
    unit = UNIT;
  }

  void drawstickman2() {
   
    strokeWeight(2);
    fill(255);
    stroke(255);

    // Głowa
    ellipse(0, 0, unit, unit);

    // Ciało
    line(0, -unit / 2, 0, -unit * 2.2);

    // Ręce
    line(0, -unit / 1.5, -unit * 1.8, -unit * 0.9); 
    line(0, -unit / 1.5, unit * 1.8, -unit * 0.9);  

    // Nogi
    line(0, -unit * 2.2, -unit / 2, -unit * 4.5); 
    line(0, -unit * 2.2, unit / 2, -unit * 4.5);  

    strokeWeight(1);
  }
}


/* Funkcja stickman_move odpowiada za animację poruszania się po ekranie. 
W zależności od pozycji, na której znajduje się ludzik wykonuje określone czynności, 
tzn, przesunięcie o określoną pozycję, zaaktualizoawanie bieżącej pozycji i ewentualnie rotację ludzika.
Zwraca tablicę, w której mamy aktualne współrzędne dla naszego ludzika */
int[] stickman_move(int index, int verticalPosition, int horizontalPosition){
  
  int verticalPos = verticalPosition;
  int horizontalPos = horizontalPosition;
  
  pushMatrix();
  // Stickman dochodzi do słupka
  if (horizontalPos < X[index] - 10){
    translate(horizontalPos, Y[index]);
    horizontalPos++;
    Stanley.stickman();
  }
  
  // Stickman wchodzi na słupek
  if (horizontalPos >= X[index] - 10  && horizontalPos < X[index] + 12 && verticalPos >= Y[index] - Heights[index]-1) {
    verticalPos = verticalPos - 1;
    translate(horizontalPos+7, verticalPos);
    rotate(radians(270));
    Stanley.stickman();
  }
  
  // Stickman idzie po słupku
  if (horizontalPos >= X[index] - 10 && horizontalPos < X[index] + 12 && verticalPos <= Y[index] - Heights[index]-2){
    horizontalPos++;
    translate(horizontalPos, Y[index] - Heights[index]-2);
    Stanley.stickman();
  }
  
  // Stickman skacze
  if (horizontalPos >= X[index] + 10 && verticalPos < Y[index]){ 
    verticalPos = verticalPos + 1;
    translate(horizontalPos+28, verticalPos);
    rotate(radians(270));
    Stanley2.drawstickman2();
  }
 
  popMatrix();
  
  int[] arr = {verticalPos, horizontalPos};
  return arr;
}
