
// one class per line

// and several timer classes per class

class Line_cl {







  // _   initilisations     


  // set up we_are_changing to false !!!

  // ___ the changing gen instances
  int num_of_change_val_generators = 3;
  Change_values_gen[] change_value_generators;

  // indicies
  int x_rot_changer_gen_index = 0;
  int y_rot_changer_gen_index = 1;  
  int velocity_changer_gen_index = 2;

  // number of points visible in the line?
  // NOTE: this becomes the length of the line positions stack!
  int num_of_line_points ;

  // number of points to draw - 0 means all, every other number means the nuber of points to draw ( might even be circular...)
  int num_of_line_pts_to_draw = 0;


  // __ and the VERY LOCAL arrays of positions
  float[] x_coords_pts_array ;
  float[] y_coords_pts_array ;
  // and a z array?? - let's do it for fun :)
  // - use different update position functions if we're doing 2d or 3d
  float[] z_coords_pts_array ;  

  // this is also VERY LOCAL - this is an index to which 
  // coord pos in the array of coords we're currently filling
  // (note that we have to do curr_line_pts_coords_array_index%num_of_line_points, to get the abs index position!
  // NOTE: it's initialised HERE
  int curr_line_pts_coords_array_index = 1;




  // stroke colour?
  color line_stroke_colour ;

  // the general transparency level
  float general_transparency_level ;

  // >> fade to transparency along the length of the line??? YES!
  // flag it here please!
  boolean fade_line_to_transparency ;

  // stroke weight
  float line_stroke_weight ;



  //____ changing and 'passive' behaviour _


  // FLAG indicating whether we're changing or not
  boolean we_are_changing ;

  // this indicates the time when we change next time
  int time_of_next_change ;

  // and then a flag to indicate how the updating of positiongs happens
  //   during PASSIVE MODE (< flag)
  // - whether the direction is constant (note, not touching speed here)
  // - OR whether the direction is constantly incremented with the change values?
  //    (i.e. that we have a value for how much turning there is generally,
  //        which might change when we have the changing period/season,
  //        and which is updated on every loop

  // this indicates whether we update the curr_y/x_rot_heading in the 
  //  nonChanging_mode
  // (essentially, are we doing spirals or not ;-)
  // NOTE: this is also used in the changing mode,
  //      if this is true, then we update the x_rot_change in changing mode
  //      if this is false, then we update the heading in changing mode
  boolean changing_direction_in_nonChanging_mode ;
  // String update_velocity_incrementally_or_absolutely_in_NON_ch_mode = "kuyghg";

  // this indicates whether we're changing speed in the changing mode
  boolean changing_speed_incremntally_in_changing_mode ;
  // and this defines exactly how we do that - incrementally or aboslutely
  //String update_velocity_incrementally_or_absolutely_in_ch_mode = "kuyghg";

  // and this indicates whether we change speed in nonChanging mode
  boolean changing_speed_in_nonChanging_mode ;

  // ______________   advanced line behaviour

  // ___ new heading = incremented current heading or absolute new heading
  // this switch indicates whether the new (end) value of transitions
  // are a product of adding a random(min,max) value to the current heading, or just letting the heading be random(min, max)
  //    true = incrementation, false = absolute
  boolean new_direction_values_are_increments_of_curr_heading_or_absolute_headings_true_false ;

  // ___ is the new speed an incrementation of the previous speed, or an aboslute speed
  //    true = incrementation, false = absolute
  boolean new_speed_value_is_an_increment_of_curr_speed_or_absolute_speed_value_true_false ;



  // __   the current directions and speed

  // this is the values that get incremented by the change values below
  float curr_x_rot_heading ;
  float curr_y_rot_heading ;
  float curr_velocity ;

  // direction/velocity incrementation values
  // depending on which mode we're in, these are added to the current position
  // ALSO - depending on which mode we're in, in passive mode, 
  //      we incrment the 'constant'/ heading values above or not.
  //      IF we're not incrementing them in passive mode, then the path is stright
  //      IF we're incrementing them, in passive mode, then we'd be turning
  //       -- how things are in changing mode, is a different issue ;-)
  float curr_x_rot_incr ;
  float curr_y_rot_incr ;
  float curr_velocity_incr ;
  /*
  hmmm... and what happens in changing mode then?
   - do we update the heading or the accelleration?
   - if we have a flag for changing heading or accelleration, mostly used in the nonchanging mode
   we could use the same flag to indicate whether the position update in the changing mode
   is to update the heading with the current heading values (which'd be changed in the changing
   mode) or whether to use the turn_change values to update the heading)
   
   
   */


  // __ setup the timers of these things here!

  //  x  min / max direction -- ABSOLUTE VALUEs
  float x_dir_min_value ;
  float x_dir_max_value ;
  // and a value for suggesting the likelihood of getting a value in the 'other direction'...
  // (however we figure that out...)
  float x_dir_negation_probability ;

  // __ x min / max heading INCREMENTATIONs of current heading
  // - i.e. if we modify the heading using incrementation values, these are the min/max incrementation values
  float x_dir_min_incrementation_value ;
  float x_dir_max_incrementation_value ;
  // and the negation probability of this
  float x_dir_incrementation_negation_probability ;   



  //  y  min / max  --  ABSOLUTE VALUEs
  float y_dir_min_value ;
  float y_dir_max_value ;
  // and a value for suggesting the likelihood of getting a value in the 'other direction'...
  // (however we figure that out...)
  float y_dir_negation_probability ;

  // __ y min / max heading INCREMENTATIONs of current heading
  // - i.e. if we modify the heading using incrementation values, these are the min/max incrementation values
  float y_dir_min_incrementation_value ;
  float y_dir_max_incrementation_value ;
  // and the negation probability of this
  float y_dir_incrementation_negation_probability ; 


  //   speed ??  -- ABSOLUTE VALUEs
  float min_speed ;
  float max_speed ;
  // the likelihood of getting a negative speed
  float speed_negation_probability ;

