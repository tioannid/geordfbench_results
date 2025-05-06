# Contents

#### benchmark_results/scripts
The folder includes the **experiment execution scripts** that drove the experiments
for each one of the systems. For the interested reader, they provide a high-level 
but concise description of the steps required to setup and run new experiments
with an RDF Module of the GeoRDFBench Framework.
```
└── scripts
    ├── runGraphDB_GeoSPARQL_Scal10K_1M_Pred.sh
    ├── runGraphDB_GeoSPARQL_Scal10K_1M.sh
    ├── runGraphDB_Scal10K_1M.sh
    ├── runJenaGeoSPARQLScal10K_1M.sh
    ├── runRDF4J_Lucene_Scal10K_1M.sh
    ├── runRDF4J_Scal10K_1M.sh
    ├── runStrabonJDK8_Scal10K_1M.sh
    └── runVirtuoso_Scal10K_1M.sh
```

#### benchmark_results/RepoCreation
This folder contains:
- The _environment variables_ as set by the **environment preparation 
scrip** and recorded by the **print environment script** of each system configuration
variant. 
- The logs produced by the **repository generation wrapper script** of each system 
configuration variant
```
├── RepoCreation
│   ├── GraphDBSUT
│   │   ├── GeoSPARQL_Quad_11_Func
│   │   ├── GeoSPARQL_Quad_11_Pred
│   │   └── NoGeoSPARQL
│   ├── JenaGeoSPARQLSUT
│   │   ├── envvars_jenageosparql.log
│   │   └── logCreateRepo_Scal10K_1M_JenaGeoSPARQL.log
│   ├── RDF4JSUT
│   │   ├── Lucene
│   │   └── NoLucene
│   ├── StrabonSUT
│   │   ├── envvars_strabon.log
│   │   └── StrabonLoader
│   └── VirtuosoSUT
│       ├── envvars_virtuoso.log
│       └── logCreateRepos_Scal10K_1M_Virtuoso.log
```

#### benchmark_results/ExperimentResults 
This folder contains the _results_ and _statistics_ generated in the default 
location (filesystem) by the **experiment run script**.
```
├── ExperimentResults
│   ├── GraphDBSUT
│   │   ├── GeoSPARQL_Quad_11_Func
│   │   ├── GeoSPARQL_Quad_11_Pred
│   │   └── NoGeoSPARQL
│   ├── JenaGeoSPARQLSUT
│   │   ├── 2025-04-26_JenaGeoSPARQL_RunWL_Scal100K
│   │   ├── 2025-04-26_JenaGeoSPARQL_RunWL_Scal10K
│   │   └── 2025-04-26_JenaGeoSPARQL_RunWL_Scal1M
│   ├── RDF4JSUT
│   │   ├── Lucene
│   │   └── NoLucene
│   ├── StrabonSUT
│   │   ├── 2025-05-04_StrabonSUT_RunWL_Scal100K
│   │   ├── 2025-05-04_StrabonSUT_RunWL_Scal10K
│   │   └── 2025-05-04_StrabonSUT_RunWL_Scal1M
│   └── VirtuosoSUT
│       ├── 2025-04-27_VirtuosoSUT_RunWL_Scal100K
│       ├── 2025-04-27_VirtuosoSUT_RunWL_Scal10K
│       └── 2025-04-27_VirtuosoSUT_RunWL_Scal1M
```

#### benchmark_results/ExperimentRun
This folder contains the logs produced by the **experiment run script**.
```
├── ExperimentRun
│   ├── GraphDBSUT
│   │   ├── GeoSPARQL_Quad_11_Func
│   │   ├── GeoSPARQL_Quad_11_Pred
│   │   └── NoGeoSPARQL
│   ├── JenaGeoSPARQLSUT
│   │   ├── RunWLJenaGeoSPARQLExp_Scal100K.log
│   │   ├── RunWLJenaGeoSPARQLExp_Scal10K.log
│   │   └── RunWLJenaGeoSPARQLExp_Scal1M.log
│   ├── RDF4JSUT
│   │   ├── Lucene
│   │   └── NoLucene
│   ├── StrabonSUT
│   │   ├── RunWLStrabonExp_Scal100K.log
│   │   ├── RunWLStrabonExp_Scal10K.log
│   │   └── RunWLStrabonExp_Scal1M.log
│   └── VirtuosoSUT
│       ├── RunWLVirtuosoExp_Scal100K.log
│       ├── RunWLVirtuosoExp_Scal10K.log
│       └── RunWLVirtuosoExp_Scal1M.log
```

#### benchmark_results/Charts
This folder contains the charts created based on the results. For each 
one of the three queries (SC1, SC2, SC3) there is one chart for COLD
and one with WARM caches, a total of 6 charts. The response time axis
is in logarithmic scale.
```
├── Charts
│   ├── SC1_COLD.png
│   ├── SC1_WARM.png
│   ├── SC2_COLD.png
│   ├── SC2_WARM.png
│   ├── SC3_COLD.png
│   └── SC3_WARM.png
```
