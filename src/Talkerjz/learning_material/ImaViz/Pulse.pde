/*
 * Pulse extends CircleWave to create a linked list for the pulsar animation
 */
class Pulse extends CircleWave 
{
	
	
	//Fade speed
	protected final int FADE = 25;
	
	//Expand speed
	protected final int EXPAND = 35;
	
	//Parent
	public Pulse parent = null;
	
	//Color values
	protected int _red = 255;
	protected int _blue = 255;
	protected int _green = 255;
	protected int _alpha = 255;
	
	//Wave data
	protected float[] _wave;
	
	//Constructor
	public Pulse(float x, float y, float w, float h, float multiplier, float[] wave, int r, int g, int b)
	{
		//Call the parent construct with no color
		super(x, y, w, h, multiplier, color(0));
		
		//Set properties
		_wave = wave;
		_red = r;
		_green = g;
		_blue = b;
		
		//Assign step
		_step = 8; //Much bigger than circle wave normally, do to recursive functionality and more than 3 waves in the animation at any frame
	}
	
	//Method to return current alpha
	public int alpha()
	{
		return _alpha;
	}
	
	//Draw method
	void draw()
	{
	
		//Set the forground color
		_foreground = color(_red, _green, _blue, _alpha);
	
		//If the pulse has a parent
		if(parent != null) {
		
			//Draw the parent
			parent.draw();
			
			//If the parent is now invisible, delete it
			if(parent.alpha() <= 0)
				parent = null;
		}

		//Draw the wave form
		super.draw(_wave);		
		
		//Increase width and height. And decrease alpha
		_width += EXPAND;
		_height += EXPAND;
		_alpha -= FADE;
		
	}
	
}
