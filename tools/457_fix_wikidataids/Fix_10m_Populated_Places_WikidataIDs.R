library(sf)
library(WikidataR)
library(tidyverse)

read_from <- "~/Repos/natural-earth-vector/10m_cultural/"
write_to <- "~/Repos/natural-earth-vector/tools/457_fix_wikidataids"

## IMPORT NE DATA
setwd(read_from)

# Read in ne_10m_populated_places shapefile
ne_10m_populated_places <- st_read('ne_10m_populated_places.shp',
                                   drivers = 'ESRI Shapefile',
                                   as_tibble = TRUE)

# Preserve metadata to diff changes
ne_10m_populated_places_original_metadata <- ne_10m_populated_places %>% st_drop_geometry()

# Copy the geometry to LATITUDE and LONGITUDE fields
coords <- as.data.frame(round(st_coordinates(ne_10m_populated_places),7))
coords <- cbind(coords,ne_10m_populated_places[,c("ne_id","LONGITUDE","LATITUDE")])

# Does this change any LATITUDE, LONGITUDE values?
# 2 - different enough to be noticable, 1 - different, but probably just precision
coord.diff <- function(d1,d2) { ifelse(abs(d1-d2) > 0.01, 2, ifelse(abs(d1-d2) > 0.001, 1, 0)) }
coords$lon_diff <- coord.diff(coords$X, ne_10m_populated_places$LONGITUDE)
coords$lat_diff <- coord.diff(coords$Y, ne_10m_populated_places$LATITUDE)
coords.to.check <- coords %>% filter(lat_diff > 0 | lon_diff > 0)

ne_10m_populated_places$LATITUDE <- coords$Y
ne_10m_populated_places$LONGITUDE <- coords$X

