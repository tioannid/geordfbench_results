# GeoRDFBench Framework Benchmark Results

[![License](https://img.shields.io/badge/license-Apache2.0-green)](./LICENSE)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15349540.svg)](https://doi.org/10.5281/zenodo.15349540)
[![Execution framework docs](https://img.shields.io/badge/docs-Execution_framework-red)](https://github.com/tioannid/geordfbench/README.md)

## Benchmark Results v2.0

### Description
#### 1. Purpose
The following experiment aimed both at studying performance characteristics of 
the SUTs but primarily exhibiting the usage of **GeoRDFBench Framework** for 
running GeoSPARQL/SPARQL benchmarks.

#### 2. Systems Under Test (SUTs)
*We were unable to run experiments with the latest __v8.2.2__ of the __Stardog__ module 
which is included with GeoRDFBench. Unfortunately, we were not provided with a 
license renewal without which experiments fail*. Therefore we used all the other 
implemented RDF modules of GeoRDFBench, but we used several configuration options
on the RDF4J and GraphDB SUTs, which effectively gave 8 system variants.

| **ExpIDs** | **ConfigName**    | **System**                   | **ConfigDesc**                  |
|:----------:|-------------------|------------------------------|---------------------------------|
|     1-3    | **RDF4J**         | RDF4J                        | v4.3.15                         |
|     4-6    | **JenaGeoSPARQL** | Jena GeoSPARQL               | v4.10.0                         |
|     7-9    | **GraphDB**       | GraphDB                      | v10.8.5                         |
|  10,11,14  | **Virtuoso**      | Virtuoso Open Server         | v7.2.14, _2D Rtree_             |
|    15-17   | **GraphDB+**      | GraphDB + _GeoSPARQL plugin_ | v10.8.5, _Quad-11_              |
|    18-20   | **GraphDB+P**     | GraphDB + _GeoSPARQL plugin_ | v10.8.5, _Quad-11, Pred_        |
|    21-23   | **RDF4J+**        | RDF4J + _Lucene Sail_        | v4.3.15, _Lucene spatial index_ |
|    31-33   | **Strabon**       | Strabon                      | 3.3.3-SNAPSHOT                  |

#### 2. Workloads

[![Scalability DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13283414.svg)](https://doi.org/10.5281/zenodo.13283414)

We chose the 10K, 100K and 1M variants of the Scalability workload where the 
respective datasets contain 10K, 100K and 1M triples. The basic characteristics 
of the datasets (e.g., features and geometries) are described in the following
table.

| **Dataset** | **\# of Features** | **\# of Points** | **\# of Lines** | **\# of Polygons** |
|------------:|-------------------:|-----------------:|----------------:|-------------------:|
|     **10K** |              1,135 |              587 |               0 |                900 |
|    **100K** |             12,166 |            6,623 |           4,239 |              2,531 |
|      **1M** |            118,161 |           46,781 |          45,238 |             29,200 |
|         10M |          1,038,739 |          317,865 |         328,630 |            427,842 |
|        100M |         10,259,959 |          904,677 |       2,058,386 |          7,553,440 |
|        500M |         48,623,878 |        5,520,767 |      15,771,932 |         23,390,220 |

All workload variants use share the same queryset which comprises three 
queries: (i) a spatial selection __SC1__, (ii) a low selectivity (heavy) spatial 
join __SC2__ and (iii) a higher selectivity (lighter) spatial join __SC3__. The
queryset has two variants: one with __spatial functions__ and one with __spatial 
predicates__.

#### 3. Benchmark framework
The experiments have been run with GeoRDFBench branch **_releases/v2.0.0_**.

#### 4. Host Hardware
The hardware platform for the experiments was an Intel NUC8i7BEH box,  
Ubuntu 22.04.5 LTS with 32GB DDR4-2400MHz, a Samsung SSD NVMe 970 EVO Plus 
500GB system disk and a secondary data disk Western Digital WDC WD20SPZX-75U 
2TB mounted on **/data**. Both filesystems **/** and **/data** 
were formatted as _'ext4'_. All SUTs and their repository data were 
intentionally placed under the slower **/data** filesystem.