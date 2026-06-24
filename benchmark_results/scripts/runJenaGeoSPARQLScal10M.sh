#!/bin/bash

# A. Store current directory
CWD=`pwd`

# B. Run JenaGeoSPARQL against Scalability-{10M} workload

# B.1. Prepare the environment for creating the <scalability-{10M}> JenaGeoSPARQL repository
cd /data/geordfbench/scripts
source prepareRunEnvironment.sh nuc8i7beh JenaGeoSPARQLSUT "CreateRepo_Scalability10M_JenaGeoSPARQL"
./printRunEnvironment.sh >> /data/envvars_jenageosparql.log

BASE_LOG_DIR=/data/LOGS
REPO_CREATION_LOG_DIR=${BASE_LOG_DIR}/RepoCreation/${ActiveSUT}
EXP_RUN_LOG_DIR=${BASE_LOG_DIR}/ExperimentRun/${ActiveSUT}
mkdir -p ${REPO_CREATION_LOG_DIR}
mkdir -p ${EXP_RUN_LOG_DIR}
mv /data/envvars_jenageosparql.log ${REPO_CREATION_LOG_DIR}

# B.2. Create the <scalability-{10M}> JenaGeoSPARQL repository and load the data
cd ../JenaGeoSPARQLSUT/scripts/CreateRepos/
# restore createAllJenaGeoSPARQLScalabilityRepos.sh script to its original state
git checkout createAllJenaGeoSPARQLScalabilityRepos.sh

# B.2.1. Using sed, in the JenaGeoSPARQL wrapper repo generation script, replace the bash array that holds the standard 10K scalability repo
#         	levels=( "10K" )repo 
#        with the 1 desired repo 10M
#			levels=( "10M" )
sed -i -e 's@^levels=( "10K" )@levels=( "10M" )@g' createAllJenaGeoSPARQLScalabilityRepos.sh
# B.2.2. Call the JenaGeoSPARQL wrapper repo generation script to create the repos and load the data
./createAllJenaGeoSPARQLScalabilityRepos.sh 2>&1 | tee -a ${REPO_CREATION_LOG_DIR}/logCreateRepo_Scal10M_JenaGeoSPARQL.log

# restore createAllJenaGeoSPARQLScalabilityRepos.sh script to its original state
git checkout createAllJenaGeoSPARQLScalabilityRepos.sh

# B.3. Run the experiment with JenaGeoSPARQL against the <scalability-{10M}> repository
DateTimeISO8601=`date --iso-8601='date'`
cd ../RunTests3/
# -rbd JenaGeoSPARQL_3.17.0_Repos ==> -rbd ${JenaGeoSPARQLRepoBaseDir//"${EnvironmentBaseDir}/"}
./runWLTestsForJenaGeoSPARQLSUT.sh -Xmx24g -rbd ${JenaGeoSPARQLRepoBaseDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_JenaGeoSPARQL_RunWL_Scal10M -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLJenaGeoSPARQLExp_Scal10M.log

# C. Restore the current working directory
cd $CWD
