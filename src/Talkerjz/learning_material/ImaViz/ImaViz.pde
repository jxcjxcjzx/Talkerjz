/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/9923*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
/****************************************************************************/
/*					ImaViz Application - Ashley Blurton                 	*/
/*				Coursework for Animation and Multimedia (CSC-10026)			*/
/****************************************************************************/

//Imports
import ddf.minim.*;
import java.awt.*;
import javax.swing.*;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

/*********** CONSTANTS **********/
final color BACKGROUND = color(0); //Background color of applet
final int APP_WIDTH = 480, APP_HEIGHT = 480; //Application dimensions
final int APP_FRAMERATE = 20; //Framerate of application. Set to 20 as visualizations utilize a lot of processing
final int BUFFER_SIZE = 1024; //Amount of bytes to buffer into each channel of the AudioPlayer
final int HELP_ALPHA_STEP = 50; //Amount of alpha to decrease/increase per frame for help menu
final int MAX_URL = 30; //Maximum amount of characters in a URL before shortening occurs

final String MENU_MUSIC = "menu.mp3"; //Path to the menu music in the /data folder

//Color constants for use with theme arrays
final color WHITE = color(255);
final color RED = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE = color(0, 0, 255);
final color YELLOW = color(255, 255, 0);
final color PURPLE = color(255, 0, 255);
final color TEAL = color(0, 255, 255);
final color ORANGE = #FF9900;

//Raw color constants for use with visualizations that need to set alpha values
final int[] RAW_WHITE = {255, 255, 255};
final int[] RAW_RED = {255, 0, 0};
final int[] RAW_GREEN = {0, 255, 0};
final int[] RAW_BLUE = {0, 0, 255};
final int[] RAW_YELLOW = {255, 255, 0};
final int[] RAW_PURPLE = {255, 0, 255};
final int[] RAW_TEAL = {0, 255, 255};
final int[] RAW_ORANGE = {255, 153, 0};

//Themes for visualizations
final color[] WARM = {YELLOW, ORANGE, RED};
final color[] COOL = {TEAL, BLUE, WHITE};
final color[] DEFAULT = {PURPLE, TEAL, BLUE, GREEN, YELLOW, RED};

//Raw themes for visualizations that use alpha
final int[][] RAW_WARM = {RAW_YELLOW, RAW_ORANGE, RAW_RED};
final int[][] RAW_COOL = {RAW_TEAL, RAW_BLUE, RAW_WHITE};
final int[][] RAW_DEFAULT = {RAW_BLUE, RAW_TEAL, RAW_GREEN, RAW_YELLOW, RAW_RED, RAW_PURPLE};

//Theme indexes for settings
final int DEFAULT_THEME = 0; //Uses a rainbow based color scheme
final int WARM_THEME = 1; //Uses a warm tone color scheme
final int COOL_THEME = 2; //Uses a cool tone color scheme

//State constants
final int PLAY_ERROR = -4; //When no mp3 can be played
final int PLAYLIST_ERROR = -3; //When the playlist cannot be loaded, or is empty.
final int FONT_ERROR = -2; //When fonts cannot be loaded into the system
final int MINIM_ERROR = -1; //If minim cannot be initialized
final int INIT = 0; //First state of the application before the main menu is shown
final int INIT_PLAYBACK = 1; //State before playback begins, loads the playlist and sets up visuals
final int PLAYING = 2; //When music is being played, allows changing of visualization and tracks
final int MAIN_MENU = 3; //Shows the main menu allowing the user to start, edit options, view credits, or exit.
final int OPTIONS = 4; //Allows users to set the theme, xml playlist locations, and whether or not to use images
final int CREDITS = 5; //Shows the credits menu
final int THEME_SELECT = 6; //Shows the menu to select the theme
final int IMAGE_MODE_SELECT = 7; //Shows the menu to select image use
final int ABOUT = 8; //Applet version
final int EXIT = 9; //Turns off all visualizations and menus, and displays the exit message.

/*********** END CONSTANTS **********/

/*********** GLOBAL PROPERTIES ***********/

//Current theme property
int g_theme = DEFAULT_THEME;

//Default location of xml playlists
String g_music = "mp3.xml";
String g_images = "images.xml";

