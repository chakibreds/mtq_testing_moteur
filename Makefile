<<<<<<< HEAD
QUERIES=data/queries/file-per-template/
DATA=data/dataset/1M.nt
OUTPUT=output/test2-qengine/
=======
QUERIES=data/queries/file-per-template-final/
DATA=data/dataset/2M.nt
OUTPUT=output/test-final-qengine/
>>>>>>> 8db5da375f223b307315e81f88e5b2ce7e604ebf

PARAM=-queries $(QUERIES) -data $(DATA) -output $(OUTPUT) -export_query_results

qengine:
	java -jar rdfengine.jar $(PARAM)

jena: 
	java -jar rdfengine.jar -jena $(PARAM)
