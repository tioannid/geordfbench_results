select e.id, e.description, e.host, v.*, CASE
			-- remove the SUT from the end of GraphDBSUT and add a + to denote GeoSPARQL plugin is enabled
            WHEN e.id >= 15 AND e.id <= 17 THEN substring(v.sut, 1, (length(v.sut)-3)) || '+' 
			-- remove the SUT from the end of GraphDBSUT, add a + to denote GeoSPARQL plugin is enabled
			-- and add a P to denote that spatial predicate version of the queryset has been used
			WHEN e.id >= 18 AND e.id <= 20 THEN substring(v.sut, 1, (length(v.sut)-3)) || '+P'
			-- remove the SUT from the end of RDF4JSUT and add a + to denote Lucene spatial indexing is enabled
			WHEN e.id >= 21 AND e.id <= 23 THEN substring(v.sut, 1, (length(v.sut)-3)) || '+'
            ELSE substring(v.sut, 1, (length(v.sut)-3))
        END AS effectivesut
from vquery_ordered_aggrs_3 v, "EXPERIMENT" e
where v.experiment_id = e.id