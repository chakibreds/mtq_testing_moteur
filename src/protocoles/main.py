import qualite as q

if __name__ == '__main__': 
    dir_qengine = '../../output/test-qualite-qengine/'
    dir_jena = '../../output/test-qualite-jena/'
    result = q.qualite_per_template(dir_qengine, dir_jena)
    print (result)