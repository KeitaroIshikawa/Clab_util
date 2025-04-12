#!/bin/sh


#set -eu
# set -e : エラーがあったらそこでスクリプトを打ち止めにしてくれる
# set -u : 未定義の変数を使おうとしたら打ち止めにしてくれる

date
# 今日の日付

# node1
#node_num=("01" "02" "03" "04" "05" "06")
# jobの数

vnode=`qstat -f | grep exec_vnode`
# echo ${vnode}
for node_num in "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14"
do
    number_job=$(echo -e ${vnode} | grep node${node_num} | wc -l | tr -d ' ')
    # echo 'the number of job :' ${number_job}

    if [ ${number_job} = 0 ]; then # []はifや中身との間にスペースを作る
        echo "00/56 core used in node${node_num}" # echo は '' と "" とで意味が変わる。 '' : 全て文字列 "" : 中身を展開  cf. `` : 中身をコマンドだと認識
    else
        # each_core=$(echo -e `qstat -f | grep exec_vnode | grep node${node_num}` | sed -en "s/.*ncpus=\([0-9]\+\).*/\1/p" | awk '{s += $1} END {print s}')
        # each_core=$(echo -e ${vnode} | sed -e "s/.*node${node_num}:ncpus=\([0-9]\+\).*/\1/g" | awk '{for(i=1;i<=NF;i++){a+=$i};print a}')
        each_core=$(echo -e ${vnode} | sed -e "s/) e/)\\ne/g" | grep node${node_num} | sed -e "s/.*:ncpus=\([0-9]\+\).*/\1/g" | awk '{s += $1} END {print s}')
        
        padding=$(printf "%02d" ${each_core})
        echo "${padding}/56 core used in node${node_num}"
    fi
done

unset number_job
unset each_core

set +eu


# 1以上、99以下の２桁の数字
#[1-9]|[1-9][0-9]
# [1-9]|[1-5][0-9]

#str=world
#echo 'hello hoge' | sed -e "s/hoge/$str/"
#hello world

#total=0 # 初期化
#echo ${each_core}
#for i in ${each_core} # 連番1~$number_jobまで(1,2,・・・,$number_job) # {1..1}でも1と出力
#do
#    total=`expr $total + $i` # 演算子はスペース必要。 *はワイルドカードの意味も持つので、掛け算で使用するときは \* 
#done
#unset total
