
/*

 this keeps track of changing values.
 
 - initialise it with :
 - start / end values, and the number of steps needed to get there
 ( the start value is the current value and the new value is the end value)
 
 - the initialisation sets up the counter and figures out the steplength
 
 - update:
 - figures out the current value
 - if we're at the end, it returns a string (or something simlarly distinct) to indicate things are 'over'
 
 */


class Change_values_gen{


  // _______________________________________   initilisations     __________________________________




  /*
   NOTE: 
   NOTE:   when initalising values for new change, 
   NOTE:   one could just fetch the values via super.relev.values, instead of 
   NOTE:   trying to get them as arguments, etc... 
   NOTE: 
   */


  // _______ the values and basic steppings


  // ___ where the loop starts and ends, and where we are in it

  int curr_step_num = 0 ;

  int end_step_num = 0 ;


  /* -- actually, we're doing this in the line class, ... so no need for, methinks
   // ___ NOTE : WRITE THE COMMENTS FOR THIS!
   float probability_of_getting_a_negated_value_on_initialisation ;
   */

  // ___ and the actual values

  // this is what we've got now
  float current_value = 0 ;

  // the start value, to which we add the step_num*increment_val
  float transition_start_value ;

  // and, if we're doing a LINEAR TRANSITION, this is the
  // step between the values (put all the steps together and you should 
  // get the range between the values being transitioned between )
  float linear_value_transition_value_step_distance ;

  // - a little clumsily, we'll use this value to indicate whether 
  //   the value transition is over or not - remmber to check for it in super
  boolean is_transition_in_progress_TrueFalse = false;

  // and this is for other kinds of transitions....(eg. nonlinear)




  /*
 NOTE : when we initialise, we fetch some of the values
   from el superclass - such as the max/min probability values
   */





  // ___________________________________________  constructor ______________________________




  Change_values_gen(){

    //   setup_relevant_values()  ???
    // ...noooo.. we're just a little lazy... not doing anything.

  }



  // =============================================   class methods   =============================



  //    setup_relevant_start_values()
  //      - this function uses the super values to establish the inbetween step




  // __________________________________________________________________________________

  //   initialise
  //    counters, start/end nums... step distance
  //     making use of nice things like super...

  void initialise( String type_of_transition,
  int num_of_steps_, float start_val, float end_val ){

    // initialise the counter
    curr_step_num = 0;

    // the end step num - i.e. how long the transition is
    end_step_num = num_of_steps_ ;

    /* -- we're trying to do this in the line class instead
     // and USE THE PROBABILLTY OF NEGATING THE NEW VALUE HERE! HERE
     if( random( 1) > probability_of_getting_a_negated_value_on_initialisation ){
     
     if(debug > 3){
     println(" changing generator: initialising: with start val "+start_val+", looks like we're negating the end val" );
     }
     
     // negate the start value
     end_val *= -1 ;      
     }
     */


    // start value of the transition
    transition_start_value = start_val ;

    // ______ then set up the inbetween steps *IF* it's a linear transition

    if( type_of_transition == "linear" ){


      // find the step distance... (which, when all the steps have been taken, 
      //   make up the value range between the end and the start distance...)
      linear_value_transition_value_step_distance = ( end_val - transition_start_value ) / float( end_step_num ) ;

      if( debug > 3){
        println("\n\n changing values gen: initialising: got start/end val - "+transition_start_value+"/"+end_val+", num of steps - "+end_step_num+", and inbtw. step val - "+linear_value_transition_value_step_distance); 
      }

    }
    else{
      println("\n\n changing values gen: initialising: oooh, looks like we're donig some transition algorithm that we've not coded yet." );
    }


    // __ and turn it on...
    is_transition_in_progress_TrueFalse = true;


  }


  // __________________________________________________________________________________



  //  __ update current value

  /*
  
   this function:
   - calculates the current value
   - increments the current counter
   
   */


  void fetch_current_value_and_increment_stepCounter(){

    // do a bit of checking of where we are regarding start/end nums...
    if( curr_step_num >= end_step_num ){

      if( debug > 3 ){
        println("\n\n transition class here, with start value "+transition_start_value+" just finished the transition .. switching the transitioning flag ");
      }

      // when checked by super, this will signal that the transition is over
      // - and hopefully super will go into passive mode and reinitialise this 
      //   class with a new transition later (switching this flag to what it should be )
      is_transition_in_progress_TrueFalse = false;

    }
    // and if we've not reached the end yet - find the current value...
    else{

      // find the current value
      current_value = transition_start_value + ( curr_step_num * linear_value_transition_value_step_distance ) ;

      if( debug > 3 ){
        println("\n\n transition class here, with start value "+transition_start_value+" ... working on step "+curr_step_num+" / "+end_step_num );
        println("     just got the the following value "+current_value );
      }      

    } // end of if/else statement


    // _________   next loop things...

    // increment the counter
    curr_step_num++ ;


  }



  // _____________________________________________________________________________________


} // end of class







