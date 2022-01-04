import os, sys
import pandas as pd
import matplotlib.pyplot as plt 
import numpy as np

def performances_per_dataset(qengine_dir, jena_dir): 
    time_per_dataset = {}
    files = os.listdir(qengine_dir)
    for file in files : 
        dataset_name = file.split('-')[1].split('.')[0]
        stats_jena = pd.read_csv(jena_dir + file)
        stats_qengine = pd.read_csv(qengine_dir + file)
        time_per_dataset[dataset_name] = (stats_qengine.iloc[0]['temps total d’évaluation du workload (ms)']/len(files), stats_jena.iloc[0]['temps total d’évaluation du workload (ms)']/len(files))
        
    keys = sorted(time_per_dataset.keys())
    
    plt.xlabel('nombre de tuples')
    plt.ylabel("temps d'exécution (ms/query)")
    plt.plot(keys, [time_per_dataset[k][0] for k in keys])
    plt.plot(keys, [time_per_dataset[k][1] for k in keys])
    
    plt.title('Comparaison entre notre système et Jena')
    plt.legend(['Qengine','Jena'])
    
    plt.show()
    
if __name__ == '__main__':
    if len(sys.argv) != 3 : 
        print ("Usage : python3 performance.py dir_qengine dir_jena") 
        exit(0)
    dir_qengine = sys.argv[1]
    dir_jena = sys.argv[2]
    performances_per_dataset(dir_qengine, dir_jena)

        