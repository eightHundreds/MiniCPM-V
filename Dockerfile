# 使用PyTorch官方CUDA基础镜像
FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-runtime

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# 复制项目文件
COPY . /app/

# 安装Python依赖
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir flash-attn==2.3.4 xformers==0.0.22.post7 \
    && pip install --no-cache-dir deepspeed \
    && pip install --no-cache-dir \
        streamlit \
        pandas \
        decord \
        huggingface_hub \
        python-dotenv \
        tabulate \
        sty \
        validators \
        requests

# 暴露端口（用于web demo）
EXPOSE 7860