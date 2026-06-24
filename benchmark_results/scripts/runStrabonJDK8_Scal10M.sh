#!/bin/bash

# A. Store current directory
CWD=`pwd`

# B. Run Strabon against Scalability-{10M} workload

# B.1. Prepare the environment for creating the <scalability-{10M}> Strabon repository
cd /data/geordfbench/scripts
source prepareRunEnvironment.sh nuc8i7beh StrabonSUT "CreateRepo_Scalability10M_Strabon"
./printRunEnvironment.sh >> /data/envvars_strabon.log

BASE_LOG_DIR=/data/LOGS
REPO_CREATION_LOG_DIR=${BASE_LOG_DIR}/RepoCreation/${ActiveSUT}
EXP_RUN_LOG_DIR=${BASE_LOG_DIR}/ExperimentRun/${ActiveSUT}
REPO_CREATION_LOG_FILE=${REPO_CREATION_LOG_DIR}/StrabonLoader/CSVs2PostGIS/logCreateRepos_Scal10M_Strabon.log
mkdir -p ${REPO_CREATION_LOG_DIR}
mkdir -p ${EXP_RUN_LOG_DIR}
mkdir -p ${REPO_CREATION_LOG_DIR}/StrabonLoader/CSVs2PostGIS/

# B.2. Create the <scalability-{10M}> RDF4J repositories and load the data using the StrabonLoader 3 phase offline utility
BASE_CSV_DIR=/data/LOGS/RepoCreation/StrabonSUT/StrabonLoader/NTriples2CSVs/Scalability_10M

# copy Scalability_10M CSV files to current directory
# record start time of experiment
echo ""
echo "Generation of scalability_10M repository, Phases 2 and 3" > $REPO_CREATION_LOG_FILE
EXPIR_START_TIME=$SECONDS
echo " Phase 2: Copying CSVs of phase-1 to LoadingScripts/postgis ..." >> $REPO_CREATION_LOG_FILE
cp -v ${BASE_CSV_DIR}/*.csv /data/strabonloader/LoadingScripts/postgis >> $REPO_CREATION_LOG_FILE 2>&1
# import CSVs to PostGIS
cd /data/strabonloader/LoadingScripts/postgis >> $REPO_CREATION_LOG_FILE 2>&1
echo " Phase 3: Creating PostGIS database, importing CSVs to PostGIS tables, indexing PostGIS tables ..." >> $REPO_CREATION_LOG_FILE
./import scalability_10M >> $REPO_CREATION_LOG_FILE 2>&1
# record end time of experiment
DURATION_SECS=$(($SECONDS-$EXPIR_START_TIME))
# clean CSVs from LoadingScripts/postgis
mv *.log ${REPO_CREATION_LOG_DIR}/StrabonLoader/CSVs2PostGIS/
rm *.csv
cd ${CWD}
echo "-------------------------------" >> $REPO_CREATION_LOG_FILE
echo "Scalability_10M Repository Generation (Phases 2 and 3) Duration : ${DURATION_SECS} secs" >> $REPO_CREATION_LOG_FILE
echo ""

# B.3. Run the experiments with RDF4J against the <scalability-{10M}> RDF4J repositories
DateTimeISO8601=`date --iso-8601='date'`

cd /data/geordfbench/StrabonSUT/scripts/RunTests3/
# Change to JDK-8 for Strabon related compatibility issues (OpenRDF Sesame)
sudo update-alternatives --set java $(update-alternatives --list java | grep java-8)
# run against scalability_10M
./runWLTestsForStrabonSUT.sh -Xmx24g -expdesc ${DateTimeISO8601}_StrabonSUT_RunWL_Scal10M -dbh localhost -dbp 5432 -dbn scalability_10M -dbu postgres -dbps postgres -wl ${GeoRDFBenchJSONLibDir}/workloads/scalabilityFunc10M_WLoriginal.json -h ${GeoRDFBenchJSONLibDir}/hosts/nuc8i7behHOSToriginal.json -rs ${GeoRDFBenchJSONLibDir}/reportspecs/simplereportspec_original.json -rpsr ${GeoRDFBenchJSONLibDir}/reportsources/nuc8i7behHOSToriginal.json 2>&1 | tee -a ${EXP_RUN_LOG_DIR}/RunWLStrabonExp_Scal10M.log

# Revert to JDK-11 which is the default target for GeoRDFBench Framework
sudo update-alternatives --set java $(update-alternatives --list java | grep java-11)

# C. Restore the current working directory
cd $CWD
