library(sf)
library(WikidataR)
library(tidyverse)
library(compare)

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

