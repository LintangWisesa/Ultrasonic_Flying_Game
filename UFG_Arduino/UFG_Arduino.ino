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
