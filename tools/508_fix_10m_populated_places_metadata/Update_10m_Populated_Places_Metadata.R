library(sf)
library(WikidataR)
library(tidyverse)
library(kableExtra)

read_from <- "~/Repos/natural-earth-vector/10m_cultural/"
write_to <- "~/Repos/natural-earth-vector/tools/508_fix_10m_populated_places_metadata/"

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
  # Chittagong -> Chattogram
  rows_update(by = "NE_ID", tibble(NE_ID = 1159151473,
                                   NAME = "Chattogram",
                                   NAMEASCII = "Chattogram",
                                   NAMEPAR = "Chittagong",
                                   NAMEALT = "")) %>%
  # Jessore -> Jashore
  rows_update(by = "NE_ID", tibble(NE_ID = 1159145151,
                                   NAME = "Jashore",
                                   NAMEASCII = "Jashore",
                                   NAMEPAR = "Jessore",
                                   NAMEALT = "")) %>%
  # Barisal -> Barishal
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
  # Akureyi -> Akureyri
  rows_update(by = "NE_ID", tibble(NE_ID = 1159147673,
                                   NAME = "Akureyri",
                                   NAMEASCII = "Akureyri",
                                   NAMEALT  ="Akureyi")) %>%
  # 10m places: misspelling of Liupanshui, Guizhou, China #369
  # Lupanshui -> Liupanshui
  rows_update(by = "NE_ID", tibble(NE_ID = 1159149787,
                                   NAME = "Liupanshui",
                                   NAMEASCII = "Liupanshui",
                                   NAMEALT = "Lupanshui")) %>%
  # Places: Ujungpandang, Indonesia, is now Makassar #398
  # Ujungpandang -> Makassar
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150843,
                                   NAME = "Makassar",
                                   NAMEASCII = "Makassar",
                                   NAMEALT = "Kota Makassar|Ujung Pandang",
                                   FEATURECLA = 'Admin-1 capital')) %>%
  # 10m populated places: request for location adjustments #409
  # Tizi-Ouzou
  rows_update(by = "NE_ID", tibble(NE_ID = 1159120991,
                                   LATITUDE = 36.7117101,
                                   LONGITUDE = 4.0461444)) %>%
  # Bordj Bou Arréridj
  rows_update(by = "NE_ID", tibble(NE_ID = 1159121009,
                                   LATITUDE = 36.0777088,
                                   LONGITUDE = 4.7646624)) %>%
  # Paro
  rows_update(by = "NE_ID", tibble(NE_ID = 1159121163,
                                   LATITUDE = 27.4293704,
                                   LONGITUDE =  89.4167773)) %>%
  # Punakha
  rows_update(by = "NE_ID", tibble(NE_ID = 1159121181,
                                   LATITUDE = 27.5841540,
                                   LONGITUDE =  89.8641347)) %>%
  # 10m places: Max_pop of Newcastle, Australia, is too high #414
  # Newcastle
  rows_update(by = "NE_ID", tibble(NE_ID = 1159151163,
                                   POP_MAX = 540796,
                                   POP_MIN = 322278,
                                   POP_OTHER = 0)) %>%
  # Sovetskaya Gavan misspelled #428
  # Savetskaya Gavan -> Sovetskaya Gavan
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146767,
                                   NAME = "Sovetskaya Gavan",
                                   NAMEASCII = "Sovetskaya Gavan",
                                   NAMEALT = "Savetskaya Gavan")) %>%
  # Populated_Places: Wrong Chinese names #430
  # Shijianzhuang -> Shijianzhuang
  rows_update(by = "NE_ID", tibble(NE_ID = 1159149907,
                                   NAME = "Shijiazhuang",
                                   NAMEASCII = "Shijiazhuang",
                                   NAMEALT = "Shijianzhuang")) %>%
  # Xiangfan -> Xiangyang
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148459,
                                   NAME = "Xiangyang",
                                   NAMEASCII = "Xiangyang",
                                   NAMEALT = "Xiangfan")) %>%
  # 10m Populated Places: State-Wide Name Updates in Karnataka, India #448
  # Bangalore -> Bengaluru
  rows_update(by = "NE_ID", tibble(NE_ID = 1159151543,
                                   NAME = "Bengaluru",
                                   NAMEASCII = "Bengaluru",
                                   NAMEPAR = "Bangalore",
                                   NAMEALT = "")) %>%
  # Mangalore -> Mangaluru
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150015,
                                   NAME = "Mangaluru",
                                   NAMEASCII = "Mangaluru",
                                   NAMEPAR = "Mangalore",
                                   NAMEALT = "")) %>%
  # Bellary -> Ballari
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148527,
                                   NAME = "Ballari",
                                   NAMEASCII = "Ballari",
                                   NAMEPAR = "Bellary",
                                   NAMEALT = ""))  %>%
  # Bijapur -> Vijayapura
  rows_update(by = "NE_ID", tibble(NE_ID = 1159147195,
                                   NAME = "Vijayapura",
                                   NAMEASCII = "Vijayapura",
                                   NAMEPAR = "Bijapur",
                                   NAMEALT = "")) %>%
  # Belgaum -> Belagavi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148531,
                                   NAME = "Belagavi",
                                   NAMEASCII = "Belagavi",
                                   NAMEPAR = "Belgaum",
                                   NAMEALT = "")) %>%
  # Gulbarga -> Kalaburagi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150019,
                                   NAME = "Kalaburagi",
                                   NAMEASCII = "Kalaburagi",
                                   NAMEPAR = "Gulbarga",
                                   NAMEALT = "")) %>%
  # Mysore -> Mysuru
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150017,
                                   NAME = "Mysuru",
                                   NAMEASCII = "Mysuru",
                                   NAMEPAR = "Mysore",
                                   NAMEALT = "")) %>%
  # Hospet -> Hosapete
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141837,
                                   NAME = "Hosapete",
                                   NAMEASCII = "Hosapete",
                                   NAMEPAR = "Hospet",
                                   NAMEALT = "")) %>%
  # Shimoga -> Shivamogga
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141827,
                                   NAME = "Shivamogga",
                                   NAMEASCII = "Shivamogga",
                                   NAMEPAR = "Shimoga",
                                   NAMEALT = "")) %>%
  # Hubli -> Hubballi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150013,
                                   NAME = "Hubballi",
                                   NAMEASCII = "Hubballi",
                                   NAMEPAR = "Hubli",
                                   NAMEALT = "")) %>%
  # Tumkur -> Tumakuru
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148523,
                                   NAME = "Tumakuru",
                                   NAMEASCII = "Tumakuru",
                                   NAMEPAR = "Tumkur",
                                   NAMEALT = "")) %>%
  # 10m Populated Places: Location of Bodø, Norway #450
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146401,
                                   LATITUDE = 67.2764346,
                                   LONGITUDE =  14.4292849)) %>%
  # 10m Populated Places: Ammochostos/Famagusta, Nicosia #452
  # Ammochostos -> Famagusta
  rows_update(by = "NE_ID", tibble(NE_ID = 1159132353,
                                   NAME = "Famagusta",
                                   NAMEASCII = "Famagusta",
                                   NAMEPAR = "Ammochostos")) %>%
  # 10m Populated Place: Puducherry, India #454
  # Pondicherry -> Puducherry
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150163,
                                   NAME = "Puducherry",
                                   NAMEASCII = "Puducherry",
                                   NAMEPAR = "Pondicherry",
                                   NAMEALT = "")) %>%
  # 10m populated places: location precision for Windsor, Ontario #468
  rows_update(by = "NE_ID", tibble(NE_ID = 1159147661,
                                   LATITUDE = 42.3154570,
                                   LONGITUDE =  -83.0368525)) %>%
  # 10m populated places: Request to update name for Kuwait City #483
  # Kuwait -> Kuwait City
  rows_update(by = "NE_ID", tibble(NE_ID = 1159151361,
                                   NAME = "Kuwait City",
                                   NAMEASCII = "Kuwait City",
                                   NAMEALT = "Al Kuwayt|Kuwait")) %>%
  # 10m populated places: Request for location changes #338
  # Jacundá
  rows_update(by = "NE_ID", tibble(NE_ID = 1159143267,
                                   LATITUDE = -4.4394588,
                                   LONGITUDE = -49.1156930)) %>%
  # Peter I Island
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146109,
                                   LATITUDE = -68.7951614,
                                   LONGITUDE = -90.5842030)) %>%
  # Dawwah -> Hilf
  rows_update(by = "NE_ID", tibble(NE_ID = 1159132343,
                                   LATITUDE = 20.6561533,
                                   LONGITUDE = 58.8767621,
                                   NAME = "Hilf",
                                   NAMEASCII = "Hilf",
                                   NAMEALT = "Dawwah",
                                   POP_MAX = 8500)) %>%
  # 10m places: Adjust max population of Korla, China to 770,000 #412
  # Aksu
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146973,
                                    POP_MAX = 695000)) %>%
  # Hami
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150881,
                                    POP_MAX = 580000)) %>%
  # Hotan
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150883,
                                    POP_MAX = 408894)) %>%
  # Karamay
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146971,
                                    POP_MAX = 261445)) %>%
  # Kashgar
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150885,
                                    POP_MAX = 506640)) %>%
  # Korla
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146961,
                                    POP_MAX = 613000)) %>%
  # Kuqa
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146965,
                                    POP_MAX = 470600)) %>%
  # Quiemo
  rows_update(by = "NE_ID", tibble(NE_ID = 1159140711,
                                    POP_MAX = 65572)) %>%
  # Shache
  rows_update(by = "NE_ID", tibble(NE_ID = 1159149875,
                                    POP_MAX = 851374)) %>%
  # Shihezi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146969,
                                    POP_MAX = 640000)) %>%
  # Turpan
  rows_update(by = "NE_ID", tibble(NE_ID = 1159140707,
                                    POP_MAX = 651853)) %>%
  # Urumqi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159151531,
                                    POP_MAX = 3575000)) %>%
  # Yining
  rows_update(by = "NE_ID", tibble(NE_ID = 1159149877,
                                    POP_MAX = 542507)) %>%
  # 10m Populated Places: Wikidata for Banners in Inner Mongolia #455
  # Genhe -> Ergun Zuoqi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159130275,
                                   NAME = "Genhe",
                                   NAMEASCII = "Genhe",
                                   NAMEPAR = "Ergun Zuoqi",
                                   WIKIDATAID = 'Q1354108')) %>%
  # Bairin Zuoqi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141123,
                                   WIKIDATAID = 'Q1329235')) %>%
  # Hanggin Houqi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159130301,
                                   WIKIDATAID = 'Q1202314')) %>%
  # Alxa Zuoqi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141109,
                                   WIKIDATAID = 'Q1367222')) %>%
  # Wikidata | Populated_Places | China | County -> City replacement #458
  # Qinggang
  rows_update(by = "NE_ID", tibble(NE_ID = 1159130307,
                                   WIKIDATAID = 'Q8836938')) %>%
  # Suileng
  rows_update(by = "NE_ID", tibble(NE_ID = 1159130333,
                                   WIKIDATAID = 'Q13992688')) %>%
  # Wenshan
  rows_update(by = "NE_ID", tibble(NE_ID = 1159140833,
                                   WIKIDATAID = 'Q1201048')) %>%
  # Liuhe
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141055,
                                   WIKIDATAID = 'Q11109923')) %>%
  # Wangqing
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141079,
                                   WIKIDATAID = 'Q13897219')) %>%
  # Tailai
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141183,
                                   WIKIDATAID = 'Q11145142')) %>%
  # Gannan
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141193,
                                   WIKIDATAID = 'Q1493582')) %>%
  # Lanxi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141223,
                                   WIKIDATAID = 'Q10893722')) %>%
  # Nancha
  rows_update(by = "NE_ID", tibble(NE_ID = 1159141231,
                                   WIKIDATAID = 'Q2043360')) %>%
  # wikidata | 10m populated_places | replace #459
  # Peace River
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150235,
                                   WIKIDATAID = 'Q1743985')) %>%
  # Tarawa
  rows_update(by = "NE_ID", tibble(NE_ID = 1159149079,
                                   WIKIDATAID = 'Q131233')) %>%
  # Chapleau
  rows_update(by = "NE_ID", tibble(NE_ID = 1159143805,
                                   WIKIDATAID = 'Q2957549')) %>%
  # Chilca
  rows_update(by = "NE_ID", tibble(NE_ID = 1159136041,
                                   WIKIDATAID = 'Q16890238')) %>%
  # Oymyakon
  rows_update(by = "NE_ID", tibble(NE_ID = 1159132375,
                                   WIKIDATAID = 'Q192098')) %>%
  # Chuquicamata
  rows_update(by = "NE_ID", tibble(NE_ID = 1159130545,
                                   WIKIDATAID = 'Q55342984',
                                   POP_MAX = 0,
                                   POP_MIN = 0,
                                   POP_OTHER = 0)) %>%
  # Hua Hin
  rows_update(by = "NE_ID", tibble(NE_ID = 1159134475,
                                   WIKIDATAID = 'Q667576')) %>%
  # Samut Prakan
  rows_update(by = "NE_ID", tibble(NE_ID = 1159134483,
                                   WIKIDATAID = 'Q13139252')) %>%
  # Thung Song
  rows_update(by = "NE_ID", tibble(NE_ID = 1159134373,
                                   WIKIDATAID = 'Q15199303')) %>%
  # Miaoli
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146177,
                                   WIKIDATAID = 'Q701651')) %>%
  # Warangal
  rows_update(by = "NE_ID", tibble(NE_ID = 1159147191,
                                   WIKIDATAID = 'Q25563103 ')) %>%
  # Makale
  rows_update(by = "NE_ID", tibble(NE_ID = 1159139891,
                                   WIKIDATAID = 'Q57079173')) %>%
  # Gorakhpur
  rows_update(by = "NE_ID", tibble(NE_ID = 1159147325,
                                   WIKIDATAID = 'Q5584396')) %>%
  # Vitória da Conquista
  rows_update(by = "NE_ID", tibble(NE_ID = 1159150217,
                                   WIKIDATAID = 'Q22062839')) %>%
  # Ras al Khaymah
  rows_update(by = "NE_ID", tibble(NE_ID = 1159134277,
                                   WIKIDATAID = 'Q2126436')) %>%
  # Antioch -> Antakya
  rows_update(by = "NE_ID", tibble(NE_ID = 1159113499,
                                   WIKIDATAID = 'Q80561',
                                   NAME = "Antakya",
                                   NAMEASCII = "Antakya",
                                   NAMEALT = "Antioch")) %>%
  # Hatay - province, so delete
  rows_delete(by = "NE_ID", tibble(NE_ID = 1159135187)) %>%
  # Villa Ahumada
  rows_update(by = "NE_ID", tibble(NE_ID = 1159138309,
                                   WIKIDATAID = 'Q20148488')) %>%
  # Ciudad Camargo
  rows_update(by = "NE_ID", tibble(NE_ID = 1159138313,
                                   WIKIDATAID = 'Q2528602')) %>%
  # Sonbong
  rows_update(by = "NE_ID", tibble(NE_ID = 1159139183,
                                   WIKIDATAID = 'Q221734',
                                   NAME = "Rason",
                                   NAMEASCII = "Rason",
                                   NAMEALT = "Sonbong")) %>%
  # Hungnam
  rows_delete(by = "NE_ID", tibble(NE_ID = 1159139193)) %>%
  # Ali Bayramli -> Şirvan
  rows_update(by = "NE_ID", tibble(NE_ID = 1159144565,
                                   WIKIDATAID = 'Q241116',
                                   NAME = "Şirvan",
                                   NAMEASCII = "Shirvan",
                                   NAMEALT = "Ali Bayramli")) %>%
  # Xigaze
  rows_update(by = "NE_ID", tibble(NE_ID = 1159149873,
                                   WIKIDATAID = 'Q1211183')) %>%
  # wikidata | 10m populated_places | other proposals ... #461
  # Xiangkhoang -> Phonsavan
  rows_update(by = "NE_ID", tibble(NE_ID = 1159139143,
                                   # this town is no longer the admin-1 capital
                                   FEATURECLA = "Populated Place",
                                   # feature should be moved to 19.451895771215643, 103.19599722986072
                                   LATITUDE = 19.4518958,
                                   LONGITUDE = 103.1959972,
                                   # name changed to Phonsavan
                                   NAME = "Phonsavan",
                                   NAMEASCII = "Phonsavan",
                                   NAMEALT = "Xiangkhoang",
                                   # population changed to 37507
                                   POP_MAX = 37507,
                                   POP_MIN = 37507,
                                   # WD changed to Q1011711
                                   WIKIDATAID = 'Q1011711')) %>%
  # Zhijiang
  rows_update(by = "NE_ID", tibble(NE_ID = 1159140801,
                                   WIKIDATAID = 'Q14297991')) %>%
  # Mohembo
  rows_update(by = "NE_ID", tibble(NE_ID = 1159145189,
                                   WIKIDATAID = 'Q171089')) %>%
  # El Kharga
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148437,
                                   WIKIDATAID = 'Q4063326')) %>%
  # Umm al Qaywayn
  rows_update(by = "NE_ID", tibble(NE_ID = 1159126925,
                                   WIKIDATAID = 'Q2788830')) %>%
  # Escudero Base
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146095,
                                   WIKIDATAID = 'Q2714138')) %>%
  # Oktyabrskiy
  rows_update(by = "NE_ID", tibble(NE_ID = 1159146863,
                                   WIKIDATAID = 'Q1691320',
                                   # change population to 1534
                                   POP_MAX = 1534,
                                   POP_MIN = 1534)) %>%
  # Mato Grosso -> Vila Bela da Santíssima Trindade
  rows_update(by = "NE_ID", tibble(NE_ID = 1159148779,
                                   WIKIDATAID = 'Q732088',
                                   # change name to Santissima Trindade
                                   NAME = "Santissima Trindade",
                                   NAMEASCII = "Santissima Trindade",
                                   NAMEALT = "Vila Bela da Santissima Trindade|Mato Grosso",
                                   # change population to 16271
                                   POP_MAX = 16271,
                                   POP_MIN = 16271)) %>%
  # Pakhachi
  rows_update(by = "NE_ID", tibble(NE_ID = 1159129673,
                                   WIKIDATAID = 'Q4347325')) %>%
  # Aqadyr
  rows_update(by = "NE_ID", tibble(NE_ID = 1159129551,
                                   WIKIDATAID = 'Q4056543')) %>%
  # Omchak
  rows_update(by = "NE_ID", tibble(NE_ID = 1159129085,
                                   WIKIDATAID = 'Q14545882')) %>%
  # Zvezdnyy -> Zvëzdnyj
  rows_update(by = "NE_ID", tibble(NE_ID = 1159128511,
                                   WIKIDATAID = 'Q2305684',
                                   # change name to Zvëzdnyj
                                   NAME = "Zvëzdnyj",
                                   NAMEASCII = "Zvezdnyj",
                                   NAMEALT = "Zvezdnyy")) %>%
  # Gyzlarbat -> Serdar
  rows_update(by = "NE_ID", tibble(NE_ID = 1159126955,
                                   WIKIDATAID = 'Q1015618',
                                   # change name to Serdar
                                   NAME = "Serdar",
                                   NAMEASCII = "Serdar",
                                   NAMEALT = "Gyzlarbat"))

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

