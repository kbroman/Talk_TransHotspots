## library(devtools)
## load_all("~/Project/R-pkg/qtlpvl")
library(qtlpvl)
library(qtl)
library(lineup)

folder <- "../TransBandsPaper/Data/"
para <- "lod_10.transcM_10.windowcM_10.count_50"
load(paste0(folder, "transbands.", para, "-sep.RData"))
load(paste0(folder, "test1vs2.", para, "-sep.RData"))
load(paste0(folder, "transbands.pvalue.nsimu_1000.RData"))
load(paste0(folder, "f2g.calc.RData"))
map <- pull.map(f2g)

pdf("../Figs/plot_all.pdf", width=11, height=8.5)
par(mfcol=c(2,3))
par(oma=c(0,0,2,0)+3)
bn <- rownames(info.all)

# sort by LODdiff
LODdiff <- rep(0, nrow(info.all))
for(i in seq(along=bn)) {
    s <- bn[i]
    LODdiff[i] <- get(paste0("test1vs2.", s))$LODdiff
}
names(LODdiff) <- bn

for(i in rev(order(LODdiff))) {
  s <- bn[i]
  result <- get(paste0("test1vs2.", s))
  main <- paste0(s, " pvalue=", info.all[s, "pvalue"])
  transband <- get(paste0("transband.", s))
  Y <- attr(transband, "Y")
  geno <- attr(transband, "geno")
  nonrecomb <- attr(transband, "nonrecomb")
  out <- attr(transband, "out")
  chr <- attr(transband, "info")$chr

  par(mar=c(3,3,2,2))
  plottrans.LDA(Y, geno, nonrecomb, main="")
  plottrans.PCA(Y, geno, nonrecomb, main="")

  par(mar=c(3,3,3.5,2), las=1)
  plotLODsign(maxPOS=out$pos, LODsign=sign(out$eff.a)*out$lod1, map=map[[chr]],
              main="signed LOD")
  plotGenetpattern(a=out$eff.a, d=out$eff.d, main="Inheritance Pattern")

  plot(result, main="LOD profile")
  plottrace(result, main="LOD diff by cut point", xlab="cut point")
  title(main, outer=TRUE, line=1)
}
dev.off()
