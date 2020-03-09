class Particle{

    PVector loc,
        prevLoc,
        velocity,
        acceleration;
    Float mass,
        rot,
        sensorRot = 15.0,
        rotMult = 2.0,
        sensorDist = 25.0;
    int margin = 10;
    ArrayList<Particle> family;
    Sensor[] sensors = new Sensor[3];
    
    // Initalize Object
    Particle(ArrayList<Particle> family){
        this.loc = new PVector(random(width), random(height));
        this.prevLoc = new PVector(random(width), random(height));
        this.velocity = new PVector(0,0);
        this.acceleration = new PVector(0,0);
        this.rot = radians(random(360));
        this.mass = 0.0;
        this.family = family;
        this.sensors[0] = new Sensor(this.loc, this.sensorDist, this.rot);
        this.sensors[1] = new Sensor(this.loc, this.sensorDist, this.rot+radians(this.sensorRot));
        this.sensors[2] = new Sensor(this.loc, this.sensorDist, this.rot-radians(this.sensorRot));
    }
    
    Particle update(){
        if(frameCount > 1 ) this.prevLoc = this.loc.copy();
        this.acceleration.normalize();
        this.velocity.add(this.acceleration);
        this.velocity.normalize();
        this.loc.add(this.velocity);
        this.acceleration.mult(0);
        this.correctLoc();
        this.calcRot();
        this.sensors[0].update(this.loc, this.rot);
        this.sensors[1].update(this.loc, this.rot+radians(this.sensorRot));
        this.sensors[2].update(this.loc, this.rot-radians(this.sensorRot));
        this.forage(sensors[0], sensors[1], sensors[2]);
        this.deposit();
        return this;
    }

    Particle forage(Sensor a, Sensor b, Sensor c){
        float valA = a.val; // Middle
        float valB = b.val; // Right
        float valC = c.val; // Left
        PVector force = PVector.sub(loc, prevLoc);
        if(valA > valB && valA > valC){
            // No Change
        } else if(valB > valA && valA > valC){ // Go Right
            force.rotate(radians(this.sensorRot*this.rotMult));
        } else if(valC > valA && valA > valB) { // Go Left
            force.rotate(radians(-this.sensorRot*this.rotMult));
        } //else if(valC == valA){ // Random Rotation
            //force.rotate(radians(random(360)));
        //}
        this.applyForce(force);
        return this;
    }

    Particle deposit(){
        foodmap.map.set(int(this.loc.x), int(this.loc.y), color(1));
        return this;
    }

    Particle calcRot(){
        PVector current = PVector.sub(loc,prevLoc);
        this.rot = current.heading();
        return this;
    }
    
    Particle setLoc(PVector loc){
        this.loc = loc;
        return this;
    }
    
    Particle setAcceleration(PVector velocity){
        this.velocity = velocity;
        return this;
    }
    
    Particle setVelocity(PVector acceleration){
        this.velocity = velocity;
        return this;
    }
    
    Particle setMass(float mass){
        this.mass = mass;
        return this;
    }
    
    Particle applyForce(PVector force){
        PVector f = force.get();
        f.div(this.mass);
        this.acceleration.add(f);
        return this;
    }

    Particle correctLoc(){
        if(this.loc.x > width - this.margin){
            this.loc.x = random(width);
            this.loc.y = random(height);
        }
        if(this.loc.x < 0 + this.margin){
            this.loc.x = random(width);
            this.loc.y = random(height);
        }
        if(this.loc.y > height - this.margin){
            this.loc.x = random(width);
            this.loc.y = random(height);
        }
        if(this.loc.y < 0 + this.margin){
            this.loc.x = random(width);
            this.loc.y = random(height);
        }
        return this;
    }
    
    Particle draw(){
        this.sensors[0].draw();
        this.sensors[1].draw();
        this.sensors[2].draw();
        pushMatrix();
            translate(this.loc.x, this.loc.y);
            rotate(this.rot);
            stroke(1,0,0);
            line(0,0,10,0);
        popMatrix();
        stroke(1);
        point(this.loc.x, this.loc.y);
        return this;
    }
}
