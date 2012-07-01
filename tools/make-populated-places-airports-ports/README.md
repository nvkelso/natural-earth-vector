#Makefile

* For auto-extracting the **50m** and **110m populated places** from the master 10m theme. 
* For auto-extracting the **simplified versions** of the 10m, 50m, and 110m populated places from the master 10m theme. 
* For auto-extracting the **50m airports** from the master 10m theme.
* For auto-extracting the **50m ports** from the master 10m theme.

#Usage

    Make all

The following files being updated:

* ne_50m_populated_places
* ne_110m_populated_places
* ne_10m_populated_places_simple
* ne_50m_populated_places_simple
* ne_110m_populated_places_simple
* ne_50m_airports
* ne_50m_ports

To remove the generative output:

    Make clean