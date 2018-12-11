//#local CAJA_W=0.5;	
//#local CAJA_H=0.2;	

#declare caja=union
{
    box {
        <-CAJA_W, 0,-CAJA_DEEP>, < CAJA_W, CAJA_H, CAJA_DEEP>
	    texture {
		    pigment {
			    color rgb<0.8, 0.8, 0.6>
		    }
	    }
    }

}
