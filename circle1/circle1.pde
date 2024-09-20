int nc = 40; // number of circles
float[] cx = new float[nc]; // tömbök, fiókos szekrény
float[] vx = new float[nc];
float[] cy = new float[nc];
float[] vy = new float[nc];

void setup()
{
   size(800,600);
   surface.setResizable(true);
   for(int i = 0; i < nc; i = i + 1)
   {
   cx[i] = width / 2;
   cy[i] = height / 2;
   vx[i] = round(random(1,15));
   vy[i] = round(random(1,13));
   }
}

void draw()
{
  background(color(0,0,0));
  for(int i = 0; i < nc; i = i + 1)
   {
      println(cy[i]);
      circle(cx[i], cy[i], 40);
      cx[i] = cx[i] + vx[i];
      cy[i] = cy[i] + vy[i];
      if(cx[i] > width || cx[i] < 0) vx[i] = vx[i] * -1;
      if(cy[i] > height || cy[i] < 0) vy[i] = vy[i] * -1;
   }
  
}
