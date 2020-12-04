FROM paddlepaddle/paddle:2.0.0rc0

RUN pip3.8 install paddlehub -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com && \
    pip3.8 install matplotlib -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com && \
    pip3.8 install imgaug -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com && \
    pip3.8 install tools -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com && \
    pip3.8 install pyclipper -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com

WORKDIR /home

RUN git clone https://gitee.com/paddlepaddle/PaddleOCR.git && \ 
    mkdir /home/PaddleOCR/inference && \
    wget -P /home/PaddleOCR/inference https://paddleocr.bj.bcebos.com/20-09-22/server/det/ch_ppocr_server_v1.1_det_infer.tar && \
    wget -P /home/PaddleOCR/inference https://paddleocr.bj.bcebos.com/20-09-22/cls/ch_ppocr_mobile_v1.1_cls_infer.tar && \
    wget -P /home/PaddleOCR/inference https://paddleocr.bj.bcebos.com/20-09-22/server/rec/ch_ppocr_server_v1.1_rec_infer.tar
RUN tar -xvf /home/PaddleOCR/inference/ch_ppocr_server_v1.1_det_infer.tar -C /home/PaddleOCR/inference && \
    tar -xvf /home/PaddleOCR/inference/ch_ppocr_mobile_v1.1_cls_infer.tar -C /home/PaddleOCR/inference && \
    tar -xvf /home/PaddleOCR/inference/ch_ppocr_server_v1.1_rec_infer.tar -C /home/PaddleOCR/inference
    
RUN sed -i 's/ch_ppocr_mobile_v1.1_det_infer/ch_ppocr_server_v1.1_det_infer/' /home/PaddleOCR/deploy/hubserving/ocr_det/params.py && \
    sed -i 's/ch_ppocr_mobile_v1.1_rec_infer/ch_ppocr_server_v1.1_rec_infer/' /home/PaddleOCR/deploy/hubserving/ocr_rec/params.py && \
    sed -i 's/ch_ppocr_mobile_v1.1_det_infer/ch_ppocr_server_v1.1_det_infer/' /home/PaddleOCR/deploy/hubserving/ocr_system/params.py && \
    sed -i 's/ch_ppocr_mobile_v1.1_rec_infer/ch_ppocr_server_v1.1_rec_infer/' /home/PaddleOCR/deploy/hubserving/ocr_system/params.py

WORKDIR /home/PaddleOCR

RUN hub install deploy/hubserving/ocr_det/ && \
    hub install deploy/hubserving/ocr_rec/ && \
    hub install deploy/hubserving/ocr_system/

CMD hub serving start --modules ocr_system --port 8866 --use_multiprocess

EXPOSE 8866
