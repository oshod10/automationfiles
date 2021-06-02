#! /bin/bash



################################
#                              #
# Developed by Osho Divyang    #
#                              #
################################



DAYS_TO_REMOVE=180
FOLDER=/home/sigvalue/etc/ftp/Archive
AUTOMATION=/home/sigvalue/automation/delete_archive

if [ ! -d $FOLDER ]; then

   echo "Archive directory does not exist on this server, exiting script..."
else

   echo "Script execution started at `date`, clearing up the clutter..."
   cd $FOLDER
   find . -maxdepth 1 -type d | while read -r dir; do printf "%s:\t" "$dir"; find "$dir" -type f -ctime +${DAYS_TO_REMOVE}| wc -l; done > $AUTOMATION/Pre.count
   find . -mindepth 1 -type f -ctime +${DAYS_TO_REMOVE} | xargs rm 2> /dev/null
   find . -maxdepth 1 -type d | while read -r dir; do printf "%s:\t" "$dir"; find "$dir" -type f -ctime +${DAYS_TO_REMOVE}| wc -l; done > $AUTOMATION/Post.count

echo "Script execution ended at. `date`"
fi
