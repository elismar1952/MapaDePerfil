#include "colors.inc"
#include "textures.inc"
#include "shapes.inc" 
#include "glass.inc" 
#include "metals.inc" 
#include "woods.inc" 
#include "stones.inc"    // pre-defined scene elements 



    #declare WIDE_IMAGE=800;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    #declare VAR_H0=400;
    #declare VAR_D=1.0;
    #declare VAR_Q=60*pi/180;
    #declare VAR_F=1.8;
    #declare VAR_G=1.8;

    ////////////////////////////////////////////////////////////////////////////
    // CAMERA POSITION
    #declare CAMARA_ALTURA=VAR_D*tan(VAR_Q);	// Camera altura.
    #declare CAMERA_DEEP=VAR_D;	// Que tao longue esta o CUBO: 2.0m
    #declare CAMARA_THETA=VAR_Q;

    #declare CAMARA_ANG_APERTURE=2*atan(0.5*WIDE_IMAGE/VAR_H0)*180/pi;

    camera {
       location  <0, CAMARA_ALTURA, -CAMERA_DEEP>
       look_at   <0, 0, 0>
       angle CAMARA_ANG_APERTURE
    }


    light_source 
    {
        <0, CAMARA_ALTURA, -CAMERA_DEEP>   // Position
        color Red*3           // Color and intensity multiplicator
        spotlight
        point_at <0, 0, 0>     // direction of your laser
        // Size and properties of the gaussian beam profile
        radius 0.5
        falloff 0.75
        tightness 0.0
    }


    ////////////////////////////////////////////////////////////////////////////
    #declare LASERDOTS_H=VAR_G;
    #include "laserdots.pov"
    object{    laserdots    translate<0,0,VAR_F-VAR_D> }

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
#declare CAJA_W=0.5;
#declare CAJA_H=0.5;	
#declare CAJA_DEEP=0.3;	
#declare CAJA_POS=0.8;	
#include "caja.pov"
object{    caja    translate<-1.0,0,CAJA_POS>    }


////////////////////////////////////////////////////////////////////////////////
#declare CONO_H=0.5;	
#declare CONO_R=0.5;
#declare CONO_POS=0.8;		
#include "cono.pov"
object{    cono    translate<+1.0,0,CONO_POS>    }



////////////////////////////////////////////////////////////////////////////////
// Piso
plane {//normal=<0, 1, 0>	y=0
	<0, 1, 0>, 0
	//texture { T_Stone25 scale 4 }
	texture {
		    pigment {
			    color rgb<0.5, 0.3, 0.5>
		    }
	}
}

// Pared
#declare PARED_DEEP=10;
plane {//normal=<0, 1, 0>	y=0
	<0, 0, 1>, PARED_DEEP
	texture { DMFLightOak }
}

