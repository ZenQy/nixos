{
  # 代理节点
  tuic = [
    "bitsflow"
    "wawo"
    "alice"
    "osaka-1"
    "sailor"
    "gcloud"
  ];
  anytls = [
    "lxc"
  ];

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
    "osaka-1"
    "sailor"
    "gcloud"
  ];
}
