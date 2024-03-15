clear
set seed 123
set obs 365
gen day = _n
gen temperature = sin(day/58.1) + rnormal(0, 0.5)
gen ice_cream_sales = 2 + (3 * temperature) + rnormal(0, 0.2)
gen swimming_pool_attendance = 1 + (2.5 * temperature) + rnormal(0, 0.25)
corr ice_cream_sales swimming_pool_attendance

*Identifying confounding variable
corr ice_cream_sales swimming_pool_attendance temperature

*Correlations

reg ice_cream_sales swimming_pool_attendance
reg swimming_pool_attendance ice_cream_sales

*Causality

reg ice_cream_sales temperature
reg swimming_pool_attendance temperature

*Introducing temperature as a control variable

reg ice_cream_sales swimming_pool_attendance temperature
reg swimming_pool_attendance ice_cream_sales temperature