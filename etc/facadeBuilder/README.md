# How to build everytime you change facadeBuilder.ts
- `npx tsc facadeBuilder.ts`
- `npx pkg facadeBuilder.js --targets node14-macos-x64,node14-macos-arm64,node14-linux-x64,node14-win-x64 --output facade`
- `chmod +x facade-*`
- `cp facade.yaml ../../`
