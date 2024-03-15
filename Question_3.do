* Clear existing data
clear

set seed 123

* Set the number of observations
local N = 100

* Initialize sum of correlations
scalar sum_corr = 0

* Generate random x-values spanning both positive and negative values
set obs `N'
gen x = .
gen y = .

* Loop for 10000 times to calculate correlation and add it to sum
forval i = 1/10000 {
    * Generate random x-values spanning both positive and negative values
    replace x = 20 * (runiform() - 0.5)  // Values ranging from -10 to 10

    * Sort the data by x
    sort x

    * Compute y-values using a quadratic function (e.g., y = x^2)
    replace y = x^2

    * Calculate correlation between x and y
    corr x y 
    scalar sum_corr = sum_corr + r(rho)
}

* Calculate average correlation
scalar avg_corr = sum_corr / 10000

* Display the average correlation
display "Average correlation: " avg_corr

