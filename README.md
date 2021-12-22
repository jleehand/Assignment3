# Assignment3

### Dataset

The dataset that is processed by this script are the UCI HAR Dataset available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

### Transformation

The data is processed by the `run_analysis.R` file in the following pipeline using the `dplyr` library:
1. The training and test data for measurements, activities and subjects are read in.
2. Each training and test set is joined for each type of data with the training set coming first, and the test set second.
3. The `features.txt` file is read to find the labels for each of the quantitative measurements and the mean() and stddev() measurements are found. These are then used to filter the quatitative measurements such that only the means and standard deviation measurements are kept.
4. These measurements from (3) are then joined to the subject and activity vectors and this is written to the `activity_measurement.csv` file
5. The result from (4) is then grouped on the subject and activity, and all other columns are averaged over these subsets. The result of this is written to the `mean_activity_measurement.csv` file.
