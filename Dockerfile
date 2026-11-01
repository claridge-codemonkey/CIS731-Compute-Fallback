ARG BASE_IMAGE=python:3.11-slim
FROM ${BASE_IMAGE}

WORKDIR /workspace

ARG COMPUTE_MODE=cpu

RUN if [ "$COMPUTE_MODE" = "cpu" ]; then \
      python -m pip install --no-cache-dir numpy torch==2.7.0 --index-url https://download.pytorch.org/whl/cpu; \
    else \
      python -c "import torch; assert torch.version.cuda is not None, 'CUDA PyTorch required'"; \
    fi

COPY probe_compute.py /workspace/probe_compute.py

CMD ["python", "/workspace/probe_compute.py"]
