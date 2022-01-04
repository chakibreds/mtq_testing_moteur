import os,sys
import pandas as pd

def qualite_per_template(queries_responses_qengine, queries_responses_jena):
    q_per_template = {}
    files = os.listdir(queries_responses_qengine)
    for file in files : 
        if file !="stats.csv":
            template_name = file.split('-')[0]
            results_jena = pd.read_csv(queries_responses_jena + file)
            results_qengine = pd.read_csv(queries_responses_qengine + file)
            same_result = 0
            #check if two responses are equal
            for i in range(len(results_jena)): 
                if equal_result(results_jena.iloc[i]['Result'], results_qengine.iloc[i]['Result']): 
                    same_result += 1
            
            q_per_template[template_name] = (same_result/len(results_qengine))
            
    somme = 0 
    for k in q_per_template.keys():
        somme += q_per_template[k]
    
    return somme/len(q_per_template.keys())


def equal_result(r1, r2): 
    l_qengine = list(r1.replace('"',''))
    l_jena = list(r2.replace('"',''))
    
    l_qengine.sort()
    l_jena.sort()
    
    if len(l_jena) != len(l_qengine):
        return False
    else :
        for i in range(len(l_qengine)):
            if l_jena[i] != l_qengine[i]: 
                return False
        return True


if __name__ == '__main__':
    if len(sys.argv) != 3 : 
        print ("Usage : python3 qualite.py dir_result_qengine dir_result_jena") 
        exit(0)
    dir_qengine = sys.argv[1]
    dir_jena = sys.argv[2]
    result = qualite_per_template(dir_qengine, dir_jena)
    print ("Le pourcentage de réponse identique de notre système avec les reponses de Jena est de", result*100, "%")