  /// __ (new) speed values (as) INCREMENTATIONs of the current..
  float min_speed_incrementation_of_curr_speed ;
  float max_speed_incrementation_of_curr_speed ;  
  /// and the likelihood of getting a negative value?
  float speed_incrementation_value_negation_probability ;




  //   min / max number of steps in the change
  int min_steps_of_value_change ;
  int max_steps_of_value_change ;

  //  min / max num of time of staying in the same mode (unchaning)
  // - in milliseconds
  int min_time_of_non_changing_mode ;
  int max_time_of_non_changing_mode ;






  // _____________________________________    constructor    _______________________________________


  Line_cl( boolean changing_direction_in_nonChanging_mode_, 
  boolean changing_speed_incremntally_in_changing_mode_, 
  boolean changing_speed_in_nonChanging_mode_, 
  boolean new_direction_values_are_increments_of_curr_heading_or_absolute_headings_true_false_, 
  boolean new_speed_value_is_an_increment_of_curr_speed_or_absolute_speed_value_true_false_, 
  int num_of_line_points_, 
  int num_of_line_pts_to_draw_,
  color line_stroke_colour_,
  float general_transparency_level_,
  boolean fade_line_to_transparency_,
  float line_stroke_weight_,
  int time_of_next_change_,
  float x_dir_min_value_,
  float x_dir_max_value_,
  float x_dir_negation_probability_, 
  float x_dir_min_incrementation_value_, 
  float x_dir_max_incrementation_value_,
  float x_dir_incrementation_negation_probability_,
  float y_dir_min_value_,
  float y_dir_max_value_,
  float y_dir_negation_probability_, 
  float y_dir_min_incrementation_value_,
  float y_dir_max_incrementation_value_,
  float y_dir_incrementation_negation_probability_,
  float min_speed_,
  float max_speed_,
  float speed_negation_probability_, 
  float min_speed_incrementation_of_curr_speed_,
  float max_speed_incrementation_of_curr_speed_,
  float speed_incrementation_value_negation_probability_,
  int min_steps_of_value_change_,
  int max_steps_of_value_change_,
  int min_time_of_non_changing_mode_, 
  int max_time_of_non_changing_mode_  ) {


    // ___ line behaviour

    // whether we change the heading in changing and nonchanging mode
    changing_direction_in_nonChanging_mode = changing_direction_in_nonChanging_mode_ ;
    // update_velocity_incrementally_or_absolutely_in_NON_ch_mode = "kuyghg";

    // this indicates whether we're changing speed in the changing mode
    changing_speed_incremntally_in_changing_mode = changing_speed_incremntally_in_changing_mode_ ; 
    // update_velocity_incrementally_or_absolutely_in_ch_mode = "absolutely" ;

    // and this indicates whether we change speed in nonChanging mode
    changing_speed_in_nonChanging_mode = changing_speed_in_nonChanging_mode_ ;

    // ______________   advanced line behaviour

    // ___ new heading = incremented current heading or absolute new heading
    // this switch indicates whether the new (end) value of transitions
    // are a product of adding a random(min,max) value to the current heading, or just letting the heading be random(min, max)
    //    true = incrementation, false = absolute
    new_direction_values_are_increments_of_curr_heading_or_absolute_headings_true_false = new_direction_values_are_increments_of_curr_heading_or_absolute_headings_true_false_ ;

    // ___ is the new speed an incrementation of the previous speed, or an aboslute speed
    //    true = incrementation, false = absolute
    new_speed_value_is_an_increment_of_curr_speed_or_absolute_speed_value_true_false = new_speed_value_is_an_increment_of_curr_speed_or_absolute_speed_value_true_false_ ;    








    // ___ line qualities

    // number of points visible in the line?
    // NOTE: this becomes the length of the line positions stack!
    num_of_line_points = num_of_line_points_ ;

    num_of_line_pts_to_draw = num_of_line_pts_to_draw_ ;

    // very local issue - array where to hold the x coord values
    x_coords_pts_array = new float[ num_of_line_points ];
    y_coords_pts_array = new float[ num_of_line_points ];
    // and a z array?? - let's do it for fun :)
    // - use different update position functions if we're doing 2d or 3d
    z_coords_pts_array = new float[ num_of_line_points ];  

    // __ curr line coords pt index 
    // set this according to the number of points to draw
    // - makes the later calculations easier. (saves us from negative array index checking...)
    // - 
    // 
    if( num_of_line_pts_to_draw == 0 ) {
      // putting the '-1' in there so it doesn't do a complete loop and go around from the beginning..
      num_of_line_pts_to_draw = num_of_line_points-1;
    }
    curr_line_pts_coords_array_index = num_of_line_pts_to_draw+1 ;

    // stroke colour?
    line_stroke_colour = line_stroke_colour_ ;

    // the general transparency level - even sets the max transparency which is faded
    general_transparency_level = general_transparency_level_ ;

    // >> fade to transparency along the length of the line??? YES!
    // flag it here please!
    fade_line_to_transparency = fade_line_to_transparency_ ;

    // stroke weight
    line_stroke_weight = line_stroke_weight_ ;

    // FLAG indicating whether we're changing or not
    we_are_changing = false ;

    // this indicates the time when we change next time
    time_of_next_change = time_of_next_change_ ;


    // __  directions and speed

    //  x  min / max direction - ABSOLUTE VALUES
    x_dir_min_value = x_dir_min_value_ ;
    x_dir_max_value = x_dir_max_value_ ;
    // and a value for suggesting the likelihood of getting a value in the 'other direction'...
    // (however we figure that out...)
    x_dir_negation_probability = x_dir_negation_probability_ ;


    // __ x min / max heading INCREMENTATION VALUEs of current heading
    // - i.e. if we modify the heading using incrementation values, these are the min/max incrementation values
    x_dir_min_incrementation_value = x_dir_min_incrementation_value_ ;
    x_dir_max_incrementation_value = x_dir_max_incrementation_value_ ;
    // and the negation probability of this
    x_dir_incrementation_negation_probability = x_dir_incrementation_negation_probability_ ; 



    //  y  min / max
    y_dir_min_value = y_dir_min_value_ ;
    y_dir_max_value = y_dir_max_value_ ;
    // and a value for suggesting the likelihood of getting a value in the 'other direction'...
    // (however we figure that out...)
    y_dir_negation_probability = y_dir_negation_probability_ ;



    // __ y min / max heading INCREMENTATIONs of current heading
    // - i.e. if we modify the heading using incrementation values, these are the min/max incrementation values
    y_dir_min_incrementation_value = y_dir_min_incrementation_value_ ;
    y_dir_max_incrementation_value = y_dir_max_incrementation_value_ ;
    // and the negation probability of this
    y_dir_incrementation_negation_probability_ = y_dir_incrementation_negation_probability_ ; 


    //   speed ??
    min_speed = min_speed_ ;
    max_speed = max_speed_ ;
    // the likelihood of getting a negative speed
    speed_negation_probability = speed_negation_probability_ ;


    /// __ (new) speed values INCREMENTATION VALUEs of the current..
    min_speed_incrementation_of_curr_speed = min_speed_incrementation_of_curr_speed_ ;
    max_speed_incrementation_of_curr_speed = max_speed_incrementation_of_curr_speed_ ;  
    /// and the likelihood of getting a negative value?
    speed_incrementation_value_negation_probability = speed_incrementation_value_negation_probability_ ;






    //   min / max number of steps in the change
    min_steps_of_value_change = min_steps_of_value_change_ ;
    max_steps_of_value_change = max_steps_of_value_change_ ;

    //  min / max num of time of staying in the same mode (unchaning)
    // - in milliseconds
    min_time_of_non_changing_mode = min_time_of_non_changing_mode_ ;
    max_time_of_non_changing_mode = max_time_of_non_changing_mode_ ; 



    // ______ setup the changing gen instances!

    // make space for them
    change_value_generators = new Change_values_gen[ num_of_change_val_generators ] ;
    // initialise them
    for( int i = 0 ; i < num_of_change_val_generators; i++ ) {
      change_value_generators[i] = new Change_values_gen();
    }
  }






