# MiniOCR

## 重要提示

本项目基于PaddlePaddle2.0.0rc0, 封装了OCR服务, 但是并非使用官方推荐的模型!!!!

1. 检测模型: ch_ppocr_server_v1.1_det_infer
2. 方向分类器: ch_ppocr_mobile_v1.1_cls_infer
3. 识别模型: ch_ppocr_server_v1.1_rec_infer

大小约为155M, 如果需要运行在低配置设备请修改dockerfile中的模型文件

## 构建方向

一键式服务化部署, 具体实现逻辑请参考[官方文档](https://gitee.com/paddlepaddle/PaddleOCR/blob/develop/deploy/hubserving/readme.md)

## 使用方法

1. 自行构建

`
docker build -f min-ocr.dockerfile -t mini-ocr:1.0.1 .
`

2. 仓库拉取

`暂未上传公共仓库`
