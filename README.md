# ModalPrompt: Towards Efficient Multimodal Continual Instruction Tuning with Dual-Modality Guided Prompt (EMNLP 2025 Main)

This repo is the official implementation of paper: **[ModalPrompt: Towards Efficient Multimodal Continual Instruction Tuning with Dual-Modality Guided Prompt](https://arxiv.org/abs/2410.05849)**

> ModalPrompt: Towards Efficient Multimodal Continual Instruction Tuning with Dual-Modality Guided Prompt
>
> Fanhu Zeng, Fei Zhu, Haiyang Guo, Xu-Yao Zhang, Cheng-Lin Liu

[![arXiv](https://img.shields.io/badge/Arxiv-2410.05849-b31b1b.svg?logo=arXiv)](https://arxiv.org/abs/2410.05849) [![](https://img.shields.io/badge/EMNLP-2025-blue)](https://aclanthology.org/2025.emnlp-main.609.pdf)

**Key words: Large multimodal models, Continual instruction tuning, Prompt learning, Parameter efficient learning**

## :newspaper: News
- **[2025.11.01]** Our camera ready version is released on [https://aclanthology.org](https://aclanthology.org/2025.emnlp-main.609/), check it out!
- **[2025.10.14]** ModalPrompt has been integrated into [MCITlib](https://arxiv.org/pdf/2508.07307), a **Multimodal Continual Instruction Tuning Library and Benchmark**. You can find implementations of different architectures and results on different benchmarks [here](https://github.com/Ghy0501/MCITlib)! 
- **[2025.08.21]** **ModalPrompt** has been accepted by **EMNLP 2025 main conference**! :tada:
- **[2025.06.18]** Check out our new survey: "[Continual Learning for Generative AI: From LLMs to MLLMs and Beyond](https://arxiv.org/pdf/2506.13045)". We provide a systematic review of continual learning across mainstream generative models—including LLMs, MLLMs, Vision-Language Action Models, and Diffusion Models. Feel free to cite or open pull requests in [Awesome-Continual-Learning-in-Generative-Models](https://github.com/Ghy0501/Awesome-Continual-Learning-in-Generative-Models)!
- **[2025.04.12]** We release [Trainig](#Training) and [Evaluation](#Evaluation) script for ModalPrompt. Try it now! :fire:
- **[2024.10.08]** [ModalPrompt](https://arxiv.org/abs/2410.05849) is available on Arxiv. :candy:

## :sparkles: Overview
Large Multimodal Models (LMMs) exhibit remarkable multi-tasking ability by learning mixed instruction datasets. However, novel tasks would be encountered sequentially in dynamic world, which urges for equipping LMMs with multimodal continual instruction learning (MCIT) ability especially for diverse and challenging generative tasks. Existing MCIT methods do not fully exploit the unique attribute of LMMs and often gain performance at the expense of efficiency. In this paper, we propose a novel prompt learning framework for MCIT to effectively alleviate forgetting of previous knowledge while managing computational complexity with natural image-text supervision. Concretely, we learn prompts for each task and exploit efficient prompt fusion for knowledge transfer and prompt selection for complexity management with dual-modality guidance. Extensive experiments demonstrate that our approach achieves substantial **+14.26%** performance gain on MCIT benchmarks with remarkable $\times$**1.42** inference speed free from growing computation.

<div align="center">
  <img src=figure/framework.png width="960px">
</div>

## :rocket: Quick Start

### Install
Like [LLaVA](https://github.com/haotian-liu/LLaVA), install the packages following the steps below:

1. Clone this repository
```bash
git clone https://github.com/AuroraZengfh/ModalPrompt.git
cd ModalPrompt
```

2. Install Package
```Shell
conda create -n modalprompt python=3.10 -y
conda activate modalprompt
pip install --upgrade pip
pip install -e .
```

3. Install additional packages for training cases
```
pip install -e ".[train]"
pip install flash-attn --no-build-isolation
```

### Dataset and Instruction Preparation

Create `models` folder, download pre-trained checkpoint for [LLaVA](https://huggingface.co/liuhaotian/llava-v1.5-7b) and [CLIP-Large-Patch14-336](https://huggingface.co/openai/clip-vit-large-patch14-336).

Create `datasets` folder and download image datasets from the construction of [CoIN](https://github.com/zackschen/CoIN).

Create `instructions` folder and download instructions from [Huggingface](https://huggingface.co/datasets/Zacks-Chen/CoIN/tree/main/Instructions_Original).

### Training

Sequentially train a foundation model on various datasets in the form of prompt tuning.

e.g., take llava-v1.5-7b as an example

```
sh scripts/ModalPrompt/Train/train_all.sh
```

training checkpoints will be placed in `checkpoints/ModalPrompt`. Be careful that you should replace the paths in the scripts with your own paths.

### Evaluation

Evaluate the model on different stages of continual instruction tuning and obtain all the results on backward transfer. During Evaluation, *stage*, *model-path*, *current task* and *total task* have to be set.

Note that your config file should contain the two args *mm_text_select_layer* and *mm_text_tower*. If not, follow the sample file *config.json* in the repo and modify it based on your own environment.

```
sh scripts/ModalPrompt/Eval/eval_all.sh
```

*current task* is not the task identifier, but the number of trained task. Total task is constructed for conventient initialization of all prompts at one time. You can modify the code to remove the parameter of total task when the task of continual instruction learning is unknown, and initializing corresponding prompts for each new task.

### Notice
1. When implemnting the codebase, we find that it may occur the prolem of initialization when training. We do not find a proper solution to this and empirically disabling line35-37 in llava/model/llava_arch.py will solve the problem. We welcome suggestions if you find a simpler solution that refrains from switching the code for training and evaluation.

2. Some of the hyper-parameters are set frozen in our code, you can set them in the parser if you want to automatically search for the best performance.

3. In the experiment of ImageNet, we slightly alter the instruction and add option choice of all category names to the prompt to avoid inaccurate descriptions.

## :blue_book: Citation
If you find this work useful, consider giving this repository a star :star: and citing :bookmark_tabs: our paper as follows:

```bibtex
@inproceedings{zeng2025modalprompt,
  title={ModalPrompt: Towards Efficient Multimodal Continual Instruction Tuning with Dual-Modality Guided Prompt},
  author={Zeng, Fanhu and Zhu, Fei and Guo, Haiyang and Zhang, Xu-Yao and Liu, Cheng-Lin},
  booktitle={Proceedings of the 2025 Conference on Empirical Methods in Natural Language Processing},
  pages={12137--12152},
  year={2025}
}

@article{guo2025mcitlib,
  title={MCITlib: Multimodal Continual Instruction Tuning Library and Benchmark},
  author={Guo, Haiyang and Zhu, Fei and Zhao, Hongbo and Zeng, Fanhu and Liu, Wenzhuo and Ma, Shijie and Wang, Da-Han and Zhang, Xu-Yao},
  journal={arXiv preprint arXiv:2508.07307},
  year={2025}
}

@article{guo2025continual,
  title={Continual Learning for Generative AI: From LLMs to MLLMs and Beyond},
  author={Guo, Haiyang and Zeng, Fanhu and Zhu, Fei and Wang, Jiayi and Wang, Xukai and Zhou, Jingang and Zhao, Hongbo and Liu, Wenzhuo and Ma, Shijie and Zhang, Xu-Yao and others},
  journal={arXiv preprint arXiv:2506.13045},
  year={2025}
}
```

## Acknowledgememnt

The code is based on [LLaVA](https://github.com/haotian-liu/LLaVA). Thanks for these great works and open sourcing! 

If you find them helpful, please consider citing them as well. 
