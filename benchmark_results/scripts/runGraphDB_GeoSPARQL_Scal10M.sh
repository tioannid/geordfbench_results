#!/bin/bash

# A. Store current directory
CWD=`pwd`

# B. Run GraphDB with GeoSPARQL plugin enabled with Quad-11 against Scalability-{10M} workload

# B.1. Prepare the environment for creating the <scalability-{10M}> GraphDB repository
cd /data/geordfbench/scripts
# Enable the GeoSPARQL plugin which has default=false
export EnableGeoSPARQLPlugin=true
# Set the following only if IndexingAlgorithm needs to become 'geohash', otherwise default=quad
# export IndexingAlgorithm = quad
# Set the following only if IndexingPrecision needs to change, default=11, min=1, max(geohash)=24, max(quad)=50
# export IndexingPrecision = 11
source prepareRunEnvironment.sh nuc8i7beh GraphDBSUT "CreateRepo_Scalability10M_GraphDB_GeoSPARQL_Enabled_Quad_11"

# Print the environment variables
./printRunEnvironment.sh >> /data/envvars_graphdb_geosparql_quad_11.log

BASE_LOG_DIR=/data/LOGS
REPO_CREATION_LOG_DIR=${BASE_LOG_DIR}/RepoCreation/${ActiveSUT}
EXP_RUN_LOG_DIR=${BASE_LOG_DIR}/ExperimentRun/${ActiveSUT}
mkdir -p ${REPO_CREATION_LOG_DIR}
mkdir -p ${EXP_RUN_LOG_DIR}
mv /data/envvars_graphdb_geosparql_quad_11.log ${REPO_CREATION_LOG_DIR}

# B.2. Create the <scalability-{10M}> GraphDB repository and load the data
cd ../GraphDBSUT/scripts/CreateRepos/
# restore createAllGraphDBRepos.sh script to its original state
git checkout createAllGraphDBRepos.sh
# B.2.1. Using sed, in the GraphDB wrapper repo generation script, replace the bash array that holds the standard 10K scalability repo
#         	levels=( "10K" )repo 
#        with the 1 desired repo 10M
#			levels=( "10M" )
sed -i -e 's@^levels=( "10K" )@levels=( "10M" )@g' createAllGraphDBRepos.sh
# B.2.2. Call the GraphDB wrapper repo generation script to create the repos and load the data
./createAllGraphDBRepos.sh 2>&1 | tee -a ${REPO_CREATION_LOG_DIR}/logCreateRepo_Scal10M_GraphDB_GeoSPARQL_Enabled_Quad_11.log

# restore createAllGraphDBRepos.sh script to its original state
git checkout createAllGraphDBRepos.sh

# B.3. Run the experiment with GraphDB against the <scalability-{10M}> GraphDB repository
DateTimeISO8601=`date --iso-8601='date'`
cd ../RunTests3/
# -rbd graphdb-free-9.11.1/data ==> -rbd ${GraphDBDataDir//"${EnvironmentBaseDir}/"}
./runWLTestsForGraphDBSUT.sh -Xmx24g -rbd ${GraphDBDataDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal10M -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLGraphD_GeoSPARQL_Enabled_Quad_11Exp_Scal10M.log

# C. Restore the current working directory
cd $CWD
