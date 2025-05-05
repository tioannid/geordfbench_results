#!/bin/bash

# A. Store current directory
CWD=`pwd`

# B. Run RDF4J against Scalability-{10K | 100K | 1M} workloads

# B.1. Prepare the environment for creating the <scalability-{10K | 100K | 1M}> RDF4J repositories
cd /data/geordfbench/scripts
source prepareRunEnvironment.sh nuc8i7beh RDF4JSUT "CreateRepo_Scalability10K_1M_RDF4J"
./printRunEnvironment.sh >> /data/envvars_rdf4j.log

BASE_LOG_DIR=/data/LOGS
REPO_CREATION_LOG_DIR=${BASE_LOG_DIR}/RepoCreation/${ActiveSUT}
EXP_RUN_LOG_DIR=${BASE_LOG_DIR}/ExperimentRun/${ActiveSUT}
mkdir -p ${REPO_CREATION_LOG_DIR}
mkdir -p ${EXP_RUN_LOG_DIR}

# B.2. Create the <scalability-{10K | 100K | 1M}> RDF4J repositories and load the data
cd ../RDF4JSUT/scripts/CreateRepos/
# B.2.1. Using sed, in the RDF4J wrapper repo generation script, replace the bash array that holds the standard 10K scalability repo
#         	levels=( "10K" )repo 
#        with the 3 desired repos 10K 100K 1M
#			levels=( "10K" "100K" "1M" )
sed -i -e 's@^levels=( "10K" )@levels=( "10K" "100K" "1M" )@g' createAllRDF4JRepos.sh
# B.2.2. Call the RDF4J wrapper repo generation script to create the repos and load the data
./createAllRDF4JRepos.sh false 2>&1 | tee -a ${REPO_CREATION_LOG_DIR}/logCreateRepos_Scal10K_1M_RDF4J.log

# B.3. Run the experiments with RDF4J against the <scalability-{10K | 100K | 1M}> RDF4J repositories
DateTimeISO8601=`date --iso-8601='date'`

cd ../RunTests3/
# -rbd RDF4J_3.7.7_Repos/server ==> -rbd ${RDF4JRepoBaseDir//"${EnvironmentBaseDir}/"}
./runWLTestsForRDF4JSUT.sh -Xmx24g -rbd ${RDF4JRepoBaseDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_RDF4JSUT_RunWL_Scal10K -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10K_WLoriginal_GOLD_STANDARD.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLRDF4JExp_Scal10K.log

./runWLTestsForRDF4JSUT.sh -Xmx24g -rbd ${RDF4JRepoBaseDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_RDF4JSUT_RunWL_Scal100K -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc100K_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLRDF4JExp_Scal100K.log

./runWLTestsForRDF4JSUT.sh -Xmx24g -rbd ${RDF4JRepoBaseDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_RDF4JSUT_RunWL_Scal1M -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc1M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLRDF4JExp_Scal1M.log

# C. Restore the current working directory
cd $CWD
