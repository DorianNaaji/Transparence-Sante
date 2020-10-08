# script for downloading huge files that are not part of the github repository (files that are larger than 100MB can't be hosted).
cd C:\BI\transparence-sante

# downloading rrps_diplomes
curl.exe --output C:\BI\transparence-sante\data\others\rpps_diplomes.zip --url http://82.254.125.180:55166/share/QW3PbWnQFxfdlAi0/rpps_diplomes.zip
# downloading data.gouv.zip
curl.exe --output C:\BI\transparence-sante\data\data.gouv\data.gouv.zip --url http://82.254.125.180:55166/share/GT1e57gNYLfizc_v/data.gouv.zip
# downloading zipcodes_dep_region
curl.exe --output C:\BI\transparence-sante\data\others\zipcodes_dep_region.zip --url http://82.254.125.180:55166/share/eTF3QY5bJAHcpbVV/zipcodes_dep_region.zip

# dezip
expand-archive -path 'C:\BI\transparence-sante\data\others\rpps_diplomes.zip' -destinationpath '.\data\others'
expand-archive -path 'C:\BI\transparence-sante\data\data.gouv\data.gouv.zip' -destinationpath '.\data\data.gouv'
expand-archive -path 'C:\BI\transparence-sante\data\others\zipcodes_dep_region.zip' -destinationpath '.\data\others'

# removing zip files
Remove-Item –path 'C:\BI\transparence-sante\data\others\rpps_diplomes.zip'
Remove-Item –path 'C:\BI\transparence-sante\data\data.gouv\data.gouv.zip'
Remove-Item –path 'C:\BI\transparence-sante\data\others\zipcodes_dep_region.zip'