  // =============================================   class methods   =============================


  // _________________________________________________________________________________________


  // the update position function, which is sensitive to changing/nonchanging
  //   and different ways of 'being passive'

  void update_position() {

    // ___ do different things depending on whether we're changing directions + velocities or not
    /*
      - if the 'changing direction in nonchanging mode' flag is true, then update the rot vel incr here
     and we add it to the direction here immediately.
     - if the 'changing direction in nonChanging mode' flag is FALSE, then we update the direction here
     */

    //
    if( debug > 2 ) {
      println(" \n\n linecl: changing mode : update position ");
    }

    if( we_are_changing ) {

      //
      if( debug > 2 ) {
        println(" linecl: changing mode, updating values generators AND checking if any of the value generators are finished ");
      }

      // update the values in the transition generators
      for( int i = 0; i < num_of_change_val_generators ; i++ ) {        
        change_value_generators[i].fetch_current_value_and_increment_stepCounter() ;
      }

      // ARE WE DONE in the CHANGING VALUES loop? - stop changing?
      // check if any of them are done... well, that means we're done changing.
      // and if they are, stop getting new values here, 
      // and initialise a nonChanging period
      if( check_if_any_changing_vals_gens_are_done() ) {

        //
        if( debug > 3 ) {
          println(" linecl: changing mode : checking if any val gens are done - SOMEONE is done! ");
        }

        // ___ if we're here, then one of the vals gens are done... and then we

        // set a new time for the next period of changing
        set_new_time_of_changing_period();

        // make the non-chaning period official ;-) 
        we_are_changing = false;

        // feedback for helpless coders 
        if( debug > 2 ) {
          println("\n update_pos: we_are_chaning : detected end of changing period. switching flag, setting new time of change ");
          println(" \t set new time of next changing period. current time: "+millis()+" , new time: "+time_of_next_change );
        }
      }
      //  IF WE'RE in CHANGING mode (not at the end of ch loop)
      //  update the values as appropriate
      else {

        //
        if( debug > 2 ) {
          println(" \n\n linecl: changing mode :  ");
        }

        // check whether we'll be CHANGING HEADING in nonChanging mode
        // - get a change in the rot_incr, which you'll add to the heading
        // (i.e. we're changing the spee of heading change)
        if( changing_direction_in_nonChanging_mode ) {
          // update curr *incr* values
          changing_mode_update_values( "changing_dir_in_nonChanging_mode" );

          //
          if( debug > 2 ) {
            println(" linecl: changing mode : changing_direction_in_nonChanging_mode : just updated heading acc. to incr ");
          }
        }
        // and IF WE're keeping a CONSTATNT HEADING in nonChanging mode
        // - change the heading directly (this is the changing value)
        else {
          // update the *heading* directly - and not the incrementors first, as above
          changing_mode_update_values( "NOT_changing_dir_in_nonChanging_mode" );

          if( debug > 2 ) {
            println(" linecl: changing mode : NOT_changing_direction_in_nonChanging_mode : NOT updating heading acc. to incr, JUST updating heading directly");
          }
        }

        /*
- might not need this
         // remember the velocity incrementation flag too!!!      
         // CHANGING VELOCITY IN CHANGING MODE?
         if( changing_speed_incremntally_in_changing_mode ){
         
         // update the velocity according to the vel incr.
         update_velocity_according_to_vel_incrementor();
         
         // feedback
         if( debug > 3 ){
         // println("\n line cl: changing mode : changing vel during changing . "+update_velocity_incrementally_or_absolutely_in_ch_mode+"   new vel = "+curr_velocity );
         println("\n line cl: changing mode : changing vel during changing . new vel = "+curr_velocity );
         }
         }
         */


        // ... are we done changing?
      }
    }


    /*
    if NOT in CHANGING MODE
     - if we're not in the active changing mode, 
     - just keep heading in the same direction, if we're not using the rot / vel incrementors here
     - add the rot / vel incrementors as appropriate
     */
    if( !we_are_changing ) {

      //
      if( debug > 2) {
        println(" line cl: updating() NON_CH_mode:   curr time: "+millis()+"  time of next change: "+time_of_next_change );
      }

      // check TIME TO START A NEW CHANGE?????
      if( millis() > time_of_next_change ) {

        // INITIALISE NEW CHANGE!
        initialise_new_changes_generators();

        // make it official
        we_are_changing = true;

        // .... announce it in text...
        if( debug > 3 ) {
          println(" \n line cl: updating() NON_CH_mode:  if( curr_time > time_of_next_change): just set new values for ch generators" );
        }
      }
      // NOT TIME TO START NEW CHANGE - keep going as before
      // not changing values - keep the same values ( i.e. heading or heading incr values )
      // i.e. it's not time to change, just update the current position in different ways
      else {

        // ___ remember the different modes of being constant... . REMEMBER THE FLAG!


        if( changing_direction_in_nonChanging_mode ) {

          // then use the rot incr to update the heading
          update_headings_according_to_incrementors();

          // baadd feedback... 
          if( debug > 3) {
            println("\n linecl: updating() NON_CH_mode: changing_dir: updating heading using icrementors ");
            println(" \t new x/y heading "+curr_x_rot_heading+","+curr_y_rot_heading );
          }
        }
        else {
          // then just keep the same heading
          // 
          // baadd feedback... 
          if( debug > 3) {
            println("\n linecl: updating() NON_CH_mode: NOT_changing_dir: KEEPING the same HEADING in nonCh mode: which is x/y: "+curr_x_rot_heading+", "+curr_y_rot_heading+"   at vel: "+curr_velocity );
          }
        }


        // remember the velocity incrementation flag too!!!
        if( changing_speed_in_nonChanging_mode ) {
          // update the velocity with the vel incr 
          update_velocity_according_to_vel_incrementor();
          /* -- mea culpa...
           update_velocity_incrementally_or_absolutely( update_velocity_incrementally_or_absolutely_in_NON_ch_mode );
           */
          // feeble programmer feedback
          if( debug > 3 ) {
            println(" linecl: updating() NON_CH_mode: changing_vel: incrementing/updating velocity to "+curr_velocity );
          }
        }
        else {
          // ie. don't update the velocity - then do nothing ;-)
          // not even this is needed ;)  
          if( debug > 3 ) {
            println(" linecl: updating() NON_CH_mode: NOT_changing_dir: NOT incrementing/updating velocity" );
          }
        }
      }
    }



    // ________ and then update the position and draw!  _______

    if( debug > 2) {
      println(" line cl: updating(): getting ready to update the position: curr x/y rot + vel = "+curr_x_rot_heading+", "+curr_y_rot_heading+"   at vel: "+curr_velocity );
    }

    // ___ find the vector at the currrent x/y rot and velcoity    
    PVector curr_3d_vector = find_curr_vector_given_x_y_rot_and_vel();


    // ___ add the vector to the previous position to get the current position

    // find the current and previous absolute coords array index positions first though
    int curr_abs_line_pts_coords_index = curr_line_pts_coords_array_index % x_coords_pts_array.length ;
    // and the previous
    int prev_abs_line_pts_coords_index = (curr_line_pts_coords_array_index-1) % x_coords_pts_array.length ;

    if( debug > 4 ) {
      println(" line cl: updating() (near end): updating x/y/z array pos - have this index "+curr_line_pts_coords_array_index+", calculated these abs prev/curr "+prev_abs_line_pts_coords_index+"/"+curr_abs_line_pts_coords_index+" indicies of array length "+x_coords_pts_array.length);
    }

    //   set... 
    // __ and update the current position, given the previous position
    x_coords_pts_array[ curr_abs_line_pts_coords_index ] = x_coords_pts_array[ prev_abs_line_pts_coords_index ] + curr_3d_vector.x ;
    y_coords_pts_array[ curr_abs_line_pts_coords_index ] = y_coords_pts_array[ prev_abs_line_pts_coords_index ] + curr_3d_vector.y ;
    // for debugging: println(" almost done z array ");
    z_coords_pts_array[ curr_abs_line_pts_coords_index ] = z_coords_pts_array[ prev_abs_line_pts_coords_index ] + curr_3d_vector.z ;    

    if( debug > 2) {
      println(" \n line cl: updating(): final part - updating position :   added it to the prev pos . curr pos x/y/z: "+x_coords_pts_array[ curr_abs_line_pts_coords_index ]+", "+y_coords_pts_array[ curr_abs_line_pts_coords_index ]+", "+z_coords_pts_array[ curr_abs_line_pts_coords_index ] );
    }


    // _____________   and then draw the current line....    ______________
    //        remembering that we're drawing a series of points!
    //          (and we might be fading to transp along the line... )


    // _____________ for the next loop: remember to update the index of where we are in the array of positions!
    curr_line_pts_coords_array_index++ ;


    // ________ LE FIN???  __________ of the update loop???
  }







