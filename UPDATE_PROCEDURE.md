# Natural Earth Update Procedure

Scripts to build Natural Earth ZIP archives for individual themes, scalesets, and packagages.

_NOTE: Individual Pull Requests should **not** include running these steps, it'll create merge conflicts between different binary files (some of which are no longer tracked in the repository because of Github.com changes)._

**Requirements**: 

 - `Make` a generic Unix utility, to be installed. 
 - `GDAL` to be installed and the folder containing ogr2ogr to be added to the PATH environment variable
   
Assumed to be run on Mac or Ubuntu Linux.

# Usage

1. Increment the VERSION number, per the semantic versioning guidelines at ../README.md:

        pico VERSION
        
2. Update the CHANGELOG with the new edits.

        pico CHANGELOG
    
    Note: You'll likely want to edit the CHANGELOG in a real text editor. Those changes should
also be recorded, with better formatting, in a public blog post.
    
3. Formalize the new version in Git by setting a tag:

	    git tag  -m 'See CHANGELOG for details.' -a v`cat VERSION`

4. Package those changes for distribution by running one of the make targets:

        make all
    
    Other common, more specific targets include:

        make zips/10m_cultural/10m_cultural.zip
        make zips/10m_physical/10m_physical.zip
        make zips/50m_cultural/50m_cultural.zip
        make zips/50m_physical/50m_physical.zip
        make zips/110m_cultural/110m_cultural.zip
        make zips/110m_physical/110m_physical.zip
        make zips/packages/natural_earth_vector.zip
        make zips/packages/Natural_Earth_quick_start/Natural_Earth_quick_start.zip
        make clean
    
    Note, that if this is a clean clone or checkout you should
    start with the following, since 'clean' creates the required
    empty directories:
    
        make clean all
            
6. Push those changes live to the distribution network!

        make live
        
7. Updated Drainholes on the distribution server:

        http://naturalearthdata.com/blog/wp-admin/

8. Write the blog post announcing the changes (parallels the CHANGELOG above).

        http://naturalearthdata.com/blog/wp-admin/

9. Send email to update list announcing the changes and directing them to the blog post.

        http://naturalearthdata.com/updates/
