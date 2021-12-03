# This script create a queryset with $NB_QUERIES using watdiv
# All the queries are stored in the file $RESULT_FILE

DATE=`date +"-%d%m%y-%H%M"`
WATDIV="../watdiv"
TEMPLATE_DIR=$WATDIV"/templates"
RESULT_DIR="../data/queries"
RESULT_FILE=$RESULT_DIR"/queries"$DATE".queryset"

if [ ! -d $RESULT_DIR ]; then
   echo "Creating directory $RESULT_DIR"
   mkdir $RESULT_DIR || echo "Error creating directory $RESULT_DIR" && exit 1
fi

if [ -f $RESULT_FILE ]; then
   echo "File $RESULT_FILE already exist"
   exit 1
elses
   echo "Creating file $RESULT_FILE"
   touch $RESULT_FILE || echo "Error creating file $RESULT_FILE" && exit 1
fi

NB_QUERIES=1000
i=0

for template in ${TEMPLATE_DIR}/*.sparql-template; 
do
   $WATDIV/watdiv -q $WATDIV/model/wsdbm-data-model.txt ${template} $NB_QUERIES 1 >> $RESULT_FILE
   i=$(($i+$NB_QUERIES))
done;

if [ -f $RESULT_FILE ]; then
   echo "File $RESULT_FILE created with $i queries."
fi