//Help display properties
boolean showHelp = false; //If help is being displayed
int alphaHelp = 0; //Alpha of the help menu

//Counters for files that cannot be loaded as audio
int corruptSongs = 0, corruptNotify = 0;

//Visualization name display
FadingText g_visual;

//Music variables
AudioMetaData g_meta; //Stores ID3 info in mp3 files
AudioPlayer g_player; //Plays the mp3 files in playback mode
AudioPlayer g_menu_player; //Plays the menu music
Minim g_minim; //Minim instance

//Current state
int state = INIT; //Start within in the initialize phase

//Playlist for mp3 files
Playlist g_playlist;

//Menus
Menu g_main_menu; //Main menu
Menu g_credits; //Credits menu
Menu g_options; //Options menu
Menu g_theme_select; //Theme select menu
Menu g_image_mode_select; //Use images menu
Menu g_current_menu; //Tracks the currently displayed menu - Used for user input
Menu g_about; //Shows information about the applet version

//Visualization lists
LinkedList g_visuals = new LinkedList(); //List for storing visualizations
LinkedList g_visuals_name = new LinkedList(); //List for storing the names of visualizations

//Menu visualization item
Visualization g_menu_visual;

//Image visualization item
Ima g_image_visual;

//Image show visual toggle
boolean g_show_images = false;

//Current menu visualization
int g_menu_visual_index = 0;

//Tracker for last selected() menu item - Used in mouseRelease/mousePress to circumvent mouseClick which will not fire when the mouse is moved slightly between press and release
int g_last_selected = 0;

//Current visualization index
int g_current_visual_index = 0;
Visualization g_current_visual; //Stores a pointer to the current visualization, since access to linked list can slow

//Fonts
PFont g_font, g_title_font;

/*********** END GLOBAL PROPERTIES ***********/

//Method to make setUpVisuals use true by default
void setUpVisuals() { setUpVisuals(true); };

//Method to setup visualizations
void setUpVisuals(boolean renew)
{
	//Arrays to store the colors to be used
	color[] c;
	int[][] rawC;
	
	//Assign colors based on current theme
	switch(g_theme)
	{
		case WARM_THEME:
			c = WARM;
			rawC = RAW_WARM;
		break;
		case COOL_THEME:
			c = COOL;
			rawC = RAW_COOL;
		break;
		default:
			c = DEFAULT;
			rawC = RAW_DEFAULT;
		break;
	}

	//Setup triwave/classic colors as they can only use 3 colors, where as the default theme has 6
	color[] triwave = new color[3];
	triwave[0] = c.length == 3 ? c[0] : c[1];
	triwave[1] = c.length == 3 ? c[1] : c[3];
	triwave[2] = c.length == 3 ? c[2] : c[5];
	
	//Reset visuals lists
	g_visuals = new LinkedList();
	g_visuals_name = new LinkedList();
	
	//Determine the smallest dimension
	float smallest = width < height ? width : height;
	
	//Create TriWave visual
	g_visuals.add(new TriCircleWave(width / 2, height / 2, (int)(0.8 * smallest) , (int)(0.8 * smallest), (int)(smallest / 10) , triwave[2], triwave[1], triwave[0], 2));
	g_visuals_name.add("TriWave");

	//Create Ecliptic visual
	g_visuals.add(new Ecliptic(width /2, height / 2, (int)(0.9 * smallest) , (int)(0.9 * smallest), 12, c));		
	g_visuals_name.add("Ecliptic");
	
	//Create Blitz visual
	g_visuals.add(new Blitz(width /2, height / 2, width, (int)(0.8 * height), 40, c));	
	g_visuals_name.add("Blitz");
	
	//Create Pulsar visual
	g_visuals.add(new Pulsar(width /2, height / 2, (int)(0.9 * smallest) , (int)(0.9 * smallest), 50, rawC));	
	g_visuals_name.add("Pulsar");
	
	//Create Burst visual
	g_visuals.add(new Burst(width / 2, height / 2, (int)(0.9 * smallest), c));
	g_visuals_name.add("Burst");
	
	//Create Chaos visual
	g_visuals.add(new Chaos(width / 2, height / 2, (int)(0.9 * smallest) , (int)(0.9 * smallest), rawC));
	g_visuals_name.add("Chaos");
	
	//Create Torrent visual
	g_visuals.add(new Torrent(width / 2, height / 2, (int)(0.9 * smallest) , (int)(0.9 * smallest), rawC));
	g_visuals_name.add("Torrent");
	
	//Create Classic Visual
	g_visuals.add(new Classic(width / 2, height / 2, width, (int)(0.8 * height), triwave[0], triwave[1], triwave[2]));
	g_visuals_name.add("Classic");
	
	//Set up image visuals
	setUpImageVisual(false);
	
	//Set message of visual name display
	g_visual.message = (String)g_visuals_name.get(0);	

	//Menu visualization setup	
	if(renew) g_menu_visual_index = (int)random(g_visuals.size()); //If renew is true, change the visual index
	g_menu_visual = (Visualization)g_visuals.get(g_menu_visual_index);//Random visualization
	
	//Assign current visual
	g_current_visual = (Visualization)g_visuals.get(g_current_visual_index);
}

