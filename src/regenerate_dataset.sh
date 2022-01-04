# This script create a queryset with $NB_QUERIES using watdiv
# We create a file by template

WATDIV="../watdiv"
RESULT_DIR="../data/dataset"

if [ ! -d $WATDIV ] ; then
   echo "Error: watdiv not found"
   exit 1
fi

if [ ! -d $RESULT_DIR ]; then
   echo "Creating directory $RESULT_DIR"
   mkdir $RESULT_DIR
fi

i=0
override=0

for dataset in 100 200 500 700 1000 1200 1500 1700 2000;
do 
   dataset_file=$RESULT_DIR"/"$dataset"K.nt"

   if [ $override -eq 0 ] && [ -f $dataset_file ]; then
      echo -e "File '$dataset_file' already exists.\nDo you want to overwrite ? (any key to continue / CTRL-C to exit)"
      read $x
      echo -e "Overwriting..."
      override=1
   fi

   $WATDIV/watdiv -d $WATDIV/model/wsdbm-data-model.txt $(($dataset / 100)) > $dataset_file
   i=$(($i+1))
done

if [ -f $RESULT_FILE ]; then
   echo -e "$i file created \nThe file are in $RESULT_DIR."
fi