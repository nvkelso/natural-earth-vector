#!/bin/bash

set -Eeuo pipefail

runMode=$1
planMode=1

if [[ "$runMode" == "plan" ]]; then
  planMode=0
  shift
  runMode=$1
fi

shift

isUppercased() {
  list=(
      "admin_0_sovereignty"
      "admin_0_countries"
      "admin_0_countries_lakes"
      "admin_0_map_units"
      "admin_0_map_subunits"
      "admin_0_disputed_areas"
      "admin_2_label_points_details"
      "admin_2_counties"
      "admin_2_counties_lakes"
      "admin_0_tiny_countries"
      "admin_0_breakaway_disputed_areas"
      )
  for item in "${list[@]}"; do
    if [[ "$1" == *"$item" ]]; then
      return 0
    fi
  done
  return 1
}

_10mCulturalList=(
      "admin_0_sovereignty"
      "admin_0_countries"
      "admin_0_countries_lakes"
      "admin_0_map_units"
      "admin_0_map_subunits"
      "admin_0_disputed_areas"
      "admin_1_states_provinces"
      "admin_1_states_provinces_lakes"
      "admin_1_label_points_details"
      "admin_2_label_points_details"
      "admin_2_counties"
      "admin_2_counties_lakes"
      "airports"
      "populated_places"
      )

_10mPhysicalList=(
      "geographic_lines"
      "geography_marine_polys"
      "geography_regions_elevation_points"
      "geography_regions_points"
      "geography_regions_polys"
      "lakes"
      "lakes_europe"
      "lakes_historic"
      "lakes_north_america"
      "playas"
      "rivers_lake_centerlines"
      "rivers_lake_centerlines_scale_rank"
      "rivers_europe"
      "rivers_north_america"
      )

_50mCulturalList=(
      "admin_0_sovereignty"
      "admin_0_countries"
      "admin_0_countries_lakes"
      "admin_0_map_units"
      "admin_0_map_subunits"
      "admin_0_tiny_countries"
      "admin_0_breakaway_disputed_areas"
      "admin_1_states_provinces"
      "admin_1_states_provinces_lakes"
      )

_50mPhysicalList=(
      "lakes"
      "lakes_historic"
      "playas"
      "rivers_lake_centerlines"
      "rivers_lake_centerlines_scale_rank"
      )

_110mCulturalList=(
      "admin_0_sovereignty"
      "admin_0_countries"
      "admin_0_countries_lakes"
      "admin_0_map_units"
      "admin_1_states_provinces"
      "admin_1_states_provinces_lakes"
      )

_110mPhysicalList=(
      "lakes"
      "rivers_lake_centerlines"
      )

function is10mCultural() {
  for item in "${_10mCulturalList[@]}"; do
    if [[ "$1" == "$item" || "$1" == 10m_"$item" || "$1" == ne_10m_"$item" ]]; then
      return 0
    fi
  done
  return 1
}

function is10mPhysical() {
  for item in "${_10mPhysicalList[@]}"; do
    if [[ "$1" == "$item" || "$1" == 10m_"$item" || "$1" == ne_10m_"$item" ]]; then
      return 0
    fi
  done
  return 1
}

function is10m() {
    if is10mCultural "$1" || is10mPhysical "$1" ; then
        return 0
    fi
    return 1
}

function is50mCultural() {
  for item in "${_50mCulturalList[@]}"; do
    if [[ "$1" == "$item" || "$1" == *50m_"$item" ]]; then
      return 0
    fi
  done
  return 1
}

function is50mPhysical() {
  for item in "${_50mPhysicalList[@]}"; do
    if [[ "$1" == "$item" || "$1" == *50m_"$item" ]]; then
      return 0
    fi
  done
  return 1
}

function is50m() {
    if  is50mCultural "$1" || is50mPhysical "$1" ; then
        return 0
    fi
    return 1
}

function is110mCultural() {
  for item in "${_110mCulturalList[@]}"; do
    if [[ "$1" == "$item" || "$1" == *110m_"$item" ]]; then
      return 0
    fi
  done
  return 1
}

function is110mPhysical() {
  for item in "${_110mPhysicalList[@]}"; do
    if [[ "$1" == "$item" || "$1" == *110m_"$item" ]]; then
      return 0
    fi
  done
  return 1
}

function is110m() {
    if  is110mCultural "$1" || is110mPhysical "$1" ; then
        return 0
    fi
    return 1
}

function isPhysical() {
  if is10mPhysical "$1" || is50mPhysical "$1" || is110mPhysical; then
    return 0
  fi
  return 1
}

function isCultural() {
  if is10mCultural "$1" || is50mCultural "$1" || is110mCultural; then
    return 0
  fi
  return 1
}

