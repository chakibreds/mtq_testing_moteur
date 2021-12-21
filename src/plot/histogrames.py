import os

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from plot import queries as q

# Génération d'un histograme pour chaque fichier de requête on associe le nombre de requête n'ayant pas de réponses
def hist_per_template(queries_responses_dir, queries_dir, option='dup'):
    # for each file in the output directory, read the queries results and put them in a list
    hist_per_template = {}
    files = os.listdir(queries_responses_dir)
    actual_file = 0
    for file in files:
        if file != "stats.csv":
            actual_file += 1
            print(f"Processing file ({actual_file}/{len(files)-1}): {file}")
            template_name = file.split('-')[0]
            results = pd.read_csv(queries_responses_dir + file)

            reponses_null = 0
            dup, maxi = q.parse_dup_queries(queries_dir + template_name + '.queryset')
            #dup = q.duplicates_queries2(q.parse_queries(queries_dir + template_name + '.queryset'))

            # for each query result, get the number of results
            for i in range(len(results)):
                if results.iloc[i]['Result'] == "[]":
                    # empty result
                    reponses_null += 1

            hist_per_template[template_name] = (reponses_null, dup, maxi)
            
            
    keys = sorted(hist_per_template.keys())
    x_pos = np.arange(len(keys))
    plt.xlabel('Template name')
    plt.ylabel('N° of queries')
    
    
    if (option == 'dup') : 
        values_null = [hist_per_template[k][0] for k in keys]
        values_dup = [hist_per_template[k][1] for k in keys]

        plt.bar(x_pos*2, values_null, color=(0.33, 0.23, 0.83, 0.3),  edgecolor='blue')
        plt.bar(x_pos*2+0.8, values_dup, color=(1, 0.34, 0.2, 0.3),  edgecolor='orange')
        # 255, 87, 51
        # 85 , 60 , 213

        plt.title('Histogram of queries without results and duplicated queries')
        plt.legend(['Number of queries without results', 'Number duplicated queries'])
        # Create names on the x-axis
        #ax.set_xticklabels(xlabels, rotation=40, ha=ha[n])
        plt.xticks(x_pos*2+0.4, keys, rotation=45,ha='right')

        for index, value in enumerate(values_null):
            plt.text(index*2-0.3, value+15, str(value), color='black')
        
        for index, value in enumerate(values_dup):
            plt.text(index*2+0.5, value+15, str(value), color='grey')

        
    elif option == 'max' :
        values_max = [hist_per_template[k][2] for k in keys]
        plt.bar(x_pos, values_max, color=(0.33, 0.23, 0.83, 0.3),  edgecolor='blue')
        plt.title("Histogram of max of duplicated query")
        plt.legend(['max of duplicated query'])
        plt.xticks(x_pos, keys, rotation=45,ha='right')
        
        for index, value in enumerate(values_max):
            plt.text(index-0.1, value+2, str(value), color='grey')
            
        
        
    plt.grid(b = True, color ='grey',
        linestyle ='-.', linewidth = 0.75,
        alpha = 0.4)
    # Custom the subplot layout
    plt.subplots_adjust(bottom=0.4, top=0.99)
    
    plt.show()
    
