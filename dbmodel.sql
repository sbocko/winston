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
select * from analysis_result;
select distinct(class) from analysis_result;

select a.id analysisId, min(rmse) from analysis a left join analysis_result ar on a.id = ar.analysis_id where a.dataset_id = 8 group by a.id order by ar.rmse;