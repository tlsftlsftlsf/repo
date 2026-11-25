# tlsf's iOS Jailbreak Repo

个人专属 iOS 越狱插件源，支持 Sileo、Zebra、Cydia、TrollStore。

### 📱 源地址
```text
https://tlsftlsftlsf.github.io/repo/
```

### ⚡ 快速添加
- **Sileo**: [点击一键添加](sileo://source/https://tlsftlsftlsf.github.io/repo/)
- **Zebra**: [点击一键添加](zbra://sources/add/https://tlsftlsftlsf.github.io/repo/)
- **Cydia**: [点击一键添加](cydia://url/https://cydia.saurik.com/api/share#?source=https://tlsftlsftlsf.github.io/repo/)

### 🛠️ 如何添加新插件
1. 将打包好的 `.deb` 文件放入 `debs/` 目录；
2. 运行 `./update_repo.sh` 更新索引；
3. 执行 `git add . && git commit -m "add tweak" && git push` 推送至 GitHub。
