# script to login on Synapse in R (can access TCGA data without having to download it)
# need to create an account at Synapse first


require(synapseClient)
require(gplots)
require(BHC)

synapseLogin()

# enter username and password
