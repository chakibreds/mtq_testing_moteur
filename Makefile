QUERIES=data/queries/file-per-template/
DATA=data/dataset/1M.nt
OUTPUT=output/test1-qengine/

PARAM=-queries $(QUERIES) -data $(DATA) -output $(OUTPUT) -export_query_results

qengine:
	java -jar rdfengine.jar $(PARAM)

jena: 
	java -jar rdfengine.jar -jena $(PARAM)
