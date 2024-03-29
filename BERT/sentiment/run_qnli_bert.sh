

## make data for training QNLI style
module load python/3.7.2
cd /u/scratch/d/datduong/SemEval2017Task4/SemEval2017Task4Code/Data
main_dir='/u/scratch/d/datduong/SemEval2017Task4/4B-English/'
fout='task4B_bert_sentiment_file_mask'
to_skip='none'
topic_to_test_file='topic_to_test_3_7'
where_save='BertSentimentFilterTestLabel37'
do_filter_test_label='1'
# python3 make_bert_sentimental_data.py $main_dir $fout $to_skip
python3 make_fold.py $main_dir $fout'.txt' $to_skip $do_filter_test_label $topic_to_test_file $where_save



## mask out some information 
module load python/3.7.2
cd /u/scratch/d/datduong/SemEval2017Task4/SemEval2017Task4Code/Data
main_dir='/u/scratch/d/datduong/SemEval2017Task4/4B-English/'
fout='task4B_bert_sentiment_file_mask'
do_filter_test_label='1'
topic_to_test_file='topic_to_test_3_7'
where_save='BertSentimentFilterTestLabel37'
# python3 make_bert_sentimental_data.py $main_dir $fout none
# python3 make_fold.py $main_dir $fout'.txt' none $do_filter_test_label
for to_skip in text name description location user_gender description ; do # text name description location user_gender text description
  # python3 make_bert_sentimental_data.py $main_dir $fout $to_skip
  python3 make_fold.py $main_dir $fout'_'$to_skip'.txt' $to_skip $do_filter_test_label $topic_to_test_file $where_save
done


## mask out all user information 
module load python/3.7.2
cd /u/scratch/d/datduong/SemEval2017Task4/SemEval2017Task4Code/Data
main_dir='/u/scratch/d/datduong/SemEval2017Task4/4B-English/'
fout='task4B_bert_sentiment_file_mask'
do_filter_test_label='1'
to_skip='name+description+location+user_gender'
topic_to_test_file='topic_to_test_3_7'
where_save='BertSentimentFilterTestLabel37'
# python3 make_bert_sentimental_data.py $main_dir $fout $to_skip
python3 make_fold.py $main_dir $fout'_name_description_location_user_gender.txt' $to_skip $do_filter_test_label $topic_to_test_file $where_save

## 
## keep**** something + tweet
module load python/3.7.2
cd /u/scratch/d/datduong/SemEval2017Task4/SemEval2017Task4Code/Data
main_dir='/u/scratch/d/datduong/SemEval2017Task4/4B-English/'
fout='task4B_bert_sentiment_file_mask'
do_filter_test_label='1'
to_skip='location+user_gender'
topic_to_test_file='topic_to_test_3_7'
where_save='BertSentimentFilterTestLabel37'
# python3 make_bert_sentimental_data.py $main_dir $fout $to_skip
python3 make_fold.py $main_dir $fout'_location_user_gender.txt' $to_skip $do_filter_test_label $topic_to_test_file $where_save


## keep**** something + tweet task4B_bert_sentiment_add_gamergate
module load python/3.7.2
cd /u/scratch/d/datduong/SemEval2017Task4/SemEval2017Task4Code/Data
main_dir='/u/scratch/d/datduong/SemEval2017Task4/4B-English/'
fout='task4B_bert_sentiment_nonan_user'
do_filter_test_label='1'
to_skip='none'
topic_to_test_file='topic_to_test_3_7'
where_save='BertSentimentNoNanUser'
base_name='Base'
# python3 make_bert_sentimental_data.py $main_dir $fout $to_skip
python3 make_fold.py $main_dir $fout'.txt' $to_skip $do_filter_test_label $topic_to_test_file $where_save $base_name


## keep**** something + tweet task4B_bert_sentiment_add_gamergate ...
module load python/3.7.2
cd /u/scratch/d/datduong/SemEval2017Task4/SemEval2017Task4Code/Data
main_dir='/u/scratch/d/datduong/SemEval2017Task4/4B-English/'
fout='task4B_bert_sentiment_nonan_user'
do_filter_test_label='1'
to_skip='none'
topic_to_test_file='topic_to_test_3_7'
where_save='BertSentimentNoNanUser'

for base_name in name desc loc gender text ; do 
  python3 make_fold.py $main_dir $fout'_mask_'$base_name'.txt' $to_skip $do_filter_test_label $topic_to_test_file $where_save $base_name
done 




## keep**** something + tweet
module load python/3.7.2
cd /u/scratch/d/datduong/SemEval2017Task4/SemEval2017Task4Code/Data
main_dir='/u/scratch/d/datduong/SemEval2017Task4/4B-English/'
fout='task4B_bert_sentiment_file_mask'
do_filter_test_label='1'
to_skip='name+description+location'
topic_to_test_file='topic_to_test_3_7'
where_save='BertSentimentFilterTestLabel37'
python3 make_bert_sentimental_data.py $main_dir $fout $to_skip
python3 make_fold.py $main_dir $fout'_name_description_location.txt' $to_skip $do_filter_test_label $topic_to_test_file $where_save


