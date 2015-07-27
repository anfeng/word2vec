MIN_COUNT=${1:5}
ITERS=${2:10}

make
if [ ! -e text8 ]; then
  wget http://mattmahoney.net/dc/text8.zip -O text8.gz
  gzip -d text8.gz -f
fi
time ./word2vec -min-count $MIN_COUNT -save-vocab vocab.txt -size 300 -train text8 -output vectors.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter $ITERS -output vectors.txt
time ./word2vec -read-vocab vocab.txt -size 300 -train text8 -output vectors.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter $ITERS
time ./distance vectors.bin
