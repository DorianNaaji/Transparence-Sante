# script for downloading huge files that are not part of the github repository (files that are larger than 100MB can't be hosted).
cd C:\BI\transparence-sante

# downloading rrps_diplomes
curl.exe --output C:\BI\transparence-sante\data\others\rpps_diplomes.zip --url https://srv-file6.gofile.io/downloadStore/srv-store4/NMW0Da/rpps_diplomes.zip 
# downloading data.gouv.zip
curl.exe --output C:\BI\transparence-sante\data\data.gouv\data.gouv.zip --url https://srv-file20.gofile.io/downloadStore/srv-store4/lxEeQf/data.gouv.zip

# dezip
expand-archive -path 'C:\BI\transparence-sante\data\others\rpps_diplomes.zip' -destinationpath '.\data\others'
expand-archive -path 'C:\BI\transparence-sante\data\data.gouv\data.gouv.zip' -destinationpath '.\data\data.gouv'

# removing zip files
Remove-Item –path 'C:\BI\transparence-sante\data\others\rpps_diplomes.zip'
Remove-Item –path 'C:\BI\transparence-sante\data\data.gouv\data.gouv.zip'