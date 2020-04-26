# prebuild-kata.sh <kata-folder> <kata-notebook>
KATA_FOLDER=$1
KATA_NOTEBOOK=${2:-$1.ipynb}

echo "Prebuilding: $KATA_NOTEBOOK in $KATA_FOLDER kata..."

#dotnet build $KATA_FOLDER

start=`date +%s`
# All we need to do is import the qsharp package, this will take care of building the Workspace
python -c "import qsharp"
end=`date +%s`

echo total time `expr $end - $start`