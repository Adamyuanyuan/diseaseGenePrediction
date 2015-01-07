#!bin/bash

###USE RBR to prediction toppgene

rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_1 -r 1
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_2 -r 10
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_3 -r 100
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_4 -r 1000
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_5 -r 0.1
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_6 -r 0.01

rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_7 -r 1
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_8 -r 0.5
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_9 -r 0.7
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_10 -r 0.9
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_11 -r 2
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_12 -r 5

rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_13 -r 1 -w
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_14 -r 1 -w variable.importance
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_15 -r 1 -w variable.importance
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_16 -r 1 -w variable.importance
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_17 -r 1 -w variable.importance
rbr toppgene_rbr_train.csv toppgene_rbr_trainY.txt toppgene_rbr_all.csv toppgene_rbr_result_18 -r 1 -w variable.importance







