from plot import histogrames as h

if __name__ == '__main__':
    directory = '../output/test1-qengine/'
    q_dir= '../data/queries/file-per-template/'
    h.hist_per_template(directory, q_dir)