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
  #419 Saguenay
  rows_update(by = "ne_id", tibble(ne_id = 1159148923,
                                   wikidataid = 'Q139229')) %>%
  #411 Jinxi -> Huludao
  rows_update(by = "ne_id", tibble(ne_id = 1159149137,
                                   wikidataid = 'Q75379')) %>%
  #407 Add Nnewi, Nigeria
  rows_insert(by = "ne_id", tibble(ne_id = 1159151750,
                                   wikidataid = 'Q2750772',
                                   FEATURECLA = 'Populated place',
                                   SOV0NAME = 'Nigeria',
                                   ADM0_A3 = 'NGA',
                                   ADM1NAME = 'Anambra',
                                   ISO_A2 = 'NG',
                                   TIMEZONE = 'Africa/Lagos',
                                   LATITUDE = 6.0195310,
                                   LONGITUDE = 6.9171810)) %>%
  #406 Bose -> Baise
  rows_update(by = "ne_id", tibble(ne_id = 1159149783,
                                   wikidataid = 'Q571949')) %>%
  #405 Remove North Shore, NZ
  rows_delete(by = "ne_id", tibble(ne_id = 1159149783)) %>%
  #389 Dar es Salaam should be Admin-1 capital
  rows_update(by = "ne_id", tibble(ne_id = 1159151305,
                                   FEATURECLA = 'Admin-1 capital'))
  #373 Remove Vila Velha (Amapá, Brazil)
  rows_delete(by = "ne_id", tibble(ne_id = 1159148899)) %>%
  #365 Remove duplicate Bandar Lampung (Sumatra, Indonesia)
  rows_delete(by = "ne_id", tibble(ne_id = 1159139819)) %>%
  rows_update(by = "ne_id", tibble(ne_id = 1159149817,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  #358 Remove Natal in Amazonas, Brazil
  rows_delete(by = "ne_id", tibble(ne_id = 1159148743)) %>%
  #356 Remove Noginsk in the Moscow region
  rows_delete(by = "ne_id", tibble(ne_id = 1159137287)) %>%
  #339 Gar -> Shiquanhe
  rows_update(by = "ne_id", tibble(ne_id = 1159140703,
                                   wikidataid = 'Q2279283')) %>%
  #334 Bol'sheretsk -> Ust-Bolsheretsk 
  rows_update(by = "ne_id", tibble(ne_id = 1159139297,
                                   wikidataid = 'Q2502620')) %>%
  #330 Add Belushya Guba, Russia
  rows_insert(by = "ne_id", tibble(ne_id = 1159151751,
                                   wikidataid = 'Q26324',
                                   FEATURECLA = 'Populated place',
                                   SOV0NAME = 'Russia',
                                   ADM0_A3 = 'RUS',
                                   ADM1NAME = 'Arkhangelsk',
                                   ISO_A2 = 'RU',
                                   TIMEZONE = 'Europe/Moscow',
                                   LATITUDE = 71.545556,
                                   LONGITUDE = 52.320278)) %>%
  #323 El Cayo -> San Ignacio 
  rows_update(by = "ne_id", tibble(ne_id = 1159122697,
                                   wikidataid = 'Q724815')) %>%
  #318 Add Horten, Norway
  rows_insert(by = "ne_id", tibble(ne_id = 1159151752,
                                   wikidataid = 'Q109048',
                                   FEATURECLA = 'Populated place',
                                   SOV0NAME = 'Norway',
                                   ADM0_A3 = 'NOR',
                                   ADM1NAME = 'Vestfold',
                                   ISO_A2 = 'NO',
                                   TIMEZONE = 'Europe/Oslo',
                                   LATITUDE = 59.4166459,
                                   LONGITUDE = 10.4838599))

write.csv(ne_10m_populated_places_modified_metadata, "ne_10m_populated_places_modified_metadata.csv", na = "")

# Requires a bit more tweaking to ensure DBF encoding and data types aren't messed up in the transformation.
#ne_10m_populated_places_modified <- st_set_geometry(ne_10m_populated_places_modified_metadata, 
#                                                    ne_10m_populated_places$geometry)
#st_write(ne_10m_populated_places_modified, 'ne_10m_populated_places_wikidataid_update.shp', overwrite = TRUE)

# add_modify <- anti_join(ne_10m_populated_places_original_metadata, 
#                         ne_10m_populated_places_modified_metadata)
# 
# remove <- semi_join(ne_10m_populated_places_original_metadata, 
#                     ne_10m_populated_places_modified_metadata)
# 
# 
# write.csv(add_modify, "Add_Modify_10m_Populated_Places_WikidataIDs.csv", na = "")
# write.csv(remove, "Remove_10m_Populated_Places_WikidataIDs.csv", na = "")