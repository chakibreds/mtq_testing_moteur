import os

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from plot import queries as q

# Génération d'un histograme pour chaque fichier de requête on associe le nombre de requête n'ayant pas de réponses
def hist_per_template(queries_responses_dir, queries_dir):
    # for each file in the output directory, read the queries results and put them in a list
    hist_per_template = {}
    for file in os.listdir(queries_responses_dir):
        if file != "stats.csv":
            template_name = file.split('-')[0]
            results = pd.read_csv(queries_responses_dir + file)
            reponses_null = 0
            dup = q.duplicates_queries(q.parse_queries(queries_dir + template_name + '.queryset'))


            # for each query result, get the number of results
            for i in range(len(results)):
                if results.iloc[i]['Result'] == "[]":
                    # empty result
                    reponses_null += 1
            hist_per_template[template_name] = (reponses_null, dup)

    keys = sorted(hist_per_template.keys())
    values = [hist_per_template[k] for k in keys]
    x_pos = np.arange(len(keys))

    plt.bar(x_pos, values)
    
    plt.xlabel('Template name')
    plt.ylabel('Number of queries without results')
    plt.title('Histogram of queries without results')

    # Create names on the x-axis
    plt.xticks(x_pos, keys, rotation=45,ha='right')
    #ax.set_xticklabels(xlabels, rotation=40, ha=ha[n])
    
    # Custom the subplot layout
    plt.subplots_adjust(bottom=0.4, top=0.99)
    plt.show()
