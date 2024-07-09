/* Aby zachować lepszą przejrzystość kodu, utworzyliśmy plik, 
który przechowuje importy i inicjalizuje zmienne.
Niekóre zmienne deklarujemy już na tym etapie */

// Importy
import processing.sound.*;
import controlP5.*;

// Muzyka
SoundFile music;

// Objekty i widgety GUI
PImage img; 
PShape kontur;
Table our_data;
ControlP5 cp5;
Textlabel myLabel1;
Textlabel myLabel2;
Stickman Stanley;
stickman2 Stanley2;

// Zmienne i i tablice
int frameCounter = 0;
int rectX, rectY;
int rectSizeX = 200;
int rectSizeY = 40;
int circle_diameter = 14;
int selected_year = 2017;
int[] targetHeights; 
int[] currentHeights;
int[][] highestCoordinates;
int[] X;
int[] Y;
int[] Heights;
int grnd;
int verticalPos1;
int verticalPos2;
int verticalPos3;
int verticalPos4;
int verticalPos5;
int horizontalPos1 = 0;
int horizontalPos2 = 0;
int horizontalPos3 = 0;
int horizontalPos4 = 0;
int horizontalPos5 = 0;