  // _________________________________________________________________________________________

  /*
  this function simply fetches the class specific global min/max values 
   and sets the change_value_generators' values right
   (including setting the curr index to zero!)
   */



  // NOTE: the following version is a modified version of the code below,
  //    which does't allow for incrementally new values

  void initialise_new_changes_generators() {

    // __ establish how long the transition is to be
    int transition_length_in_num_of_steps = int( random( min_steps_of_value_change, max_steps_of_value_change ) );



    // _____ set up x/y rot and, possibly, velocity

    // NOTE: HARDCODING - what kind of transition - the same for all of them
    String what_kind_of_transition = "linear";

    // __ we'd be updating different kinds of values - the rotation heading/vel or rot/vel incr depending on 
    //     whether we're heading in the same direction during the nonChanging period

    // __ initialise globals - 
    // x
    float x_start_val ; 
    float x_end_val ; // will always be the same, regardless of nonChanging mode dir/incr changing thingies
    // y 
    float y_start_val ;
    float y_end_val ; 
    // velocity 
    float vel_start_val ;
    float vel_end_val ;



    // _ for the changing direction in nonChanging mode - the start/end values are that of the rotation icr
    if( changing_direction_in_nonChanging_mode ) {

      // x
      x_start_val = curr_x_rot_incr ;       
      // y 
      y_start_val = curr_y_rot_incr ;      
      // velocity 
      //// vel_start_val = curr_velocity_incr ;
    }
    // for static direction - the current and end values are that of the heading
    else {

      // x
      x_start_val = curr_x_rot_heading ;  
      // y 
      y_start_val = curr_y_rot_heading ;
      // velocity 
      // vel_start_val = curr_velocity ;
    }



    // __ NEW HEADING -  incrementation of the current heading, or an absolute new heading?
    //__ depending on whether we're establishing the new value as an incrementation of the current value
    //    or as an absolute value... do different things.. 


    if( new_direction_values_are_increments_of_curr_heading_or_absolute_headings_true_false ) {

      // ___ do x

      // find the incrementation value
      float x_end_val_incrementation = random( x_dir_min_incrementation_value, x_dir_max_incrementation_value );

      // ___ do we negate things?
      if( random(1) > x_dir_incrementation_negation_probability ) {
        x_end_val_incrementation *= -1 ;
      }

      // __ then finaly add the x incrementation to the current value
      x_end_val = x_start_val + x_end_val_incrementation ;


      // ___ then do y

      // _ find the incrementation vlaue
      float y_end_val_incrementation = random( y_dir_min_incrementation_value, y_dir_max_incrementation_value );

      // ___ do we negate it?
      if( random(1) > y_dir_incrementation_negation_probability ) {
        y_end_val_incrementation *= -1 ;
      }  

      // __ then finaly add the y incrementation to the current value
      y_end_val = y_start_val + y_end_val_incrementation ;
    }
    // if we're 'just' setting an absolute value?
    else {

      // __ do fin x
      x_end_val = random( x_dir_min_value, x_dir_max_value ) ; // will always be the same, regardless of nonChanging mode dir/incr changing thingies

      // x negation????!!!
      if( random(1) > x_dir_negation_probability ) {
        x_end_val *= -1;
      }

      // __ do find y
      y_end_val = random( y_dir_min_value, y_dir_max_value ) ; 

      // y negation???!!!
      if( random(1) > y_dir_negation_probability ) {
        y_end_val *= -1;
      }
    }




    // __ then do the speed separately
    if( changing_speed_incremntally_in_changing_mode ) {
      vel_start_val = curr_velocity_incr ;
    }
    else {
      vel_start_val = curr_velocity ;
    }

    /// __ VELOCITY: new velocity: an incrementation of the curr vel or a new aboslute velocity???
    if( new_speed_value_is_an_increment_of_curr_speed_or_absolute_speed_value_true_false ) {

      // feeeeble feedback
      if( debug > 3 ) {
        println(" linecl: INITIALISING NEW CHANGE GENS: new_speed_value_is_an_increment_of_curr_speed_or_absolute_speed_value_true_false - INCREMENTING VELOCITY!!! ");
      }

      //   ok, so we're settign a new velocity that's an increment of the previous
      float speed_incremenation_value = random( min_speed_incrementation_of_curr_speed, max_speed_incrementation_of_curr_speed );

      // is the value negative?
      if( random(1) > speed_incrementation_value_negation_probability ) {
        speed_incremenation_value *= -1 ;
      }

      // then finally add the incrementation value to the current speed, to get the end value
      vel_end_val = vel_start_val + speed_incremenation_value;
    }
    // and if we're 'just' setting the velocity absolutely?
    else {
      vel_end_val = random( min_speed, max_speed );

      // is it negated?
      if( random(1) > speed_negation_probability ) {
        vel_end_val *= -1 ;
      }
    }












    // __ - input for the generators = String type_of_transition, 
    //      float probability_of_getting_a_negated_value_on_initialisation, int num_of_steps_, float start_val, float end_val 

    // the following refers to the values sent below
    if( debug > 3) {
      println(" line cl: initialising new value gens : x val curr/max value : "+x_start_val+", "+x_end_val+"   neg. possibility : "+x_dir_negation_probability+"   transition length = "+transition_length_in_num_of_steps );
      println(" line cl: initialising new value gens : y val curr/max value : "+y_start_val+", "+y_end_val+"   neg. possibility : "+y_dir_negation_probability );
      println(" line cl: initialising new value gens :   vel curr/max value : "+vel_start_val+", "+vel_end_val+"   neg. possibility : "+speed_negation_probability);
    }


    // __ x rot
    change_value_generators[ x_rot_changer_gen_index ].initialise( what_kind_of_transition, 
    transition_length_in_num_of_steps, x_start_val, x_end_val );

    // __ y rot
    change_value_generators[ y_rot_changer_gen_index ].initialise( what_kind_of_transition, 
    transition_length_in_num_of_steps, y_start_val, y_end_val );    

    // __ and possibly velocity
    change_value_generators[ velocity_changer_gen_index ].initialise( what_kind_of_transition, 
    transition_length_in_num_of_steps, vel_start_val, vel_end_val );
  }


