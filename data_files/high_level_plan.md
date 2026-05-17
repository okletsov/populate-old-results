### Purpose
Populate mariadb_prod database with missing contest results from prior years.
It'll be done by generating INSERT SQL queries based on the database schema inspection and csv files

### ✅ COMPLETED Phase 1: Populate missing Usernames
1. Retreive all usernames from data_files
2. Compare them to what already exists in the database in user and user_nickname tables 
3. Add missing usernames

### Phase 2: Create missing contests:
Note: reference Test_AddSeasonalContest.java file for existing logic
1. Seasonal
2. Month 1 (if exists)
3. Month 2 (if exists)
4. Never create annual contest and a link between annual and seasonal contests
5. All contests must be inserted in an inactive state
6. Do not link annual and seasonal contests
7. Do not add a background job execution

### Phase 3: Link participants to contests
Note: reference Test_Participants.java file for existing logic
1. Inspect contest results located in data_files for a given contest
2. Add an entrance_fee amount to the cr_finance table for each participant
3. Add an offset amount that equals to the entrance fee amount to the finance_offset_table with finance_actoun_id=14 
4. Add a user-contest link to user_seasonal_contest_participation table
5. Do not add a background job execution
6. Do not execute addUser logic
7. Do not attempt to update user_nickname.portal_id

*For all phases that follow*: 
- reference Test_EndContest for existing logic
- reference award_rules data in data_files folder to calculate award distribution
- award_rules.csv lists percentage value for each nomination and take precedence over the java code in Test_EndContest file

### Phase 3: Insert cr_general data
1. Inspect contest results located in data_files for a given contest
2. Insert contest results data for each participant for seasonal contest
3. If montly contest results exist in data_files:
    1. Insert month 1 contest results
    2. Insert month 2 contest results 

### Phase 4: Insert cr_winning_strick and cr_general data 
1. Inspect contest results located in data_files for a given contest
2. Insert cr_winning_strick and cr_biggest_odds records

### Phase 5: Insert cr_finance data
1. Insert awards for seasonal contest
2. If montly contest results exist in data_files:
    1. Insert awards for month 1 contest
    2. Insert awards for month 2 contest
3. Insert awards for biggest odds
4. Insert awards for winning streak
5. Do not add a background job execution
6. For each award add an offset amount that equals to the award amount to the finance_offset_table with finance_actoun_id=13
7. Award ids can be found in the finance_actions table
8. For the odds column individual nicknames may be separated with dashes to indicate several winners in this nomination
