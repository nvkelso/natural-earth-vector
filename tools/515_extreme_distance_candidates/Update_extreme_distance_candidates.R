library(sf)
library(WikidataR)
library(tidyverse)
library(kableExtra)

read_from <- "~/Repos/natural-earth-vector/tools/510_swap_wikidataids/"
write_to <- "~/Repos/natural-earth-vector/tools/515_extreme_distance_candidates/"

## IMPORT NE DATA
setwd(read_from)

# Read in ne_10m_populated_places shapefile
ne_10m_populated_places <- st_read('ne_10m_populated_places_modified.shp',
                                   drivers = 'ESRI Shapefile',
                                   as_tibble = TRUE)

# Preserve metadata to diff changes
ne_10m_populated_places_original_metadata <- ne_10m_populated_places %>% st_drop_geometry()

# Copy the geometry to LATITUDE and LONGITUDE fields
coords <- as.data.frame(round(st_coordinates(ne_10m_populated_places),7))
coords <- cbind(coords,ne_10m_populated_places[,c("NE_ID","LONGITUDE","LATITUDE")])

# Does this change any LATITUDE, LONGITUDE values?
# 2 - different enough to be noticable, 1 - different, but probably just precision
coord.diff <- function(d1,d2) { ifelse(abs(d1-d2) > 0.01, 2, ifelse(abs(d1-d2) > 0.001, 1, 0)) }
coords$lon_diff <- coord.diff(coords$X, ne_10m_populated_places$LONGITUDE)
coords$lat_diff <- coord.diff(coords$Y, ne_10m_populated_places$LATITUDE)
coords.to.check <- coords %>% filter(lat_diff > 0 | lon_diff > 0)

ne_10m_populated_places$LATITUDE <- coords$Y
ne_10m_populated_places$LONGITUDE <- coords$X

# Add, modify, delete records
ne_10m_populated_places_modified_metadata <- ne_10m_populated_places %>% 
  st_drop_geometry() %>%
  mutate(across(where(is.factor), as.character)) %>%
  #Aripuana -> Aripuanã
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148783,
                                   NAME = "Aripuanã",
                                   NAMEALT = "Aripuana",
                                   NAMEASCII = "Aripuana",
                                   # Move geometry to -10.17666,-59.44387
                                   LATITUDE = -10.17666,
                                   LONGITUDE = -59.44387,
                                   # add WD (confirmed with google & OSM
                                   WIKIDATAID = "Q1805412")) %>%
  # Cacolo
  rows_update(by = "NE_ID", tibble(NE_ID = 1159144693,
                                   WIKIDATAID = "Q1620901")) %>%
  # Chaguaramas
  rows_update(by = "NE_ID", tibble(NE_ID = 1159133655,
                                   WIKIDATAID = "Q1058829",
                                   # Move geometry to -10.17666,-59.44387
                                   LATITUDE = 9.33597,
                                   LONGITUDE = -66.25448 )) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148559)) %>%	#Chanaral	Chañaral	https://www.wikidata.org/wiki/Q3763	300-400km	move geometry to -26.34810,-70.62147, add WD, (confirmed with google and OSM, see:https://www.openstreetmap.org/node/214189440#map=18/-26.34810/
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141037)) %>%	#Fuyu	Fuyu	https://www.wikidata.org/wiki/Q185940	100-150km	Fuyu is a county-level city under the administration of prefecture-level city Songyuan. Geometry right now is located at Songyuan. Recommend changin
  rows_update(by = "NE_ID", tibble(NE_ID = 1159139657)) %>%	#Hechi	Hechi	https://www.wikidata.org/wiki/Q572089	250-300km	move geometry to 24.695252134251945, 108.08299950401414, add WD (confirmed with google & OSM, see https://www.openstreetmap.org/node/5729719789)
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148383)) %>%	#Kotabumi	Kotabumi	https://www.wikidata.org/wiki/Q14635420	100-150km	better WD -> Q10372500
  rows_update(by = "NE_ID", tibble(NE_ID = 1159142075)) %>%	#Lagunas	Lagunas	https://www.wikidata.org/wiki/Q1800551	300-400km	cannot verify - no action
  rows_update(by = "NE_ID", tibble(NE_ID = 1159139779)) %>%	#Pati	Pati	https://www.wikidata.org/wiki/Q4554019	200-250km	better WD -> Q4135102
  rows_update(by = "NE_ID", tibble(NE_ID = 1159135963)) %>%	#Sechura	Sechura	https://www.wikidata.org/wiki/Q3236446	250-300km	appears to be a phantom feature, actual Sechura is far away (https://www.openstreetmap.org/node/2505711675) and no nearby populated places - rec
  rows_update(by = "NE_ID", tibble(NE_ID = 1159130281)) %>%	#Shangdu	Shangdu	https://www.wikidata.org/wiki/Q10868289	250-300km	This feature appears to generalize a county - best match for county would be Q1305772
  rows_update(by = "NE_ID", tibble(NE_ID = 1159130147)) %>%	#Shashi	Shashi	https://www.wikidata.org/wiki/Q11139987	250-300km	Feature represents a district of prefecture-level city Jingzhou - name should change to Jingzhou, better WD -> Q71247, (see:https://www.openstreetma
  rows_update(by = "NE_ID", tibble(NE_ID = 1159137527))	#Yamburg	Yamburg	https://www.wikidata.org/wiki/Q1679866	250-300km	move geometry to 67.92211738288061, 74.92531301724216, add WD (confirmed with google and OSM, see:https://www.openstreetmap.org/node/1349074061)
  

# WRITE OUTPUT
setwd(write_to)

write.csv(ne_10m_populated_places_modified_metadata, "ne_10m_populated_places_modified_metadata.csv", na = "")
write.csv(coords.to.check, "coords.to.check.csv")

# Recreating all geometries from LATITUDE and LONGITUDE;
# should verify this doesn't introduce regressions.
# If not, it's the most straightforward strategy.
ne_10m_populated_places_modified <- st_as_sf(ne_10m_populated_places_modified_metadata,
                                             coords = c("LONGITUDE","LATITUDE"), remove = FALSE,
                                             crs = 4326, agr = "constant")


# Convert fields that should be integers to integers

# Total values in each column that are integers or no value
count.int <- function(x) sum(floor(x) == x, na.rm = TRUE) + sum(is.na(x))

# A column should contain almost exclusively integer values
counts.int <- ne_10m_populated_places_modified %>% 
  st_drop_geometry %>%
  summarise(across(where(is.numeric), count.int)) %>%
  pivot_longer(everything(), names_to = "fields", values_to = "integer_values") %>%
  filter(integer_values == nrow(ne_10m_populated_places_modified))

ne_10m_populated_places_modified <- ne_10m_populated_places_modified %>%
  mutate(across(all_of(counts.int$fields), as.integer, na.rm = TRUE))


st_write(ne_10m_populated_places_modified, "ne_10m_populated_places_modified.shp",
         layer_options = "ENCODING=UTF-8",
         overwrite = TRUE, append = FALSE)


  