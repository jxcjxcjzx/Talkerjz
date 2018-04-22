/*
 * ChaosPulse - Used as a list element for the Chaos visualization
 */
class ChaosPulse
{

	//Constants for animation and drawing
	protected final int ALPHA_STEP = 25;
	protected final int TOP_ALPHA = 255;
	protected final int STROKE_WEIGHT = 2;
	protected final boolean GLOBAL_ROTATE = false; //Determines if the entire sierpinski triangle is rotated, or the lowest level triangles
	
	//Variables to determine the amount of width/height to increase by per frame
	protected float _w_step, _h_step;

	//Properties for color, size, alpha, iterations and rotation
	protected int[] _c;
	protected int _x, _y, _width, _height, _final_h, _final_w, _iter, _alpha = TOP_ALPHA;
	protected float _angle;
	
	//Parent element in the stack
	public ChaosPulse parent;
	
	//Constructor
	public ChaosPulse(int x, int y, int w, int h, int[] c, int i, float a)
	{
		//Assign properties
		_x = x;
		_y = y;
		_width = w / 4;
		_height = h / 4;
		_final_h = h;
		_final_w = w;
		_angle = a;
		_c = c;
		_iter = i;
		
		//Determine the size step values
		_w_step = (_final_w - _width) / ceil(TOP_ALPHA / ALPHA_STEP);
		_h_step = (_final_h - _height) / ceil(TOP_ALPHA / ALPHA_STEP);
		
		
	}
	
	//Method to return the alpha
	public int alpha()
	{
		return _alpha;
	}
	
	//Draw method
	public void draw()
	{
		
		//If the item has a parent in the stack, draw that first
		if(parent != null) 
		{
			parent.draw();
			
			//If the parent is now invisible remove from stack to free memory
			if(parent.alpha() <= 0)
				parent = null;
			
		}
	
		//Set the stroke color and weight, and remove fill
		stroke(_c[0], _c[1], _c[2], _alpha);
		noFill();
		strokeWeight(STROKE_WEIGHT);
		
		//Store original transformation
		pushMatrix();
		
		//Set the position as 0,0
		translate(_x, _y);
		
		//Rotate now if the entire triangle is to be rotated
		if(GLOBAL_ROTATE) rotate(_angle);
		
		//Call the recursive fractal method
		drawTri(0, 0, _width, _height, _iter);
		
		//Restore original transformation
		popMatrix();
		
		//Increase alpha and size
		_width += _w_step;
		_height += _h_step;
		_alpha -= ALPHA_STEP;
	}
	
	//Recursive sierpinski triangle fractal method
	protected void drawTri(int x, int y, int width, int height, int iter)
	{
		//If at the final stage of iteration
		if(iter == 0) {
			//Store the transformation
			pushMatrix();
			//Center of the triangle is 0,0
			translate(x, y);
			//Rotate now if the lowest level triangles are to be rotated
			if(!GLOBAL_ROTATE) rotate(_angle);
			//Draw a triangle
			triangle(0, -height / 2, width / 2, height / 2, -width / 2, height / 2);
			//Restore the transformation
			popMatrix();
			//Exit out of recursion
			return;
		}
				
		//If recursion are still left, draw 3 inner triangles and supply the iteration minus 1
		drawTri(x, y - height / 4 , width / 2, height / 2, iter - 1);
		drawTri(x + height / 4,  y + height / 4, width / 2, height / 2, iter - 1);
		drawTri(x - height / 4, y+ height / 4, width / 2, height / 2, iter - 1);	
		
	}
	
	
}
