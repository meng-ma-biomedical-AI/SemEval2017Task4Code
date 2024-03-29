
## import github and other libs needed 

import sys,re,os,pickle 

sys.path.append ( "E:/diachronic_embeddings/histwords" )

from representations.embedding import Embedding
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import itertools as it

from viz.scripts import closest_over_time
from viz import mplot, mcommon
from subprocess import check_output

import random
random.seed(1111)


## !!   use python2, because github uses python2 

model_dir = 'C:/Users/dat/Documents/SemEval2017Task4/4B-English/BertSentiment/'
os.chdir(model_dir)

model_name='word_vector768'
tweet2017all = Embedding.load(model_name)

print ('model {}'.format(model_name))

word_list = ['misogynistic','feminist','caitlyn_jenner','he','she']

for word in word_list: 
  print ('word {}'.format(word))
  print (tweet2017all.closest(word,20))
  mplot.plot_one_word(word, tweet2017all)