function runFileWithPrefix() {
  # $1 = mode
  # $2 = letterCase
  # $3 = shape_path
  # $4 = shape_filename
  # $5 = prefix

  if [[ "$4" == ne_"$5"_* ]]; then
    echo  "$runMode"  "$2"   "$3"  "$4"
    if [[ $planMode -ne 0 ]]; then
      ./tools/wikidata/update.sh  "$1"  "$2"   "$3"  "$4"
    fi
  elif [[ "$4" == "$5"_* ]]; then
    echo  "$runMode"  "$2"   "$3"  "ne_$4"
    if [[ $planMode -ne 0 ]]; then
      ./tools/wikidata/update.sh  "$1"  "$2"   "$3"  "ne_$4"
    fi
  else
    echo  "$runMode"  "$2"   "$3"  "ne_${5}_${4}"
    if [[ $planMode -ne 0 ]]; then
      ./tools/wikidata/update.sh  "$1"  "$2"   "$3"  "ne_${5}_${4}"
    fi
  fi
}

function runFile {
  # $1 = mode
  # $2 = Filename
  local letterCase

  if isUppercased "$2"; then
    letterCase="uppercase"
  else
    letterCase="lowercase"
  fi

  shapefileTypeFound=1

  if is110mCultural "$2"; then
    shapefileTypeFound=0
    runFileWithPrefix "$1" "$letterCase" "110m_cultural" "$2" "110m"
  fi
  if is110mPhysical "$2"; then
    shapefileTypeFound=0
    runFileWithPrefix "$1" "$letterCase" "110m_physical" "$2" "110m"
  fi

  if is50mCultural "$2"; then
    shapefileTypeFound=0
    runFileWithPrefix "$1" "$letterCase" "50m_cultural" "$2" "50m"
  fi
  if is50mPhysical "$2"; then
    shapefileTypeFound=0
    runFileWithPrefix "$1" "$letterCase" "50m_physical" "$2" "50m"
  fi

  if is10mCultural "$2"; then
    shapefileTypeFound=0
    runFileWithPrefix "$1" "$letterCase" "10m_cultural" "$2" "10m"
  fi
  if is10mPhysical "$2"; then
    shapefileTypeFound=0
    runFileWithPrefix "$1" "$letterCase" "10m_physical" "$2" "10m"
  fi

  if [[ $shapefileTypeFound == 1 ]]; then
    echo "ERROR: Unknown shapefile name: $2"
    exit 1
  fi
}

function runList {
  # $1 = mode
  # $2 = prefix
  # $3... = list

  local mode="$1"
  shift
  local prefix="$1"
  shift
  local arr=("$@")

  for i in "${arr[@]}"; do
    runFile "$mode" "${prefix}${i}"
  done
}

if [[ ("$runMode" != "fetch") && ("$runMode" != "fetch_write") && ("$runMode" != "write") && ("$runMode" != "copy") && ("$runMode" != "all") ]]; then
  echo "Unknown runMode: $runMode"
  echo "Valid runModes are: fetch, fetch_write, write, copy, all"
  exit 1
fi

for fileName in "$@"; do
if [[ "$fileName" == "all" ]]; then
  runList "$runMode" "110m_" "${_110mCulturalList[@]}"
  runList "$runMode" "110m_" "${_110mPhysicalList[@]}"
  runList "$runMode" "50m_" "${_50mCulturalList[@]}"
  runList "$runMode" "50m_" "${_50mPhysicalList[@]}"
  runList "$runMode" "10m_" "${_10mCulturalList[@]}"
  runList "$runMode" "10m_" "${_10mPhysicalList[@]}"
elif [[ "$fileName" == "110m" ]]; then
  runList "$runMode" "110m_" "${_110mCulturalList[@]}"
  runList "$runMode" "110m_" "${_110mPhysicalList[@]}"
elif [[ "$fileName" == "50m" ]]; then
  runList "$runMode" "50m_" "${_50mCulturalList[@]}"
  runList "$runMode" "50m_" "${_50mPhysicalList[@]}"
elif [[ "$fileName" == "10m" ]]; then
  runList "$runMode" "10m_" "${_10mCulturalList[@]}"
  runList "$runMode" "10m_" "${_10mPhysicalList[@]}"
elif [[ "$fileName" == "cultural" ]]; then
  runList "$runMode" "110m_" "${_110mCulturalList[@]}"
  runList "$runMode" "50m_" "${_50mCulturalList[@]}"
  runList "$runMode" "10m_" "${_10mCulturalList[@]}"
elif [[ "$fileName" == "physical" ]]; then
  runList "$runMode" "110m_" "${_110mPhysicalList[@]}"
  runList "$runMode" "50m_" "${_50mPhysicalList[@]}"
  runList "$runMode" "10m_" "${_10mPhysicalList[@]}"
elif [[ "$fileName" == "cultural_10m" ]]; then
  runList "$runMode" "10m_" "${_10mCulturalList[@]}"
elif [[ "$fileName" == "physical_10m" ]]; then
  runList "$runMode" "10m_" "${_10mPhysicalList[@]}"
elif [[ "$fileName" == "cultural_50m" ]]; then
  runList "$runMode" "50m_" "${_50mCulturalList[@]}"
elif [[ "$fileName" == "physical_50m" ]]; then
  runList "$runMode" "50m_" "${_50mPhysicalList[@]}"
elif [[ "$fileName" == "cultural_110m" ]]; then
  runList "$runMode" "110m_" "${_110mCulturalList[@]}"
elif [[ "$fileName" == "physical_110m" ]]; then
  runList "$runMode" "110m_" "${_110mPhysicalList[@]}"
else
  runFile "$runMode" "$fileName"
fi
done