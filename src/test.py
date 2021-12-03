import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

def get_group(i):
    if i < 10:
        return 10
    elif i < 100:
        return 100
    elif i < 1000:
        return 1000
    elif i < 10000:
        return 10000
    else:
        return 100000

# read each coloumn from a csv file and put it in a list
def read_queries_results(file_name):
    df = pd.read_csv (file_name)
    
    queries_results = df
    
    return queries_results

if __name__ == '__main__':
    queries_results = read_queries_results('../output/queryResult-qengine.csv')

    nb_occurence_log = []
    nb_occurence_linear = []

    for i in range(len(queries_results)):
        if queries_results.iloc[i]['Result'] == "[]":
            nb_occurence_log.append(0)
            nb_occurence_linear.append(0)
        else:
            nb_occurence_log.append(get_group(queries_results.iloc[i]['Result'].count(',') + 1))
            nb_occurence_linear.append(1)
            
    x = [0] + [get_group(i) for i in range(1,max(nb_occurence_log))]
    x_linear = [i for i in range(1,len(queries_results)+1)]

    #plt.hist(nb_occurence_log, bins=x)
    #plt.gca().set_xscale("log")

    plt.plot(x_linear, nb_occurence_linear)
    plt.xlabel('Query ID')
    plt.ylabel('0:Aucun resultat, 1:résultats')

    plt.show()
    print("Nombre de requêtes vide : ", nb_occurence_log.count(0))