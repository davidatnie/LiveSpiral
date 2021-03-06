// The main class for the Live Wave visualizer
// see also class WaveUI

class WaveActivity extends LVActivity {

  // Fields
  WaveUI wvaUI;
  Wave wave;




  // Constructor
  WaveActivity( LiveViz o ) {
    super( o );
    bgColor = color( 0, 0, 0 );
    wvaUI = new WaveUI( this );
    aUI = wvaUI;

    wave = new Wave();
  } // end constructor




  // Methods
  
  void display() {
    super.display();
  } // end display()




  void render() {
    super.render();
    if( hasNewDatastream )
      processDatastream( databaseStream );
    prepForNextDatastream();
    View renderer = aUI.view;
    renderer.updateOffsetRenders();
    wave.display( renderer );
  } // end render()




  void startWave( String[] aDetails ) {
  // aDetails [0] [1] [2] is url, startTime and title
  //
    println( "in WaveActivity.startWave(), now calling super.startLV()" );
    super.startLV( aDetails );

    // create a new wave and put in activity details into it
    print( "Creating new Wave using provided details: " + aDetails[ 1 ] + " " + aDetails[ 2 ] + " ... " );
    wave.sproutWave( aDetails[ 1 ], aDetails[ 2 ] );
    println( "[DONE]" );
  } // end startWave()




  void processDatastream( Table databaseStream ) {
    println( "processing Databasestream for Wave ... " );
    wave.growWave( databaseStream );
    wave.lastCountForFuncs = wave.funcs.size();
  } // end processDatastream()




  String toString() {
    return( "This is WaveActivity" );
  } // end toString()




} // end class WaveActivity
