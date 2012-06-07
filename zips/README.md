#About

Scripts to build Natural Earth ZIP archives for individual themes, scalesetsm, and packagages.

TODO: and copy them to the 2 servers.

**Requirements**: `Make` a generic Unix utility, to be installed.

#Usage

From the command line, move into the directory:

    cd zips
    
Then run one of the make targets:

    make all
    
Other common targets include:

    make ../zips/10m_cultural/10m_cultural.zip
	make ../zips/10m_physical/10m_physical.zip
	make ../zips/50m_cultural/50m_cultural.zip
	make ../zips/50m_physical/50m_physical.zip
	make ../zips/110m_cultural/110m_cultural.zip
	make ../zips/110m_physical/110m_physical.zip
    make ../zips/packages/natural_earth_vector.zip
    make ../zips/packages/Natural_Earth_quick_start/Natural_Earth_quick_start.zip
    make clean