#!/bin/bash

sh ./scripts/ModalPrompt/Train/1_Science.sh
sh ./scripts/ModalPrompt/Train/2_TextVQA.sh
sh ./scripts/ModalPrompt/Train/3_ImageNet.sh
sh ./scripts/ModalPrompt/Train/4_GQA.sh
sh ./scripts/ModalPrompt/Train/5_VizWiz.sh
sh ./scripts/ModalPrompt/Train/6_Grounding.sh
sh ./scripts/ModalPrompt/Train/7_vqav2.sh
sh ./scripts/ModalPrompt/Train/8_OCRVQA.sh