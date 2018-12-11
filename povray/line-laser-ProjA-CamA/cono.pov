//#local CONO_H=0.5;	
//#local CONO_R=0.2;	

#declare cono=union
{
  cone {
    <0, 0, 0>, CONO_R    // Center and radius of one end
    <0, CONO_H, 0>, 0.0    // Center and radius of other end
    open              // Removes end caps
    texture {
	    pigment {
			    color rgb<0.8, 0.8, 0.6>
	    }
	}
  }

}
