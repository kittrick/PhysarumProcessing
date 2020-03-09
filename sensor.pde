class Sensor{

    PVector loc;
    float rot, dist;
    color val;

    Sensor(PVector loc, float dist, float rot){
        this.loc = loc;
        this.dist = dist;
        this.rot = rot;
        this.val = foodmap.map.get(int(this.loc.x), int(this.loc.y));
    }

    Sensor update(PVector loc, float rot){
        this.loc = loc;
        this.rot = rot;
        this.correctPos();
        this.correctLoc();
        this.val = foodmap.map.get(int(this.loc.x), int(this.loc.y));
        return this;
    }

    Sensor correctPos(){
        this.loc = new PVector(
            this.loc.x + this.dist*cos(this.rot),
            this.loc.y + this.dist*sin(this.rot)
        );
        return this;
    }

    Sensor setLoc(PVector loc){
        this.loc = loc;
        return this;
    }

    Sensor correctLoc(){
        if(this.loc.x > width){
            this.loc.x = 0;
        }
        if(this.loc.x < 0){
            this.loc.x = width;
        }
        if(this.loc.y > height){
            this.loc.y = 0;
        }
        if(this.loc.y < 0){
            this.loc.y = height;
        }
        return this;
    }

    Sensor setVal(color val){
        this.val = val;
        return this;
    }

    Sensor draw(){
        stroke(1);
        fill(this.val);
        rectMode(CENTER);
        rect(this.loc.x, this.loc.y, 10, 10);
        return this;
    }
}