//Method to setup image visuals
void setUpImageVisual(boolean renew)
{
	//Load playlist
	Playlist images = new Playlist(this, g_images);
	
	//Create new Ima instance if it is empty, or renew has been specified
	if(g_image_visual == null || renew) g_image_visual = new Ima(width / 2, height / 2 , width, height, images);
	else g_image_visual.reset(); //Otherwise just call reset
}

//Setup method - ran on application start
void setup()
{
	//First time setup
	if(state == INIT)
	{
		//Set size of the application
		size(APP_WIDTH, APP_HEIGHT);
		
		//Set background color
		background(BACKGROUND);
		
		//Set framerate
		frameRate(APP_FRAMERATE);
		
		//Setup minim
		try 
		{
			g_minim = new Minim(this); //Attempt to intialize minim
		}
		catch (Exception e)
		{
			state = MINIM_ERROR; //Set state to minim error if minim could not be started
		}
		
		
		//Load fonts
		try 
		{	
			//Generic font
			g_font = loadFont("font-20.vlw");
			
			//Font for menu titles
			g_title_font = loadFont("font-alt-32.vlw");
			
			//Setup font
			textFont(g_font, 20);
			
		}
		catch (Exception e)
		{
			state = FONT_ERROR; //Go to font error if fonts could not be loaded
		}
		
		/************** MENU SETUP **************/
		MenuItem[] main_menu =  {new MenuButton("Start"), new MenuButton("Options"), new MenuButton("Credits"), new MenuButton("About the Applet Version"), new MenuButton("Exit")};
		g_main_menu = new Menu("ImaViz", main_menu, width / 2, height / 2);
		
		MenuItem[] credits = {new MenuText("Menu Music:"), new MenuButton("http://www.newgrounds.com/audio/listen/302626"), new MenuText("Coded by: Ashley Blurton"), new MenuText("Designed by: Ashley Blurton"), new MenuText("Made for: CSC-10026"), new MenuButton("Main Menu")};
		g_credits = new Menu("Credits", credits, width / 2 , height / 2);
		
		g_options = new Menu("Options", configOptions(), width / 2, height / 2);
		
		MenuItem[] themes = {new MenuButton("Normal"), new MenuButton("Warm"), new MenuButton("Cool"), new MenuButton("Back to Options")};
		g_theme_select = new Menu("Theme Select", themes, width / 2, height / 2);
		
		MenuItem[] image_options = {new MenuButton("Yes"), new MenuButton("No"), new MenuButton("Back to Options")};
		g_image_mode_select = new Menu("Use images", image_options, width / 2, height / 2);
		
		MenuItem[] about_options = {
			new MenuText("Unfortunately due to restrictions with applets, the full version of the application cannot be published online. So features have been removed:"),
			new MenuText(""),
			new MenuText("Custom playlists have been removed, and only a selection of three 30 second tracks can be played, and the image slideshow can only use pre-determined images."),
			new MenuText(""),
			new MenuText("You can get the full version below (click):"),
			new MenuButton("http://media.deathmonkeyz.com/"),
			new MenuButton("Main Menu")
		};
		g_about = new Menu("About", about_options, width / 2, height / 2);
		
		/************** END MENU SETUP **************/	
			
		
		//Visualization display set-up
		g_visual = new FadingText(width / 2, height / 2);
				
		//Visualization set-up
		setUpVisuals();
		
		//If state is INIT (i.e no errors occurred) go to the main menu
		if(state == INIT)
			state = MAIN_MENU;
		
	}

	
}

