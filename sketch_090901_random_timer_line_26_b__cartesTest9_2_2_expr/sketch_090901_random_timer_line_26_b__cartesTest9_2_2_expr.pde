/*

 // 090901
 
 a little sketch to test changing values and timers - shown as temperamental lines
 
 */


// __ lifesaver :)
int debug = 1;


// __ lifesaver too
import processing.opengl.* ;


// ___________  super line qualities

int num_of_lines = 5 ;
// put somewhere to put them
Line_cl[] lines;


//   NOTE the line parameters are in a function below draw()!




// _______ test of changing values gen _____

int num_of_changing_values_gens = 3;
Change_values_gen[] changing_values_gens ;



// ______________ view/drawing setings ____________________

// __ are we drawing in 2d or 3d?

// true for 2d, false for 3d
boolean drawing_in_2d_or_3d_true_false = false;

// __ do we move to follow the latest point of the line
boolean move_view_to_center_on_line_latest_point = true;


// ___ some line drawing qualities/characteristics

//  dirty dirty dirty 
//   do we draw the whole line as one shape...?
//     trying to speed up the drawing... 
boolean draw_line_as_one_long_line = false; 

// __ testing wit drwaing different kinds of shapes.
// - so far the possibilities include "line", "ellipse", "rect", "wide_line"
String what_kind_of_shape_to_draw = "wide_line";

// drawing a wide line ? - how wide?
float dist_to_shiftShapeBy = 5; 

// drawing two lines - one slightly above the other?
boolean drawing_double_line = false ;
float double_line_Y_dist_above = 10;

// and what size would the ellipses be?
float ellipse_size = 10;



// _______ and the camera position vs. the line... 
// - well, let's assume we're just following one line

// which line do we follow
int num_of_line_which_camera_follows = 0;

// the distance from the current point on the line
float distance_from_line = 700 / 2 ;

// ___ angles to the camera from the line we're tracing

//  x rot - pretty much the elevation
float x_rot_angle_of_camera_from_curr_line = 0 /* TWO_PI * ( 0 / 360.0 ) */;

//  y rot - the circle around the current line
float y_rot_angle_of_camera_from_curr_line = TWO_PI * ( 225 / 360.0 );


// _____________ BACKG~ROUND COLOUR

color background_colour = color( 255 );



// __________   some GENERAL VISUAL LINE CHARACTERISTICS 

// ____ general colours

// greyscale or colour? - greyscale = true, colour = false
boolean using_random_greyscale_or_colour_line_colours_true_false = false;

// are we doing random colours or not?
boolean doing_random_line_stroke_colours = true;

// current non-random colour
color curr_non_random_line_stroke_colour =  color( 255, 128, 0) ;

// ____ then the value ranges for random colours

// _ red
float rand_col_min_red = 28 ;
float rand_col_max_red = 180 ;
// _ green
float rand_col_min_green = 28 ;
float rand_col_max_green = 200 ;
// _ blue
float rand_col_min_blue = 28 ;
float rand_col_max_blue = 200 ;


// __ greyscale??

// __ for the non-random greyscale, just use the general colour above
float rand_line_col_greyscale_min = 128;
float rand_line_col_greyscale_max = 228;






// ___ transparency?

boolean doing_line_transparency = false;
/// switch
boolean doing_random_line_transparency = false;

// this is for nonrandom operations
float non_random_max_line_transparency = 255;

// and this is the value range for random assignment
float random_line_transp_min = 72;
float random_line_transp_max = 250;



// ___ line stroke

// switch whether we're donig random widths or not
boolean doing_random_line_stroke_weight = true;

// non-random value
float general_line_stroke_weight = 1 ;

// and the width of line range
float min_rand_line_stroke_weight = 2 ;
float max_rand_line_stroke_weight = 25 ;





// ____________ bounds?
//      - do the lines stay inside a specified area?

boolean lines_stay_inside_bounds = true;

// - at least this should work in 2d - we just draw the bounds
boolean draw_bounds = true;

// stroke color and stroke weight
color bounds_lines_colour = color( 128, 128, 0, 128 );
float bounds_lines_strokeWeight = 0.25 ;

// _ x
float bounds_x_min = -400;
float bounds_x_max = 400;
// _ y
float bounds_y_min = -400;
float bounds_y_max = 400;
// _ z
float bounds_z_min = -400 ;
float bounds_z_max = 400 ;



