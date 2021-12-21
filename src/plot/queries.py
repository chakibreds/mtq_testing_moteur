def parse_dup_queries(file_name):
    queries = {}
    dup = 0
    with open(file_name, 'r') as f:
        i = 0
        lines = f.readlines()
        while i < len(lines):
            line=lines[i].strip()
            
            if line.startswith('SELECT'):
                i += 1
            else:
                i += 1
                continue
            patterns = []
            while (lines[i].strip() != '}'):
                if lines[i].strip() == '':
                    i += 1
                    continue
                patterns.append(tuple(lines[i].strip().split(' ')[1:3]))
                i += 1
            i += 1
            patterns = tuple(sorted(patterns))
            if patterns in queries:
                queries[patterns] += 1
                dup += 1
            else:
                queries[patterns] = 1
        max_duplicated = max(queries.values())   
        
    return (dup,max_duplicated)
