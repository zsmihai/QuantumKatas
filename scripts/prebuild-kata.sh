# prebuild-kata.sh <kata-folder> <kata-notebook>
KATA_FOLDER=$1
KATA_NOTEBOOK=${2:-$1.ipynb}

echo "Prebuilding: $KATA_NOTEBOOK in $KATA_FOLDER kata..."

#dotnet build $KATA_FOLDER

start=`date +%s`
jupyter nbconvert $KATA_FOLDER/$KATA_NOTEBOOK --execute --to markdown  --allow-errors  --ExecutePreprocessor.timeout=600 --log-level=DEBUG
end=`date +%s`

echo total time `expr $end - $start`