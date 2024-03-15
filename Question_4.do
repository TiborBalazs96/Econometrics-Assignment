clear all
set scheme s2mono
set seed 1234
set obs 10000

generate ability = rnormal(1,2)
generate schooling=0.3*ability + rnormal(0,1.3)
generate earnings =-0.4*schooling + 1.2*ability+ runiform()


regress earnings schooling ability, r
regress earnings schooling, r

twoway (scatter earning schooling, mcolor(gray) msize(small) msymbol(o))||lfit (earning schooling)

regress earnings ability, r
predict earnings_res, residuals

plot earnings earnings_res

regress schooling ability
predict res_schol, residuals

plot schooling res_schol

regress earnings_res res_schol, r