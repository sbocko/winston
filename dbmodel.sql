use nh2096401db;

SET FOREIGN_KEY_CHECKS = 0;
drop table if exists analysis;
drop table if exists analysis_result;
drop table if exists knn_result;
drop table if exists decision_tree_result;
drop table if exists logistic_regression_result;
drop table if exists svm_result;
drop table if exists attribute;
drop table if exists dataset;
drop table if exists dmmethod;
drop table if exists dataset;
SET FOREIGN_KEY_CHECKS = 1;

show tables;

select * from dataset;
select * from attribute;
select * from analysis;
select count(*) from analysis_result;
select * from analysis_result where rmse < 0.095;
select distinct(class) from analysis_result;