

import os, sys, re, gensim, pickle
import numpy as np
import pandas as pd


## what words should we write out ??
## we can use the same word as the w2v .

os.chdir ("/u/scratch/d/datduong/SemEval2017Task4/4B-English")

## may not matter which files we load in, we just want the words
fin = open ('W2vEmbTweetall/W2vEmbTweetall.txt','r')

fout = open('word_to_get_vec.txt', 'w', encoding='utf-8')

dim = 0
for index, line in enumerate(fin):
  if index == 0:
    dim = int (line.split()[1])
    continue
  #
  line = line.split()
  word = line[0:(len(line)-dim)]
  # *** we will add the "_" later too ??
  # we want something like this "Los_Angeles \t Los Angeles"
  word_label = "_".join(word) ## make life easier if we don't have space for given word
  fout.write(word_label+ "\t" + " ".join(word)+"\n")


fin.close()

## load user description and topics

user_desc = pd.read_csv ('output_semeval_tweet_userinfo.gender.tsv', sep="\t",dtype='str')

counter = 0
for index,line in user_desc.iterrows():
  ## must add "tweet_text" otherwise user description alone doesn't make sense ?? 
  line_out =" ".join( line[s] for s in ['description','name','location'] if line[s] is not np.NaN)  ## + " " + line['text']
  line_out = line_out.strip().replace('\n', ' ').replace('\r', ' ').replace('\t', ' ')
  if len(line_out) == 0:
    continue
  fout.write( 'userId'+str(line['user_id']) + "\t" + line_out +"\n" )
  counter = counter + 1 


print ('data dim {}'.format(user_desc.shape))
print ('user with no empty string {}'.format(user_desc.shape))


## topics
fin = pd.read_csv('SemEval2017-task4-dev.subtask-BD.english.INPUT.gender.tsv',sep="\t")
topic = set ( list ( fin['topic'] ) )
for t in topic :
  fout.write(re.sub(" ","_",t)+"\t"+t+"\n")


fout.close()

df = pd.read_csv('word_to_get_vec.txt',header=None,sep="\t")
print (df.shape)
df = df.drop_duplicates()
print (df.shape)

## remove empty 
df = df.dropna()
print (df.shape)

df.to_csv('word_to_get_vec.txt',index=None,sep="\t",columns=None,header=None)

