#!/bin/bash

# A. Store current directory
CWD=`pwd`

# B. Run JenaGeoSPARQL against Scalability-{10K | 100K | 1M} workloads

# B.1. Prepare the environment for creating the <scalability-{10K | 100K | 1M}> JenaGeoSPARQL repositories
cd /data/geordfbench/scripts
source prepareRunEnvironment.sh nuc8i7beh JenaGeoSPARQLSUT "CreateRepo_Scalability10K_1M_JenaGeoSPARQL"
./printRunEnvironment.sh >> /data/envvars_jenageosparql.log

BASE_LOG_DIR=/data/LOGS
REPO_CREATION_LOG_DIR=${BASE_LOG_DIR}/RepoCreation/${ActiveSUT}
EXP_RUN_LOG_DIR=${BASE_LOG_DIR}/ExperimentRun/${ActiveSUT}
mkdir -p ${REPO_CREATION_LOG_DIR}
mkdir -p ${EXP_RUN_LOG_DIR}

# B.2. Create the <scalability-{10K | 100K | 1M}> JenaGeoSPARQL repositories and load the data
cd ../JenaGeoSPARQLSUT/scripts/CreateRepos/
# B.2.1. Using sed, in the JenaGeoSPARQL wrapper repo generation script, replace the bash array that holds the standard 10K scalability repo
#         	levels=( "10K" )repo 
#        with the 3 desired repos 10K 100K 1M
#			levels=( "10K" "100K" "1M" )
sed -i -e 's@^levels=( "10K" )@levels=( "10K" "100K" "1M" )@g' createAllJenaGeoSPARQLScalabilityRepos.sh
# B.2.2. Call the JenaGeoSPARQL wrapper repo generation script to create the repos and load the data
./createAllJenaGeoSPARQLScalabilityRepos.sh 2>&1 | tee -a ${REPO_CREATION_LOG_DIR}/logCreateRepo_Scal10K_1M_JenaGeoSPARQL.log

# B.3. Run the experiment with JenaGeoSPARQL against the <scalability-{10K | 100K | 1M}> repositories
DateTimeISO8601=`date --iso-8601='date'`
cd ../RunTests3/
# -rbd JenaGeoSPARQL_3.17.0_Repos ==> -rbd ${JenaGeoSPARQLRepoBaseDir//"${EnvironmentBaseDir}/"}
./runWLTestsForJenaGeoSPARQLSUT.sh -Xmx24g -rbd ${JenaGeoSPARQLRepoBaseDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_JenaGeoSPARQL_RunWL_Scal10K -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10K_WLoriginal_GOLD_STANDARD.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLJenaGeoSPARQLExp_Scal10K.log

./runWLTestsForJenaGeoSPARQLSUT.sh -Xmx24g -rbd ${JenaGeoSPARQLRepoBaseDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_JenaGeoSPARQL_RunWL_Scal100K -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc100K_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLJenaGeoSPARQLExp_Scal100K.log

./runWLTestsForJenaGeoSPARQLSUT.sh -Xmx24g -rbd ${JenaGeoSPARQLRepoBaseDir//"${EnvironmentBaseDir}/"} -expdesc ${DateTimeISO8601}_JenaGeoSPARQL_RunWL_Scal1M -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc1M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLJenaGeoSPARQLExp_Scal1M.log

# C. Restore the current working directory
cd $CWD
