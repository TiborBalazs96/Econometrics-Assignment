* Step 1: Set up variables and initialize empty matrix to store results
clear
set seed 12345  // Setting seed for reproducibility
matrix results = J(100, 1, .) // Matrix to store correlation coefficients

* Step 2: Run Monte Carlo simulation
forval i = 1/100 {
    clear
    set obs 100 // Setting sample size
    set seed `i' // Setting a different seed for each iteration
    
    gen stress_level = rnormal(5, 2)
    gen time_spent_on_social_media = 2 + (0.5 * stress_level) + rnormal(0, 0.5)
    gen academic_performance = 90 - (2 * stress_level) + rnormal(0, 2)
    
    correlate time_spent_on_social_media academic_performance // Calculating correlation coefficient
    matrix results[`i', 1] = r(rho) // Storing result in matrix
}

* Step 3: Extract correlation coefficients from the matrix
matrix colnames results = "Correlation"
matrix list results

* Step 4: Convert the matrix to a dataset and generate a variable
svmat results, names(col)
*gen Correlation = col1

* Step 5: Plot the histogram
histogram Correlation, title(Correlation Coefficients Distribution) ///
    xtitle(Correlation Coefficient) ytitle(Frequency) ///
    name(hist_corr) 

* Step 6: Save the plot
graph export "correlation_coefficients_histogram.png", replace

* Run a regression of academic performance on time spent on social media including stress levels as a control variable

reg academic_performance time_spent_on_social_media stress_level