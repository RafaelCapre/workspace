#nodetool 
nodetool status > status
nodetool info > info
nodetool cfstats > cfstats
nodetool compactionstats > compactionstats
nodetool describecluster > describecluster
nodetool gossipinfo > gossipinfo
nodetool proxyhistograms > proxyhistograms
nodetool netstats > netstats
nodetool tpstats > tpstats
dsetool ring > ring

## Java Version
java -version > java-version.txt

## List All Keyspaces
cqlsh -e "DESC KEYSPACES" |perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' | sed '/^$/d' > Keyspace_name_schema.cql