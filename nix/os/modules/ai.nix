{
  config,
  pkgs,
  pkgsUnstable,
  ...
}:
{
  services.ollama = {
    enable = true;
    package = pkgsUnstable.ollama-cuda;
    openFirewall = true;
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_FLASH_ATTENTION = "1"; # Faster prompt processing
      OLLAMA_KV_CACHE_TYPE = "q4_0"; # Quantized KV cache - uses ~25% of f16 VRAM
      OLLAMA_CONTEXT_LENGTH = "65536"; # 64K context (default is 4K, qwen3-coder supports 262K)
    };
    loadModels = [
      "deepseek-r1:14b"
      "qwen3-coder:30b"
      "qwen3:30b-a3b"
    ];
  };

  services.open-webui = {
    enable = true;
    package = pkgsUnstable.open-webui;
    openFirewall = true;
    host = "0.0.0.0";
  };
}
