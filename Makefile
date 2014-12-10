all: move rmd2md

move:
		cp inst/vign/musemeta_vignette.md vignettes

rmd2md:
		cd vignettes;\
		mv musemeta_vignette.md musemeta_vignette.Rmd
