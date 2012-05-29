import zipfile, sys, os, glob
from optparse import OptionParser

optparser = OptionParser(usage="""%prog [options]

Zips up shapefile file groups (.shp, .dbf, .shx, .prj, etc) into single files.

For use preparing new releases of Natural Earth.""")

optparser.add_option('-i', '--in_dir', dest='in_dir',
                      help='Input directory of shapefiles.')

optparser.add_option('-o', '--out_dir', dest='out_dir', 
                      help='Output directory for resulting ZIP files.')


def zipShapefilesInDir(inDir, outDir):
    # Check that input directory exists
    if not os.path.exists(inDir):
        print "Input directory %s does not exist!" % inDir
        return False

    # Check that output directory exists
    if not os.path.exists(outDir):
        # Create it if it does not
        print "Creating output directory %s" %outDir
        os.mkdir(outDir)

    print "Zipping shapefile(s) in folder %s to output folder %s" % (inDir, outDir)

    # Loop through shapefiles in input directory
    for inShp in glob.glob(os.path.join(inDir, "*.shp")):
        # Build the filename of the output zip file
        outZip = os.path.join(outDir, os.path.splitext(os.path.basename(inShp))[0] + ".zip")

        # Zip the shapefile
        zipShapefile(inShp, outZip)
    return True

def zipShapefile(inShapefile, newZipFN):
    print 'Starting to Zip '+(inShapefile)+' to '+(newZipFN)

    # Check that input shapefile exists
    if not (os.path.exists(inShapefile)):
        print inShapefile + ' Does Not Exist'
        return False

    # Delete output zipfile if it already exists
    if (os.path.exists(newZipFN)):
        print 'Deleting '+newZipFN
        os.remove(newZipFN)

    # Output zipfile still exists, exit
    if (os.path.exists(newZipFN)):
        print 'Unable to Delete'+newZipFN
        return False

    # Open zip file object
    zipobj = zipfile.ZipFile(newZipFN,'w')

    # Loop through shapefile components
    for infile in glob.glob( inShapefile.lower().replace(".shp",".*")):
        # Skip .zip file extension
        if os.path.splitext(infile)[1].lower() != ".zip":
            print "Zipping %s" % (infile)
            # Zip the shapefile component
            zipobj.write(infile,os.path.basename(infile),zipfile.ZIP_DEFLATED)

    # Close the zip file object
    zipobj.close()
    return True

# Main method, used when this script is the calling module, otherwise
# you can import this module and call your functions from other modules
if __name__=="__main__":

    (options, args) = optparser.parse_args()
    
    ##    testShapeFile = r"C:\temp\geomTest.shp"
    ##    testZipFile = r"C:\temp\geomTest.zip"
    ##    zipShapefile(testShapeFile,testZipFile)
    #inDir = r"/Volumes/Data/NaturalEarth/updates/natural_earth_update_1d4/10m_cultural"
    #outDir = r"/Volumes/Data/NaturalEarth/updates/natural_earth_update_1d4_zips"
    
    inDir = options.in_dir
    outDir = options.out_dir
    
    zipShapefilesInDir(inDir, outDir)
    print "done!"