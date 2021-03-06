# BGSE DATA SCIENCE MASTER PROGRAM 2016-17
# COMPUTING PROJECT - 1st TERM
# SORT DATA & KICK ASSES - K.W. L.R. A.B.

# SELECTION OF WORKING INPUT DATA

rm(list = ls())
library(dplyr)

# create a connection with the DB
db.npo <- dbConnect(MySQL(), user='alfonso', password = '1317', dbname = 'db_npo', host = '127.0.0.1')
on.exit(dbDisconnect(db.npo))

# work.path = "/Users/Laura/Desktop/2013"

work.path <- "C:/ALFONSO/WORK/GSE/14D003/dataset/PF/"
setwd(work.path)

file.list <- list.files(pattern="*.csv")
short.names <- paste0('form_', str_sub(file.list, -13, -4))

# process the whole batch of csv files to obtain df.total
df.total <- data.frame()
for (f in 1:length(file.list)) {
  
  # read one csv file
  df <- data.frame()
  df <- (read.csv(paste0(work.path, file.list[f])))
  
  # select columns
  df <- select(df, EIN, ZIP, FNDNCD, RULEDATE, ACCPER, DEDUCTCD, EOSTATUS, FRCD, tax_pd, FisYr, eostat, tax_yr, operatingcd, fairmrktvalamt, grscontrgifts, schedbind, intrstrvnue, dividndsamt, grsrents, grsslspramt, costsold, grsprofitbus, otherincamt, totrcptperbks, compofficers, pensplemplbenf, legalfeesamt, accountingfees, interestamt, depreciationamt, occupancyamt, travlconfmtngs, printingpubl, topradmnexpnsa, contrpdpbks, totexpnspbks, excessrcpts, totrcptnetinc, topradmnexpnsb, totexpnsnetinc, netinvstinc, trcptadjnetinc, totexpnsadjnet, adjnetinc, topradmnexpnsd, totexpnsexempt, othrcashamt, invstgovtoblig, invstcorpstk, invstcorpbnd, totinvstsec, mrtgloans, othrinvstend, othrassetseoy, totassetsend, mrtgnotespay, othrliabltseoy, totliabend, tfundnworth, fairmrktvaleoy, totexcapgnls, totexcapgn, totexcapls, invstexcisetx, sec4940notxcd, sec4940redtxcd, sect511tx, subtitleatx, totaxpyr, esttaxcr, txwithldsrc, txpaidf2758, erronbkupwthld, estpnlty, taxdue, overpay, crelamt, infleg, actnotpr, chgnprvrptcd, filedf990tcd, contractncd, furnishcpycd, claimstatcd, cntrbtrstxyrcd, acqdrindrintcd, orgcmplypubcd, filedlf1041ind, propexchcd, brwlndmnycd, furngoodscd, paidcmpncd, transfercd, agremkpaycd, exceptactsind, prioractvcd, undistrinccd, applyprovind, dirindirintcd, excesshldcd, invstjexmptcd, prevjexmptcd, propgndacd, ipubelectcd, grntindivcd, nchrtygrntcd, nreligiouscd, excptransind, rfprsnlbnftind, pyprsnlbnftind, tfairmrktunuse, valncharitassets, cmpmininvstret, distribamt, undistribincyr, adjnetinccola, adjnetinccolb, adjnetinccolc, adjnetinccold, adjnetinctot, qlfydistriba, qlfydistribb, qlfydistribc, qlfydistribd, qlfydistribtot, valassetscola, valassetscolb, valassetscolc, valassetscold, valassetstot, qlfyasseta, qlfyassetb, qlfyassetc, qlfyassetd, qlfyassettot, endwmntscola, endwmntscolb, endwmntscolc, endwmntscold, endwmntstot, totsuprtcola, totsuprtcolb, totsuprtcolc, totsuprtcold, totsuprttot, pubsuprtcola, pubsuprtcolb, pubsuprtcolc, pubsuprtcold, pubsuprttot, grsinvstinca, grsinvstincb, grsinvstincc, grsinvstincd, grsinvstinctot, grntapprvfut, progsrvcacold, progsrvcacole, progsrvcbcold, progsrvcbcole, progsrvcccold, progsrvcccole, progsrvcdcold, progsrvcdcole, progsrvcecold, progsrvcecole, progsrvcfcold, progsrvcfcole, progsrvcgcold, progsrvcgcole, membershpduesd, membershpduese, intonsvngsd, intonsvngse, dvdndsintd, dvdndsinte, trnsfrcashcd, trnsothasstscd, salesasstscd, prchsasstscd, rentlsfacltscd, reimbrsmntscd, loansguarcd, perfservicescd, sharngasstscd)
  df["ZIP"] <- substr(df["ZIP"], 1, 5) # eliminate sub-zip codes

  # add each file to the final result
  df.total <- rbind.data.frame(df.total, df)
}  

# write the result onto a csv file
write.table(df.total, file = "C:/ALFONSO/WORK/GSE/14D003/form_PF_total.csv", row.names = F, col.names = T)
