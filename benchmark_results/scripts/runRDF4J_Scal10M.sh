#!/bin/bash

# A. Store current directory
CWD=`pwd`

# B. Run RDF4J against Scalability-{10M} workload

# B.1. Prepare the environment for creating the <scalability-{10M}> RDF4J repository
cd /data/geordfbench/scripts
source prepareRunEnvironment.sh nuc8i7beh RDF4JSUT "CreateRepo_Scalability10M_RDF4J"
./printRunEnvironment.sh >> /data/envvars_rdf4j.log

BASE_LOG_DIR=/data/LOGS
REPO_CREATION_LOG_DIR=${BASE_LOG_DIR}/RepoCreation/${ActiveSUT}
EXP_RUN_LOG_DIR=${BASE_LOG_DIR}/ExperimentRun/${ActiveSUT}
mkdir -p ${REPO_CREATION_LOG_DIR}
mkdir -p ${EXP_RUN_LOG_DIR}
mv /data/envvars_rdf4j.log ${REPO_CREATION_LOG_DIR}

# B.2. Create the <scalability-{10M}> RDF4J repositories and load the data
cd ../RDF4JSUT/scripts/CreateRepos/
# restore createAllRDF4JRepos.sh script to its original state
git checkout createAllRDF4JRepos.sh
# B.2.1. Using sed, in the RDF4J wrapper repo generation script, replace the bash array that holds the standard 10K scalability repo
#         	levels=( "10K" )repo 
#        with the 1 desired repos 10M
#			levels=( "10M" )
sed -i -e 's@^levels=( "10K" )@levels=( "10M" )@g' createAllRDF4JRepos.sh
# B.2.2. Call the RDF4J wrapper repo generation script to create the repos and load the data
./createAllRDF4JRepos.sh false 2>&1 | tee -a ${REPO_CREATION_LOG_DIR}/logCreateRepos_Scal10M_RDF4J.log

# restore createAllRDF4JRepos.sh script to its original state
git checkout createAllRDF4JRepos.sh

# B.3. Run the experiments with RDF4J against the <scalability-{10M}> RDF4J repository
DateTimeISO8601=`date --iso-8601='date'`

cd ../RunTests3/
# -rbd RDF4J_3.7.7_Repos/server ==> -rbd ${RDF4JRepoBaseDir//"${EnvironmentBaseDir}/"}
./runWLTestsForRDF4JSUT.sh -Xmx24g -rbd ${RDF4JRepoBaseDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_RDF4JSUT_RunWL_Scal10M -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLRDF4JExp_Scal10M.log

# C. Restore the current working directory
cd $CWD
