/* W tym pliku mamy funkcje, które są odpowiedzialne za tworzenie 
i manipulowanie wartościami słupków statystycznych 
oraz za pracę na współrzędnych, w których się znajdują */

//Ta funkcja odpowiedzialna jest za zmapowanie słupków w odpowiednich koordynatach na odpowiednią wysokość
void draw_coordinates() {
  clearCanvas();
  int rowCount = our_data.getRowCount();
  
  for (int i = 0; i < rowCount - 2; i++) {
    int x = our_data.getInt(i, "x");
    int y = our_data.getInt(i, "y");
    int population = our_data.getInt(i, str(selected_year));
    
    
    int targetHeight = (int) map(population, 0, 800, 0, 200); 
    
   
    if (currentHeights[i] < targetHeight) {
      currentHeights[i] += 1; 
    }
    
      fill(50);
      noStroke();
      ellipse(x + 5, y, circle_diameter + 5, circle_diameter-2);
      fill(136, 8, 8);
      rect(x, y - currentHeights[i], 10, currentHeights[i]);
      fill(255);
      textSize(12);
      textAlign(CENTER);
      text(population, x-9, y - currentHeights[i]-4);
  }
}


/* Ta funkcja oraz następna to funkcje pomocnicze, które pomagają ustalić wysokość 5 najwyższych słupków
oraz indeks 5 miast, dla których te słupki powinny zostać wyrysowane.
Ma zastosowanie przy zmianie roku - nie zawsze liczba samobójstw jest taka sama dla tych samych miast.

Funkcja choose_the_highest_coordinates() wywołuje funkcję findTop5Heights(), 
a następnie zwraca nam tablicę z tablicami przechowującymi współrzędne na osi X, na osi Y oraz wysokość słupków.

Funkcja findTop5Heights() wykorzystuje algorytm porównywania liczb i zamienia wartości tak, 
aby największe znajdowały się w 5-elementowej tablicy. 
Funkcja zwaraca tablicę z tablicami zawierającymi największe wysokości oraz indeksy miast, 
dla których te wartości zostały zapisane.
*/
int[][] choose_the_highest_coordinates(){
  int[] X = new int[5];
  int[] Y = new int[5];
  int[] Heights = new int[5];
    
 int[][] array = findTop5Heights();
 
 int[] harr = array[0];
  for (int i = 0; i < 5; i++){
    Heights[i] = harr[i];
  }
  
  int[] indexes = array[1];
    for (int i = 0; i < indexes.length; i++) {
      int rowIndex = indexes[i];
      if (rowIndex < our_data.getRowCount()) {
        TableRow row = our_data.getRow(rowIndex);
        int x = row.getInt("x");
        int y = row.getInt("y");
        X[i] = x;
        Y[i] = y;
      } else {
        println("Index " + rowIndex + " is out of range.");
      }
  }
  
  int[][] highestCoordinates = {X,Y, Heights};
 
  return highestCoordinates;
}


int[][] findTop5Heights() {
  
  int rowCount = our_data.getRowCount();
  int[] top5Heights = new int[5];
  int[] top5Indexes = new int[5];
  
   for (int i = 0; i < 5; i++) {
      top5Heights[i] = 0;
      top5Indexes[i] = -1;
    }
  
  for (int i = 0; i < rowCount - 2; i++) {
      int population = our_data.getInt(i, str(selected_year));
      int targetHeight = (int) map(population, 0, 800, 0, 200);
  
      for (int j = 0; j < 5; j++) {
        if (targetHeight > top5Heights[j]) {
          // Aktualizacja wartości i indeksu
          for (int k = 4; k > j; k--) {
            top5Heights[k] = top5Heights[k - 1];
            top5Indexes[k] = top5Indexes[k - 1];
          }
          top5Heights[j] = targetHeight;
          top5Indexes[j] = i;
          break;
        }
      }
    }
  
    int[][] top5Array = {top5Heights, top5Indexes};
  
    return top5Array;
  }
  
/* Funkcja clear_settings() aktualizuje nam dane dla aktualneie wybranego roku
i zeruje ustawienia pozycji, na których znajdują się nasze ludziki,
aby po zmianie roku animacja zaczęła się od nowa. */

void clear_settings(){
  highestCoordinates = choose_the_highest_coordinates();
  X = highestCoordinates[0];
  Y = highestCoordinates[1];
  Heights = highestCoordinates[2];
  verticalPos1 = Y[0];
  verticalPos2 = Y[1];
  verticalPos3 = Y[2];
  verticalPos4 = Y[3];
  verticalPos5 = Y[4]; 
  horizontalPos1 = 0;
  horizontalPos2 = 0;
  horizontalPos3 = 0;
  horizontalPos4 = 0;
  horizontalPos5 = 0;
}
