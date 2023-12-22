-- Inserts for User table
INSERT INTO `cyber_db`.`User` (`username`, `email`, `password_hash`) VALUES ('user1', 'user1@example.com', 'hash1');
INSERT INTO `cyber_db`.`User` (`username`, `email`, `password_hash`) VALUES ('user2', 'user2@example.com', 'hash2');
INSERT INTO `cyber_db`.`User` (`username`, `email`, `password_hash`) VALUES ('user3', 'user3@example.com', 'hash3');

-- Inserts for Administrator table
INSERT INTO `cyber_db`.`Administrator` (`username`, `email`, `password_hash`, `last_login`, `access_level`, `user_id`) VALUES ('admin1', 'admin1@example.com', 'adminhash1', '2021-01-01 00:00:00', 'high', 1);
INSERT INTO `cyber_db`.`Administrator` (`username`, `email`, `password_hash`, `last_login`, `access_level`, `user_id`) VALUES ('admin2', 'admin2@example.com', 'adminhash2', '2021-01-02 00:00:00', 'medium', 2);
INSERT INTO `cyber_db`.`Administrator` (`username`, `email`, `password_hash`, `last_login`, `access_level`, `user_id`) VALUES ('admin3', 'admin3@example.com', 'adminhash3', '2021-01-03 00:00:00', 'low', 3);


-- Inserts for Integration Service table
INSERT INTO `cyber_db`.`IntegrationService` (`name`, `description`, `integration_type`) VALUES ('Service1', 'Description1', 'Type1');
INSERT INTO `cyber_db`.`IntegrationService` (`name`, `description`, `integration_type`) VALUES ('Service2', 'Description2', 'Type2');
INSERT INTO `cyber_db`.`IntegrationService` (`name`, `description`, `integration_type`) VALUES ('Service3', 'Description3', 'Type3');


-- Inserts for Alerting System table
INSERT INTO `cyber_db`.`AlertingSystem` (`name`, `description`, `last_triggered`, `acknowledged`) VALUES ('System1', 'Description1', '2021-01-01 00:00:00', TRUE);
INSERT INTO `cyber_db`.`AlertingSystem` (`name`, `description`, `last_triggered`, `acknowledged`) VALUES ('System2', 'Description2', '2021-01-02 00:00:00', FALSE);
INSERT INTO `cyber_db`.`AlertingSystem` (`name`, `description`, `last_triggered`, `acknowledged`) VALUES ('System3', 'Description3', '2021-01-02 00:00:00', FALSE);


-- Inserts for Machine Learning Tool table
INSERT INTO `cyber_db`.`MachineLearningTool` (`session_type`, `machine_learning_model`) VALUES ('Type1', 'Model1');
INSERT INTO `cyber_db`.`MachineLearningTool` (`session_type`, `machine_learning_model`) VALUES ('Type2', 'Model2');
INSERT INTO `cyber_db`.`MachineLearningTool` (`session_type`, `machine_learning_model`) VALUES ('Type3', 'Model3');



-- Inserts for Threat Correlation Engine table
INSERT INTO `cyber_db`.`ThreatCorrelationEngine` (`name`, `description`, `correlation_algorithm`, `last_run`, `risk_score`, `machine_learning_tool_session_id`) VALUES ('Engine1', 'Desc1', 'Algo1', '2021-01-01 00:00:00', 10, 1);
INSERT INTO `cyber_db`.`ThreatCorrelationEngine` (`name`, `description`, `correlation_algorithm`, `last_run`, `risk_score`, `machine_learning_tool_session_id`) VALUES ('Engine2', 'Desc2', 'Algo2', '2021-01-02 00:00:00', 20, 2);
INSERT INTO `cyber_db`.`ThreatCorrelationEngine` (`name`, `description`, `correlation_algorithm`, `last_run`, `risk_score`, `machine_learning_tool_session_id`) VALUES ('Engine3', 'Desc3', 'Algo3', '2021-01-03 00:00:00', 30, 3);


