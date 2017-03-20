Get the full scoop at [NaturalEarthData.com](http://naturalearthdata.com)

_No, really! This readme is a poor substitute for the live site._

# About Natural Earth Vector

Natural Earth is a public domain map dataset available at 1:10m, 1:50m, and 1:110 million scales. Featuring tightly integrated vector (here) and raster data ([over there](https://github.com/nvkelso/natural-earth-raster)), with Natural Earth you can make a variety of visually pleasing, well-crafted maps with cartography or GIS software.

Natural Earth was built through a collaboration of many [volunteers](http://www.naturalearthdata.com/about/contributors/) and is supported by [NACIS](http://www.nacis.org/) (North American Cartographic Information Society), and is free for use in any type of project (see our [Terms of Use](http://www.naturalearthdata.com/about/terms-of-use/) page for more information).

[Get the Data »](http://www.naturalearthdata.com/downloads)

![Convenience](http://www.naturalearthdata.com/wp-content/uploads/2009/08/home_image_11.png)

# Convenience

Natural Earth solves a problem: finding suitable data for making small-scale maps. In a time when the web is awash in geospatial data, cartographers are forced to waste time sifting through confusing tangles of poorly attributed data to make clean, legible maps. Because your time is valuable, Natural Earth data comes ready-to-use.

![Neatness Counts](http://www.naturalearthdata.com/wp-content/uploads/2009/08/home_image_21.png)

# Neatness Counts

The carefully generalized linework maintains consistent, recognizable geographic shapes at 1:10m, 1:50m, and 1:110m scales. Natural Earth was built from the ground up so you will find that all data layers align precisely with one another. For example, where rivers and country borders are one and the same, the lines are coincident.

![GIS Atributes](http://www.naturalearthdata.com/wp-content/uploads/2009/08/home_image_32.png)

# GIS Attributes

Natural Earth, however, is more than just a collection of pretty lines. The data attributes are equally important for mapmaking. Most data contain embedded feature names, which are ranked by relative importance. Other attributes facilitate faster map production, such as width attributes assigned to river segments for creating tapers.

# Versioning

The 2.0 release in 2012 marked the project's shift from so-called marketing versions to [semantic versioning](http://semver.org/). 

Natural Earth is a big project with hundreds of files that depend on each other and the total weighs in at several gigabytes. SemVer is a simple set of rules and requirements around version numbers. For our project, the data layout is the API. 

* **Version format of X.Y.Z** (Major.Minor.Patch). 
* **Backwards incompatible** changes, increment the major version X.
* **Backwards compatible** additions/changes, increment the minor version Y
* **Bug fixes** not affecting the file and field names, patch version Z will be incremented. 

Major version increments:

* Changing existing data **file names**
* Changing existing data **column (field) names**
* Removing **`FeatureCla` field attribute values**
* Additions, deletions to **admin-0**
* Introduce **significant new themes**

Minor version increments:

* Any shape or attribute change in **admin-0**
* Additions, deletions, and any shape or attribute changes in **admin-1**
* Additions, deletions to **any theme**
* Major shape or attribute changes in **any theme**
* Adding, changing **`FeatureCla` field attribute values**
* Introduce **minor new themes**

Patch version increments:

* Minor shape or attribute changes in **any theme**
* Bug fixes to shape, attributes in **any theme**

Under this scheme, version numbers and the way they change convey meaning about the underlying code and what has been modified from one version to the next.

When we introduce a new version of Natural Earth, you can tell by the version number how much effort you will need to extend to integrate the data with your map implementation.

* **Bug fixes Z**: can simply use the new data files, replacing your old files.
* **Minor version Y**: limited integration challenges.
* **Major version X**: significatnt integration challenges, either around changed file strucutre, field layout, field values like `FeatureCla` used in symbolizing data, or significant new additions or significant changes to existing themes.

# &etc

Natural Earth is maintained by Nathaneiel V. KELSO ([@nvkelso](https://github.com/nvkelso/)) and Tom Patterson.

The project transitioned to Github in 2012. Versioned files are here to collaborate around. The frontend still lives at [NaturalEarthData.com](http://naturalearthdata.com).
