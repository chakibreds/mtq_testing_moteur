import sys
import os
import pandas as pd
import math

if __name__ == '__main__':
    if len(sys.argv) != 2 : 
        print ("Usage : python3 facteur.py dir_results") 
        exit(0)
    
    dir_qengine = sys.argv[1]
    files = os.listdir(dir_qengine)

    y = {}
    for file in files: 
        temps = pd.read_csv(dir_qengine + file).iloc[0]['temps total d’évaluation du workload (ms)']
        y['-'.join(file.split('.')[0].split('-')[1:])] = temps

    q = {}
    q['q0'] = (y['low-low'] + y['high-low'] + y['low-high'] + y['high-high'])/4
    q['qA'] = (-y['low-low'] + y['high-low'] - y['low-high'] + y['high-high'])/4
    q['qB'] = (-y['low-low'] - y['high-low'] + y['low-high'] + y['high-high'])/4
    q['qAB'] = (y['low-low'] - y['high-low'] - y['low-high'] + y['high-high'])/4
    
    q['Variation A'] = (4*(math.pow(q['qA'],2))) / (4*(math.pow(q['qA'],2) + math.pow(q['qB'],2) + math.pow(q['qAB'],2)))
    q['Variation B'] = (4*(math.pow(q['qB'],2))) / (4*(math.pow(q['qA'],2) + math.pow(q['qB'],2) + math.pow(q['qAB'],2)))
    q['Variation AB'] = (4*(math.pow(q['qAB'],2))) / (4*(math.pow(q['qA'],2) + math.pow(q['qB'],2) + math.pow(q['qAB'],2)))
    
    print(q)