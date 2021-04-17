library(sf)
library(WikidataR)
library(tidyverse)
library(kableExtra)

read_from <- "~/Repos/natural-earth-vector/tools/508_fix_10m_populated_places_metadata/"
write_to <- "~/Repos/natural-earth-vector/tools/510_swap_wikidataids/"

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

# 460
lookup_460 = tibble(NE_ID = c(1159136389, 1159146257, 1159146503, 1159146881, 1159147443, 1159149127, 1159149245, 1159149299, 1159149367, 1159149385, 1159149697, 1159149705, 1159149795, 1159149893, 1159150029, 1159150127, 1159150469, 1159150507, 1159150519, 1159150591, 1159150621, 1159150847, 1159150849, 1159150853, 1159150931, 1159150997, 1159151059, 1159151127, 1159151133, 1159151181, 1159151263, 1159151277, 1159151287, 1159151291, 1159151303, 1159151341, 1159151347, 1159151359, 1159151401, 1159151417, 1159151421, 1159151453, 1159151465, 1159151503, 1159151511, 1159151525, 1159151545, 1159151549, 1159151593, 1159151601, 1159151615, 1159151623, 1159151703,1159151281),
                    NEW_WOF_ID = c(421190297, 101720567, 1175613621, 102027991, 85981333, 421189725, 85970739, 85949461, 101750467, 421171291, 1125988111, 1125880387, 102027777, 102027827, 102030245, 421202467, 890437681, 421186751, 101723183, 1175612707, 1125905513, 421173233, 421171925, 421191785, 102016833, 421189675, 101735873, 1125853197, 421176731, 101919427, 101751949, 421200923, 421191101, 1158857531, 421188981, 1125373543, 421186583, 101748113, 890429209, 1125955239, 1125929605, 101950447, 1175610569, 101748283, 421186805, 1159397249, 1175612731, 421170391, 101752607, 421186687, 102016915, 101932003, 101914257,1495123997))


# Add, modify, delete records
ne_10m_populated_places_modified_metadata <- ne_10m_populated_places %>% 
  st_drop_geometry() %>%
  # Update WOF concordances in NE populated places file #447
  # Lodz: change id, change namealt to Lodz or remove value of "L"
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148225,
                                   WOF_ID = 101913783,
                                   NAMEALT = "")) %>%
  # Rest validated from #447: sub old WOF_ID for new WOF_ID
  left_join(lookup_460, by = "NE_ID") %>%
  mutate(WOF_ID = ifelse(is.na(NEW_WOF_ID),WOF_ID,NEW_WOF_ID)) %>%
  select(!NEW_WOF_ID)


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