-- Inserts for Incident Report table
INSERT INTO `cyber_db`.`IncidentReport` (`name`, `description`, `reported_by_user_id`, `assigned_to_user_id`, `user_id`) VALUES ('Report1', 'Desc1', 1, 2, 3);
INSERT INTO `cyber_db`.`IncidentReport` (`name`, `description`, `reported_by_user_id`, `assigned_to_user_id`, `user_id`) VALUES ('Report2', 'Desc2', 2, 3, 1);
INSERT INTO `cyber_db`.`IncidentReport` (`name`, `description`, `reported_by_user_id`, `assigned_to_user_id`, `user_id`) VALUES ('Report3', 'Desc3', 3, 1, 2);


-- Inserts for Customizable Compliance Reports table
INSERT INTO `cyber_db`.`CustomizableComplianceReports` (`report_name`, `regulation_type`, `generation_schedule`, `export_format`, `archived`, `user_id`) VALUES ('Report1', 'Type1', 'Schedule1', 'PDF', FALSE, 1);
INSERT INTO `cyber_db`.`CustomizableComplianceReports` (`report_name`, `regulation_type`, `generation_schedule`, `export_format`, `archived`, `user_id`) VALUES ('Report2', 'Type2', 'Schedule2', 'CSV', TRUE, 2);
INSERT INTO `cyber_db`.`CustomizableComplianceReports` (`report_name`, `regulation_type`, `generation_schedule`, `export_format`, `archived`, `user_id`) VALUES ('Report3', 'Type3', 'Schedule3', 'XML', FALSE, 3);


-- Inserts for Data Privacy and Compliance table
INSERT INTO `cyber_db`.`DataPrivacyAndCompliance` (`name`, `description`, `compliance_type`, `audit_logs_enabled`, `last_audit_timestamp`, `customizable_compliance_reports_report_id`) VALUES ('Privacy1', 'Desc1', 'Type1', TRUE, '2021-01-01 00:00:00', 1);
INSERT INTO `cyber_db`.`DataPrivacyAndCompliance` (`name`, `description`, `compliance_type`, `audit_logs_enabled`, `last_audit_timestamp`, `customizable_compliance_reports_report_id`) VALUES ('Privacy2', 'Desc2', 'Type2', FALSE, '2021-01-02 00:00:00', 2);
INSERT INTO `cyber_db`.`DataPrivacyAndCompliance` (`name`, `description`, `compliance_type`, `audit_logs_enabled`, `last_audit_timestamp`, `customizable_compliance_reports_report_id`) VALUES ('Privacy3', 'Desc3', 'Type3', TRUE, '2021-01-03 00:00:00', 3);


-- Inserts for Customizable Threat Intelligence Feeds table
INSERT INTO `cyber_db`.`CustomizableThreatIntelligenceFeeds` (`name`, `description`, `last_updated`, `enabled`, `user_id`) VALUES ('Feed1', 'Description1', '2021-01-01 00:00:00', TRUE, 1);
INSERT INTO `cyber_db`.`CustomizableThreatIntelligenceFeeds` (`name`, `description`, `last_updated`, `enabled`, `user_id`) VALUES ('Feed2', 'Description2', '2021-01-02 00:00:00', FALSE, 2);
INSERT INTO `cyber_db`.`CustomizableThreatIntelligenceFeeds` (`name`, `description`, `last_updated`, `enabled`, `user_id`) VALUES ('Feed3', 'Description3', '2021-01-03 00:00:00', TRUE, 3);


-- Inserts for Historical Threat Data Analysis table
INSERT INTO `cyber_db`.`HistoricalThreatDataAnalysis` (`date`, `analysis_type`, `result_summary`, `created_by`, `data_exported`, `export_format`, `user_id`) VALUES ('2021-01-01 00:00:00', 'Type1', 'Summary1', 1, TRUE, 'PDF', 1);
INSERT INTO `cyber_db`.`HistoricalThreatDataAnalysis` (`date`, `analysis_type`, `result_summary`, `created_by`, `data_exported`, `export_format`, `user_id`) VALUES ('2021-01-02 00:00:00', 'Type2', 'Summary2', 2, FALSE, 'CSV', 2);
INSERT INTO `cyber_db`.`HistoricalThreatDataAnalysis` (`date`, `analysis_type`, `result_summary`, `created_by`, `data_exported`, `export_format`, `user_id`) VALUES ('2021-01-03 00:00:00', 'Type3', 'Summary3', 3, TRUE, 'XML', 3);