## mask user desc + something 
module load python/3.7.2
cd /u/scratch/d/datduong/SemEval2017Task4/SemEval2017Task4Code/Data
main_dir='/u/scratch/d/datduong/SemEval2017Task4/4B-English/'
fout='task4B_bert_sentiment_file_mask'
do_filter_test_label='1'
to_skip='description'
topic_to_test_file='topic_to_test_3_7'
where_save='BertSentimentFilterTestLabel37'
for pair in name location user_gender text ; do 
  python3 make_bert_sentimental_data.py $main_dir $fout $to_skip'+'$pair
  python3 make_fold.py $main_dir $fout'_description_'$pair'.txt' $to_skip'+'$pair $do_filter_test_label $topic_to_test_file $where_save
done 


## can we load a model with more than 2 id types ??? yes ... we can trick the model 


# BertSentimentFilterTestLabel
conda activate tensorflow_gpuenv

for folder_type in Base ; do 

  data_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentimentNoNanUser/'$folder_type # full_data_mask
  output_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentimentNoNanUser/'$folder_type
  mkdir $output_dir
  model_name_or_path='/local/datdb/SemEval2017Task4/4B-English/BertFineTune/' ## load fine tune with just 2 tokens 
  config_name=$model_name_or_path/'bert_config.json'
  tokenizer_name='bert-base-cased'

  cd /local/datdb/SemEval2017Task4/SemEval2017Task4Code/BERT/sentiment
  CUDA_VISIBLE_DEVICES=1 python3 -u run_glue.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --num_train_epochs 10 --do_train --max_seq_length 512 --overwrite_output_dir --evaluate_during_training --num_segment_type 6 --learning_rate 0.00001 --fp16 --logging_steps 1000 --save_steps 1000 > $output_dir/track.log

done 






## run entailment based on BERT. using QNLI as template input, use MASK if data is missing, so we have 6 token types
conda activate tensorflow_gpuenv

data_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentimentFilterTestLabel/full_data_mask/'
output_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentimentFilterTestLabel/full_data_mask/'
mkdir $output_dir
output_dir_log=$output_dir/'by_topic'
mkdir $output_dir_log
model_name_or_path='/local/datdb/SemEval2017Task4/4B-English/BertFineTune/' ## load fine tune with just 2 tokens 
config_name=$model_name_or_path/'bert_config.json'
tokenizer_name='bert-base-cased'

cd /local/datdb/SemEval2017Task4/SemEval2017Task4Code/BERT/sentiment
# CUDA_VISIBLE_DEVICES=1 python3 -u run_glue.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --num_train_epochs 20 --do_train --max_seq_length 512 --overwrite_output_dir --evaluate_during_training --num_segment_type 6 --learning_rate 0.00001 --fp16 --logging_steps 250 --save_steps 250 > $output_dir/track.log

## *** do testing 

model_name_or_path=$output_dir ## so that we load in newer model
fold_where_test_file='/local/datdb/SemEval2017Task4/4B-English/BertSentimentFilterTestLabel'

for folder in full_data_mask full_data_mask_name_description_location_user_gender full_data_mask_text full_data_mask_description ; do 
  for test_data_type in test_user_only_islam test_user_only test_user_only_israel test_user_only_sharknado ; do
    test_file=$fold_where_test_file'/'$folder'/'$test_data_type'.tsv'
    CUDA_VISIBLE_DEVICES=1 python3 -u run_glue.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --num_train_epochs 20 --do_eval --test_file $test_file --max_seq_length 512 --overwrite_output_dir --evaluate_during_training --num_segment_type 6 --learning_rate 0.00001 --fp16 > $output_dir_log/test_$folder'_'$test_data_type.log
  done
done


## remove *************** some other fields, see what happens
conda activate tensorflow_gpuenv

data_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentiment/full_data_mask_name_description_location_user_gender/'
output_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentiment/full_data_mask_name_description_location_user_gender/'
mkdir $output_dir
output_dir_log=$output_dir/'by_topic'
mkdir $output_dir_log
model_name_or_path='/local/datdb/SemEval2017Task4/4B-English/BertFineTune/' ## load fine tune with just 2 tokens 
config_name=$model_name_or_path/'bert_config.json'
tokenizer_name='bert-base-cased'

# cd /local/datdb/SemEval2017Task4/SemEval2017Task4Code/BERT/sentiment
# CUDA_VISIBLE_DEVICES=3 python3 -u run_glue.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --num_train_epochs 20 --do_train --max_seq_length 512 --overwrite_output_dir --evaluate_during_training --num_segment_type 6 --learning_rate 0.00001 --fp16 > $output_dir/track.log

