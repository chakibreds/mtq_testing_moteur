QUERIES=data/queries/file-per-template-final/
DATA=data/dataset/1M.nt
OUTPUT=output/test-final-qengine/

PARAM=-queries $(QUERIES) -data $(DATA) -output $(OUTPUT) -export_query_results

qengine:
	java -jar rdfengine.jar $(PARAM)

jena: 
	java -jar rdfengine.jar -jena $(PARAM)
