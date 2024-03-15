clear
set obs 100
set seed 12345

*Generate height and weight variables following normal distribution

gen height = rnormal(175,5)
sum height

gen weight = rnormal(70,5)
sum weight

*Let's say hypothetically that the average running speed (in km/h) is determined by height and weight following the "population regression function" with a normally distributed error term with zero mean and standard deviation one km/h

gen epsilon = rnormal(0, 0.5)
gen speed = 2 + 0.1*height - 0.1*weight + epsilon
sum speed

*Regress speed on height and weight

reg speed height weight, r
predict speed_res, residuals

*twoway (scatter speed height, mcolor(gray) msize(small) msymbol(o))||lfit (speed height)
*twoway (scatter speed weight, mcolor(gray) msize(small) msymbol(o))||lfit (speed weight)

*Measurement error in the dependent variable (speed): let's assume the measurement in error in speed is normally distributed with mean zero, and standard deviation one

gen speed_err = speed + rnormal(0,1)


reg speed_err height weight, r
predict speed_err_res, residuals

sum speed_res speed_err_res

*We can see that the standard deviation of the composite error term is much larger than the standard deviation of the simple error term without measurement error.
*This leads to less accurate coefficient estimates (larger confidence intervals), however the independent variables still remain exogenous.

*Measurement error in the independent variable (height): let's assume the measuerement error in height is normally distributed with mean zero, and standard deviation 5

gen height_err = height + rnormal(0,5)

reg speed height_err weight, r
predict height_err_res, residuals

sum speed_res height_err_res

*We can see, similarly to the previous case that the standard deviation of the composite error term is again larger than the standard error of the simple error term without measuerement error, which leads to less accurate coefficient estimates. In this case, however, the exogeneity of the error term is not as clear as before. If there is no  correlation between the measurement error and the variables, then the variables are can still be considered exogenous. In contrast, in the case when the measurement error is correlated with either of the explanatory variables, then the exogeneity condition does not hold and the model cannot be consistently estimated using OLS. In this case the measurement error in height is correlated with the composite error term, therefore the model violates the exogeneity assumption.