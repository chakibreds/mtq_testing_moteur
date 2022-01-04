# Ce script réalise le protocole de test de qualité

DATASET="../data/dataset/2M.nt"
QUERIES="../data/queries/file-per-template-final/"

PY="./protocoles/qualite.py"
JAR="../rdfengine.jar"

OUTPUT="../output/test-qualite/"
O_QENGINE=$OUTPUT"qengine/"
O_JENA=$OUTPUT"jena/"

CMDJAR="java -jar $JAR -export_query_results -queries $QUERIES -data $DATASET -output "

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

echo "Running qengine on dataset "$DATASET" and queries "$QUERIES
echo "Output will be in "$O_QENGINE

$CMDJAR $O_QENGINE > /dev/null

echo ""
echo "Running jena on dataset "$DATASET" and queries "$QUERIES
echo "Output will be in "$O_JENA

$CMDJAR $O_JENA -jena > /dev/null

echo ""
echo "Runninge "$PY

python $PY $O_QENGINE $O_JENA

