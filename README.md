# How to run this in docker:

## First:
```
mkdir -p misc/
wget http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2 -O misc/shape_predictor_68_face_landmarks.dat.bz2
bzip2 -d misc/shape_predictor_68_face_landmarks.dat.bz2
wget --content-disposition https://github.com/mpc001/Lipreading_using_Temporal_Convolutional_Networks/raw/master/preprocessing/20words_mean_face.npy -O misc/20words_mean_face.npy
```

```
wget https://dl.fbaipublicfiles.com/avhubert/model/lrs3/vsr/large_lrs3_30h.pt -O misc/model.pt
```


## if you **dont have** GPU run this command:
```
docker build -t deepfake_detector .
```

## if you **have** GPU:

replace in `requirements.txt`:
```
faiss-gpu==1.7.2
# faiss-cpu==1.7.2
```
and then run this command:
```
docker build -t deepfake_detector --gpus=all .
```


## To run code in the container interactively:
```
docker run --rm -it --entrypoint bash deepfake_detector
cd av_hubert/avhubert/
python3 preprocess.py --ffmpeg_path=$(which ffmpeg)
python3 inference.py 0
python3 eval.py
```

# Instruction without docker (tested on python3.9):
Install apt packages:
```
sudo apt-get install -y --fix-missing build-essential  
sudo apt-get install -y --fix-missing cmake
sudo apt-get install -y --fix-missing ffmpeg
sudo apt-get install -y --fix-missing libopencv-dev
```

then install requirements.txt and `fairseq`
```
python3 -m venv vnev
source venv/bin/activate
pip install --no-cache-dir -r requirements.txt
pip install --editable av_hubert/fairseq
```

Then move this to venv:
```
cp av_hubert/avhubert/abstract.py venv/lib/python3.9/site-packages/skvideo/io/
```

Commands to evaluate model
```
cd av_hubert/avhubert/
python3 preprocess.py --ffmpeg_path=$(which ffmpeg)
python3 inference.py 0
python3 eval.py
```