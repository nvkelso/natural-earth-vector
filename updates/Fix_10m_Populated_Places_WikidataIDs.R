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
  #387 Tomakomai should be Populated
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
  #381 Yangon should be Admin-1 capital alt
  rows_update(by = "ne_id", tibble(ne_id = 1159151477,
                                   FEATURECLA = 'Admin-1 capital alt',
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
                                   LONGITUDE = 10.4838599)) %>%
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
  rows_insert(by = "ne_id", tibble(ne_id = 1159151753,
                                   wikidataid = 'Q764968',
                                   FEATURECLA = 'Admin-1 capital',
                                   SOV0NAME = 'Chad',
                                   ADM0_A3 = 'TCD',
                                   ADM1NAME = 'Baguirmi',
                                   ISO_A2 = 'TD',
                                   TIMEZONE = 'Africa/Ndjamena',
                                   LATITUDE = 11.398333,
                                   LONGITUDE = 16.1675)) %>%
  rows_insert(by = "ne_id", tibble(ne_id = 1159151754,
                                   wikidataid = 'Q3112862',
                                   FEATURECLA = 'Admin-1 capital',
                                   SOV0NAME = 'Chad',
                                   ADM0_A3 = 'TCD',
                                   ADM1NAME = 'Sila',
                                   ISO_A2 = 'TD',
                                   TIMEZONE = 'Africa/Ndjamena',
                                   LATITUDE = 12.223611,
                                   LONGITUDE = 21.414444)) %>%
  rows_insert(by = "ne_id", tibble(ne_id = 1159151755,
                                   wikidataid = 'Q1070175',
                                   FEATURECLA = 'Admin-1 capital',
                                   SOV0NAME = 'Chad',
                                   ADM0_A3 = 'TCD',
                                   ADM1NAME = 'Mandoul',
                                   ISO_A2 = 'TD',
                                   TIMEZONE = 'Africa/Ndjamena',
                                   LATITUDE = 8.9,
                                   LONGITUDE = 17.55))

write.csv(ne_10m_populated_places_modified_metadata, "ne_10m_populated_places_modified_metadata.csv", na = "")

# Requires a bit more tweaking to ensure DBF encoding and data types aren't messed up in the transformation.
# #ne_10m_populated_places_modified <- st_set_geometry(ne_10m_populated_places_modified_metadata, 
# #                                                    ne_10m_populated_places$geometry)
# #st_write(ne_10m_populated_places_modified, 'ne_10m_populated_places_wikidataid_update.shp', overwrite = TRUE)
# 
# # add_modify <- anti_join(ne_10m_populated_places_original_metadata, 
# #                         ne_10m_populated_places_modified_metadata)
# # 
# # remove <- semi_join(ne_10m_populated_places_original_metadata, 
# #                     ne_10m_populated_places_modified_metadata)
# # 
# # 
# # write.csv(add_modify, "Add_Modify_10m_Populated_Places_WikidataIDs.csv", na = "")
# # write.csv(remove, "Remove_10m_Populated_Places_WikidataIDs.csv", na = "")