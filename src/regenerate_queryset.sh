nb_q=1000

for qt in ../watdiv/templates/*.sparql-template; 
do
   qt2=${qt##*templates/}
   ../watdiv/watdiv -q ../watdiv/model/wsdbm-data-model.txt ${qt} ${nb_q} 1 > ../data/queries/${nb_q}/${qt2%.sparql-template}.queryset;
done;