## *** do testing 

model_name_or_path=$output_dir ## so that we load in newer model
fold_where_test_file='/local/datdb/SemEval2017Task4/4B-English/BertSentiment'

for folder in full_data_mask_name_description_location_user_gender full_data_mask_text full_data_mask_name full_data_mask_description full_data_mask_location full_data_mask_user_gender full_data_mask ; do 
  for test_data_type in test_user_only_islam test_user_only test_user_only_sharknado ; do
    test_file=$fold_where_test_file'/'$folder'/'$test_data_type'.tsv'
    CUDA_VISIBLE_DEVICES=3 python3 -u run_glue.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --num_train_epochs 20 --do_eval --test_file $test_file --max_seq_length 512 --overwrite_output_dir --evaluate_during_training --num_segment_type 6 --learning_rate 0.00001 --fp16 > $output_dir_log/test_$folder'_'$test_data_type.log
  done
done




## remove *************** some other fields, see what happens
conda activate tensorflow_gpuenv

for task_type in full_data_mask_text full_data_mask_description full_data_mask_name full_data_mask_location full_data_mask_user_gender ; do 
  data_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentiment/'$task_type'/'
  output_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentiment/'$task_type'/'
  mkdir $output_dir
  model_name_or_path='/local/datdb/SemEval2017Task4/4B-English/BertFineTune/' ## load fine tune with just 2 tokens 
  config_name=$model_name_or_path/'bert_config.json'
  tokenizer_name='bert-base-cased'

  cd /local/datdb/SemEval2017Task4/SemEval2017Task4Code/BERT/sentiment
  CUDA_VISIBLE_DEVICES=4 python3 -u run_glue.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --num_train_epochs 20 --do_train --max_seq_length 512 --overwrite_output_dir --evaluate_during_training --num_segment_type 6 --learning_rate 0.00001 --fp16 > $output_dir/track.log

  ## *** do testing 
  model_name_or_path=$output_dir ## so that we load in newer model
  fold_where_test_file='/local/datdb/SemEval2017Task4/4B-English/BertSentiment'

  for folder in full_data_mask_name_description_location_user_gender full_data_mask_text full_data_mask_name full_data_mask_description full_data_mask_location full_data_mask_user_gender full_data_mask ; do 
    for test_data_type in test_user_only_islam test_user_only test_user_only_sharknado ; do
      test_file=$fold_where_test_file'/'$folder'/'$test_data_type'.tsv'
      CUDA_VISIBLE_DEVICES=4 python3 -u run_glue.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --num_train_epochs 20 --do_eval --test_file $test_file --max_seq_length 512 --overwrite_output_dir --evaluate_during_training --num_segment_type 6 --learning_rate 0.00001 --fp16 > $output_dir/test_$folder'_'$test_data_type.log
    done
  done
done




## *** EVALUATION 

conda activate tensorflow_gpuenv

data_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentiment/fold_1/'
output_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentiment/fold_1/'
model_name_or_path=$output_dir
config_name=$model_name_or_path/'bert_config.json'
tokenizer_name='bert-base-cased'

## eval uses dev.tsv, so we "trick" the input by naming test-->dev, and set dev-->dev_original 
cd /local/datdb/pytorch-transformers/examples
CUDA_VISIBLE_DEVICES=4 python3 -u run_glue.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --num_train_epochs 10 --do_train --max_seq_length 512 --overwrite_output_dir > $output_dir/track2.log


--num_segment_type 6 

## *** GET WORD VECTORS

## create filles with words to extract vectors from 
cd $SCRATCH/SemEval2017Task4/SemEval2017Task4Code/  
python3 BERT/sentiment/word_to_write.py 


##
conda activate tensorflow_gpuenv
cd /local/datdb/SemEval2017Task4/SemEval2017Task4Code/  # BERT/sentiment

data_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentiment/fold_1/'
output_dir='/local/datdb/SemEval2017Task4/4B-English/BertSentiment/fold_1/'
model_name_or_path=$output_dir
config_name=$model_name_or_path/'bert_config.json'
tokenizer_name='bert-base-cased'

word_vector_input='/local/datdb/SemEval2017Task4/4B-English/word_to_get_vec.txt'
word_vector_output=$output_dir/'word_vector.txt'

## eval uses dev.tsv, so we "trick" the input by naming test-->dev, and set dev-->dev_original 
CUDA_VISIBLE_DEVICES=4 python3 -u BERT/sentiment/write_vector.py --data_dir $data_dir --model_type bert --model_name_or_path $model_name_or_path --task_name qnli --output_dir $output_dir --config_name $config_name --tokenizer_name $tokenizer_name --max_seq_length 512 --overwrite_output_dir --word_vector_input $word_vector_input --word_vector_output $word_vector_output > $output_dir/track.log


## convert into form for @hist_words 
python3 BERT/sentiment/convert_to_np.py

