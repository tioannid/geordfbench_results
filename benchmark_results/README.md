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
	├── runGraphDB_GeoSPARQL_Scal10M_Pred.sh
	├── runGraphDB_GeoSPARQL_Scal10M.sh
	├── runGraphDB_Scal10K_1M.sh
	├── runGraphDB_Scal10M.sh
	├── runJenaGeoSPARQLScal10K_1M.sh
	├── runJenaGeoSPARQLScal10M.sh
	├── runRDF4J_Lucene_Scal10K_1M.sh
	├── runRDF4J_Lucene_Scal10M.sh
	├── runRDF4J_Scal10K_1M.sh
	├── runRDF4J_Scal10M.sh
	├── runStrabonJDK8_Scal10K_1M.sh
	├── runStrabonJDK8_Scal10M.sh
	├── runVirtuoso_Scal10K_1M.sh
	└── runVirtuoso_Scal10M.sh
```

#### benchmark_results/RepoCreation
This folder contains:
- The _environment variables_ as set by the **environment preparation 
scrip** and recorded by the **print environment script** of each system configuration
variant. 
- The logs produced by the **repository generation wrapper script** of each system 
configuration variant
```
└── RepoCreation/
	├── GraphDBSUT
	│   ├── GeoSPARQL_Quad_11_Func
	│   ├── GeoSPARQL_Quad_11_Pred
	│   └── NoGeoSPARQL
	├── JenaGeoSPARQLSUT
	│   ├── envvars_jenageosparql_10M.log
	│   ├── envvars_jenageosparql.log
	│   ├── logCreateRepo_Scal10K_1M_JenaGeoSPARQL.log
	│   └── logCreateRepo_Scal10M_JenaGeoSPARQL.log
	├── RDF4JSUT
	│   ├── Lucene
	│   └── NoLucene
	├── StrabonSUT
	│   ├── envvars_strabon.log
	│   └── StrabonLoader
	└── VirtuosoSUT
		 ├── envvars_virtuoso_10M.log
		 ├── envvars_virtuoso.log
		 ├── logCreateRepos_Scal10K_1M_Virtuoso.log
		 └── logCreateRepos_Scal10M_Virtuoso.logs
```

#### benchmark_results/ExperimentResults 
This folder contains the _results_ and _statistics_ generated in the default 
location (filesystem) by the **experiment run script**.
```
└── ExperimentResults/
	├── GraphDBSUT
	│   ├── GeoSPARQL_Quad_11_Func
	│   │   ├── 2025-04-28_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal100K
	│   │   ├── 2025-04-28_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal10K
	│   │   ├── 2025-04-28_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal1M
	│   │   └── 2025-12-13_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal10M
	│   ├── GeoSPARQL_Quad_11_Pred
	│   │   ├── 2025-04-28_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal100K_Pred
	│   │   ├── 2025-04-28_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal10K_Pred
	│   │   ├── 2025-04-28_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal1M_Pred
	│   │   └── 2025-12-13_GraphDBSUT_GeoSPARQL_Enabled_Quad_11_RunWL_Scal10M_Pred
	│   └── NoGeoSPARQL
	│       ├── 2025-04-26_GraphDBSUT_RunWL_Scal100K
	│       ├── 2025-04-26_GraphDBSUT_RunWL_Scal10K
	│       ├── 2025-04-26_GraphDBSUT_RunWL_Scal1M
	│       └── 2025-12-13_GraphDBSUT_RunWL_Scal10M
	├── JenaGeoSPARQLSUT
	│   ├── 2025-04-26_JenaGeoSPARQL_RunWL_Scal100K
	│   ├── 2025-04-26_JenaGeoSPARQL_RunWL_Scal10K
	│   ├── 2025-04-26_JenaGeoSPARQL_RunWL_Scal1M
	│   └── 2025-12-13_JenaGeoSPARQL_RunWL_Scal10M
	├── RDF4JSUT
	│   ├── Lucene
	│   │   ├── 2025-04-28_RDF4JSUT_Lucene_RunWL_Scal100K
	│   │   ├── 2025-04-28_RDF4JSUT_Lucene_RunWL_Scal10K
	│   │   ├── 2025-04-28_RDF4JSUT_Lucene_RunWL_Scal1M
	│   │   └── 2025-12-12_RDF4JSUT_Lucene_RunWL_Scal10M
	│   └── NoLucene
	│       ├── 2025-04-26_RDF4JSUT_RunWL_Scal100K
	│       ├── 2025-04-26_RDF4JSUT_RunWL_Scal10K
	│       ├── 2025-04-26_RDF4JSUT_RunWL_Scal1M
	│       └── 2025-12-12_RDF4JSUT_RunWL_Scal10M
	├── StrabonSUT
	│   ├── 2025-05-04_StrabonSUT_RunWL_Scal100K
	│   ├── 2025-05-04_StrabonSUT_RunWL_Scal10K
	│   ├── 2025-05-04_StrabonSUT_RunWL_Scal1M
	│   └── 2025-12-14_StrabonSUT_RunWL_Scal10M
	└── VirtuosoSUT
		 ├── 2025-04-27_VirtuosoSUT_RunWL_Scal100K
		 ├── 2025-04-27_VirtuosoSUT_RunWL_Scal10K
		 ├── 2025-04-27_VirtuosoSUT_RunWL_Scal1M
		 └── 2025-12-14_VirtuosoSUT_RunWL_Scal10M
