/*
 * Torrent Visualization - Uses particles alongside a linked list to create an explosion of particles based on the sound wave
 */
 
class Torrent extends Visualization
{
	//Root element
	protected TorrentPulse _root = null;
	
	//Attributes for color, size and position
	int[][] _colors;
	int _x, _y, _width, _height;
	
	//Constructor
	public Torrent(int x, int y, int w, int h, int[][] c)
	{
		//Assign properties
		_x = x;
		_y = y;
		_width = w;
		_height = h;
		_colors = c;
	}
	
	//Draw method
	public void draw(float[] left, float[] right, float[] mix, float left_level, float right_level, float mix_level)
	{
		//Create a new torrent pulse element
		TorrentPulse n = new TorrentPulse(mix, left_level, right_level, _x, _y, _width, _height, _colors);
		//Set the parent of the new pulse to the current top item
		n.parent = _root;
		
		//Set the root item to the new pulse
		_root = n;
		
		//Enable smoothing
		smooth();
		
		//Draw the elements
		_root.draw();
		
		//Disable smoothing
		noSmooth();
		
	}
	
	//Reset method
	public void reset()
	{
		//Reset the stack to one empty pulse
		float[] mix = new float[BUFFER_SIZE];
		_root = new TorrentPulse(mix, 0, 0, _x, _y, _width, _height, _colors);
	}
}
