# Calculate TPM (transcript per million)
#
# counts = table with raw counts per ID for each sample
# lengths = table with gene lengths for each ID 

tpm <- function(counts, lengths) {
  rate <- counts / lengths
  rate / sum(rate) * 1e6
}

tpms <- apply(counts, 2, function(x) tpm(x, lengths$gene_length))


