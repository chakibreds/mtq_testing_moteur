# This script create a queryset with $NB_QUERIES using watdiv
# We create a file by template

WATDIV="../watdiv"
TEMPLATE_DIR=$WATDIV"/templates"
RESULT_DIR="../data/queries/file-per-template"

if [ ! -d $WATDIV ] || [ ! -d $TEMPLATE_DIR ]; then
   echo "Error: watdiv or template directory not found"
   exit 1
fi

if [ ! -d $RESULT_DIR ]; then
   echo "Creating directory $RESULT_DIR"
   mkdir $RESULT_DIR || echo "Error creating directory $RESULT_DIR" && exit 1
fi

NB_QUERIES=1000
i=0
override=0

for template in ${TEMPLATE_DIR}/*.sparql-template;
do 
   template_name=${template##*/}
   template_name=${template_name%.sparql-template}
   querie_file=$RESULT_DIR"/"$template_name".queryset"

   if [ $override -eq 0 ] && [ -f $querie_file ]; then
      echo -e "File '$querie_file' already exists.\nDo you want to overwrite ? (any key to continue / CTRL-C to exit)"
      read $x
      echo -e "Overwriting..."
      override=1
   fi

   $WATDIV/watdiv -q $WATDIV/model/wsdbm-data-model.txt ${template} $NB_QUERIES 1 > $querie_file
   i=$(($i+1))
done

if [ -f $RESULT_FILE ]; then
   echo -e "$i file created with $NB_QUERIES queries for each one.\nThe file are in $RESULT_DIR."
fi