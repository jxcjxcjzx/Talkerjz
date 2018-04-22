/*
 * Ima visualization - Produces a looping slideshow of images, who's filter values are determined by the left, right and mix channels. Each new image is faded in
 */
class Ima extends Visualization 
{
	//Constants for the seconds to display each image for, and amount of alpha to fade in
	protected final int SLIDE_DELAY = 7;
	protected final int ALPHA_STEP = 20;
	
	//Property for the image playlist
	protected Playlist _images;
	
	//Properties for size and position
	protected int _x, _y, _width, _height;
	
	//Top and bottom PImage variables
	protected PImage _top, _bottom;
	
	//Url for the top and bottom images
	protected String _top_url, _bottom_url;
	
	//Boolean to say if the top image is to be faded
	protected boolean _fade_top = false;
	
	//Properties for the alpha value of the top image, and a counter to check the amount of seconds passed by
	protected int _top_alpha = 0, _counter = 0;
	
	//Boolean to determine if a fatal error occurred
	protected boolean _fatal_error = false;
	//Counter of invalid images
	protected int _invalid_images = 0;
	
	//Constructor
	public Ima(int x, int y, int w, int h, Playlist images)
	{
		//Assign properties
		_x = x;
		_y = y;
		_width = w;
		_height = h;		
		_images = images;
		
		
		//If the playlist was errornous
		if(_images.fatalError()) 
		{
			//A fatal error occurred
			_fatal_error = true;
		}
		else 
		{
			//Get the url of the first image
			_bottom_url = _images.get(0);
			
			//Whilst the bottom image is invalid
			while(!validateImage(_bottom_url)) 
			{
				//Increase the invalid counter
				_invalid_images++;
				
				//If all images are invalid
				if(_invalid_images == _images.size())
				{
					//A fatal error occurred and break from loop
					_fatal_error = true;
					println("No valid image files");
					break;
				}
				
				//Try to get the next image
				_bottom_url = _images.next();
			}
			
			//If a fatal error occurred or the playlist had an error
			if(_fatal_error || _images.fatalError())
			{
				//A fatal error occurred - Used because of checking the playlist message
				_fatal_error = true;
			}
			else
			{
				//Load the next image url into the top
				_top_url = _images.next();
				//Load images
				load();
			}
			
		}
		
	}
	
	//Draw method
	public void draw(float[] left, float[] right, float[] mix, float left_level, float right_level, float mix_level)
	{
		//If a fatal error occurred, just show an error message
		if(_fatal_error)
		{
			textFont(g_title_font, 32);
			fill(150);
			textAlign(CENTER);
			text("Could not load images", _x, _y);
		}
		else
		{
			//If the next image needs to be shown - the !_fade_top test will prevent uncessary processing
			if(!_fade_top && (int)(_counter / frameRate) == SLIDE_DELAY)
			{
				//Start to fade in
				_fade_top = true;
				
			}
			
			//If the top image needs to be faded in
			if(_fade_top)
			{
				//Increase alpha of top image
				_top_alpha += ALPHA_STEP;
			}
			
			//Set images to draw in the center
			imageMode(CENTER);			
			
			//Grab the red, green and blue channels for the filter based on the channels
			float r = 100 + left_level * 255;
			if(r > 255) r = 255;		
			float g = 100 + right_level * 255;
			if(g > 255) g = 255;		
			float b = 100 + mix_level * 255;
			if(b > 255) b = 255;
			
			//Tint the image
			tint(r, g, b);	
			//Draw the bottom image
			image(_bottom, _x, _y);	
			//Tint the image, applying the alpha of the top image
			tint(r, g, b, _top_alpha);
			//Draw the top image
			image(_top, _x, _y);
		
			//If the top image has fully faded in
			if(_top_alpha >= 255)
			{
				//Stop the fade animation, hide the top image, reset the counter, and get the next image
				_fade_top = false;
				_top_alpha = 0;
				next();
				_counter = 0;
			}
			
			//Increment counter for fade
			_counter++;
		}
		
	}
	
	//Reset method
	public void reset()
	{
		//Reset counter to 0
		_counter = 0;
	}
	
	//Loads the front image
	protected PImage loadFront()
	{
		return loadImage(_top_url);
	}
	
	//Loads the back image
	protected PImage loadBack()
	{
		return loadImage(_bottom_url);
	}
	
	//Get the next set of images
	protected void next() 
	{		
		//Get the next image
		String url = _images.next();
		
		//Whilst the image is invalid, attempt to get a new image (will never run an unlimited loop as this is checked in the constructor)
		while(!validateImage(url)) url = _images.next();
		
		//Assign bottom image to the current top image
		_bottom_url = _top_url;
		
		//Set the top image to the new image
		_top_url = url;
		
		load();
		
	}
	
	//Load new images
	protected void load()
	{
		//If the top image exists, simply use that as the bottom image, otherwise load a new PImage
		_bottom = _top == null ? loadBack() : _top;
		//Load the new top image
		_top = loadFront();				
		
		//Resize both images to the size of the visualization
		_top.resize(_width, _height);
		_bottom.resize(_width, _height);
	}
	
	//Method to validate an image
	protected boolean validateImage(String url)
	{
		try
		{
			PImage t = loadImage(url);
			if(t == null) return false;
		}
		catch(Exception e)
		{
			return false;
		}
		
		return true;
	}
	
}