  // _________________________________________________________________________________________


  // a little function that returns a false is any of the changing values gens are done!
  boolean check_if_any_changing_vals_gens_are_done() {

    // initialise
    boolean is_any_change_val_generators_finnished = false;

    for( int i = 0 ; i < num_of_change_val_generators; i++ ) {
      // if ANY one is finished, then record this  
      if( change_value_generators[i].is_transition_in_progress_TrueFalse == false ) {
        is_any_change_val_generators_finnished = true;
      }
    }   

    // and then return the verdict
    return is_any_change_val_generators_finnished ;
  }


  // _________________________________________________________________________________________


  /*
  090905
   a nice little function that sets the time at which the new changing period starts!
   */

  void set_new_time_of_changing_period() {  
    time_of_next_change = int(millis() + random( min_time_of_non_changing_mode, max_time_of_non_changing_mode ));
    if( debug > 3 ) {
      println(" line cl: set_new_time_of_changing_period() : curr time / new time = "+millis()+" /  "+time_of_next_change );
    }
  }


  // _________________________________________________________________________________________

  /*
  090905 
   updates values in changing values
   - sensitive as to whether we'll be changing direction in non-changing mode or not:
   - if we're changing direction in non-changing mode, then update the incrementors
   - if we're keeping the same heading in non-changing mode, update the heading
   */

