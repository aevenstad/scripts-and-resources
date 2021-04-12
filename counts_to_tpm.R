# Calculate TPM (transcript per million)
#
# counts = table with raw counts per ID for each sample
# lengths = table with gene lengths for each ID 
# original link: https://gist.github.com/slowkow/6e34ccb4d1311b8fe62e

tpm <- function(counts, lengths) {
  
  # Ensure valid arguments.
  stopifnot(length(lengths) == nrow(counts))
  
  rate <- counts / lengths
  rate / sum(rate) * 1e6
}

tpms <- apply(counts, 2, function(x) tpm(x, lengths$gene_length))


