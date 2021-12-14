QUERIES=data/queries/queries-031221-0121.queryset
DATA=data/1M.nt
OUTPUT=output/

PARAM=-queries $(QUERIES) -data $(DATA) -output $(OUTPUT) -export_query_results

qengine:
	java -jar rdfengine.jar 

jena: 
	java -jar rdfengine.jar -jena $(PARAM)
