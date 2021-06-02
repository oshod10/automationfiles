#! /bin/bash
# redirect stdout/stderr to a file
exec &>> /home/sigvalue/automation/logfile.txt

FILEPATH=/home/sigvalue/mnt
YESTERDAY=`date -d '-1 day' +'%Y%m%d'`
CURRENT=`date`
TODAY=`date +'%Y%m%d'`
VEH1=$FILEPATH/usage/extracts_files_path/VehicleListComplianceReport/*.csv
PAYCHARGE=$FILEPATH/usage/extracts_files_path/PayCharge_XML/*.CSV
VEH2=$FILEPATH/usage/extracts_files_path/VehiclesForAccount/*.txt
BULK=$FILEPATH/usage/extracts_files_path/Bulk_File/SummaryReport/*.csv
MINS_TO_REMOVE=720

echo "running the script at" $CURRENT
for j in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
  do
   find $FILEPATH/usage/extracts_files_path/PayCharge_XML/Pay__$TODAY$j*.CSV -mmin +${MINS_TO_REMOVE} -exec /usr/bin/rm -f {} \;
  done

for i in "$VEH2" "$VEH1" "$BULK"
    do
      find $i -mmin +${MINS_TO_REMOVE} -exec /usr/bin/rm -f {} \;
    done
VAR=`ls $FILEPATH/usage/extracts_files_path/PayCharge_XML/Pay__$YESTERDAY*.CSV| wc -l`
echo "Previous day Paycharge file count is: " $VAR
if [ $VAR -ge 200 ]
  then
     echo "Too many files, deleting them all!"
     rm -f $FILEPATH/usage/extracts_files_path/PayCharge_XML/Pay__$YESTERDAY*.CSV
     VAR=`ls $FILEPATH/usage/extracts_files_path/PayCharge_XML/Pay__$YESTERDAY*.CSV| wc -l`
       if [ $VAR -lt 10 ]
         then
            echo "file deleted successfully!"
       fi
else
  echo "Yesterday's files do not exist, nothing to delete using rm command!"
fi