```

#### benchmark_results/ExperimentRun
This folder contains the logs produced by the **experiment run script**.
```
└──ExperimentRun/
	├── GraphDBSUT
	│   ├── GeoSPARQL_Quad_11_Func
	│   │   ├── RunWLGraphDB_GeoSPARQL_Enabled_Quad_11Exp_Scal100K.log
	│   │   ├── RunWLGraphDB_GeoSPARQL_Enabled_Quad_11Exp_Scal10K.log
	│   │   ├── RunWLGraphDB_GeoSPARQL_Enabled_Quad_11Exp_Scal1M.log
	│   │   └── RunWLGraphD_GeoSPARQL_Enabled_Quad_11Exp_Scal10M.log
	│   ├── GeoSPARQL_Quad_11_Pred
	│   │   ├── RunWLGraphDB_GeoSPARQL_Enabled_Quad_11Exp_Scal100K_Pred.log
	│   │   ├── RunWLGraphDB_GeoSPARQL_Enabled_Quad_11Exp_Scal10K_Pred.log
	│   │   ├── RunWLGraphDB_GeoSPARQL_Enabled_Quad_11Exp_Scal1M_Pred.log
	│   │   └── RunWLGraphD_GeoSPARQL_Enabled_Quad_11Exp_Scal10M_Pred.log
	│   └── NoGeoSPARQL
	│       ├── RunWLGraphDBExp_Scal100K.log
	│       ├── RunWLGraphDBExp_Scal10K.log
	│       ├── RunWLGraphDBExp_Scal10M.log
	│       └── RunWLGraphDBExp_Scal1M.log
	├── JenaGeoSPARQLSUT
	│   ├── RunWLJenaGeoSPARQLExp_Scal100K.log
	│   ├── RunWLJenaGeoSPARQLExp_Scal10K.log
	│   ├── RunWLJenaGeoSPARQLExp_Scal10M.log
	│   └── RunWLJenaGeoSPARQLExp_Scal1M.log
	├── RDF4JSUT
	│   ├── Lucene
	│   │   ├── RunWLRDF4J_LuceneExp_Scal100K.log
	│   │   ├── RunWLRDF4J_LuceneExp_Scal10K.log
	│   │   ├── RunWLRDF4J_LuceneExp_Scal10M.log
	│   │   └── RunWLRDF4J_LuceneExp_Scal1M.log
	│   └── NoLucene
	│       ├── RunWLRDF4JExp_Scal100K.log
	│       ├── RunWLRDF4JExp_Scal10K.log
	│       ├── RunWLRDF4JExp_Scal10M.log
	│       └── RunWLRDF4JExp_Scal1M.log
	├── StrabonSUT
	│   ├── RunWLStrabonExp_Scal100K.log
	│   ├── RunWLStrabonExp_Scal10K.log
	│   ├── RunWLStrabonExp_Scal10M.log
	│   └── RunWLStrabonExp_Scal1M.log
	└── VirtuosoSUT
		 ├── RunWLVirtuosoExp_Scal100K.log
		 ├── RunWLVirtuosoExp_Scal10K.log
		 ├── RunWLVirtuosoExp_Scal10M.log
		 └── RunWLVirtuosoExp_Scal1M.log
```

#### benchmark_results/Charts
This folder contains the charts created based on the results. For each 
one of the three queries (SC1, SC2, SC3) there is one chart for COLD
and one with WARM caches, a total of 6 charts. The response time axis
is in logarithmic scale.
```
└──Charts/
	├── EPS
	│   ├── SC1_COLD.eps
	│   ├── SC1_WARM.eps
	│   ├── SC2_COLD.eps
	│   ├── SC2_WARM.eps
	│   ├── SC3_COLD.eps
	│   └── SC3_WARM.eps
	└── PNG
		 ├── Charts for 10K_1M only
		 ├── SC1_COLD.png
		 ├── SC1_WARM.png
		 ├── SC2_COLD.png
		 ├── SC2_WARM.png
		 ├── SC3_COLD.png
		 └── SC3_WARM.png
```

#### benchmark_results/geordfbench_postgresql_backup/
This folder contains a backup of the PostgreSQL database schema which 
was used as the report sink for all experiment results. The tool used for 
the export was pg_dump.

#### benchmark_results/ExperimentDetailsAndResults.ods
This the spreadsheet where all the data from the PostgreSQL database
were exported, processed. Final results are in various sheets and 
the corresponding charts are also embedded. These charts have been
exported as PNG (raster) and EPS (vector) image formats as shown
above in the  benchmark_results/Charts folder.

#### benchmark_results/BeautifyResults.sql
This SQL script contains the SQL query which produced the data
exported to the benchmark_results/ExperimentDetailsAndResults.ods
workbook.