//Draw method (called every frame)
void draw()
{	
	//Clear screen
	background(BACKGROUND);
	
	switch(state)
	{
		//If errors were encountered when trying to use the playlist
		case PLAY_ERROR:
			drawErrorDialogue("Playback Error", "Could not load the mp3 file.", "Q: Main Menu\nO: Options");
		break;
		case PLAYLIST_ERROR:
			drawErrorDialogue("Playlist Error", g_playlist.message(), "Q: Main Menu\nO: Options");
		break;
		case MINIM_ERROR:
			drawErrorDialogue("Sound Library Error", "Could not start the sound library", "Please restart the application");
		break;
		case FONT_ERROR:
			print("FONT ERROR");
		break;
		case INIT_PLAYBACK:
		
			//Setup mp3 playlist
			g_playlist = new Playlist(this, g_music);
	
			//Set the current state to playing
			state = PLAYING;
	
			//Reset corrupt counter
			corruptNotify = 0;
	
			//If no errors were encountered whilst loading the playlist
			if(!g_playlist.fatalError())
			{			
				//Load first track
				load(0);				
			}
			else
			{
				//Display error message in console
				println(g_playlist.message());
				
				//Show playlist error message
				state = PLAYLIST_ERROR;
			}
			
			//If the menu player was created and is still playing, pause it.
			if(g_menu_player != null && g_menu_player.isPlaying()) g_menu_player.pause();
				
			//Close help menu and reset alpha to 0
			showHelp = false;	
			alphaHelp = 0;				
		break;
		case MAIN_MENU:			
			g_current_menu = g_main_menu; //Set the current menu to the main menu		
		break;
		case CREDITS:
			g_current_menu = g_credits; //Set the current menu to the credits
		break;
		case THEME_SELECT:
			g_current_menu = g_theme_select; //Set the current menu to the theme select menu
		break;
		case IMAGE_MODE_SELECT:
			g_current_menu = g_image_mode_select; //Set the current menu to the use images menu
		break;
		case OPTIONS:
			g_options.setItems(configOptions()); //Generate the fields for the options menu
			g_current_menu = g_options; //Set the current menu to the options menu
		break;
		case ABOUT:
			g_current_menu = g_about;
		break;
		case PLAYING:		
		
			//If the player has been initialized
			if(g_player != null)
			{
				//Draw images in the background if the option is enabled
				if(g_show_images) g_image_visual.draw(g_player.left.toArray(), g_player.right.toArray(), g_player.mix.toArray(), g_player.left.level(), g_player.right.level(), g_player.mix.level());
				
				//Draw the current visualization
				g_current_visual.draw(g_player.left.toArray(), g_player.right.toArray(), g_player.mix.toArray(), g_player.left.level(), g_player.right.level(), g_player.mix.level());
				
				//If the player has stopped (i.e song has finished) play the next track automatically
				if(!g_player.isPlaying())
				{
					loadNext();
				}
				
			}
			else
			{
				//Silent visualization if the player is not set
				float[] blank = new float[BUFFER_SIZE];
				if(g_show_images) g_image_visual.draw(blank, blank, blank, 0, 0, 0);
				g_current_visual.draw(blank, blank, blank, 0, 0, 0);
			}
			
			//Setup g_font
			textFont(g_font, 20);
			smooth();
			
			//Output track info
			if(g_meta != null)
			{	
				//White text
				fill(255);
				
				textAlign(LEFT);
				
				//Output title and artist info in top left
				text("Title: " + g_meta.title(), 5, 15);
				text("Artist: " + g_meta.author(), 5, 30);

				String total = "";	

				//If the length could not be determined, display an unknown length
				if(g_player.length() == -1)
					total = "??:??";
				else
					total = formatTime(g_player.length()); //Get a formatted time

				
				
				//Display current position and total time in lower right
				textAlign(RIGHT);
				text(formatTime(g_player.position()) + " / " + total, width - 5, height - 5);
					
			}
			
			//If playlist loaded correctly
			if(!g_playlist.fatalError())
			{
				fill(255);
				textAlign(RIGHT);
				//Output playlist location in top right
				text("Playlist: " + shorten(g_playlist.url()), width - 5, 15);
				//Display current track and total tracks. Including any corrupt tracks if any.
				text("Track: " + g_playlist.positionMessage() + (corruptNotify == 0 ? "" : " (" + corruptNotify + " Errors)"), width - 5, 30);
			}
			
			//Output help message in lower left
			fill(255);
			textAlign(LEFT);
			text("View Help: H", 5, height - 5);
			
			//Show visualization name
			g_visual.draw();
			
			
			
			//Fade In/Out help
			if(showHelp && alphaHelp < 255)
				alphaHelp += HELP_ALPHA_STEP;
			else if(!showHelp && alphaHelp > 0)
				alphaHelp -= HELP_ALPHA_STEP;
				
			//Ensure alpha value is within bounds
			alphaHelp = alphaHelp > 255 ? 255 : (alphaHelp < 0 ? 0 : alphaHelp);
			
			
			/************* HELP DISPLAY ***********/
			
			textFont(g_font, 20);
			stroke(255, alphaHelp);
			strokeWeight(1);
			rectMode(CENTER);
			fill(0, 200*((float)alphaHelp/255));
			rect(width / 2, height / 2, 300, 240);
			
			fill(255, alphaHelp);
			textAlign(RIGHT);
			text("LEFT ARROW:\nRIGHT ARROW:\nUP ARROW\nDOWN ARROW:\nLEFT CLICK:\nRIGHT CLICK:\nH KEY:\nT KEY:\nI KEY:\nQ KEY:", width/2 - 30, height/2 - 60);
			textAlign(LEFT);
			text("Previous Track\nNext Track\nNext Visualization\nPrevious Visualization\nNext Visualization\nNext Track\nShow/Hide Help\nTheme Toggle (Not Saved)\nImage Toggle (Not Saved)\nMain Menu", width/2-20, height/2 - 60);
			textAlign(CENTER);
			text("Created by Ashley Blurton", width/2, height/2 - 90);
			text("Coursework for CSC-10026", width/2, height/2 + 105);
			
			/************ END HELP DISPLAY *********/
			
			noSmooth();	
		break;
		case EXIT:
			//Stop any players that may be running
			if(g_player != null && g_player.isPlaying()) g_player.pause();
			if(g_menu_player != null && g_menu_player.isPlaying()) g_menu_player.pause();
			
			
			//Output an exit message
			textAlign(CENTER);
			fill(255);
			textFont(g_title_font, 32);
			text("Thanks for using ImaViz!!!", width / 2, height / 2);
			textFont(g_font, 20);
			text("To download the full version. Press ENTER to open the download page", width / 2, height / 2 + 30);
			
			
		break;
			
	}

	//Show menus if within a menu state
	if(state >= MAIN_MENU && state < EXIT)
	{
		showMenu(g_current_menu);
	}
	
}

