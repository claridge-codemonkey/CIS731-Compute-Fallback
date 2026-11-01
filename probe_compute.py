
import torch

def probe_compute():
    if torch.cuda.is_available():
        print("GPU Pool Active - Batch Embedding/Whisper Ready")
        print(f"GPU Device: {torch.cuda.get_device_name(0)}")
        device = torch.device("cuda")
    else:
        print("CPU-Only Fallback Active")
        device = torch.device("cpu")

    print(f"Selected Device: {device}")
    return device

if __name__ == "__main__":
    probe_compute()
