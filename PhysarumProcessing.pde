
ArrayList<Particle> particles = new ArrayList<Particle>();
Foodmap foodmap;
Boolean recording = false;
int count = 50000;
String timestamp = year()+month()+day()+"-"+hour()+minute()+second();

void setup(){
    size(600,600,FX2D);
    //fullScreen(1);
    colorMode(RGB, 1);
    foodmap = new Foodmap(width, height);
    for (int i = 0; i < count; ++i) {
        Particle p = new Particle(particles);
        PVector newPos = new PVector(random(width),random(height));
        p.setMass(100.0);
        p.setLoc(newPos);
        particles.add(p);
    }
}

void draw(){
    //flood();
    //background(0);
    foodmap.update().draw();
    for (int i = 0; i < particles.size(); ++i) {
        particles.get(i).update();
    }
    record();
}

//Fill the Background
void flood(){
    fill(0,.01);
    noStroke();
    rectMode(LEFT);
    rect(0,0, width, height);
}

// Some code for recording screenshots
void keyPressed(){
    if(key == 'r' || key == 'R'){
        recording = !recording;
    }
}

void record(){
    if(recording == true){
        saveFrame("output_"+timestamp+"/slime_mold_####.png");
    }
    if(frameCount == 900){
        exit();
    }
}
