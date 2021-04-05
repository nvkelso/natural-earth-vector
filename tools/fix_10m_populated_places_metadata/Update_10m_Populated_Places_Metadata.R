library(sf)
library(WikidataR)
library(tidyverse)
library(kableExtra)

read_from <- "~/Repos/natural-earth-vector/10m_cultural/"
write_to <- "~/Repos/natural-earth-vector/tools/fix_10m_populated_places_metadata/"

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
  # Update spellings for major cities in Bangladesh #329
  rows_update(by = "NE_ID", tibble(NE_ID = 1159151473,
                                   NAME = "Chattogram",
                                   NAMEASCII = "Chattogram",
                                   NAMEPAR = "Chittagong",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159145151,
                                   NAME = "Jashore",
                                   NAMEASCII = "Jashore",
                                   NAMEPAR = "Jessore",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159145155,
                                   NAME = "Barishal",
                                   NAMEASCII = "Barishal",
                                   NAMEPAR = "Barisal",
                                   NAMEALT = "")) %>%
  # Kandalaksha, Murmansk, Russia, has too high maxpop #359
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148085,
                                   POP_MAX = 38126,
                                   POP_MIN = 35654,
                                   POP_OTHER = 0)) %>%
  # 10m places: misspelling of Akureyri (Iceland) #366
  rows_update(by = "NE_ID", tibble(NE_ID = 1159147673,
                                   NAME = "Akureyri",
                                   NAMEASCII = "Akureyri")) %>%
  # 10m places: misspelling of Liupanshui, Guizhou, China #369
  rows_update(by = "NE_ID", tibble(NE_ID = 1159149787,
                                   NAME = "Liupanshui",
                                   NAMEASCII = "Liupanshui")) %>%
  # Places: Ujungpandang, Indonesia, is now Makassar #398
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150843,
                                   NAME = "Makassar",
                                   NAMEASCII = "Makassar",
                                   NAMEALT = "Kota Makassar|Ujung Pandang",
                                   FEATURECLA = 'Admin-1 capital')) %>%
  # 10m populated places: request for location adjustments #409
  rows_update(by = "NE_ID", tibble(NE_ID = 1159120991,
                                   LATITUDE = 36.7117101,
                                   LONGITUDE = 4.0461444)) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159121009,
                                   LATITUDE = 36.0777088,
                                   LONGITUDE = 4.7646624)) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159121163,
                                   LATITUDE = 27.4293704,
                                   LONGITUDE =  89.4167773)) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159121181,
                                   LATITUDE = 27.5841540,
                                   LONGITUDE =  89.8641347)) %>%
  # 10m places: Max_pop of Newcastle, Australia, is too high #414
  # Lookup result: 1159151163 Newcastle        New South Wales    Australia
  rows_update(by = "NE_ID", tibble(NE_ID = 1159151163,
                                   POP_MAX = 540796,
                                   POP_MIN = 322278,
                                   POP_OTHER = 0)) %>%
  # Sovetskaya Gavan misspelled #428
  # Lookup result: 1159146767 Savetskaya Gavan Khabarovsk Russia
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146767,
                                   NAME = "Sovetskaya Gavan",
                                   NAMEASCII = "Sovetskaya Gavan")) %>%
  # Populated_Places: Wrong Chinese names #430
  # Lookup result: 1159149907 Shijianzhuang Hebei    China
  # Lookup result: 1159148459 Xiangfan    Hubei       China
  rows_update(by = "NE_ID", tibble(NE_ID = 1159149907,
                                   NAME = "Shijiazhuang",
                                   NAMEASCII = "Shijiazhuang",
                                   NAMEALT = "Shijianzhuang")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148459,
                                   NAME = "Xiangyang",
                                   NAMEASCII = "Xiangyang",
                                   NAMEALT = "Xiangfan")) %>%
  # 10m Populated Places: State-Wide Name Updates in Karnataka, India #448
  rows_update(by = "NE_ID", tibble(NE_ID = 1159151543,
                                   NAME = "Bengaluru",
                                   NAMEASCII = "Bengaluru",
                                   NAMEPAR = "Bangalore",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150015,
                                   NAME = "Mangaluru",
                                   NAMEASCII = "Mangaluru",
                                   NAMEPAR = "Mangalore",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148527,
                                   NAME = "Ballari",
                                   NAMEASCII = "Ballari",
                                   NAMEPAR = "Bellary",
                                   NAMEALT = ""))  %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159147195,
                                   NAME = "Vijayapura",
                                   NAMEASCII = "Vijayapura",
                                   NAMEPAR = "Bijapur",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148531,
                                   NAME = "Belagavi",
                                   NAMEASCII = "Belagavi",
                                   NAMEPAR = "Belgaum",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150019,
                                   NAME = "Kalaburagi",
                                   NAMEASCII = "Kalaburagi",
                                   NAMEPAR = "Gulbarga",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150017,
                                   NAME = "Mysuru",
                                   NAMEASCII = "Mysuru",
                                   NAMEPAR = "Mysore",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141837,
                                   NAME = "Hosapete",
                                   NAMEASCII = "Hosapete",
                                   NAMEPAR = "Hospet",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141827,
                                   NAME = "Shivamogga",
                                   NAMEASCII = "Shivamogga",
                                   NAMEPAR = "Shimoga",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150013,
                                   NAME = "Hubballi",
                                   NAMEASCII = "Hubballi",
                                   NAMEPAR = "Hubli",
                                   NAMEALT = "")) %>%
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148523,
                                   NAME = "Tumakuru",
                                   NAMEASCII = "Tumakuru",
                                   NAMEPAR = "Tumkur",
                                   NAMEALT = "")) %>%
  # 10m Populated Places: Location of Bodø, Norway #450
  # Lookup result: 1159146401 Bodø  Nordland Norway
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146401,
                                   LATITUDE = 67.2764346,
                                   LONGITUDE =  14.4292849)) %>%
  # 10m Populated Places: Ammochostos/Famagusta, Nicosia #452
  # Lookup result: 1159132353 Ammochostos Northern Cyprus
  rows_update(by = "NE_ID", tibble(NE_ID = 1159132353,
                                   NAME = "Famagusta",
                                   NAMEASCII = "Famagusta",
                                   NAMEALT = "Ammochostos")) %>%
  # 10m Populated Place: Puducherry, India #454
  # Lookup result: 1159150163 Pondicherry India    Puducherry
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150163,
                                   NAME = "Puducherry",
                                   NAMEASCII = "Puducherry",
                                   NAMEPAR = "Pondicherry",
                                   NAMEALT = "")) %>%
  # 10m populated places: location precision for Windsor, Ontario #468
  # Lookup result: 1159147661 Windsor Canada   Ontario
  rows_update(by = "NE_ID", tibble(NE_ID = 1159147661,
                                   LATITUDE = 42.3154570,
                                   LONGITUDE =  -83.0368525)) %>%
  # 10m populated places: Request to update name for Kuwait City #483
  # Lookup result: 1159151361 Kuwait Kuwait   Al Kuwayt
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150163,
                                   NAME = "Kuwait City",
                                   NAMEASCII = "Kuwait City",
                                   NAMEALT = "Al Kuwayt"))
  
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

