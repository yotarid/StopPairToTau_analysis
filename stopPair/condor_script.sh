#!/bin/sh

DIR="/nfs/dust/cms/user/yotarid/SUSY/CMSSW_10_5_0/src/StopPairToTau_analysis/stopPair"

cd $DIR

export SCRAM_ARCH=slc6_amd64_gcc530
export CPATH=$CPATH:$DIR

# Proxy path must be common to all nodes
# Default path is /tmp/, but thatis not common for all nodes
export X509_USER_PROXY=/nfs/dust/cms/user/yotarid/proxies/x509up_u35340

source /cvmfs/cms.cern.ch/cmsset_default.sh

module use -a /afs/desy.de/group/cms/modulefiles/ 
module load cmssw
eval cmsenv

#echo "Creating voms-proxy..."
#eval vpxy
echo "Proxy info:"
voms-proxy-info -all
echo ""

if ./compile.sh ch @infile@ ; then
    ./@exe@
else
    echo "Compilation failed."
fi