-- Inserts for Collaborative Threat Analysis table
INSERT INTO `cyber_db`.`CollaborativeThreatAnalysis` (`name`, `description`, `status`, `priority`, `created_at`, `assigned_to`, `user_id`) VALUES ('Analysis1', 'Desc1', 'Active', 'High', '2021-01-01 00:00:00', 1, 1);
INSERT INTO `cyber_db`.`CollaborativeThreatAnalysis` (`name`, `description`, `status`, `priority`, `created_at`, `assigned_to`, `user_id`) VALUES ('Analysis2', 'Desc2', 'Inactive', 'Medium', '2021-01-02 00:00:00', 2, 2);
INSERT INTO `cyber_db`.`CollaborativeThreatAnalysis` (`name`, `description`, `status`, `priority`, `created_at`, `assigned_to`, `user_id`) VALUES ('Analysis3', 'Desc3', 'Pending', 'Low', '2021-01-03 00:00:00', 3, 3);


-- Inserts for Subscription Management table
INSERT INTO `cyber_db`.`SubscriptionManagement` (`plan_name`, `billing_history`, `subscription_status`, `renewal_reminder_sent`, `payment_information`, `user_id`, `administrator_id`) VALUES ('Plan1', 'History1', 'active', TRUE, 'Info1', 1, 1);
INSERT INTO `cyber_db`.`SubscriptionManagement` (`plan_name`, `billing_history`, `subscription_status`, `renewal_reminder_sent`, `payment_information`, `user_id`, `administrator_id`) VALUES ('Plan2', 'History2', 'inactive', FALSE, 'Info2', 2, 2);
INSERT INTO `cyber_db`.`SubscriptionManagement` (`plan_name`, `billing_history`, `subscription_status`, `renewal_reminder_sent`, `payment_information`, `user_id`, `administrator_id`) VALUES ('Plan3', 'History3', 'cancelled', TRUE, 'Info3', 3, 3);

-- Inserts for APIs for Third-Party Integrations table
INSERT INTO `cyber_db`.`APIsForThirdPartyIntegrations` (`api_name`, `description`, `integration_type`, `documentation_link`, `api_key_generation`) VALUES ('API1', 'Desc1', 'Type1', 'http://link1.com', TRUE);
INSERT INTO `cyber_db`.`APIsForThirdPartyIntegrations` (`api_name`, `description`, `integration_type`, `documentation_link`, `api_key_generation`) VALUES ('API2', 'Desc2', 'Type2', 'http://link2.com', FALSE);
INSERT INTO `cyber_db`.`APIsForThirdPartyIntegrations` (`api_name`, `description`, `integration_type`, `documentation_link`, `api_key_generation`) VALUES ('API3', 'Desc3', 'Type3', 'http://link3.com', TRUE);


-- Inserts for Collaborative Threat Intelligence Sharing table
INSERT INTO `cyber_db`.`CollaborativeThreatIntelligenceSharing` (`community_name`, `shared_content`, `quality_rating`, `shared_timestamp`, `collaboration_status`, `user_id`) VALUES ('Community1', 'Content1', 'High', '2021-01-01 00:00:00', 'active', 1);
INSERT INTO `cyber_db`.`CollaborativeThreatIntelligenceSharing` (`community_name`, `shared_content`, `quality_rating`, `shared_timestamp`, `collaboration_status`, `user_id`) VALUES ('Community2', 'Content2', 'Medium', '2021-01-02 00:00:00', 'inactive', 2);
INSERT INTO `cyber_db`.`CollaborativeThreatIntelligenceSharing` (`community_name`, `shared_content`, `quality_rating`, `shared_timestamp`, `collaboration_status`, `user_id`) VALUES ('Community3', 'Content3', 'Low', '2021-01-03 00:00:00', 'pending', 3);


