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
                                   FEATURECLA = 'Admin-1 capital',)) 
  
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