//Method to display a menu
void showMenu(Menu m)
{
	//Turn off the main AudioPlayer
	if(g_player != null && g_player.isPlaying()) g_player.pause();
	
	//Attempt to load the menu music if it has stopped or was never created
	if(g_menu_player == null || !g_menu_player.isPlaying())
	{
		try
		{
			g_menu_player = g_minim.loadFile(MENU_MUSIC, BUFFER_SIZE);
			
			g_menu_player.play();
		
			//Loop the menu music indefinitely
			g_menu_player.loop();
			
		}
		catch(Exception e){}

		
	}

	//If the menu music is playing, display the menu visuals
	if(g_menu_player != null) {
		if(g_show_images) g_image_visual.draw(g_menu_player.left.toArray(), g_menu_player.right.toArray(), g_menu_player.mix.toArray(), g_menu_player.left.level(), g_menu_player.right.level(), g_menu_player.mix.level()); //Display images if the options is enabled
		g_menu_visual.draw(g_menu_player.left.toArray(), g_menu_player.right.toArray(), g_menu_player.mix.toArray(), g_menu_player.left.level(), g_menu_player.right.level(), g_menu_player.mix.level());
	}

	//Draw the menu provided
	m.draw();

	//Display navigation hint message in bottom center
	fill(255);
	textAlign(CENTER);
	textFont(g_font, 20);
	text("Use arrow keys to navigate, and SPACE to select. Or use the mouse.", width / 2, height - 5);
	text("Applet Version.", width / 2, 15); //Applet version notification
}

