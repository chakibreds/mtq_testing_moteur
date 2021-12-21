QUERIES=data/queries/file-per-template/
DATA=data/dataset/2M.nt
OUTPUT=output/test2-qengine/

PARAM=-queries $(QUERIES) -data $(DATA) -output $(OUTPUT) -export_query_results

qengine:
	java -jar rdfengine.jar $(PARAM)

jena: 
	java -jar rdfengine.jar -jena $(PARAM)
