#!/bin/bash

CHUNKS=1
IDX=0

STAGE=$1
MODELPATH=$2
CUR_TASK=$3

RESULT_DIR="./results/ModalPrompt/OCRVQA"

CUDA_VISIBLE_DEVICES=0 python -m llava.eval.ModalPrompt.model_ocr_vqa \
    --model-path $MODELPATH \
    --model-base models/llava_v1.5-7b \
    --question-file instructions/OCRVQA/test.json \
    --image-folder datasets/ \
    --text-tower models/clip-vit-large-patch14-336 \
    --prefix-len 10 \
    --cur-task $CUR_TASK \
    --answers-file $RESULT_DIR/$STAGE/${CHUNKS}_${IDX}.jsonl \
    --num-chunks $CHUNKS \
    --chunk-idx $IDX \
    --temperature 0 \
    --conv-mode vicuna_v1 &

wait

output_file=$RESULT_DIR/$STAGE/merge.jsonl

# Clear out the output file if it exists.
> "$output_file"

# Loop through the indices and concatenate each file.
for IDX in $(seq 0 $((CHUNKS-1))); do
    cat $RESULT_DIR/$STAGE/${CHUNKS}_${IDX}.jsonl >> "$output_file"
done

python -m llava.eval.ModalPrompt.eval_ocrvqa \
    --annotation-file instructions/OCRVQA/test.json \
    --result-file $output_file \
    --output-dir $RESULT_DIR/$STAGE \