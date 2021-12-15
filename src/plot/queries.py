# parse a file containing a set of SPARQL Queries
def parse_queries(file_name):
    queries = []
    with open(file_name, 'r') as f:
        i = 0
        lines = f.readlines()
        while i < len(lines):
            line=lines[i].strip()
            if line.startswith('SELECT'):
                i += 1
            else:
                continue
            patterns = []
            while (lines[i].strip() != '}'):
                patterns.append(lines[i].strip().split(' ')[1:2])
                i += 1
            i += 1
            queries.append(patterns)
    return queries

# return true if two queries are equal
def equal_queries(q1, q2):
    if len(q1) != len(q2):
        return False
    
    q1 = sorted(q1)
    q2 = sorted(q2)
    
    for i in range(len(q1)):
        if q1[i] != q2[i]:
            return False
    return True

# return the number of duplicates queries in a list of queries
def duplicates_queries(queries):
    duplicates = 0
    for i in range(len(queries)):
        for j in range(i+1, len(queries)):
            if equal_queries(queries[i], queries[j]):
                duplicates += 1
    return duplicates
