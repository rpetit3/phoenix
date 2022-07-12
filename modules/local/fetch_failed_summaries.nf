process FETCH_FAILED_SUMMARIES {
    label 'process_low'

    input:
    path(directory)
    path(failed_summaries)
    path(summaries)

    output:
    path('*_summaryline.tsv'), emit: spades_failure_summary_line

    script:
    """
    for file in ${directory}/*/*_summaryline_failure.tsv; do 
        if grep -q SPAdes_Failure "\$file"; then
            fname=\$(basename \$file _summaryline_failure.tsv)
            cp \$file \${fname}_summaryline.tsv
            mv \$file ${directory}/\${fname}/\${fname}_summaryline.tsv
        fi
    done 
    """
}