library(sf)
library(WikidataR)
library(tidyverse)

setwd("~/Repos/natural-earth-vector/10m_cultural/")

## IMPORT NE DATA

# Read in ne_10m_populated_places shapefile
ne_10m_populated_places <- st_read('ne_10m_populated_places.shp')

# Preserve metadata to diff changes
ne_10m_populated_places_original_metadata <- ne_10m_populated_places %>% st_drop_geometry()


# Add new wikidataids
ne_10m_populated_places_modified_metadata <- ne_10m_populated_places %>% 
  st_drop_geometry() %>%
  mutate(across(where(is.factor), as.character)) %>%
  #453 Rida -> Rada'a
  rows_update(by = "ne_id", tibble(ne_id = 1159134263,
                                   wikidataid = 'Q2125362')) %>%
  #449 Sakarya
  rows_update(by = "ne_id", tibble(ne_id = 1159113425, 
                                   wikidataid = 'Q3945164')) %>%
  #411 Jinxi -> Huludao
  rows_update(by = "ne_id", tibble(ne_id = 1159149137,
                                   wikidataid = 'Q75379'))

diff <- anti_join(ne_10m_populated_places_original_metadata, 
                  ne_10m_populated_places_modified_metadata)

write.csv(diff, "Fix_10m_Populated_Places_WikidataIDs.csv", na = "")

# Requires a bit more tweaking to ensure DBF encoding and data types aren't messed up in the transformation.
#ne_10m_populated_places_modified <- st_set_geometry(ne_10m_populated_places_modified_metadata, 
#                                                    ne_10m_populated_places$geometry)
#st_write(ne_10m_populated_places_modified, 'ne_10m_populated_places_wikidataid_update.shp', overwrite = TRUE)
