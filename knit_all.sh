#!/bin/bash

#------------------------ Load module of interest
#module load singularity

#------------------------ Set variables
project_dir="/home/nf1/Documents/Audrey/git_hue/"
singularity_container="/home/nf1/Documents/Audrey/git_scripts/singularity/rpackages_dir/singularity_from_dir.simg"
analysis_dir="/home/nf1/Documents/Audrey/git_hue/"

export APPTAINER_BIND="${project_dir}:${project_dir}"

#------------------------ Knit

#---------- Our data
# Metadata
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/1_metadata/1_build_metadata.Rmd',
                                  output_file = '${analysis_dir}/1_metadata/1_build_metadata.html')" &&

# Sample
for sample in $(ls -d ${analysis_dir}/2_individual/input/*/)
do
    sample=$(basename $sample)
    sample=${sample%/}
    echo $sample
    singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/2_individual/1_make_individual.Rmd',
                                  output_file = '${analysis_dir}/2_individual/${sample}.html',
                                  params = list(sample_name = '${sample}'))"
done

# Combined
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/3_combined/1_combined_all.Rmd',
                                  output_file = '${analysis_dir}/3_combined/1_combined_all.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/3_combined/2_ibl_ors_markers.Rmd',
                                  output_file = '${analysis_dir}/3_combined/2_ibl_ors_markers.html')"

# Zoom
# Immune cells
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/1_zoom_immune/1_zoom_immune_dataset.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/1_zoom_immune/1_zoom_immune_dataset.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/1_zoom_immune/2_zoom_immune_analysis.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/1_zoom_immune/2_zoom_immune_analysis.html')"

# HF-SCs
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/2_zoom_hfsc/1_zoom_hfsc_dataset.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/2_zoom_hfsc/1_zoom_hfsc_dataset.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/2_zoom_hfsc/2_zoom_hfsc_analysis.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/2_zoom_hfsc/2_zoom_hfsc_analysis.html')"

# ORS and IFE basal
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/3_zoom_ors_ifeb/1_zoom_ors_ifeb_dataset.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/3_zoom_ors_ifeb/1_zoom_ors_ifeb_dataset.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/3_zoom_ors_ifeb/2_zoom_ors_ifeb_analysis.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/3_zoom_ors_ifeboom_hfsc/2_zoom_ors_ifeb_analysis.html')"

# IFE granular and spinous
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/4_zoom_ifegs/1_zoom_ifegs_dataset.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/4_zoom_ifegs/1_zoom_ifegs_dataset.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/4_zoom_ifegs/2_zoom_ifegs_analysis.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/4_zoom_ifegs/2_zoom_ifegs_analysis.html')"

# Trajectory (non matrix)
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/5_zoom_non_matrix/1_zoom_non_matrix_dataset.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/5_zoom_non_matrix/1_zoom_non_matrix_dataset.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/5_zoom_non_matrix/2_trajectory_tinga.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/5_zoom_non_matrix/2_trajectory_tinga.html')"

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/5_zoom_non_matrix/3_trajectory_slingshot.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/5_zoom_non_matrix/3_trajectory_slingshot.html')"

# Matrix cells
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/6_zoom_matrix/1_zoom_matrix_dataset.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/6_zoom_matrix/1_zoom_matrix_dataset.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/4_zoom/6_zoom_matrix/2_zoom_matrix_analysis.Rmd',
                                  output_file = '${analysis_dir}/4_zoom/6_zoom_matrix/2_zoom_matrix_analysis.html')"


#---------- Wu data
# Metadata
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/5_wu/1_metadata/1_build_metadata.Rmd',
                                  output_file = '${analysis_dir}/5_wu/1_metadata/1_build_metadata.html')" &&

# Sample
for sample in $(ls -d ${analysis_dir}/5_wu/2_individual/input/*/)
do
    sample=$(basename $sample)
    sample=${sample%/}
    echo $sample
    singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/5_wu/2_individual/1_make_individual.Rmd',
                                  output_file = '${analysis_dir}/5_wu/2_individual/${sample}.html',
                                  params = list(sample_name = '${sample}'))"
done

# Combined
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/5_wu/3_combined/1_combined_all.Rmd',
                                  output_file = '${analysis_dir}/5_wu/3_combined/1_combined_all.html')"

# ORS and IFE basal
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/5_wu/4_ibl_ors/1_zoom_ors_ifeb_dataset.Rmd',
                                  output_file = '${analysis_dir}/5_wu/4_ibl_ors/1_zoom_ors_ifeb_dataset.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/5_wu/4_ibl_ors/2_zoom_ors_ifeb_analysis.Rmd',
                                  output_file = '${analysis_dir}/5_wu/4_ibl_ors/2_zoom_ors_ifeb_analysis.html')"


#---------- Takahashi data
# Metadata
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/6_takahashi/1_metadata/1_build_metadata.Rmd',
                                  output_file = '${analysis_dir}/6_takahashi/1_metadata/1_build_metadata.html')" &&

# Sample
for sample in $(ls -d ${analysis_dir}/6_takahashi/2_individual/input/*/)
do
    sample=$(basename $sample)
    sample=${sample%/}
    echo $sample
    singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/6_takahashi/2_individual/1_make_individual.Rmd',
                                  output_file = '${analysis_dir}/6_takahashi/2_individual/${sample}.html',
                                  params = list(sample_name = '${sample}'))"
done

# Combined
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/6_takahashi/3_combined/1_combined_all.Rmd',
                                  output_file = '${analysis_dir}/6_takahashi/3_combined/1_combined_all.html')"

# ORS and IFE basal
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/6_takahashi/4_ibl_ors/1_zoom_ors_ifeb_dataset.Rmd',
                                  output_file = '${analysis_dir}/6_takahashi/4_ibl_ors/1_zoom_ors_ifeb_dataset.html')" &&

singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/6_takahashi/4_ibl_ors/2_zoom_ors_ifeb_analysis.Rmd',
                                  output_file = '${analysis_dir}/6_takahashi/4_ibl_ors/2_zoom_ors_ifeb_analysis.html')"


#---------- Combined three data
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/3_combined/2_combined_three_data.Rmd',
                                  output_file = '${analysis_dir}/3_combined/2_combined_three_data.html')"

#---------- Figures
singularity exec ${singularity_container} \
    Rscript -e "rmarkdown::render(input = '${analysis_dir}/7_figures/figures.Rmd',
                                  output_file = '${analysis_dir}/7_figures/figures.html')"

#------------------------ Unload module of interest
#module unload singularity
