R_opt = --no-save --no-restore --no-site-file --no-init-file  ## --no-environ
STEM = trans_eqtl_hotspot

trans_eqtl_hotspots.pdf: trans_eqtl_hotspots.tex Figs/plot-eqtl.pdf Figs/chr6_lod.pdf Figs/islet_c6_pca.pdf Figs/islet_c6_geno_C.pdf Figs/ldapca_islet6.pdf Figs/effects_islet6.pdf Figs/formal_islet6.pdf header.tex Figs/intercross.png
	xelatex $<

trans_eqtl_hotspots_withnotes.tex: trans_eqtl_hotspots.tex
	Ruby/createVersionWithNotes.rb $<

trans_eqtl_hotspots_withnotes.pdf: trans_eqtl_hotspots_withnotes.tex
	xelatex $<
	pdfnup $@ --nup 1x2 --no-landscape --paper letterpaper --frame true --scale 0.9
	mv trans_eqtl_hotspots_withnotes-nup.pdf $@

notes: trans_eqtl_hotspots_withnotes.pdf

Figs/plot-eqtl.pdf: R/plot-eqtl.R R/my_ploteQTL.R
	cd $(<D); R CMD BATCH $(R_opt) $(<F)

Figs/chr6_lod.pdf: R/chr6_lod.R
	cd $(<D); R CMD BATCH $(R_opt) $(<F)

Figs/islet_c6_pca.pdf: R/islet_c6_pca.R
	cd $(<D); R CMD BATCH $(R_opt) $(<F)

Figs/islet_c6_geno_C.pdf: R/islet_c6_geno.R R/myplotgeno.R
	cd $(<D); R CMD BATCH $(R_opt) $(<F)

Figs/ldapca_islet6.pdf: R/lda_pca.R R/my_plottrans.R
	cd R;R CMD BATCH $(<F)

Figs/effects_islet6.pdf: R/effects.R R/my_plotGenetpattern.R
	cd R;R CMD BATCH $(<F)

Figs/formal_islet6.pdf: R/formal.R R/my_plot_formal.R
	cd R;R CMD BATCH $(<F)

Figs/intercross.png: R/intercross.R
	cd R;R CMD BATCH $(<F)

web: trans_eqtl_hotspots.pdf trans_eqtl_hotspots_withnotes.pdf
	scp trans_eqtl_hotspots.pdf broman-10.biostat.wisc.edu:Website/presentations/cornell2016.pdf
	scp trans_eqtl_hotspots_withnotes.pdf broman-10.biostat.wisc.edu:Website/presentations/cornell2016_withnotes.pdf
