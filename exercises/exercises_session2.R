# Packages ----
# remember to install the packages (if necessary) before loading them with library()
library(rstatix)
library(dplyr)



## 1. Exercise Solution -----
# Load the survey data and assign it to a dataframe object named `df` (if not done so already)
df <- read.table(file = "data/raw/student_experiment.csv", 
                 sep = ";", 
                 header = TRUE)
# Hint: you may need to adapt this to your working directory file path


# How many rows and columns does `df` contain?

# as always: there are many options
# either read from the environment or
str(df)   # or
View(df)  # or
dim(df)   # or
ncol(df)  # and
nrow(df)

# Calculate simple summary statistics for the `df`
# have simple summary stats with base R
summary(df$r_experience)

# Calculate the standard error for the variable `shoesize`


# option 1: base R
sd_1 <- sd(df$shoesize)
n_1  <- length(df$shoesize)
se_1 <- sd/sqrt(n)


# option 2: rstatix
# get standard error by specifying the type = "full" in the rstatix function
summary <- rstatix::get_summary_stats(data = df, 
                                      shoesize, 
                                      type = "full")
sd_2 <- summary$sd[1]
n_2  <- summary$n[1]
se_2 <- sd_2/sqrt(n_2)




## 2. Exercise Solution -----

# Build a new dataframe called `df_demographics` that contains just the demographic information from our survey data
df_demographics <- df %>% select(age, gender, education)

# Rename the `gender` column to `sex` column in this dataframe

# option 1:
df <- rename(.data = df,
             sex = gender)
names(df) # check result

# option 2:
names(df)[names(df) == 'gender'] <- 'sex'



# Calculate the mean age by sex in this dataframe

# option 1: with %>%
mean_age_gender_1 <- df %>% 
  group_by(sex) %>% 
  summarise(mean_age = mean(age))

# option 2: base R
mean_age_gender_2  <- summarize(.data = group_by(.data = df, sex), mean_age = mean(age))

# check whether both options lead to same result
mean_age_gender_1 == mean_age_gender_2


# What if we want this to be more understandable for the reader?
# Rename the condition, e.g., 

# option 1
df$sex <- ifelse(test = df$sex == 1, 
                 yes  = "male", 
                 no   = "female") # or

# option 2
df$sex[df$sex == 1] <- "male"   # and
df$sex[df$sex == 0] <- "female" # or

# option 3
df %>% mutate(sex=recode(sex, 
                         `1` = "male",
                         `2` = "female")
              )



# Calculate the logarithmic rent of all male participants of the AIBS course and store it in a column named `log_rent`

# option 1: tidyverse
df_log <- df %>% 
  filter(sex == "male" & education == 2) %>% 
  mutate(log_rent = log(rent))
names(df_log) # check whether `log_rent` appears


# option 2: base R
log_rent <- log(df[df$sex == 'male' & df$education == 2, 'rent'])
df_log   <- cbind(df[df$sex == 'male' & df$education == 2, ],
                  log_rent)
names(df_log) # check whether `log_rent` appears


## 3. Exercise Solution -----

# Perform a Multiple Linear Regression: Regress `rent` on `height` and `shoesize`
lm(rent ~ height + shoesize, 
   data = df) %>%
  summary()



#  Calculate the mean difference between `r_experience` by `education`

# option 1: base R
mean(df[df$education==1, 'r_experience']) - mean(df[df$education==2, 'r_experience'])

# option 2: base R
mean(df[df$education==1,]$r_experience) - mean(df[df$education==2,]$r_experience)

# option 3: tidyverse
mean_rexp_class <- df %>% 
  group_by(education) %>% 
  summarise(mean_rexp = mean(r_experience))
mean_rexp_class[[1,2]]-mean_rexp_class[[2,2]]

# option 4: regression (OLS)
lm(r_experience ~ education, # the education coefficient describes the difference
   data = df)


# Now, perform a t-test
t_test_rexp <- t.test(r_experience ~ education, 
                      data = df)


# Do `r_experience` and `interest_data` correlate
cor(df$r_experience, df$interest_data)
cor.test(df$r_experience, df$interest_data)