// - according to the distance from the 'front'?
boolean fade_line_acc_to_z_dist = false; 
float min_transp_value = 30;  ///  just to keep things from becoming too small 
// - just a quick lookup :
////// float total_z_dist = abs( bounds_z_min - bounds_z_max );
// - cheating a little, so as to move values away from zero
float total_z_dist = abs( bounds_z_min - bounds_z_max ) ;




// ----------- how long does a frame take?
float frameTiming ;





// __________________________     setup   _________________________________

void setup() {
  size( 1000, 800, OPENGL );
  // size( 1920, 1200, OPENGL );
  frameRate( 25*1 );
  // and a special one for testing purposes
  //noLoop();

  // disable depth check/sort , speedup
  hint(DISABLE_DEPTH_SORT);


  // _______  setup the lines

  // __ if we're setting all the num_of_lines to the same setting
  setup_many_lines_2();

}










// __________________________     draw!   _________________________________


void draw() {

  if( debug > 2 ) {
    println(" the last frame took "+(millis()-frameTiming )+" ms to do ");
    frameTiming = millis();
  }

  translate( 500, 400, -500 );
  background( background_colour );

  // __ update the lines? 

  if( debug > 3 ) {
    println(" \n\n\n _______________________ working on frame num "+frameCount+" ________________ \n\n " );
  }

  for( int i = 0; i < lines.length; i++ ) {
    lines[i].update_position();
    // and if we're checking that the lines stay within bounds
    if( lines_stay_inside_bounds ) {
      lines[i].check_that_lines_are_within_bounds_and_reverse_vel_if_not();
    }
  }



  // ___ more testing, testdraw

  // if we're drawing in 2d...
  if( drawing_in_2d_or_3d_true_false ) {

    // if we're moving the view to focus on the line point
    if( move_view_to_center_on_line_latest_point ) {
      // this function moves/pans the screen 'perspective'/view to follow the latest line position in 2d
      move_2d_perspective_to_follow_given_line();
    }
    // or if we just let the line start in the center
    else {
      translate( width/2.0, height/2.0 );
    }

    // if required
    // draw the bounds, please
    if( draw_bounds ) {
      draw_bounds_lines_2d();
    }
  }  
  // and if we're drawing in 3d
  else {

    // if we're following the latest line point
    if( move_view_to_center_on_line_latest_point ) {
      set_camera_position_vs_the_line_being_followed();
    }
  }



  // __ and draw :) the line, in 2d or 3d
  for( int i = 0; i < lines.length; i++ ) {
    // input : boolean two_or_three_d_line_trueFalse
    // if true then 2d, if false then 3d
    lines[i].quick_draw_line();
  }
}









// ============================ general functions ===========================




// ___________________________________________________________________________________________________

// a function - from the complex circles patch, which finds a 3d position given x/y rot and radius

PVector find_pos_given_rot_and_radius( float rot_x, float rot_y, float  radius ) {

  // use the x axis rotation to find the y value
  // and *importantly* the radius of circle determinding the x / z pos
  float y_pos = -1*( sin( rot_x ) * radius ) ;  // remembering to flip the axis
  float circle_radius_at_y_val = cos( rot_x ) * radius ;

  // then find the x/z position using the rotation around the z (i.e. vertical axis)
  float x_pos = cos( rot_y ) * circle_radius_at_y_val ;
  float z_pos = sin( rot_y ) * circle_radius_at_y_val ;

  // put it all in a nice little package
  PVector circle_coords = new PVector( x_pos, y_pos, z_pos );

  // and return it 
  return circle_coords;
}


// ______________________________________________________________________________________

/*
090906
 the following function moves the screen area to be centered on the line being followed
 - the line being followed is the same one that the camera follows, i.e. specified by the "" variable  at the top
 */

void move_2d_perspective_to_follow_given_line( ) {

  // ___ some measures to keep the line in the middle
  // _ fetch the latest line position, as an absolute number relative to the array length
  // NOTE the '-1' here, it's just so we get to the current point
  // (it happens in the code, that the curr_line_pt_index gets incremented before the code realises it's one too high..
  //   and thus remains one too high..!)
  int curr_abs_coords_list_pos = (lines[ num_of_line_which_camera_follows ].curr_line_pts_coords_array_index-1) % lines[ num_of_line_which_camera_follows ].num_of_line_points ;
  // now fetch the relevant coords to offset the view
  float curr_x_offset = (-1*lines[ num_of_line_which_camera_follows ].x_coords_pts_array[ curr_abs_coords_list_pos ] ) + (width/2.0) ;
  float curr_y_offset = (-1*lines[ num_of_line_which_camera_follows ].y_coords_pts_array[ curr_abs_coords_list_pos ] ) + (height/2.0) ;   
  // now shift over
  translate( curr_x_offset, curr_y_offset );
}



