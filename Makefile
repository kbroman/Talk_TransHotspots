all: jax_transbands.pdf Figs/plot_all.pdf Figs/plot_all_bychr.pdf

jax_transbands.pdf: jax_transbands.tex Figs/ldapca_islet6.pdf Figs/effects_islet6.pdf Figs/formal_islet6.pdf
	xelatex $<

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
