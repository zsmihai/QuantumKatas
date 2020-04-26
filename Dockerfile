# We use the iqsharp-base image, as that includes
# the .NET Core SDK, IQ#, and Jupyter Notebook already
# installed for us.
FROM qdkimages.azurecr.io/internal/quantum/iqsharp-base:0.11.2004.2414

# Add metadata indicating that this image is used for the katas.
ENV IQSHARP_HOSTING_ENV=KATAS_DOCKERFILE

USER root

# Install Python dependencies for the Python visualization and tutorial notebooks
RUN pip install "matplotlib"
RUN pip install "pytest"

# # Make sure the contents of our repo are in ${HOME}
# # Required for mybinder.org
COPY . ${HOME}

# FOR THIS COMMAND TO SUCCEED:
# Build iqsharp with this command:
#    dotnet publish -r linux-x64 --no-self-contained
# and copy the contents of `src/Tool/bin/Debug/netcoreapp3.1/linux-x64/publish`
# into the `.iqsharp` folder... 
RUN ${HOME}/.iqsharp/Microsoft.Quantum.IQSharp install --user --path-to-tool  ${HOME}/.iqsharp/Microsoft.Quantum.IQSharp -l Information

RUN chown -R ${USER} ${HOME} && \
    chmod +x ${HOME}/scripts/*.sh

USER ${USER}

# Pre-build the BasicGates .Net version ot make sure all packages are loaded
RUN dotnet build ${HOME}/BasicGates

# Pre-exec notebooks to improve first-use start time
RUN ${HOME}/scripts/prebuild-kata.sh BasicGates
RUN ${HOME}/scripts/prebuild-kata.sh CHSHGame
RUN ${HOME}/scripts/prebuild-kata.sh DeutschJozsaAlgorithm
RUN ${HOME}/scripts/prebuild-kata.sh GHZGame
RUN ${HOME}/scripts/prebuild-kata.sh GraphColoring
RUN ${HOME}/scripts/prebuild-kata.sh GroversAlgorithm
RUN ${HOME}/scripts/prebuild-kata.sh JointMeasurements
RUN ${HOME}/scripts/prebuild-kata.sh KeyDistribution_BB84
RUN ${HOME}/scripts/prebuild-kata.sh MagicSquareGame
RUN ${HOME}/scripts/prebuild-kata.sh Measurements
RUN ${HOME}/scripts/prebuild-kata.sh PhaseEstimation
RUN ${HOME}/scripts/prebuild-kata.sh QEC_BitFlipCode
RUN ${HOME}/scripts/prebuild-kata.sh RippleCarryAdder
RUN ${HOME}/scripts/prebuild-kata.sh SolveSATWithGrover
RUN ${HOME}/scripts/prebuild-kata.sh SuperdenseCoding
RUN ${HOME}/scripts/prebuild-kata.sh Superposition
RUN ${HOME}/scripts/prebuild-kata.sh Teleportation
RUN ${HOME}/scripts/prebuild-kata.sh TruthTables
RUN ${HOME}/scripts/prebuild-kata.sh UnitaryPatterns
RUN ${HOME}/scripts/prebuild-kata.sh tutorials/ComplexArithmetic ComplexArithmetic.ipynb
RUN ${HOME}/scripts/prebuild-kata.sh tutorials/ExploringDeutschJozsaAlgorithm DeutschJozsaAlgorithmTutorial.ipynb
RUN ${HOME}/scripts/prebuild-kata.sh tutorials/ExploringGroversAlgorithm ExploringGroversAlgorithmTutorial.ipynb
RUN ${HOME}/scripts/prebuild-kata.sh tutorials/LinearAlgebra LinearAlgebra.ipynb
RUN ${HOME}/scripts/prebuild-kata.sh tutorials/MultiQubitGates MultiQubitGates.ipynb
RUN ${HOME}/scripts/prebuild-kata.sh tutorials/MultiQubitSystems MultiQubitSystems.ipynb
RUN ${HOME}/scripts/prebuild-kata.sh tutorials/Qubit Qubit.ipynb
RUN ${HOME}/scripts/prebuild-kata.sh tutorials/SingleQubitGates SingleQubitGates.ipynb
