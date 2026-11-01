Set-Location $PSScriptRoot

$gpu = Get-Command nvidia-smi -ErrorAction SilentlyContinue

if ($gpu -and (nvidia-smi -L 2>$null)) {
    Write-Host "GPU detected - selecting GPU base image"
    $baseImage = "pytorch/pytorch:2.7.0-cuda12.6-cudnn9-runtime"
    $mode = "gpu"
} else {
    Write-Host "No NVIDIA GPU detected - selecting CPU base image"
    $baseImage = "python:3.11-slim"
    $mode = "cpu"
}

docker build --build-arg "BASE_IMAGE=$baseImage" --build-arg "COMPUTE_MODE=$mode" -t cis731-compute .

if ($LASTEXITCODE -ne 0) {
    throw "Docker build failed"
}

docker run --rm cis731-compute