// ____________________________________________________________________________________________

/*
090906
 a nice little function that sets the camera position
 vs. the line we're following, at which angle (which is specified in the globals at the top here )
 */

void set_camera_position_vs_the_line_being_followed() {


  // ______  find the latest position of the line we're following

  // __ first find the relevant coordinate array index of the latest line position
  int curr_abs_coords_list_pos = (lines[ num_of_line_which_camera_follows ].curr_line_pts_coords_array_index-1) % lines[ num_of_line_which_camera_follows ].num_of_line_points ;  
  // just save them here _ to make a few other things a little simpler
  float latest_line_pos_x = lines[ num_of_line_which_camera_follows ].x_coords_pts_array[ curr_abs_coords_list_pos ] ;
  float latest_line_pos_y = lines[ num_of_line_which_camera_follows ].y_coords_pts_array[ curr_abs_coords_list_pos ] ;
  float latest_line_pos_z = lines[ num_of_line_which_camera_follows ].z_coords_pts_array[ curr_abs_coords_list_pos ] ;


  // ______ find the vector of the camera position from the vector we're following

  //  input :  float rot_x, float rot_y, float  radius 
  PVector current_vector_to_camera_from_last_line_pos = find_pos_given_rot_and_radius( x_rot_angle_of_camera_from_curr_line, y_rot_angle_of_camera_from_curr_line, distance_from_line );

  // _____ add the vector of the camera position from the line we're following, to the line's last position
  //            to get the absolute position of the camera
  float curr_cam_x_pos = lines[ num_of_line_which_camera_follows ].x_coords_pts_array[ curr_abs_coords_list_pos ] + current_vector_to_camera_from_last_line_pos.x ;
  float curr_cam_y_pos = lines[ num_of_line_which_camera_follows ].y_coords_pts_array[ curr_abs_coords_list_pos ] + current_vector_to_camera_from_last_line_pos.y ;
  float curr_cam_z_pos = lines[ num_of_line_which_camera_follows ].z_coords_pts_array[ curr_abs_coords_list_pos ] + current_vector_to_camera_from_last_line_pos.z ;


  // ____ and, finallement, position the camera

  /* -- input :
   camera | camera_xyz_pos.x, camera_xyz_pos.y, camera_xyz_pos.z, // eyeX, eyeY, eyeZ
   0, 0, 0, // centerX, centerY, centerZ
   0.0, 1.0, 0.0 |; // upX, upY, upZ
   */
  // _ specially modified latest line Y position, so we have a nice up
  //   essentially we just subtract a few values from the lastest line Y, to make it a bit higher than the regular latest line pt Y 
  float latest_line_pos_y_modified_as_up = latest_line_pos_y - 100 ;

  camera( curr_cam_x_pos, curr_cam_y_pos, curr_cam_z_pos, // eyeX, eyeY, eyeZ
  latest_line_pos_x, latest_line_pos_y, latest_line_pos_z,  // centerX, centerY, centerY
  latest_line_pos_x, latest_line_pos_y_modified_as_up, latest_line_pos_z  // upX, upY, upZ
  );
}


// ___________________________________________________________________________________________________

/*
090906
 this nice little function draws the bounds lines...
 */

void draw_bounds_lines_2d() {

  // set the line qualities
  noFill();
  stroke( bounds_lines_colour );
  strokeWeight( bounds_lines_strokeWeight );

  // ____ now, draw something, please

  // __ the top
  line( bounds_x_min, bounds_y_min, bounds_x_max, bounds_y_min );

  // __ the bottom
  line( bounds_x_min, bounds_y_max, bounds_x_max, bounds_y_max );

  // __ the left
  line( bounds_x_min, bounds_y_min, bounds_x_min, bounds_y_max );

  // __ the right
  line( bounds_x_max, bounds_y_min, bounds_x_max, bounds_y_max );
}



// ___________________________________________________________________________________________________



/*

 NOTE 
 NOTE
 NOTE    :    this is a modified version of the version above - works better with individual settings!
 NOTE
 NOTE
 */


