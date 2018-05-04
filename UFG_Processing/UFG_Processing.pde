int i, j; 
float Tinggi;
float Sudut;
int Jarak1;
int Jarak2;
float BurungX;
float BurungY;
float RumputX;
String DataIn;

float [] AwanX = new float[6];
float [] AwanY = new float[6];

PImage Awan;
PImage Burung;
PImage Pesawat;
PImage Rumput;

import processing.serial.*; 
Serial myPort;    

void setup() {
    myPort = new Serial(this, Serial.list()[0], 9600);
    // change '[0]' with '[Arduino_port_on_Processing]'! 
    myPort.bufferUntil(10);
    frameRate(30); 
    size(800, 600);
    rectMode(CORNERS); 
    noCursor();
    textSize(16);
    Tinggi = 300;
    Awan = loadImage("awan.png");
    Burung = loadImage("burung.png");
    Pesawat = loadImage("pesawatku.png");
    Rumput = loadImage("rumput.png");
    for (int i = 1; i <= 5; i = i+1) {
        AwanX[i]=random(1000);
        AwanY[i]=random(400);
    }
}

void serialEvent(Serial p) { 
    DataIn = p.readString(); 
    Jarak2 = int(trim(DataIn));
    println(Jarak2);
    if (Jarak2 > 1  && Jarak2 < 100) {
        Jarak1 = Jarak2;
    }
}

void draw() {
    background(0, 0, 0);
    Ciel();
    fill(5, 72, 0);
    for (int i = -2; i <= 4; i = i+1) {
        image(Rumput, 224*i  + RumputX, 550, 224, 58);
    }
    RumputX = RumputX - cos(radians(Sudut)) * 10;
    if (RumputX < -224) {
        RumputX = 224;
    }
    text(Sudut, 10, 30);
    text(Tinggi, 10, 60); 
    Sudut = (18- Jarak1) * 4;
    Tinggi = Tinggi + sin(radians(Sudut)) * 10;
    if (Tinggi < 0) {
        Tinggi=0;
    }
    if (Tinggi > 600) {
        Tinggi=600;
    }
    TraceAvion(Tinggi, Sudut);
    BurungX = BurungX - cos(radians(Sudut))*10;
    if (BurungX < -30) {
        BurungX=900;
        BurungY = random(600);
    }
    for  (int i = 1; i <= 5; i = i+1) {
        AwanX[i] = AwanX[i] - cos(radians(Sudut))*(10+2*i);
        image(Awan, AwanX[i], AwanY[i], 300, 200);
        if (AwanX[i] < -300) {
            AwanX[i]=1000;
            AwanY[i] = random(400);
        }
    }
    image(Burung, BurungX, BurungY, 72, 46);
}

void Ciel() {
    noStroke();
    rectMode(CORNERS);
    for  (int i = 1; i < 600; i = i+10) {
        fill( 49    +i*0.165, 118   +i*0.118, 181  + i*0.075   );
        rect(0, i, 800, i+10);
    }
}

void TraceAvion(float Y, float SudutInklinasi) {
    noStroke();
    pushMatrix();
    translate(400, Y);
    rotate(radians(SudutInklinasi));
    scale(0.5);
    image(Pesawat, -111, -55, 400, 196);
    popMatrix();
}