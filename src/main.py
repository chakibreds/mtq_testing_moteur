from plot import histogrames as h

if __name__ == '__main__':
    directory = '../output/test-final-qengine/'
    q_dir= '../data/queries/file-per-template-final/'
    h.hist_per_template(directory, q_dir, option='max')