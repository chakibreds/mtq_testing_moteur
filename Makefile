QUERIES=data/queries/file-per-template-final/
DATA=data/dataset/2000K.nt
OUTPUT=output/

PARAM=-queries $(QUERIES) -data $(DATA) -output $(OUTPUT) -export_query_results

qengine:
	java -jar rdfengine.jar $(PARAM)

jena: 
	java -jar rdfengine.jar -jena $(PARAM)