//Method to shorten url strings over a certain length
String shorten(String s)
{
	String r = ""; //Return string
	
	//If the string needs shortening
	if(s.length() > MAX_URL)
	{
		r = s.substring(0, (MAX_URL-3)/2) + "..." + s.substring(s.length()-(MAX_URL-3)/2); //Select first set of characters, append ... and then add the final few characters
	}
	else
		return s; //Return the original string if it is too short
	
	return r;
}

//Method to dynamically generate the option menu items based on current configuration
MenuItem[] configOptions()
{
	String cTheme = g_theme == WARM_THEME ? "Warm" : (g_theme == COOL_THEME ? "Cool" : "Normal"); //Theme message
	MenuItem[] r = {
		new MenuButton("Theme: " + cTheme), 
		new MenuButton("Show Images: " + (g_show_images ? "Yes" : "No")),
		new MenuText("------------"), 
		new MenuText("WARNING:"),
		new MenuText("ID3v2 tags in mp3s not supported correctly"),
		new MenuText("Use kid3 to remove them"), 
		new MenuButton("http://kid3.sourceforge.net/"), 
		new MenuText("------------"), 
		new MenuButton("Main Menu")
	};
	return r;
}

//Method to display a simplistic error dialogue
void drawErrorDialogue(String title, String message, String instructions)
{
	//Draw bounding rectangle
	stroke(255);
	strokeWeight(1);
	fill(25);
	rectMode(CENTER);
	rect(width / 2, height / 2, 300, 200);
	fill(255);
	textAlign(CENTER);
	//Draw error title
	textFont(g_title_font, 32);
	text(title, width / 2, height / 2 - 60);
	//Draw error message
	textFont(g_font, 20);
	text(message, width /2, height / 2);
	//Draw error instructions
	text(instructions, width /2, height / 2 + 60);
}

//Show next visual
void nextVisual()
{
	//Increase current visual and loop
	g_current_visual_index++;
	g_current_visual_index %= g_visuals.size();
	loadVisual();	
}

//Show previous visual
void prevVisual()
{	
	//Decrease current visual and loop
	g_current_visual_index = g_current_visual_index == 0 ? g_visuals.size() - 1 : g_current_visual_index - 1;
	loadVisual();
}

//Load visual
void loadVisual()
{
	//Show visualization name
	g_visual.message = (String)g_visuals_name.get(g_current_visual_index);
	g_visual.reset();
	
	//Reset visualization
	g_current_visual = (Visualization)g_visuals.get(g_current_visual_index);
	g_current_visual.reset();
}

//Attempt to load next song
void loadNext()
{
	while(!load(g_playlist.next()));
}

//Attempt to load previous song
void loadPrev()
{
	while(!load(g_playlist.prev()));
}

//Manually load a file from a specific position
void load(int count)
{
	//If the desired item cannot be loaded, attempt the next track
	if(!load(g_playlist.get(count)))
		loadNext();
}

//Method to load an mp3
boolean load(String file)
{
	//If the g_player exists, try to close it before loading a new file
	if(g_player != null)
	{
		try {
			g_player.close();
		}
		catch (Exception e){}; //g_player can sometimes provide a null pointer exception, this will ignore it
	}
		
	//Reset meta data
	g_meta = null;
	
	//If the playlist has no errors
	if(!g_playlist.fatalError())
	{
		try
		{		
			//Attempt to load and play the file
			g_player = g_minim.loadFile(file, BUFFER_SIZE);
			g_player.play();
			
			//Access the meta data of the file
			g_meta = g_player.getMetaData();
			
			//Reset the corrupt song counter
			corruptSongs = 0;
		}
		catch(Exception e)
		{
			//If it could not load a file increase the corrupt song notification
			corruptSongs++;
			corruptNotify = corruptSongs; //Corrupt notify is used when displaying the amount of errors. As corruptSongs is reset upon successful load
			//If every song was found to be corrupt
			if(corruptSongs == g_playlist.size()) {
				corruptSongs = 0;
				state = PLAY_ERROR; //Show a play error
			}
			else return false;
		}
	}
	else
	{
		//If the playlist contained errors. Go to the playlist error dialogue
		println(g_playlist.message());
		state = PLAYLIST_ERROR;
	}
	
	return true;
}

