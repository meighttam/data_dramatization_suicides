// Grupa Suicide
// Członkowie: Grudnik Jan, Opalińska Wiktoria, Opar Kamil, Tambor Maksymilian
// Lider: Wiktoria Opalińska
// Zestaw Danych: Dane dotyczące samobójstw

/* Projekt - Naniesienie współrzędnych miast wojewódzkich na zdramatyzowaną mapę Polski, 
animacja ludzików podchodzących do wyrastających słupków statystycznych,
a następnie z nich skaczących przy akompaniamencie Chopina */

/* Podział obowiązków (dosyć płynny, więc będzie przybliżony)
- GUI - Kamil;
- Funkcje odpowiedzialne za rysowanie słupków i pobieranie wysokości/indeksów - Maksymilian;
- Animacja ludzika - Jan i Wiktoria;
- Czyszczenie ekranu - Jan;
- Koordynacja działań, sklejanie kodu, podział na pliki i pomaganie przy problemach z kodem - Wiktoria*/

void setup() {
  size(1200, 900);
  frameRate(100);
  
  music = new SoundFile(this, "bg_music.mp3"); 
  music.loop();
  
  // Setup lewa część ekranu
  img = loadImage("bg_map.png");
  image(img, 0,0, 950,950);
  our_data = loadTable("miasta-lata.csv", "header");
  
  grnd = height-20;
  Stanley = new Stickman(5); 
  Stanley2 = new stickman2(5);
  
  highestCoordinates = choose_the_highest_coordinates();
  X = highestCoordinates[0];
  Y = highestCoordinates[1];
  Heights = highestCoordinates[2];
  verticalPos1 = Y[0];
  verticalPos2 = Y[1];
  verticalPos3 = Y[2];
  verticalPos4 = Y[3];
  verticalPos5 = Y[4]; 
  
  // Setup prawa część ekranu  
  GUI_setup();
}


/* W funkcji draw():
- wyrysowujemy współrzędne naszych miast i słupki w tych miejscach
- tworzymy 5 ludzików dla najwyższych słupków
- wywołujemy funkcję odpowiedzialną za ich animację,
- następnie aktualizujemy pozycję ludzików na ekranie */

void draw(){
  
  draw_coordinates();
  
   
  int[] arr1 = stickman_move(0, verticalPos1, horizontalPos1);
  verticalPos1 = arr1[0];
  horizontalPos1 = arr1[1];
  
  int[] arr2 = stickman_move(1, verticalPos2, horizontalPos2);
  verticalPos2 = arr2[0];
  horizontalPos2 = arr2[1];
  
  int[] arr3 = stickman_move(2, verticalPos3, horizontalPos3);
  verticalPos3 = arr3[0];
  horizontalPos3 = arr3[1];
  
  int[] arr4 = stickman_move(3, verticalPos4, horizontalPos4);
  verticalPos4 = arr4[0];
  horizontalPos4 = arr4[1];
  
  int[] arr5 = stickman_move(4, verticalPos5, horizontalPos5);
  verticalPos5 = arr5[0];
  horizontalPos5 = arr5[1];
}


// Funkcja odpowiedzialna za czyszczenie ekranu, aby animacje się nie nadpisywały
void clearCanvas() {
  image(img, 0,0, 950, 950);
  fill(0);
  rect(900, 0, 300, 900);
}
