/* Ten plik w większości odpowiada za tworzenie i obsługę widgetów.
Wykorzystaliśmy bibliotekę ControlP5*/

/* Ta funkcja odpowiada za ustawienia początkowe dla naszych widgetów.
Tworzymy 2 etykiety odpowiedzialne za tekst wyświetlany po prawej stronie ekranu
oraz 6 przycisków odpowiadających za statystyki dla poszczególnych lat.
Przyciski nasłuchują na event i wywołują funkcję odpowiedzialną za aktualizację danych */
void GUI_setup(){
  // Setup prawa część ekranu
  rectX = 950;
  rectY = 200; 
  
  targetHeights = new int[our_data.getRowCount()];
  currentHeights = new int[our_data.getRowCount()];
 
  // Tworzymy nowe przyciski i teskt
  cp5 = new ControlP5(this);
  
  myLabel1 = cp5.addTextlabel("label")
      .setText("Statystyki ")
      .setPosition(950,50)
      .setColorValue(255)
      .setFont(createFont("Arial",32))
      ;
   myLabel1 = cp5.addTextlabel("label2")
      .setText("Samobójstw")
      .setPosition(950,90)
      .setColorValue(255)
      .setFont(createFont("Arial",32))
      ;

  
  String[] years = {"2017", "2018", "2019", "2020", "2021", "2022"};
  for (int i = 0; i < years.length; i++) {
    Button b = cp5.addButton(years[i])
       .setPosition(rectX,rectY)
       .setSize(rectSizeX,rectSizeY)
       .setValue(i)
       .addCallback(new CallbackListener() {
         public void controlEvent(CallbackEvent event) {
           if (event.getAction() == ControlP5.ACTION_RELEASED) {
             selected_year = 2017 + int(event.getController().getValue());
             updateButton();
           }
         }
       });
      
    b.setColorBackground(color(255));
    b.setColorForeground(color(255));
    b.setColorLabel(color(0));
    b.getCaptionLabel().setFont(createFont("Arial", 22));
    
    rectY = rectY + 70;
  }
  
  updateButton();
}

// Ta funkcja zmienia wygląd przycisków po naciśnięciu: czerwony - aktywny, białe - nieaktywne
void updateButton() {
  for (String year : new String[]{"2017", "2018", "2019", "2020", "2021", "2022"}) {
    Controller<?> controller = cp5.getController(year);
    if (controller instanceof Button) {
      Button button = (Button) controller;
      if (button.getValue() == selected_year - 2017) {
        button.setColorBackground(color(136, 8, 8));
        button.setColorForeground(color(255));
        button.setColorLabel(color(255));
      } else {
        button.setColorBackground(color(255));
        button.setColorForeground(color(255));
        button.setColorLabel(color(136, 8, 8));
      }
    }
  }
  
  for (int i = 0; i < currentHeights.length; i++){
    currentHeights[i] = 0;
  } 
  
  clear_settings();
}