//String to turn a millisecond time into a mm:ss format
String formatTime(int time)
{
	//Get the total seconds (rounded down)
	time /= 1000;
	//Get the current minutes and convert to a string
	String minutes = Integer.toString(time / 60);
	//Prepend a 0 if lower than 10
	minutes = Integer.parseInt(minutes) < 10 ? "0" + minutes : minutes;	
	//Get left over seconds after minutes are calculated
	String seconds = Integer.toString(time % 60);
	//Prepend 0 if less than 10
	seconds = Integer.parseInt(seconds) < 10 ? "0" + seconds : seconds;
	
	//Return the formatted string
	return minutes + ":" + seconds;
}

//Handle keyReleases. KeyPressed fires multiple times if a key is held down, so it is best not to use it
void keyReleased()
{
	//Handle input based on current state
	switch(state)
	{
		//If it is an error
		case PLAY_ERROR:
		case PLAYLIST_ERROR:
			if(key != CODED)
			{	
				switch(key)
				{
					//Uppercase and lower case are treated as separate inputs, so process both
					case 'Q':
					case 'q':
						//Return to the main menu
						state = MAIN_MENU;
					break;
					case 'o':
					case 'O':
						//Return to the options menu
						state = OPTIONS;
					break;
				}
			}
		break;
		case PLAYING:
			if(key == CODED)
			{
				switch(keyCode)
				{
					//Previous track key
					case LEFT:
						loadPrev();
					break;
					//Next track key
					case RIGHT:
						loadNext();
					break;
					//Next visualization key
					case UP:
						nextVisual();						
					break;
					//Previous visualization key
					case DOWN:
						prevVisual();						
					break;
				}
			}
			else
			{
				switch(key)
				{
					//Help toggle
					case 'h':
					case 'H':
						showHelp = !showHelp; //Flip boolean
					break;
					case 'Q':
					case 'q':
						if(g_menu_player != null) g_menu_player.cue(0);
						state = MAIN_MENU;
					break;
					//Image toggle
					case 'i':
					case 'I':
						g_show_images = !g_show_images; //Flip images boolean
					break;
					//Theme toggle
					case 't':
					case 'T':
						switch(g_theme)
						{
							case WARM_THEME:
								g_theme = COOL_THEME;
							break;
							case COOL_THEME:
								g_theme = DEFAULT_THEME;
							break;
							case DEFAULT_THEME:
								g_theme = WARM_THEME;
							break;
						}
						
						//Reset visuals to reflect theme change
						setUpVisuals(false);
						
					break;
				}
			}
		break;
		case EXIT:
			if(key == ENTER || key == RETURN)
			{
				link("http://media.deathmonkeyz.com/ImaViz/download.html"); //Open page to full version
			}
		break;
	}
	
	//If a menu is showing
	if(state >= MAIN_MENU && state < EXIT)
	{
		//Process keyboard navigation
		if(key == CODED)
		{
			handleNavigation(g_current_menu, keyCode);
		}
		//If the user selected() an item
		else if (key == ' ')
		{
			handleSelect(g_current_menu);
		}		
	}
	
}

//Method to handle navigation based on mouse movement and button presses
void handleNavigation(Menu m, int x, int y)
{
	//Use the updateFromMouse method of the menu class
	m.updateFromMouse(x, y);
}

//Method to handle navigation based on key presses
void handleNavigation(Menu m, int keyCode)
{
	switch(keyCode)
	{
		case UP:
			m.prev();
		break;
		case DOWN:
			m.next();
		break;
	}
}