  void changing_mode_update_values( String what_are_we_doing_with_the_direction_in_nonChanging_mode ) {

    // fetch the current values
    // ( decide what to do with them in the if statement below)
    float curr_x_val = change_value_generators[ x_rot_changer_gen_index ].current_value ;
    float curr_y_val = change_value_generators[ y_rot_changer_gen_index ].current_value ;
    float curr_vel_val = change_value_generators[ velocity_changer_gen_index ].current_value ;

    // check whether we're changing direction in nonchanging mode or not
    if( what_are_we_doing_with_the_direction_in_nonChanging_mode == "changing_dir_in_nonChanging_mode" ) {

      // feedback?
      if( debug > 3 ) {
        println("\n line cl: ch_mode : updating vals : ch_dir_in_nonCh_mode, so: updating incrementors ");
      }

      // use the gotten values to update the incrementors
      curr_x_rot_incr = curr_x_val ;
      curr_y_rot_incr = curr_y_val ;
      curr_velocity_incr = curr_vel_val ;     

      // then use the incrementors to update the heading
      // (so we actually see something happening during changing period)
      // MAKE IT A FUNCTION!
      update_headings_according_to_incrementors();
    }
    // IF we're NOT CHANGING DIR IN NON-CHANGING MODE, then there's no need to update the incrementors
    //  and just UPDATE THE HEADING directly
    else {

      // feedback?
      if( debug > 3 ) {
        println("\n line cl: ch_mode : updating vals : NOT_ch_dir_in_nonCh_mode, so: updating heading ");
      }

      // use the gotten values to update the heading
      curr_x_rot_heading = curr_x_val ;
      curr_y_rot_heading = curr_y_val ;
      // curr_velocity = curr_vel_val ;
    }

    // do we increment or set absolutely?
    if( changing_speed_incremntally_in_changing_mode ) {
      curr_velocity_incr = curr_vel_val ;
    }
    else {
      curr_velocity = curr_vel_val ;
    }
  }


  // __________________________________________________________________________________________________

  /*
  090905
   a nice little function that updates the heading according to incrmentors
   */

  void  update_headings_according_to_incrementors() {

    curr_x_rot_heading += curr_x_rot_incr ;
    curr_y_rot_heading += curr_y_rot_incr ;
    // curr_velocity += curr_velocity_incr ;
  }



  // __________________________________________________________________________________________________

  /*
  090905
   a nice little function that updates the velcoity incrmentally OR absolutely
   */

  void update_velocity_according_to_vel_incrementor() {
    curr_velocity += curr_velocity_incr;
  }



  // __________________________________________________________________________________________________



  PVector find_curr_vector_given_x_y_rot_and_vel() {

    // input:  float rot_x, float rot_y, float  radius 
    PVector curr_heading_3d_vector = find_pos_given_rot_and_radius( curr_x_rot_heading, curr_y_rot_heading, curr_velocity );

    // return it
    return curr_heading_3d_vector ;

    // ________  the end?
  }




  // __________________________________________________________________________________________________  

  /*
  090906
   a nice little (quickly put togther) function that draws the current line/position
   */


