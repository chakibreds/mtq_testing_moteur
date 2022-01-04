# Ce script réalise une expérience 2^2 faisant varier la taille des données et de la mémoire.

DATASET_DIR="../data/dataset/"
QUERIES="../data/queries/file-per-template-final/"

PY="./protocoles/facteur.py"
JAR="../rdfengine.jar"

OUTPUT="../output/test-facteurs/"

CMDJAR="java -jar $JAR -queries $QUERIES -output $OUTPUT -data"

if [ ! -d $QUERIES ]; then
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
else
    echo -e "Directory $OUTPUT already exists\nDo you want to overwrite ? (any key to continue / CTRL-C to exit)"
    read $x
    echo -e "Overwriting..."
fi

echo -e "Queries used : $QUERIES\n"

# 'A' represente la taille des données low => 100K, high => 2000K
A_LOW=$DATASET_DIR"200K.nt"
A_HIGH=$DATASET_DIR"2000K.nt"

# 'B' represente la taille de la mémoire low => 1Go, high => 4Go
B_LOW="-Xmx1G -Xms1G"
B_HIGH="-Xmx4G -Xms4G"

echo "Running (low, low)"
java $B_LOW -jar $JAR -queries $QUERIES -output $OUTPUT -data $A_LOW > /dev/null
mv $OUTPUT"stats.csv" $OUTPUT"stats-low-low.csv"
echo "File "$OUTPUT"stats-low-low.csv created"
    
echo "Running (low, high)"
java $B_HIGH -jar $JAR -queries $QUERIES -output $OUTPUT -data $A_LOW > /dev/null
mv $OUTPUT"stats.csv" $OUTPUT"stats-low-high.csv"
echo "File "$OUTPUT"stats-low-high.csv created"

echo "Running (high, low)"
java $B_LOW -jar $JAR -queries $QUERIES -output $OUTPUT -data $A_HIGH > /dev/null
mv $OUTPUT"stats.csv" $OUTPUT"stats-high-low.csv"
echo "File "$OUTPUT"stats-high-low.csv created"

echo "Running (high, high)"
java $B_HIGH -jar $JAR -queries $QUERIES -output $OUTPUT -data $A_HIGH > /dev/null
mv $OUTPUT"stats.csv" $OUTPUT"stats-high-high.csv"
echo "File "$OUTPUT"stats-high-high.csv created"

echo ""
echo "Running "$PY

python3 $PY $OUTPUT

