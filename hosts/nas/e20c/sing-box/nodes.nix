{
  # 代理节点
  tuic = [
    "bitsflow"
    "wawo"
    "wawo6"
    "wapac"
    "alice"
    "osaka-1"
    "sailor"
    "gcloud"
  ];
  anytls = [ ];

  # 分流节点,必须存在于代理节点中
  openai = [
    "bitsflow"
    "osaka-1"
    "sailor"
    "gcloud"
  ];
  gemini = [
    "bitsflow"
    "wawo"
    "wapac"
    "osaka-1"
    "sailor"
    "gcloud"
  ];
}