  void quick_draw_line() {


    // ________  set the indicies of what line points we're drawing

    int abs_num_of_pts_to_draw = num_of_line_pts_to_draw ;

    // ___  which cumulative index to start from ?
    //   - we've fixed it in the initialisation that we can't get a >1 number via the following subtraction
    //      ( we simply start at the index number = num_of_pts_to_draw+1 )
    int line_drawing_coords_array_index_start = curr_line_pts_coords_array_index - abs_num_of_pts_to_draw ;
    /* -- I hope I fixed this a little further up in the constructor
     // just make sure it's more than zero, as we'd otherwise try indexing the array with 
     // negative indicies... which wouldn't be good. 
     if( line_drawing_coords_array_index_start < 1 ){
     line_drawing_coords_array_index_start = 1;
     }
     // the end index is our current index position
     
     // this just helps with the line fading later
     // - the number of this varies depending on where we are 
     int abs_num_of_pts_drawing_this_time = curr_line_pts_coords_array_index - line_drawing_coords_array_index_start;
     */

    // _____ oops, must have made quite some mistakes to have to need this:
    if( debug > 3) {
      println(" \n\n linecl: quickdraw:  starting...  abs_num_of_pts_to_draw: "+abs_num_of_pts_to_draw+",   line_drawing_coords_array_index_start: "+line_drawing_coords_array_index_start );
    }




    // __________  loop through the points and draw them

    //  dirty modification - trying to speed up drawing speed
    if( draw_line_as_one_long_line == true ) {
      beginShape();

      // just do this once:

      // and finally... set the line qualities
      // noFill();
      noStroke();
      if( doing_line_transparency ) {
        fill( line_stroke_colour, general_transparency_level );
      }
      else {
        fill( line_stroke_colour );
      }
      // strokeWeight( line_stroke_weight );
    }


    // 
    for( int curr_pt_to_draw_i = line_drawing_coords_array_index_start; curr_pt_to_draw_i < curr_line_pts_coords_array_index; curr_pt_to_draw_i++ ) {





      // __________   fix the indicies  
      // - turn them from endlessly cumulative, to values fitting inside the normal array index/length

      // fetch the previous point index
      int abs_prev_pt_to_draw_i = ( curr_pt_to_draw_i-1 ) % num_of_line_points ;

      // fix the current point number
      int abs_curr_pt_to_draw_i = curr_pt_to_draw_i % num_of_line_points ;

      //  dirty dirty dirty way of drawing faster... maybe
      if( draw_line_as_one_long_line == true ) {

        /*
        draw the line bits in parallel
         */

        /*
                    // prev pt top
         vertex(  x_coords_pts_array[ abs_prev_pt_to_draw_i ], y_coords_pts_array[ abs_prev_pt_to_draw_i ] + dist_to_shiftShapeBy, z_coords_pts_array[ abs_prev_pt_to_draw_i]  );
         // prev pt bottom
         vertex(  x_coords_pts_array[ abs_prev_pt_to_draw_i ], y_coords_pts_array[ abs_prev_pt_to_draw_i ] - dist_to_shiftShapeBy, z_coords_pts_array[ abs_prev_pt_to_draw_i]  );
         */

        // curr pt bottom
        vertex(  x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i] - dist_to_shiftShapeBy, z_coords_pts_array[ abs_curr_pt_to_draw_i] );
        // curr pt right
        vertex(  x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i] + dist_to_shiftShapeBy, z_coords_pts_array[ abs_curr_pt_to_draw_i] );
      }
      else {

        // _________ more feedback for confused coders
        if( debug > 4 ) {        
          println(" linecl: quickdraw: fetched the absolute pt indicies numbers - previous / current "+abs_prev_pt_to_draw_i+", "+abs_curr_pt_to_draw_i );
        }

        if( debug > 5 ) {
          println(" linecl: quickdraw: prev_pt_coords x/y/z = "+x_coords_pts_array[ abs_prev_pt_to_draw_i ]+", "+y_coords_pts_array[ abs_prev_pt_to_draw_i ]+", "+z_coords_pts_array[ abs_prev_pt_to_draw_i] );
          println(" linecl: quickdraw: curr_pt_coords x/y/z = "+x_coords_pts_array[ abs_curr_pt_to_draw_i ]+", "+y_coords_pts_array[ abs_curr_pt_to_draw_i ]+", "+z_coords_pts_array[ abs_curr_pt_to_draw_i] );
        }



        // _______  set the line qualities
        //   - a little strange to do it here, before that below, but it's just alittle easier thus

        // do special things depending on whether we want the line to fade or not
        // make global
        float curr_pt_transparency_level = general_transparency_level;
        if( fade_line_to_transparency ) {
          curr_pt_transparency_level = 255*( (curr_pt_to_draw_i-line_drawing_coords_array_index_start) / float( num_of_line_pts_to_draw )) ;
        }

        // do we fade acc to z dist?  <<<< experimental
        if( fade_line_acc_to_z_dist ) {    
          curr_pt_transparency_level *= ( z_coords_pts_array[ abs_prev_pt_to_draw_i]/total_z_dist ) ;
          curr_pt_transparency_level = max( min_transp_value, curr_pt_transparency_level);
        }

        // and finally... set the line qualities
        // noFill();
        noStroke();
        // stroke( line_stroke_colour, curr_pt_transparency_level );  
        fill( line_stroke_colour, curr_pt_transparency_level );
        //  strokeWeight( line_stroke_weight );



        // ________ baaaaaaaaad feedback
        if( debug > 5 ) {        
          println(" linecl: quickdraw: working on pt num "+curr_pt_to_draw_i+" started at pt num "+line_drawing_coords_array_index_start+" and continuing until "+curr_line_pts_coords_array_index );
        }







        // __________ draw 2d or 3d?
        if( drawing_in_2d_or_3d_true_false ) {

          if( what_kind_of_shape_to_draw == "line" ) {
            // loops like we're drawing in 2d
            line( x_coords_pts_array[ abs_prev_pt_to_draw_i ], y_coords_pts_array[ abs_prev_pt_to_draw_i ],
            x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i] );      

            if( drawing_double_line ) {
              line( x_coords_pts_array[ abs_prev_pt_to_draw_i ], y_coords_pts_array[ abs_prev_pt_to_draw_i ] + double_line_Y_dist_above,
              x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i]+double_line_Y_dist_above );
            }
          }

