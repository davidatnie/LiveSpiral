// This is the main class for Live Spiral. Activity selection is no longer part of the Processing applet

import processing.serial.*;

// Fields

  SpiralActivity spa;

  // From Spiral v1.6
  color hitColor, noHitColor, hitColorScatter, noHitColorScatter;
  color popUpBkgrd, popUpTxt, butOv, butPress;
  PFont spiralFont;
  PFont pdfFont;
  Divider[] dividers;

  Serial arduinoPort;
  MPanel mPanel;
  JPointer[] myJays;
  // end from Spiral v1.6

  String[] aDetails = new String[ 3 ];




void setup() {
  setupDisplayElements(); 
  
  aDetails[ 0 ] = param( "fullUrl" );  
  aDetails[ 0 ] = param( "startTime" );  
  aDetails[ 0 ] = param( "title" );  
  println( aDetails ); // just to help in debugging

  spa = new SpiralActivity( this );
  spa.startSpiral( aDetails );

  // temporary block 
  if( arduinoPort == null ) {
    myJays = new JPointer[ 2 ];
    myJays[0] = new JPointer( 0, 0, color(0,0,0), color(0,0,0) );
    myJays[1] = new JPointer( 0, 0, color(0,0,0), color(0,0,0) );
  }

} // end setup()




void draw() {

  spa.display();
  
} // end draw()




void mousePressed() {
  currentActivity.aUI.executeMousePressed(); 
  if ( mouseButton == RIGHT ) {
    background( 180 );
    if ( currentActivity == menu & spa != null )
      currentActivity = spa;
    else if( currentActivity == spa & wva != null) {
      currentActivity = wva;
    }
    else { 
      menu = new MenuActivity( this );
      currentActivity = menu;
    }
  } // end if mouseButton == RIGHT
} // end mousePressed()




void mouseDragged() {
  currentActivity.aUI.executeMouseDragged();
} // end mouseDragged()




void mouseReleased() {
  currentActivity.aUI.executeMouseReleased();
} // end mouseReleased()




void setupDisplayElements() {
  size( 1180, 1000 );
  smooth();
  spiralFont = loadFont( "SansSerif.plain-12.vlw" ); // set as global to make changing easier
  textFont( spiralFont );
  hitColor = color( 0, 200, 0 );
  noHitColor = color( 200, 0, 0 );
  hitColorScatter = hitColor;
  noHitColorScatter = noHitColor;
  popUpBkgrd = color ( 0, 0, 0, 180 );
  popUpTxt = color( 255, 255, 0 );
  butOv = color( 0, 0, 0, 100 );
  butPress = color ( 10, 250, 10, 255 ); 

  dividers = new Divider[ 2 ];
  dividers[ 0 ] = new Divider( true, 0, 300, 350, 300, 90 );
  dividers[ 1 ] = new Divider( false, 350, 0, 350, height, 90 );
} // end setupDisplayElements()



float myRound( float val, int dp ) {
  return int( val * pow( 10, dp ) ) / pow( 10, dp );
} // end myRound()




void netEvent( HTMLRequest ml ) {
  spa.dataWholeChunk = ml.readRawSource();
  //println( "done passing html input to dataWholeChunk" ); 
}




