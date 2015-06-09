all: trans_eqtl_hotspots.pdf

R_opt = --no-save --no-restore --no-site-file --no-init-file  ## --no-environ

trans_eqtl_hotspots.pdf: trans_eqtl_hotspots.tex Figs/plot-eqtl.pdf Figs/chr6_lod.pdf Figs/ldapca_islet6.pdf Figs/effects_islet6.pdf Figs/formal_islet6.pdf
	xelatex $<

Figs/plot-eqtl.pdf: R/plot-eqtl.R R/my_ploteQTL.R
	cd $(<D); R CMD BATCH $(R_opt) $(<F)

Figs/chr6_lod.pdf: R/chr6_lod.R
	cd $(<D); R CMD BATCH $(R_opt) $(<F)

Figs/ldapca_islet6.pdf: R/lda_pca.R
	cd R;R CMD BATCH $(<F)

Figs/effects_islet6.pdf: R/effects.R
	cd R;R CMD BATCH $(<F)

Figs/formal_islet6.pdf: R/formal.R
	cd R;R CMD BATCH $(<F)

Figs/plot_all.pdf: R/plot_all.R
	cd R;R CMD BATCH $(<F)

Figs/plot_all_bychr.pdf: R/plot_all_bychr.R
	cd R;R CMD BATCH $(<F)
