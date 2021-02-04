# 2.05 Activity 1

(*Some of the file names are not matching since the same exercises fall on different days in FT and PT bootcamp.*)

Keep working on the `bank` database. (_In case you need to load data again, refer to `files_for_lessons_and_activities` to get the database._)

#### Simple queries

1. Select districts and salaries (from the `district` table) where salary is greater than 10000. Return columns as `district_name` and `average_salary`.
2. Select those loans whose contract finished and were not paid. **Hint**: You should be looking at the `loan` column and you will need the extended case study information to tell you which value of status is required.
3. Select cards of type `junior`. Return just first 10 in your query.
4. Select those loans whose contract finished and not paid back. Return the debt value from the status you identified in the last activity, together with loan id and account id.
5. Calculate the urban population for all districts. Hint: You are looking for the number of inhabitants and the % of urban inhabitants in each district. Return columns as district_name and urban_population.
6. On the previous query result - rerun it but filtering out districts where the rural population is greater than 50%.
