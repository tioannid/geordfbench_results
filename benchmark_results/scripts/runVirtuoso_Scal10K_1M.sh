#!/bin/bash

# A. Store current directory
CWD=`pwd`

# B. Run Virtuoso against Scalability-{10K | 100K | 1M | 10M} workloads

# B.1. Prepare the environment for creating the <scalability-{10K | 100K | 1M | 10M}> Virtuoso repositories
cd /data/geordfbench/scripts
source prepareRunEnvironment.sh nuc8i7beh VirtuosoSUT "CreateRepo_Scalability10K_10M_Virtuoso"
./printRunEnvironment.sh >> /data/envvars_virtuoso.log

BASE_LOG_DIR=/data/LOGS
REPO_CREATION_LOG_DIR=${BASE_LOG_DIR}/RepoCreation/${ActiveSUT}
EXP_RUN_LOG_DIR=${BASE_LOG_DIR}/ExperimentRun/${ActiveSUT}
mkdir -p ${REPO_CREATION_LOG_DIR}
mkdir -p ${EXP_RUN_LOG_DIR}

# B.2. Create the <scalability-{10K | 100K | 1M | 10M}> Virtuoso repositories and load the data
cd ../VirtuosoSUT/scripts/CreateRepos/
# B.2.1. Using sed, in the Virtuoso wrapper repo generation script, comment out the lines that holds the 100K, 1M, 10M scalability repos
#         	
#        #      [scalability_100K]="Scalability/100K"
#        #      [scalability_1M]="Scalability/1M"
#        with the 3 desired repos 10K 100K 1M
#	            [scalability_100K]="Scalability/100K"
#               [scalability_1M]="Scalability/1M"
sed -i -e 's@^#              \[scalability_100K\]@               \[scalability_100K\]@g' createAllVirtuosoRepos.sh
sed -i -e 's@^#              \[scalability_1M\]@               \[scalability_1M\]@g' createAllVirtuosoRepos.sh
sed -i -e 's@^#              \[scalability_10M\]@               \[scalability_10M\]@g' createAllVirtuosoRepos.sh
# B.2.2. Call the Virtuoso wrapper repo generation script to create the repos and load the data
./createAllVirtuosoRepos.sh 2>&1 | tee -a ${REPO_CREATION_LOG_DIR}/logCreateRepos_Scal10K_1M_Virtuoso.log

# B.3. Run the experiments with Virtuoso against the <scalability-{10K | 100K | 1M | 10M}> Virtuoso repositories
DateTimeISO8601=`date --iso-8601='date'`

cd ../RunTests3/
# -rbd virtuoso-opensource/repos ==> -rbd ${VirtuosoDataBaseDir//"${EnvironmentBaseDir}/"}
./runWLTestsForVirtuosoSUT.sh -Xmx24g -surl 'http://localhost:1111' -susr dba -spwd dba -rbd virtuoso-opensource-7.2.14/repos -expdesc ${DateTimeISO8601}_${ActiveSUT}_RunWL_Scal10K -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10K_WLoriginal_GOLD_STANDARD.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLVirtuosoExp_Scal10K.log

./runWLTestsForVirtuosoSUT.sh -Xmx24g -surl 'http://localhost:1111' -susr dba -spwd dba -rbd virtuoso-opensource-7.2.14/repos -expdesc ${DateTimeISO8601}_${ActiveSUT}_RunWL_Scal100K -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc100K_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLVirtuosoExp_Scal100K.log

./runWLTestsForVirtuosoSUT.sh -Xmx24g -surl 'http://localhost:1111' -susr dba -spwd dba -rbd virtuoso-opensource-7.2.14/repos -expdesc ${DateTimeISO8601}_${ActiveSUT}_RunWL_Scal1M -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc1M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLVirtuosoExp_Scal1M.log

./runWLTestsForVirtuosoSUT.sh -Xmx24g -surl 'http://localhost:1111' -susr dba -spwd dba -rbd virtuoso-opensource-7.2.14/repos -expdesc ${DateTimeISO8601}_${ActiveSUT}_RunWL_Scal10M -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLVirtuosoExp_Scal10M.log

# C. Restore the current working directory
cd $CWD