# Add new wikidataids
ne_10m_populated_places_modified_metadata <- ne_10m_populated_places %>% 
  st_drop_geometry() %>%
  mutate(across(where(is.factor), as.character)) %>%
  #453 Rida -> Rada'a
  rows_update(by = "ne_id", tibble(ne_id = 1159134263,
                                   wikidataid = 'Q2125362',
                                   NAME = "Rada'a",
                                   NAMEALT = "Rida",
                                   NAMEASCII = "Radaa",
                                   GEONAMEID = 71491)) %>%
  #449 Adapazarı
  rows_update(by = "ne_id", tibble(ne_id = 1159146375, 
                                   FEATURECLA = 'Admin-1 capital',
                                   NAMEALT = "Sakarya")) %>%
  #449 Sakarya
  rows_delete(by = "ne_id", tibble(ne_id = 1159113425)) %>%
  #419 Saguenay
  rows_update(by = "ne_id", tibble(ne_id = 1159148923,
                                   wikidataid = 'Q139229',
                                   NAME = "Saguenay",
                                   NAMEALT = "Chicoutimi",
                                   NAMEASCII = "Saguenay",
                                   POP_MAX = 144746,
                                   RANK_MAX = 9)) %>%
  #411 Jinxi -> Huludao
  rows_update(by = "ne_id", tibble(ne_id = 1159149137,
                                   wikidataid = 'Q75379',
                                   NAME = "Huludao",
                                   NAMEALT = "Jinxi",
                                   NAMEASCII = "Huludao",
                                   POP_MAX = 724800,
                                   RANK_MAX = 11)) %>%
  #407 Add Nnewi, Nigeria
  rows_insert(by = "ne_id", tibble(ne_id = 1729764357,
                                   wikidataid = 'Q2750772',
                                   FEATURECLA = 'Populated place',
                                   SOV0NAME = 'Nigeria',
                                   ADM0_A3 = 'NGA',
                                   ADM1NAME = 'Anambra',
                                   ISO_A2 = 'NG',
                                   TIMEZONE = 'Africa/Lagos',
                                   LATITUDE = 6.0195310,
                                   LONGITUDE = 6.9171810,
                                   POP_MAX = 391227,
                                   RANK_MAX = 10)) %>%
  #406 Bose -> Baise
  rows_update(by = "ne_id", tibble(ne_id = 1159149783,
                                   wikidataid = 'Q571949',
                                   NAME = "Baise",
                                   NAMEALT = "Bose",
                                   NAMEASCII = "Baise")) %>%
  #405 Remove North Shore, NZ
  rows_delete(by = "ne_id", tibble(ne_id = 1159149783)) %>%
  
  #389 Dar es Salaam should be Admin-0 capital alt, Dodoma should be Admin-0 capital
  rows_update(by = "ne_id", tibble(ne_id = 1159151305,
                                   FEATURECLA = 'Admin-0 capital alt')) %>%
  rows_update(by = "ne_id", tibble(ne_id = 1159149731,
                                   FEATURECLA = 'Admin-0 capital')) %>%
  #388 Kyoto should be Admin-0 capital alt
  rows_update(by = "ne_id", tibble(ne_id = 1159149967,
                                   FEATURECLA = 'Admin-0 capital alt')) %>%
  #387 Tomakomai should be Populated place
  rows_update(by = "ne_id", tibble(ne_id = 1159141281,
                                   FEATURECLA = 'Populated place')) %>%
  #385 Lagos should be Admin-1 capital
  rows_update(by = "ne_id", tibble(ne_id = 1159151591,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  #384 Zhengzhou should be Admin-1 capital
  rows_update(by = "ne_id", tibble(ne_id = 1159151375,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  #383 Shijiazhuang should be Admin-1 capital
  rows_update(by = "ne_id", tibble(ne_id = 1159149907,
                                   FEATURECLA = 'Admin-1 capital',
                                   NAME = "Shijiazhuang",
                                   NAMEALT = "Shimen, Shihkiachwang",
                                   NAMEASCII = "Shijiazhuang")) %>%
  #381 Yangon should be Admin-0 capital alt
  rows_update(by = "ne_id", tibble(ne_id = 1159151477,
                                   FEATURECLA = 'Admin-0 capital alt',
                                   NAME = "Yangon",
                                   NAMEALT = "Rangoon",
                                   NAMEASCII = "Yangon")) %>%
  #377 Makkah (Saudi Arabia) should be Admin-1 capital
  rows_update(by = "ne_id", tibble(ne_id = 1159151279,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  #373 Update Vila Velha (Amapá, Brazil)
  rows_update(by = "ne_id", tibble(ne_id = 1159148899,
                                   wikidataid = "Q18471012",
                                   POP_MIN = 2723,
                                   POP_MAX = 2723,
                                   POP_OTHER = 2723,
                                   RANK_MIN = 4,
                                   RANK_MAX = 4,
                                   min_zoom = 7.0)) %>%
  #368 Patra should be Admin-1 capital
  rows_update(by = "ne_id", tibble(ne_id = 1159147263,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  #365 Remove duplicate Bandar Lampung (Sumatra, Indonesia)
  rows_delete(by = "ne_id", tibble(ne_id = 1159139819)) %>%
  rows_update(by = "ne_id", tibble(ne_id = 1159149817,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  #364 Johannesburg should be Admin-0 capital alt
  rows_update(by = "ne_id", tibble(ne_id = 1159151515,
                                   FEATURECLA = 'Admin-0 capital alt')) %>%
  #362 Xian should be Admin-1 capital
  rows_update(by = "ne_id", tibble(ne_id = 1159151363,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  #358 Remove Natal in Amazonas, Brazil
  rows_delete(by = "ne_id", tibble(ne_id = 1159148743)) %>%
  
  #356 Noginsk in Siberia is a ghost town
  rows_update(by = "ne_id", tibble(ne_id = 1159146611,
                                   FEATURECLA = "Historic place",
                                   POP_MAX = 0,
                                   POP_MIN = 0,
                                   POP_OTHER = 0,
                                   RANK_MAX = 0,
                                   RANK_MIN = 0)) %>%
  #339 Gar -> Shiquanhe
  rows_update(by = "ne_id", tibble(ne_id = 1159140703,
                                   wikidataid = 'Q2279283',
                                   NAME = "Shiquanhe",
                                   NAMEPAR = "Gar",
                                   NAMEALT = "Ger, Sênggêkanbab, Sênggêzangbo, Sengge Zangbo, Senge Zangbo, Senge Zangbu, Sengghe Tsangpo",
                                   NAMEASCII = "Shiquanhe")) %>%
  #334 Bol'sheretsk -> Ust-Bolsheretsk 
  rows_update(by = "ne_id", tibble(ne_id = 1159139297,
                                   wikidataid = 'Q2502620',
                                   NAME = "Ust-Bolsheretsk",
                                   NAMEASCII = "Ust-Bolsheretsk",
                                   LATITUDE = 52.825,
                                   LONGITUDE = 156.285)) %>%
  #330 Add Belushya Guba, Russia
  rows_insert(by = "ne_id", tibble(ne_id = 1729769925,
                                   wikidataid = 'Q26324',
                                   FEATURECLA = 'Populated place',
                                   SOV0NAME = 'Russia',
                                   ADM0_A3 = 'RUS',
                                   ADM1NAME = 'Arkhangelsk',
                                   ISO_A2 = 'RU',
                                   TIMEZONE = 'Europe/Moscow',
                                   LATITUDE = 71.545556,
                                   LONGITUDE = 52.320278,
                                   POP_MAX = 1972,
                                   POP_MIN = 1972,
                                   POP_OTHER = 1972,
                                   RANK_MAX = 3,
                                   RANK_MIN = 3)) %>%
  #323 El Cayo -> San Ignacio 
  rows_update(by = "ne_id", tibble(ne_id = 1159122697,
                                   wikidataid = 'Q724815',
                                   NAME = "San Ignacio",
                                   NAMEALT = "El Cayo",
                                   NAMEASCII = "San Ignacio")) %>%
  #310 Chinhoyi should be Admin-1 capital, Kariba should not
  rows_update(by = "ne_id", tibble(ne_id = 1159134845,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  rows_update(by = "ne_id", tibble(ne_id = 1159134851,
                                   FEATURECLA = 'Populated place')) %>%
  #293 Add Chad Admin-1 capitals: Fada, Pala, Massenya, Goz Beïda, Koumra
  rows_update(by = "ne_id", tibble(ne_id = 1159148415,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  rows_update(by = "ne_id", tibble(ne_id = 1159140345,
                                   FEATURECLA = 'Admin-1 capital')) %>%
  rows_insert(by = "ne_id", tibble(ne_id = 1729769927,
                                   wikidataid = 'Q764968',
                                   NAME = "Massenya",
                                   NAMEASCII = "Massenya",
                                   FEATURECLA = 'Admin-1 capital',
                                   SOV0NAME = 'Chad',
                                   ADM0_A3 = 'TCD',
                                   ADM1NAME = 'Baguirmi',
                                   ISO_A2 = 'TD',
                                   TIMEZONE = 'Africa/Ndjamena',
                                   LATITUDE = 11.398333,
                                   LONGITUDE = 16.1675)) %>%
  rows_insert(by = "ne_id", tibble(ne_id = 1729769929,
                                   wikidataid = 'Q3112862',
                                   NAME = "Goz Beïda",
                                   NAMEASCII = "Goz Beida",
                                   FEATURECLA = 'Admin-1 capital',
                                   SOV0NAME = 'Chad',
                                   ADM0_A3 = 'TCD',
                                   ADM1NAME = 'Sila',
                                   ISO_A2 = 'TD',
                                   TIMEZONE = 'Africa/Ndjamena',
                                   LATITUDE = 12.223611,
                                   LONGITUDE = 21.414444)) %>%
  rows_insert(by = "ne_id", tibble(ne_id = 1729769933,
                                   wikidataid = 'Q1070175',
                                   NAME = "Koumra",
                                   NAMEASCII = "Koumra",
                                   FEATURECLA = 'Admin-1 capital',
                                   SOV0NAME = 'Chad',
                                   ADM0_A3 = 'TCD',
                                   ADM1NAME = 'Mandoul',
                                   ISO_A2 = 'TD',
                                   TIMEZONE = 'Africa/Ndjamena',
                                   LATITUDE = 8.9,
                                   LONGITUDE = 17.55)) %>%
  #413 Astana -> Nur-Sultan
  rows_update(by = "ne_id", tibble(ne_id = 1159150965,
                                   NAME = "Nur-Sultan",
                                   NAMEPAR = "Astana",
                                   NAMEASCII = "Nur-Sultan")) %>%
  #374 Amundsen-Scott South Pole Station
  rows_update(by = "ne_id", tibble(ne_id = 1159146123,
                                   NAME = "Amundsen-Scott South Pole Station",
                                   NAMEASCII = "Amundsen-Scott South Pole Station")) %>%
  #380 Sevastapol -> Sevastopol
  rows_update(by = "ne_id", tibble(ne_id = 1159150561,
                                   NAME = "Sevastopol",
                                   NAMEASCII = "Sevastopol")) %>%
  #333 Lansdowne House -> Neskantaga
  rows_update(by = "ne_id", tibble(ne_id = 1159148901,
                                   NAME = "Neskantaga",
                                   NAMEASCII = "Neskantaga",
                                   NAMEPAR = "Lansdowne House",
                                   wikidataid = 'Q14875338')) %>%
  #471 Banghazi -> Benghazi
  rows_update(by = "ne_id", tibble(ne_id = 1159150953,
                                   NAME = "Benghazi",
                                   NAMEASCII = "Benghazi",
                                   NAMEALT = "Banġāzī",
                                   MEGANAME = "Benghazi",
                                   LS_NAME = "Benghazi"))

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

