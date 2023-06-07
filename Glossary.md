GeoJson Files and other GIS Formats use a lot of Abbreviations for their Metadata. 
Here are some with their Type and Description (please correct or complete the list): 

| Column	| Type	| Example	| DESCRIPTION	| 
|---	|---	|--- 	|---	| 
| gid	| integer	| 	| 	| 
| scalerank	| smallint	| 1	| 	| 
| labelrank	| smallint	| 	| 	| 
| featurecla	| character(30)	| Admin-0 country	| Feature-Class, e.g. 'River', 'Lake', 	| 
| name	| character(36)	| Afghanistan	| Name of the Feature	| 
| name_long	| character(40)	| Afghanistan	| long Name	| 
| sovereignt	| character(32)	| Afghanistan	| Name of the Sovereign (ruling) Country	| 
| sov_a3	| character(3)	| AFG	| 3-Letter Abbrev. of 'sovereignt' 	| 
| geounit	| character(40)	| Afghanistan	| 	| 
| gu_a3	| character(3)	| AFG	| 3-Letter Abbrev. of 'geounit'	| 
| subunit	| character(40)	| Afghanistan	| 	| 
| su_a3	| character(3)	| AFG	| 3-Letter Abbrev. of 'subunit'	| 
| adm0_dif	| float point	| 0.000000	| 	| 
| adm0_a3	| character(3)	| AFG	| 3-Letter Abbrev. of the Admin. Level 0 (Country)	|
| adm0_a3_is	| 	| AFG	| 	|
| adm0_a3_us	| 	| AFG	| 	|
| adm0_a3_un	| 	| -99	| 	|
| adm0_a3_wb	| 	| -99	| 	|
| ISO3166-1-Alpha-3	| 	| 	| (Administative Level 0)	| 
| ISO3166-1-Alpha-3	| 	| 	| (Administative Level 0)	| 
| country	| character(40)	| Afghanistan	| The full Country Name	| 
| admin	| character(40)	| 	| 	| 
| level	| float point	| 2.000000	| 	| 
| type	| character(17)	| Sovereign country	| 	| 
| geou_dif	| float point	| 0.000000	| 	| 
| su_dif	| float point	| 	| 	| 
| brk_diff	| float point	| 0.000000	| 	| 
| brk_a3	| character(3)	| AFG	| 	| 
| brk_name	| character(36)	| Afghanistan	| 	| 
| brk_group	| character(30)	| null	| 	| 
| abbrev	| character(13)	| 	| Name-Abbreviation	| 
| postal	| character(4)	| 	| International Postal Code	| 
| formal_en	| character(52)	| Islamic State of Afghanistan	| Full English Name according to UN	| 
| min_zoom	| smallint	| 	| Minimum Zoom Level to show this Feature	| 
| min_label	| smallint	| 	| Minimum Zoom Level to show this Label	| 
| pop_est	| integer	| 28400000	| Population Estimate	|
| gdp_md_est	| float point	| 22270	| GDP Estimate	|
| pop_year	| 	| -99	| Population Current Year	|
| lastcensus	| 	| 1979	| Year of Last Census	|
| gdp_year	| 	| -99	| GDP Current Year	|
| economy	| 	| 7. Least developed region	| Economical Rank	|
| income_grp	| 	| 5. Low income	| Income Group Rank	|
| wikipedia	| 	| -99	| Wikipedia ???	|
| fips_10	| 	| null	| US Census FIPS Code	|
| iso_a2	| 	| AF	| Administrative Coding ISO 3166-1 A-2	|
| iso_a3	| 	| AFG	| Administrative Coding ISO 3166-1 A-3	|
| iso_n3	| 	| 4	| Administrative Coding ISO 3166-1 Num N3	|
| un_a3	| 	| 4	| UN 3-Letter Code	|
| wb_a2	| 	| AF	| World Bank 2-Letter Code	|
| wb_a3	| 	| AFG	| World Bank 3-Letter Code	|
| woe_id	| 	| -99	| 	|
| continent	| 	| Asia	| Continent	|
| region_un	| 	| Asia	| UN Region Name	|
| subregion	| 	| Southern Asia	| Sub Region	|
| region_wb	| 	| South Asia	| World Bank Region Name 	|
| name_len	| 	| 11	| Length of the 'name' 	|
| long_len	| 	| 11	| Length of the 'name_long'	|
| abbrev_len	| 	| 4	| Length of the 'abbrev' Field	|
| tiny	| 	| -99	| 	|
| homepart	| 	| 1	| 	|

