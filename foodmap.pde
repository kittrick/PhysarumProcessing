class Foodmap{

    PImage map;
    float blur = .02; // .02 is good
    float decay = .1; // .1 is good
    float v = 1.0 / 9.0;
    float[][] kernel = {{ v, v, v }, 
                        { v, v, v }, 
                        { v, v, v }};
    
    Foodmap(int w, int h){
        this.map = loadImage("backdrop_test.png");
        //createImage(w, h, RGB);
        // this.map.loadPixels();
        // for (int i = 0; i < this.map.pixels.length; i++) {
        //  this.map.pixels[i] = color(random(1));
        // }
        // this.map.updatePixels();
    }
    
    Foodmap update(){
        this.map.loadPixels();
        // Diffuse
        for (int y = 1; y < map.height-1; y++) {   // Skip top and bottom edges
            for (int x = 1; x < map.width-1; x++) {  // Skip left and right edges
                float sum = 0; // Kernel sum for this pixel
                for (int ky = -1; ky <= 1; ky++) {
                    for (int kx = -1; kx <= 1; kx++) {
                        // Calculate the adjacent pixel for this kernel point
                        int pos = (y + ky)*map.width + (x + kx);
                        // Image is grayscale, red/green/blue are identical
                        float val = red(map.pixels[pos]);
                        // Multiply adjacent pixels based on the kernel values
                        sum += kernel[ky+1][kx+1] * val;
                    }
                }
                // For this pixel in the new image, set the gray value
                // based on the sum from the kernel
            map.pixels[y*map.width + x] = lerpColor(color(sum),map.pixels[y*map.width + x], this.blur);
            }
        }
        // Decay
        for (int y = 0; y < map.height; y++) {
            // Decay
            for (int x = 0; x < map.width; x++) {
                map.pixels[y*map.width + x] = lerpColor(map.pixels[y*map.width + x], color(0), this.decay);
                // Draw a black circle
                // PVector pixelPoint = new PVector(x,y);
                // if(pixelPoint.dist(new PVector(width/2, height/2)) > width/2-20){
                //  map.pixels[y*map.width + x] = 0;
                // }
            }
        }

        map.updatePixels();
        return this;
    }
    
    Foodmap draw(){
        image(this.map, 0, 0, width, height);
        return this;
    }
}
