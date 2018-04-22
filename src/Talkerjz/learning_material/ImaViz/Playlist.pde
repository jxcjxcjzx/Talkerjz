/*
 * Playlist - Class respresenting a playlist of elements gained from an XML file
 */
class Playlist
{
	//Element Count
	protected int _elements = -1;
	
	//Current element
	protected int _current = -1;

	//XMLElement property
	protected XMLElement _xml;

	//XML Url
	protected String _url = "";
	
	//Error message
	protected String _message = null;
	
	//Errornous elements count
	protected int _errornousElements = 0;
	
	//Constructor
	public Playlist(PApplet xmlParent, String xml)
	{
		//Try to create the xml file and grab the element count
		try 
		{
			_xml = new XMLElement(xmlParent, xml);
			_elements = _xml.getChildCount();
		}
		//If that could not be done
		catch (Exception e)
		{
			//Set element count to -1 and apply a message
			_elements = -1;
			_message = "XML file could not be loaded";
		}

		//If the xml file was empty
		if(size() == 0)
		{
			//Assign error message
			_message = "No elements could be found in the\nxml playlist";
		}
		
		//Assign url variable
		_url = xml;
		
	}
	
	//Method to return if an error occurred
	public boolean fatalError()
	{
		return _message != null;
	}
	
	//Method to return the error message
	public String message()
	{
		return _message;
	}
	
	//Method to return the amount of elements
	public int size()
	{
		return _elements;
	}
	
	//Method to return the url of the xml playlist
	public String url()
	{
		return _url;
	}
	
	
	//Method to return the next playlist item's url
	public String next()
	{
		if(fatalError()) return null; //If an error has occurred do not attempt to aquire an element
	
		//Increment current item and make sure it is not out of bounds
		_current = (_current + 1) % size();
		
		//Grab url
		String url;
		
		//If the url attribute never existed
		if((url = loadUrl()).equals("-1"))
		{
			_errornousElements++; //Increase the errornous element count
			
			if(_errornousElements < size()) _current = (_current + 1) % size(); //Attempt to load next element
			
			//Otherwise return -1 and set the error message
			_message = "No valid elements are present within\nthe xml playlist";
		}
		
		//Return the url
		return url;
	}

	//Method to load the url from the xml file
	protected String loadUrl()
	{
		//Get the child element
		XMLElement o = _xml.getChild(_current);
		//Return the url attribute and default to -1 if it cannot be found
		return o.getStringAttribute("url", "-1");
	}
	
	//Method to return the previous item's url
	public String prev()
	{
	
		if(fatalError()) return null; //If an error has occurred do not attempt to aquire an element
	
		//Decrement current and make sure it is not out of bounds
		_current = (_current == 0 ? size() - 1 : _current - 1);	
		//Grab url
		String url;
		
		//If the url attribute never existed
		if((url = loadUrl()).equals("-1"))
		{
			_errornousElements++; //Increase the errornous element count
			
			if(_errornousElements < size()) _current = (_current == 0 ? size() - 1 : _current - 1); //Attempt to load previous element
			
			//Otherwise return -1 and set the error message
			_message = "No valid elements are present within the xml playlist";			
			
		}
		
		return url;
	}
	
	//Method to get the url of the specified element
	public String get(int count)
	{
		//Assign current to the specified index - 1 and make sure it is not out of bounds
		_current = (count - 1) % size();
		while(_current < 0) _current += size(); //Add to current until it is positive		
		return next(); //Return the next element
	}
	
	//Method to return a formatted string of the current element out of total elements
	public String positionMessage()
	{
		//Strings to store current and total
		String c = Integer.toString(_current + 1);
		String t = Integer.toString(_elements);
		
		//Make sure t is always at least 2 characters long
		t = _elements < 10 ? "0" + t : t;
		
		//Make sure current is the same length as elements
		while(c.length() < t.length())
			c = "0" + c; //Prepend 0
			
		return c + "/" + t;		
	}
	
}