-- Inserts for Real Time Threat Intelligence Recommendations table
INSERT INTO `cyber_db`.`RealTimeThreatIntelligenceRecommendations` (`threat_type`, `severity`, `recommended_action`, `action_status`, `feedback_rating`, `threat_id`, `user_id`, `threat_correlation_engine_id`, `incident_report_id`, `collaborative_threat_intelligence_sharing_id`, `machine_learning_tool_session_id`, `alerting_system_id`) VALUES ('Type1', 'high', 'Action1', 'completed', 'Good', 1, 1, 1, 1, 1, 1, 1);
INSERT INTO `cyber_db`.`RealTimeThreatIntelligenceRecommendations` (`threat_type`, `severity`, `recommended_action`, `action_status`, `feedback_rating`, `threat_id`, `user_id`, `threat_correlation_engine_id`, `incident_report_id`, `collaborative_threat_intelligence_sharing_id`, `machine_learning_tool_session_id`, `alerting_system_id`) VALUES ('Type2', 'medium', 'Action2', 'pending', 'Average', 2, 2, 2, 2, 2, 2, 2);
INSERT INTO `cyber_db`.`RealTimeThreatIntelligenceRecommendations` (`threat_type`, `severity`, `recommended_action`, `action_status`, `feedback_rating`, `threat_id`, `user_id`, `threat_correlation_engine_id`, `incident_report_id`, `collaborative_threat_intelligence_sharing_id`, `machine_learning_tool_session_id`, `alerting_system_id`) VALUES ('Type3', 'low', 'Action3', 'in_progress', 'Poor', 3, 3, 3, 3, 3, 3, 3);


-- Inserts for Data Export and Integration with SIEM table
INSERT INTO `cyber_db`.`DataExportAndIntegrationWithSIEM` (`user_id`, `siem_system`, `export_status`, `data_format`, `data_mapping_configuration`, `export_timestamp`, `enhancement_enabled`) VALUES (1, 'System1', 'pending', 'json', 'Config1', '2021-01-01 00:00:00', TRUE);
INSERT INTO `cyber_db`.`DataExportAndIntegrationWithSIEM` (`user_id`, `siem_system`, `export_status`, `data_format`, `data_mapping_configuration`, `export_timestamp`, `enhancement_enabled`) VALUES (2, 'System2', 'completed', 'xml', 'Config2', '2021-01-02 00:00:00', FALSE);
INSERT INTO `cyber_db`.`DataExportAndIntegrationWithSIEM` (`user_id`, `siem_system`, `export_status`, `data_format`, `data_mapping_configuration`, `export_timestamp`, `enhancement_enabled`) VALUES (3, 'System3', 'error', 'csv', 'Config3', '2021-01-03 00:00:00', TRUE);


-- Inserts for Customizable Dashboards and Widgets table
INSERT INTO `cyber_db`.`CustomizableDashboardsAndWidgets` (`user_id`) VALUES (1);
INSERT INTO `cyber_db`.`CustomizableDashboardsAndWidgets` (`user_id`) VALUES (2);
INSERT INTO `cyber_db`.`CustomizableDashboardsAndWidgets` (`user_id`) VALUES (3);


-- Inserts for Integration Service APIs For Third Party Integrations table
INSERT INTO `cyber_db`.`IntegrationServiceAPIsForThirdPartyIntegrations` (`integration_service_id`, `apis_for_third_party_integrations_id`) VALUES (1, 1);
INSERT INTO `cyber_db`.`IntegrationServiceAPIsForThirdPartyIntegrations` (`integration_service_id`, `apis_for_third_party_integrations_id`) VALUES (1, 2);
INSERT INTO `cyber_db`.`IntegrationServiceAPIsForThirdPartyIntegrations` (`integration_service_id`, `apis_for_third_party_integrations_id`) VALUES (2, 3);

