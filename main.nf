process run_hcl {

    tag "HCL process"
    publishDir "${params.output_dir}/observation_clusters", mode:"copy", pattern:"obs.tsv"
    publishDir "${params.output_dir}/feature_clusters", mode:"copy", pattern:"feat.tsv"
    container "ghcr.io/web-mev/mev-hcl:sha-1363f29ed25a8f4e907407609015091530f813ec"
    cpus 2
    memory '8 GB'

    input:
        path(input_file)

    output:
        path("obs.tsv")
        path("feat.tsv")
    script:
        """
        echo "{}" > obs.tsv
        echo "{}" > feat.tsv
        python3 /usr/local/bin/run_hcl.py -i ${input_file} \
            -d ${params.distance_metric} \
            -l ${params.linkage} \
            -c ${params.clustering_dimension} \
            -o obs.tsv \
            -f feat.tsv
        """
}

workflow {

    run_hcl(params.input_matrix)

}
