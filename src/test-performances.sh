# Ce script réalise le protocole de test de qualité

DATASET_DIR="../data/dataset/"
QUERIES="../data/queries/file-per-template-final/"

PY="./protocoles/performances.py"
JAR="../rdfengine.jar"

OUTPUT="../output/test-performances/"
O_QENGINE=$OUTPUT"qengine/"
O_JENA=$OUTPUT"jena/"

CMDJAR="java -jar $JAR -queries $QUERIES"

if [ ! -d $QUERIES ] || [ ! -d $TEMPLATE_DIR ]; then
   echo "Error: directory not found"
   exit 1
fi

if [ ! -f $DATASET ] || [ ! -f $PY ] || [ ! -f $JAR ]; then
   echo "Error: file not found"
   exit 1
fi

if [ ! -d $OUTPUT ]; then
   echo "Creating directory $OUTPUT"
   mkdir $OUTPUT
   echo "Creating directory $O_QENGINE"
   mkdir $O_QENGINE
   echo "Creating directory $O_JENA"
   mkdir $O_JENA
else
    echo -e "Directory $OUTPUT already exists\nDo you want to overwrite ? (any key to continue / CTRL-C to exit)"
    read $x
    echo -e "Overwriting..."
    if [ ! -d $O_QENGINE ]; then
        echo "Creating directory $O_QENGINE"
        mkdir $O_QENGINE
    fi
    if [ ! -d $O_JENA ]; then
        echo "Creating directory $O_JENA"
        mkdir $O_JENA
    fi
fi

echo -e "Queries used : $QUERIES\n"

for $dataset in $DATASET_DIR*.nt; do
    echo "Running QEngine on dataset "$dataset
    $CMDJAR -dataset $dataset -output $O_QENGINE > /dev/null
    mv $O_QENGINE"stats.csv" $O_QENGINE"stats-"$dataset".csv"
    echo "File "$O_QENGINE"stats-$dataset.csv created"
    
    echo "Running Jena on dataset "$dataset
    $CMDJAR -jena -dataset $dataset -output $O_JENA > /dev/null
    mv $O_JENA"stats.csv" $O_JENA"stats-"$dataset".csv"
    echo "File "$O_JENA"stats-$dataset.csv created"
    echo -e "\n"
done

echo ""
echo "Runninge "$PY

python3 $PY $O_QENGINE $O_JENA