void setup_many_lines_2() {


  // set up the lines array
  lines = new Line_cl[ num_of_lines ] ;

  // _______________________ then put some nice values in it 

  //               different values for each line

  /* input:
   boolean changing_direction_in_nonChanging_mode_, boolean changing_speed_incremntally_in_changing_mode_, boolean changing_speed_in_nonChanging_mode_, 
   int num_of_line_points_, int num_of_line_pts_to_draw_, color line_stroke_colour_, boolean fade_line_to_transparency_, float line_stroke_weight_,
   int time_of_next_change_, float x_dir_min_value_, float x_dir_max_value_, float x_dir_negation_probability_, 
   float y_dir_min_value_, float y_dir_max_value_, float y_dir_negation_probability_, float min_speed_, float max_speed_, 
   float speed_negation_probability_, int min_steps_of_value_change_, int max_steps_of_value_change_,
   int min_time_of_non_changing_mode_, int max_time_of_non_changing_mode_
   */

  // __ 
  for( int curr_line_num = 0; curr_line_num < num_of_lines; curr_line_num++ ) {



    // ______________   line behaviour _________

    // whether we change the heading in changing and nonchanging mode
    boolean changing_direction_in_nonChanging_mode__ = false ;

    // this indicates whether we're changing speed in the changing mode
    boolean changing_speed_incremntally_in_changing_mode__ = false ; 

    // and this indicates whether we change speed in nonChanging mode
    boolean changing_speed_in_nonChanging_mode__ = false ;

    // ______________   advanced line behaviour

    // ___ new heading = incremented current heading or absolute new heading
    // this switch indicates whether the new (end) value of transitions
    // are a product of adding a random(min,max) value to the current heading, or just letting the heading be random(min, max)
    //    true = incrementation, false = absolute
    boolean new_direction_values_are_increments_of_curr_heading_or_absolute_headings_true_false__ = true ;

    // ___ is the new speed an incrementation of the previous speed, or an aboslute speed
    //    true = incrementation, false = absolute
    boolean new_speed_value_is_an_increment_of_curr_speed_or_absolute_speed_value_true_false__ = false;







    // ______________  line qualities? _________


    // number of points visible in the line?
    // NOTE: this becomes the length of the line positions stack!
    int num_of_line_points__ = 1000 ;

    // this sets how many of the points we draw - 0 means all, all other numbers are the num of points to draw
    int num_of_line_pts_to_draw__ = 0;



    // __ stroke colour?

    // initialise the variable
    // (cheating - assigning the nonrandom value here)
    color line_stroke_colour__ = curr_non_random_line_stroke_colour ;

    // and if we're...random?
    if( doing_random_line_stroke_colours ) {

      // if we're doing radom greyscale line colours
      if( using_random_greyscale_or_colour_line_colours_true_false ) {
        line_stroke_colour__ = color( rand_line_col_greyscale_min, rand_line_col_greyscale_max );
      }
      // and if we're doing random colour:
      else {

        // line_stroke_colour__ = color( random( rand_col_min_red, rand_col_max_red ), random( rand_col_min_green, rand_col_max_green ), random( rand_col_min_blue, rand_col_max_blue)   );
        float rand_val = random( 1.0 );
        // check which colours to set
        if( rand_val < 0.5 ) {

          line_stroke_colour__ = color( 255, 0, 0, 180  );
          /////  line_stroke_colour__ = color( 255, 0, 0  );
        }
       // else if( rand_val >= 0.7 /* && rand_val <= 0.7  */ ) {
         else{
          line_stroke_colour__ = color( 0, 0, 255, 180 );
        }
        
      //  else {
      //   line_stroke_colour__ = color( 255, 255, 255, 180 );
      //   }
        
        
      }
    }



    // ___ transparency

    // _- initialise the variable
    // (and cheat and do the non-random assignment here already)
    // the general transparency level
    float general_transparency_level__ = non_random_max_line_transparency ;

    if( doing_random_line_transparency ) {
      general_transparency_level__ = random( random_line_transp_min, random_line_transp_max ) ;
    }

    // >> fade to transparency along the length of the line??? YES!
    // flag it here please!
    boolean fade_line_to_transparency__ = false;





    // ___ stroke weight

    // initialise the variable,
    // and set the non-random value:  
    // stroke weight
    float line_stroke_weight__ = general_line_stroke_weight ;

    if( doing_random_line_stroke_weight ) {
      line_stroke_weight__ = random( min_rand_line_stroke_weight, max_rand_line_stroke_weight );
    }




    // ________________   changing and 'passive' behaviour _________
    /*
   ehrmmm! - set this up per line class!!
     */

    // FLAG indicating whether we're changing or not
    boolean are_we_changing__ = false;

    // this indicates the time when we change next time - in milliseconds!
    int time_of_next_change__ = 2000;

    // ____  directions and speed

    // ____ x  min / max direction for ABSOLUTE values
    float x_dir_min_value__ = TWO_PI * ( 1/360.0) ;
    float x_dir_max_value__ = TWO_PI * ( 361/360.0) ;
    // and a value for suggesting the likelihood of getting a value in the 'other direction'...
    // (however we figure that out...)
    float x_dir_negation_probability__ = 0.5;

    // __ x min / max heading INCREMENTATIONs of current heading
    // - i.e. if we modify the heading using incrementation values, these are the min/max incrementation values
    float x_dir_min_incrementation_value__ = TWO_PI * ( 35/360.0) ;
    float x_dir_max_incrementation_value__ = TWO_PI * ( 145/360.0) ;
    // and the negation probability of this
    float x_dir_incrementation_negation_probability__ = 0.15 ; 



    // ____ y  min / max -- ABSOLUTE
    float y_dir_min_value__ = TWO_PI * ( 1/360.0) ;
    float y_dir_max_value__ = TWO_PI * ( 360/360.0) ;
    // and a value for suggesting the likelihood of getting a value in the 'other direction'...
    // (however we figure that out...)
    float y_dir_negation_probability__ = 0.5;

    // __ y min / max heading INCREMENTATIONs of current heading
    // - i.e. if we modify the heading using incrementation values, these are the min/max incrementation values
    float y_dir_min_incrementation_value__ = TWO_PI * ( 35/360.0) ;
    float y_dir_max_incrementation_value__ = TWO_PI * ( 145/360.0) ;
    // and the negation probability of this
    float y_dir_incrementation_negation_probability__ = 0.15 ; 



    // __  speed ??  -- absolute values
    float min_speed__ = 3.8*1;
    float max_speed__ = 15.2*1;
    // the likelihood of getting a negative speed
    float speed_negation_probability__ = 1.1;

    /// __ (new) speed values (as) INCREMENTATIONs of the current..
    float min_speed_incrementation_of_curr_speed__ = 0.2 ;
    float max_speed_incrementation_of_curr_speed__ = 0.8 ;  
    /// and the likelihood of getting a negative value?
    float speed_incrementation_value_negation_probability__ = 1.0 ;


    // __  min / max number of steps in the change
    int min_steps_of_value_change__ = 10;
    int max_steps_of_value_change__ = 60;

    // __ min / max num of time of staying in the same mode (unchaning)
    // - in milliseconds
    int min_time_of_non_changing_mode__ = 10 ;
    int max_time_of_non_changing_mode__ = 15 ;

    //  ---  finally, do the insertion

 


    // ________  insert values into a class instantiation
    lines[curr_line_num] = new Line_cl(  
    changing_direction_in_nonChanging_mode__,
    changing_speed_incremntally_in_changing_mode__, 
    changing_speed_in_nonChanging_mode__,
    new_direction_values_are_increments_of_curr_heading_or_absolute_headings_true_false__,
    new_speed_value_is_an_increment_of_curr_speed_or_absolute_speed_value_true_false__, 
    num_of_line_points__,
    num_of_line_pts_to_draw__,
    line_stroke_colour__,
    general_transparency_level__,
    fade_line_to_transparency__,
    line_stroke_weight__,
    time_of_next_change__,
    x_dir_min_value__,
    x_dir_max_value__,
    x_dir_negation_probability__,
    x_dir_min_incrementation_value__, 
    x_dir_max_incrementation_value__,
    x_dir_incrementation_negation_probability__,
    y_dir_min_value__,
    y_dir_max_value__,
    y_dir_negation_probability__, 
    y_dir_min_incrementation_value__,
    y_dir_max_incrementation_value__,
    y_dir_incrementation_negation_probability__,
    min_speed__, 
    max_speed__,
    speed_negation_probability__, 
    min_speed_incrementation_of_curr_speed__,
    max_speed_incrementation_of_curr_speed__,
    speed_incrementation_value_negation_probability__, 
    min_steps_of_value_change__,
    max_steps_of_value_change__, 
    min_time_of_non_changing_mode__,
    max_time_of_non_changing_mode__ );
  }
}

// ________________________________________________________________________________________________________________________







