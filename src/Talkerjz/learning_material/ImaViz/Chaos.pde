/*
 * Chaos Visualization - Uses the sierpinski triangle fractal algorithm alongside a linked list to generate a visualization
 */
class Chaos extends Visualization 
{
	//Maximum iterations the algorithm can run
	protected final int MAX_ITERATIONS = 4;
	
	//Properties for size, position and color
	protected int[][] _colors;
	protected int _x, _y, _width, _height;
	
	//Used to track the color to use
	protected int _count = 0;
	
	//Reference to the top of the stack
	protected ChaosPulse _root;
	
	//Constructor
	public Chaos(int x, int y, int w, int h, int[][] c)
	{
		//Set properties
		_x = x;
		_y = y;
		_width = w;
		_height = h;
		_colors = c;
	}
	
	//Draw method
	public void draw(float[] left, float[] right, float[] mix, float left_level, float right_level, float mix_level)
	{
		//Get the amount of interations based on the mix level
		int iterations = (int)(2 + mix_level * MAX_ITERATIONS);
		//Ensure the interations does not go over the max
		if(iterations > MAX_ITERATIONS) iterations = MAX_ITERATIONS;
		
		
		//Determine the size based on the left channel
		int w = (int)(_width * (left_level + 0.5));
		int h = (int)(_height * (left_level + 0.5));
		//Determine the rotation based on the right level
		float a = (TWO_PI * (right_level * 2.5));
		
		//Ensure the size does not extend past the total size of the visualization
		w = w > _width ? _width : w;
		h = h > _height ? _height : h;
		
		//Increment count and ensure it does not go out of bounds
		_count = (_count + 1) % _colors.length;			
		
		//Create a new stack element
		ChaosPulse t = new ChaosPulse(_x, _y, w, h, _colors[_count], iterations, a);
		
		//Set the parent of the new element to the current root
		t.parent = _root;
		
		//Re-assign the root
		_root = t;

		//Draw the root, and all other elements in the stack
		_root.draw();
		
	}
	
	//Reset method
	public void reset()
	{	
		//Reset the stack to one element
		_root = new ChaosPulse(_x, _y, _width / 2, _height / 2, _colors[0], 2, 0);
	}
	
}
