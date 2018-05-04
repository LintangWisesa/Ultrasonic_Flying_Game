#

![simplinnovation](https://4.bp.blogspot.com/-f7YxPyqHAzY/WJ6VnkvE0SI/AAAAAAAADTQ/0tDQPTrVrtMAFT-q-1-3ktUQT5Il9FGdQCLcB/s350/simpLINnovation1a.png)

# Ultrasonic Flying Game

### Ultrasonic Flying Game is a simple Arduino & Processing project that visualize the value of distance from ultrasonic sensor into altitude of a plane image. First, I wanna say big thanks to _**Mr. Roux Benjamin**_ from France, for his basic instructions and fast respond replying my questions. Watch the video below ([click here](https://www.youtube.com/watch?v=O1SEshue9pY)) to see its action, then follow the instructions below to build your own Ultrasonic Flying Game!

#

[![Video Lintang Ultrasonic Flying Game](https://img.youtube.com/vi/O1SEshue9pY/0.jpg)](https://www.youtube.com/watch?v=O1SEshue9pY)

#

### **1. What You Need** :gift:
To build this project, you need the following items:
- 1 Arduino Uno board
- 1 HC-SR04 ultrasonic sensor
- 1 proto board shield or any breadboard
- some jumper wires
- Arduino IDE ([download here](https://www.arduino.cc/en/Main/Software))
- Processing IDE ([download here](https://processing.org/download/))

#

### **2. Schematics** :wrench::hammer:

Gather your parts then follow the schematics below.

![Arduino UFG schematics](https://raw.githubusercontent.com/LintangWisesa/Ultrasonic_Flying_Game/master/UFG_Schematics.png)

#

### **3. Arduino Sketch** :clipboard:

- Open Arduino IDE then copy sketch below. Make sure you have chosen the right option for **_Board_** and **_Port_** under **_Tools_** menu, then upload to your Arduino board.

   ```c++
    int echoPin = 2;
    int triggerPin = 3;
    unsigned long waktu = 0;
    unsigned jarakNow = 0;
    unsigned jarakOld = 0;

    void setup (){
        pinMode (echoPin, INPUT);
        pinMode (triggerPin, OUTPUT);
        Serial.begin(9600);  
    }

    void loop(){
        digitalWrite(triggerPin, LOW);
        delayMicroseconds(100);
        digitalWrite(triggerPin, HIGH);
        delayMicroseconds(100);
        digitalWrite(triggerPin, LOW);
        waktu = pulseIn(echoPin, HIGH);
        jarakNow = waktu / 58;
        delay(10);
        if (jarakOld != jarakNow) {
            Serial.println(jarakNow); 
            jarakOld = jarakNow;
        }
        delay(50); 
    } 
   ```

#

### **4. Processing Sketch** :memo:

- After Arduino sketch uploaded to your Arduino board, open Processing IDE then copy sketch below. Before you run this code, pay attention to this line:

   ```java
   myPort = new Serial(this, Serial.list()[0], 9600);
   ```

- Edit ```java'[0]'``` with ```java[your__port]```. Read on Processing documentation to know how to find the right corresponding port. Then run sketch below.

   ```java
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
   ```

#

### **5. Have Fun!** :joy:
- If everything goes well, now you can control the plane's altitude by set our hand's above the ultrasonic sensor. Enjoy!

#

#### Lintang Wisesa :love_letter: _lintangwisesa@ymail.com_

[Facebook](https://www.facebook.com/lintangbagus) | 
[Twitter](https://twitter.com/Lintang_Wisesa) |
[Google+](https://plus.google.com/u/0/+LintangWisesa1) |
[Youtube](https://www.youtube.com/user/lintangbagus) | 
:octocat: [GitHub](https://github.com/LintangWisesa) |
[Hackster](https://www.hackster.io/lintangwisesa)