          if( what_kind_of_shape_to_draw == "ellipse" ) {
            pushMatrix();
            translate( x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i] );
            ellipse( 0, 0, ellipse_size, ellipse_size );
            popMatrix();
          }
        }
        else {

          if( what_kind_of_shape_to_draw == "line" ) {
            //   ___________ if we're drawing in 3d we use 3 coord points :)
            line( x_coords_pts_array[ abs_prev_pt_to_draw_i ], y_coords_pts_array[ abs_prev_pt_to_draw_i ], z_coords_pts_array[ abs_prev_pt_to_draw_i],
            x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i], z_coords_pts_array[ abs_curr_pt_to_draw_i] );

            //   ___________ just TESTING and drwaing another line, just a little further up, 
            //         to see if we can get a little more perspective.. 
            if( drawing_double_line ) {
              line( x_coords_pts_array[ abs_prev_pt_to_draw_i ], y_coords_pts_array[ abs_prev_pt_to_draw_i ], z_coords_pts_array[ abs_prev_pt_to_draw_i]+double_line_Y_dist_above,
              x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i], z_coords_pts_array[ abs_curr_pt_to_draw_i]+double_line_Y_dist_above );
            }
          }

          if( what_kind_of_shape_to_draw == "wide_line" ) {
            //   ___________ if we're drawing in 3d we use 3 coord points :)

            /*
          
             let's try drawinga wide line... 
             - how?
             add left/right? to the points?
             
             */


            beginShape(); 
            // prev pt top
            vertex(  x_coords_pts_array[ abs_prev_pt_to_draw_i ], y_coords_pts_array[ abs_prev_pt_to_draw_i ] + dist_to_shiftShapeBy, z_coords_pts_array[ abs_prev_pt_to_draw_i]  );
            // prev pt bottom
            vertex(  x_coords_pts_array[ abs_prev_pt_to_draw_i ], y_coords_pts_array[ abs_prev_pt_to_draw_i ] - dist_to_shiftShapeBy, z_coords_pts_array[ abs_prev_pt_to_draw_i]  );
            // curr pt bottom
            vertex(  x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i] - dist_to_shiftShapeBy, z_coords_pts_array[ abs_curr_pt_to_draw_i] );
            // curr pt right
            vertex(  x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i] + dist_to_shiftShapeBy, z_coords_pts_array[ abs_curr_pt_to_draw_i] );
            endShape( CLOSE );
            //
          }

          if( what_kind_of_shape_to_draw == "ellipse" ) {
            pushMatrix();
            translate( x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i], z_coords_pts_array[ abs_curr_pt_to_draw_i] );
            ellipse( 0, 0, ellipse_size, ellipse_size );
            popMatrix();
          }

          if( what_kind_of_shape_to_draw == "rect" ) {
            pushMatrix();
            translate( x_coords_pts_array[ abs_curr_pt_to_draw_i], y_coords_pts_array[ abs_curr_pt_to_draw_i], z_coords_pts_array[ abs_curr_pt_to_draw_i] );
            rect( 0, 0, ellipse_size, 4 );
            popMatrix();
          }
        }
      }
    }

    //  dirty modification - trying to speed up drawing speed
    if( draw_line_as_one_long_line == true /* || what_kind_of_shape_to_draw == "wide_line"*/  ) {
      endShape();
    }
  }


  // __________________________________________________________________________________________________  

  void check_that_lines_are_within_bounds_and_reverse_vel_if_not() {

    // ___ find the latest line point number... drawn... in absolute terms
    int curr_abs_coords_list_pos = (curr_line_pts_coords_array_index-1) % num_of_line_points ;  

    // just store the coords in a slightly cleaner way
    float curr_x_coord = x_coords_pts_array[ curr_abs_coords_list_pos ] ;
    float curr_y_coord = y_coords_pts_array[ curr_abs_coords_list_pos ] ;




    // __ check x
    if( x_coords_pts_array[ curr_abs_coords_list_pos ] > bounds_x_max ) {

      // some feedback        
      if( debug > 3 ) {
        println(" line cl: checking bounds : OOOOOOOOOOOOOPS hit one of the x max barriers! ");
      }

      // put it back within bounds
      x_coords_pts_array[ curr_abs_coords_list_pos ] = bounds_x_max;

      /* -- cmmented out for now, trying something different
       // reverse velocity
       curr_velocity *= -1;
       */
      curr_y_rot_heading += PI;
    }

    // __ check x
    if( x_coords_pts_array[ curr_abs_coords_list_pos ] < bounds_x_min ) {

      // some feedback        
      if( debug > 3 ) {
        println(" line cl: checking bounds : OOOOOOOOOOOOOPS hit the x max barrier! ");
      }

      // put it back within bounds
      x_coords_pts_array[ curr_abs_coords_list_pos ] = bounds_x_min;

      /* -- cmmented out for now, trying something different
       // reverse velocity
       curr_velocity *= -1;
       */
      curr_y_rot_heading += PI;
    }


    // __ and check if y is too large
    if( y_coords_pts_array[ curr_abs_coords_list_pos ] > bounds_y_max ) {

      // some feedback        
      if( debug > 3 ) {
        println(" line cl: checking bounds : OOOOOOOOOOOOOPS hit the y max barrier! ");
      }        

      // put it back in bounds
      y_coords_pts_array[ curr_abs_coords_list_pos ] = bounds_y_max ;

      /* -- commenting out, trying something different 
       // then reverse the velocity (well, there are nicer ways of doing this, but let's just do this for now
       curr_velocity *= -1;
       */
      // curr_y_rot_heading += PI;
      curr_x_rot_heading += PI;
    }
    // __ and check if y is too large
    if( y_coords_pts_array[ curr_abs_coords_list_pos ] < bounds_y_min ) {

      // some feedback        
      if( debug > 3 ) {
        println(" line cl: checking bounds : OOOOOOOOOOOOOPS hit the y min barrier! ");
      }        

      // put it back in bounds
      y_coords_pts_array[ curr_abs_coords_list_pos ] = bounds_y_min ;

      /* -- commenting out, trying something different 
       // then reverse the velocity (well, there are nicer ways of doing this, but let's just do this for now
       curr_velocity *= -1;
       */
      // curr_y_rot_heading += PI;
      curr_x_rot_heading += PI;
    }




    // ___ 3d sensitive things
    //    - if we're doing 3d we do this in addition:      
    // ___ are we 2d/3d sensitive, yes...
    if( drawing_in_2d_or_3d_true_false == false ) {

      // __ and check if y is too large
      if( z_coords_pts_array[ curr_abs_coords_list_pos ] > bounds_z_max ) {

        // some feedback        
        if( debug > 3 ) {
          println(" line cl: checking bounds : OOOOOOOOOOOOOPS hit the z max barrier! ");
        }        

        // put it back in bounds
        z_coords_pts_array[ curr_abs_coords_list_pos ] = bounds_z_max ;

        /* -- commenting out, trying something different 
         // then reverse the velocity (well, there are nicer ways of doing this, but let's just do this for now
         curr_velocity *= -1;
         */
        // curr_x_rot_heading += PI;
        curr_y_rot_heading += PI;
      }
      // __ and check if y is too large
      if( z_coords_pts_array[ curr_abs_coords_list_pos ] < bounds_y_min ) {

        // some feedback        
        if( debug > 3 ) {
          println(" line cl: checking bounds : OOOOOOOOOOOOOPS hit the z min barrier! ");
        }        

        // put it back in bounds
        z_coords_pts_array[ curr_abs_coords_list_pos ] = bounds_z_min ;

        // curr_x_rot_heading += PI;
        curr_y_rot_heading += PI;
      }
    }
  }


  // __________________________________________________________________________________________________  


  // __________________________________________________________________________________________________
} //   ____________________   end of class???




























































