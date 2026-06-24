#!/bin/bash

# A. Store current directory
CWD=`pwd`

# B. Run Virtuoso against Scalability-{10M} workload

# B.1. Prepare the environment for creating the <scalability-{10M}> Virtuoso repository
cd /data/geordfbench/scripts
source prepareRunEnvironment.sh nuc8i7beh VirtuosoSUT "CreateRepo_Scalability10M_Virtuoso"
./printRunEnvironment.sh >> /data/envvars_virtuoso.log

BASE_LOG_DIR=/data/LOGS
REPO_CREATION_LOG_DIR=${BASE_LOG_DIR}/RepoCreation/${ActiveSUT}
EXP_RUN_LOG_DIR=${BASE_LOG_DIR}/ExperimentRun/${ActiveSUT}
mkdir -p ${REPO_CREATION_LOG_DIR}
mkdir -p ${EXP_RUN_LOG_DIR}
mv /data/envvars_virtuoso.log ${REPO_CREATION_LOG_DIR}

# B.2. Create the <scalability-{10M}> Virtuoso repository and load the data
cd ../VirtuosoSUT/scripts/CreateRepos/
# restore createAllVirtuosoRepos.sh script to its original state
git checkout createAllVirtuosoRepos.sh

# B.2.1. Using sed, in the Virtuoso wrapper repo generation script, comment out the lines that holds the 10M scalability repo
#        and comment in the 10K repo 
#             [scalability_10K]="Scalability/10K"
#        #    [scalability_10K]="Scalability/10K"
#        with the 1 desired repo 10M
#        #    [scalability_10M]="Scalability/10M"
#             [scalability_10M]="Scalability/10M"
sed -i -e 's@^               \[scalability_10K\]@#               \[scalability_10K\]@g' createAllVirtuosoRepos.sh
sed -i -e 's@^#              \[scalability_10M\]@               \[scalability_10M\]@g' createAllVirtuosoRepos.sh
# B.2.2. Call the Virtuoso wrapper repo generation script to create the repos and load the data
./createAllVirtuosoRepos.sh 2>&1 | tee -a ${REPO_CREATION_LOG_DIR}/logCreateRepos_Scal10M_Virtuoso.log

# restore createAllVirtuosoRepos.sh script to its original state
git checkout createAllVirtuosoRepos.sh

# B.3. Run the experiments with Virtuoso against the <scalability-{10M }> Virtuoso repositories
DateTimeISO8601=`date --iso-8601='date'`

cd ../RunTests3/
# -rbd virtuoso-opensource/repos ==> -rbd ${VirtuosoDataBaseDir//"${EnvironmentBaseDir}/"}
./runWLTestsForVirtuosoSUT.sh -Xmx24g -surl 'http://localhost:1111' -susr dba -spwd dba -rbd virtuoso-opensource-7.2.14/repos -expdesc ${DateTimeISO8601}_${ActiveSUT}_RunWL_Scal10M -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLVirtuosoExp_Scal10M.log

# C. Restore the current working directory
cd $CWD