//Method to handle when a menu item is selected()
void handleSelect(Menu m)
{
	//If the main menu was used
	if(m.equals(g_main_menu))
	{
		//Determine which item was selected()
		switch(m.selected())
		{
			//Start visuals
			case 0:
				state = INIT_PLAYBACK;
			break;
			//Go to Options
			case 1:
				state = OPTIONS;
			break;						
			//Go to Credits
			case 2:
				state = CREDITS;
			break;
			//Go to About
			case 3:
				state = ABOUT;
			break;
			//Go to Exit
			case 4:
				state = EXIT;
			break;
		}
	}
	//Options menu
	else if(m.equals(g_options))
	{
		//Does not use CASE since the final option index is dynamically generated
		
		//Theme selection
		if(m.selected() == 0)
		{
			state = THEME_SELECT; //Change state
		}
		//Use images
		else if(m.selected() == 1)
		{
			state = IMAGE_MODE_SELECT; //Change state
		}
		//Kid3 application
		else if(m.selected() == m.count()-3)
		{
			//Open the kid3 website in a new tab/window
			link("http://kid3.sourceforge.net", "_new");
		}
		//Back to menu
		else if(m.selected() == m.count()-1)
		{
			state = MAIN_MENU; //State change
		}
		
		;
		
	}
	//Theme select menu
	else if(m.equals(g_theme_select))
	{
		//Back to options
		if(m.selected() == m.count()-1)
		{
			state = OPTIONS; //Change state
		}
		else
		{
			//Change theme
			g_theme = m.selected();
			//Restart visuals to reflect change
			setUpVisuals(false);
		}
		
		;
		
	}
	//Use images menu
	else if(m.equals(g_image_mode_select))
	{
		switch(m.selected())
		{
			case 0:
				g_show_images = true; //Enable images
			break;
			case 1:
				g_show_images = false; //Disable images
			break;
			case 2:
				state = OPTIONS; //Return to options
			break;
		}
		;
	}
	//Credits menu
	else if(m.equals(g_credits))
	{
		switch(m.selected())
		{
			//Menu music
			case 1:
				link("http://www.newgrounds.com/audio/listen/302626", "_new"); //Open page to menu music in a new tab/window
			break;
			//Main menu
			case 5:
				state = MAIN_MENU; //Change state
			break;
		}
	}
	else if(m.equals(g_about))
	{
		if(m.selected() == m.count()-2)
		{
			link("http://media.deathmonkeyz.com/ImaViz/download.html", "_new"); //Open page to full version
		}
		else if(m.selected() == m.count()-1)
		{
			state = MAIN_MENU; //Change state
		}
	}
}

//When the mouse is pressed
void mousePressed()
{
	//If in a menu, store the currently selected() menu item (used to circumvent mouseClicked)
	if(state >= MAIN_MENU && state < EXIT && mouseButton == LEFT)
	{
		handleNavigation(g_current_menu, mouseX, mouseY);
		g_last_selected = g_current_menu.selected();
	}
}

//When the mouse is released
void mouseReleased()
{
	//Ensure the mouse button is the left
	if(mouseButton == LEFT)
	{
		if(state >= MAIN_MENU && state < EXIT)
		{
			//Ensure the mouse has not moved to a different menu item
			handleNavigation(g_current_menu, mouseX, mouseY);
			if(g_last_selected != g_current_menu.selected())
				return;
				
			//Process selection
			handleSelect(g_current_menu);
		}	
		else if (state == PLAYING)		
		{
				nextVisual(); //Load next visualization				
		}
	}
	//If the the screen was right clicked
	else if(mouseButton == RIGHT)
	{
		//If the application is playing files, load the next track
		if(state == PLAYING) loadNext();
	}
}

//When the mouse mouse is moved
void mouseMoved()
{
	//If in a menu state, handle selection
	if(state >= MAIN_MENU && state < EXIT)
	{
		handleNavigation(g_current_menu, mouseX, mouseY);
	}
}

//Run when application is closed
void stop()
{
	//Try to shut down any players and minim instances
	//Try catch around all statements prevents any issues caused by earlier errors within execution
	try
	{
		if(g_menu_player != null) g_menu_player.close();
	}catch (Exception e){};
	
	try
	{
		if(g_player != null) g_player.close();
	}catch (Exception e){};
	
	try
	{
		if(g_minim != null) g_minim.stop(); //Close minim interface
	} catch (Exception e){};
		super.stop(); //Parent stop
}

