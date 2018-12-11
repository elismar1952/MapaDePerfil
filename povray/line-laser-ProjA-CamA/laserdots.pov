#local DOTS_INTER_SPACE=0.3;
#local RADIUS=0.1;
#local FALLOFF=0.25;
#local ANGLE=75*pi/180;


#declare laserdots=union
{


    //#for (Identifier, Start, End [, Step])
    #for (Cntr, -10, 10, 0.05)

        light_source 
        {
            <0.0, LASERDOTS_H, 0>   // Position
            color Green*3           // Color and intensity multiplicator
            spotlight
            point_at <Cntr*DOTS_INTER_SPACE, 0, LASERDOTS_H/tan(ANGLE) >      // direction of your laser
            // Size and properties of the gaussian beam profile
            radius RADIUS
            falloff FALLOFF
            tightness 0.0
        }


    #end // ----------- end of #for loop

}

