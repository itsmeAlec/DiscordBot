-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cyber_db
-- -----------------------------------------------------
DROP DATABASE IF EXISTS cyber_db;
CREATE SCHEMA IF NOT EXISTS `cyber_db` DEFAULT CHARACTER SET utf8 ;
USE `cyber_db` ;

-- -----------------------------------------------------
-- Table `cyber_db`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`User` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `cyber_db`.`Administrator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`Administrator` (
  `admin_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `last_login` DATETIME NOT NULL,
  `access_level` ENUM('low','medium','high') NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`admin_id`),
  INDEX `fk_Administrator_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Administrator_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyber_db`.`IntegrationService`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`IntegrationService` (
  `service_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `integration_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`service_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyber_db`.`AlertingSystem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`AlertingSystem` (
  `system_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `last_triggered` DATETIME NOT NULL,
  `acknowledged` BOOLEAN NOT NULL,
  PRIMARY KEY (`system_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyber_db`.`MachineLearningTool`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`MachineLearningTool` (
  `session_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `session_type` VARCHAR(45) NOT NULL,
  `machine_learning_model` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`session_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyber_db`.`ThreatCorrelationEngine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`ThreatCorrelationEngine` (
  `engine_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `correlation_algorithm` VARCHAR(45) NOT NULL,
  `last_run` DATETIME NOT NULL,
  `risk_score` INT NOT NULL,
  `machine_learning_tool_session_id` INT UNSIGNED,
  PRIMARY KEY (`engine_id`),
  INDEX `fk_ThreatCorrelationEngine_MachineLearningTool_idx` (`machine_learning_tool_session_id` ASC) VISIBLE,
  CONSTRAINT `fk_ThreatCorrelationEngine_MachineLearningTool`
    FOREIGN KEY (`machine_learning_tool_session_id`)
    REFERENCES `cyber_db`.`MachineLearningTool` (`session_id`)
    ON DELETE NO ACTION 
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyber_db`.`IncidentReport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`IncidentReport` (
  `workflow_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `reported_by_user_id` INT UNSIGNED NOT NULL,
  `assigned_to_user_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`workflow_id`),
  INDEX `fk_IncidentReport_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_IncidentReport_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyber_db`.`CustomizableComplianceReports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`CustomizableComplianceReports` (
  `report_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_name` VARCHAR(45) NOT NULL,
  `regulation_type` VARCHAR(45) NOT NULL,
  `generation_schedule` VARCHAR(45) NOT NULL,
  `export_format` VARCHAR(45) NOT NULL,
  `archived` BOOLEAN NOT NULL,
  `user_id` INT UNSIGNED NOT NULL, 
  PRIMARY KEY (`report_id`),
  INDEX `fk_CustomizableComplianceReports_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_CustomizableComplianceReports_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `cyber_db`.`DataPrivacyAndCompliance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`DataPrivacyAndCompliance` (
  `compliance_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `compliance_type` VARCHAR(45) NOT NULL,
  `audit_logs_enabled` BOOLEAN NOT NULL,
  `last_audit_timestamp` DATETIME NOT NULL,
  `customizable_compliance_reports_report_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`compliance_id`),
  INDEX `fk_DataPrivacyAndCompliance_CustomizableComplianceReports_idx` (`customizable_compliance_reports_report_id` ASC) VISIBLE,
  CONSTRAINT `fk_DataPrivacyAndCompliance_CustomizableComplianceReports`
    FOREIGN KEY (`customizable_compliance_reports_report_id`)
    REFERENCES `cyber_db`.`CustomizableComplianceReports` (`report_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyber_db`.`CustomizableThreatIntelligenceFeeds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`CustomizableThreatIntelligenceFeeds` (
  `feed_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `last_updated` DATETIME NOT NULL,
  `enabled` BOOLEAN NOT NULL,
  `user_id` INT UNSIGNED NOT NULL, 
  PRIMARY KEY (`feed_id`),
  INDEX `fk_CustomizableThreatIntelligenceFeeds_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_CustomizableThreatIntelligenceFeeds_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `cyber_db`.`HistoricalThreatDataAnalysis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`HistoricalThreatDataAnalysis` (
  `analysis_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `analysis_type` VARCHAR(45) NOT NULL,
  `result_summary` TEXT NOT NULL,
  `created_by` INT UNSIGNED NOT NULL, 
  `data_exported` BOOLEAN NOT NULL,
  `export_format` VARCHAR(45) NOT NULL,
  `user_id` INT UNSIGNED NOT NULL, 
  PRIMARY KEY (`analysis_id`),
  INDEX `fk_HistoricalThreatDataAnalysis_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_HistoricalThreatDataAnalysis_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyber_db`.`CollaborativeThreatAnalysis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`CollaborativeThreatAnalysis` (
  `analysis_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `priority` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `assigned_to` INT UNSIGNED NOT NULL, 
  `user_id` INT UNSIGNED NOT NULL, 
  PRIMARY KEY (`analysis_id`),
  INDEX `fk_CollaborativeThreatAnalysis_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_CollaborativeThreatAnalysis_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cyber_db`.`SubscriptionManagement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`SubscriptionManagement` (
  `subscription_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `plan_name` VARCHAR(45) NOT NULL,
  `billing_history` TEXT NOT NULL,
  `subscription_status` ENUM('active', 'inactive','cancelled') NOT NULL,
  `renewal_reminder_sent` BOOLEAN NOT NULL,
  `payment_information` TEXT NOT NULL,
  `user_id` INT UNSIGNED, 
  `administrator_id` INT UNSIGNED, 
  PRIMARY KEY (`subscription_id`),
  INDEX `fk_SubscriptionManagement_User_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_SubscriptionManagement_Administrator_idx` (`administrator_id` ASC) VISIBLE,
  CONSTRAINT `fk_SubscriptionManagement_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SubscriptionManagement_Administrator`
    FOREIGN KEY (`administrator_id`)
    REFERENCES `cyber_db`.`Administrator` (`admin_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cyber_db`.`APIsForThirdPartyIntegrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`APIsForThirdPartyIntegrations` (
  `api_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `api_name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `integration_type` VARCHAR(45) NOT NULL,
  `documentation_link` VARCHAR(255) NOT NULL,
  `api_key_generation` BOOLEAN NOT NULL,
  PRIMARY KEY (`api_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cyber_db`.`CollaborativeThreatIntelligenceSharing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`CollaborativeThreatIntelligenceSharing` (
  `sharing_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `community_name` VARCHAR(45) NOT NULL,
  `shared_content` TEXT NOT NULL,
  `quality_rating` VARCHAR(45) NOT NULL,
  `shared_timestamp` DATETIME NOT NULL,
  `collaboration_status` ENUM('pending', 'active', 'inactive') NOT NULL,
  `user_id` INT UNSIGNED, 
  PRIMARY KEY (`sharing_id`),
  INDEX `fk_CollaborativeThreatIntelligenceSharing_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_CollaborativeThreatIntelligenceSharing_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cyber_db`.`RealTimeThreatIntelligenceRecommendations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`RealTimeThreatIntelligenceRecommendations` (
  `recommendation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `threat_type` VARCHAR(45) NOT NULL,
  `severity` ENUM('low', 'medium', 'high') NOT NULL,
  `recommended_action` TEXT NOT NULL,
  `action_status` ENUM('pending', 'completed', 'in_progress') NOT NULL,
  `feedback_rating` VARCHAR(45) NOT NULL,
  `threat_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `threat_correlation_engine_id` INT UNSIGNED NOT NULL,
  `incident_report_id` INT UNSIGNED NOT NULL,
  `collaborative_threat_intelligence_sharing_id` INT UNSIGNED NOT NULL,
  `machine_learning_tool_session_id` INT UNSIGNED NOT NULL,
  `alerting_system_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`recommendation_id`),
  INDEX `fk_RTIR_User_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_RTIR_ThreatCorEngine_idx` (`threat_correlation_engine_id` ASC) VISIBLE,
  INDEX `fk_RTIR_IncidentReport_idx` (`incident_report_id` ASC) VISIBLE,
  INDEX `fk_RTIR_CollabThreatSharing_idx` (`collaborative_threat_intelligence_sharing_id` ASC) VISIBLE,
  INDEX `fk_RTIR_MLTool_idx` (`machine_learning_tool_session_id` ASC) VISIBLE,
  INDEX `fk_RTIR_AlertingSystem_idx` (`alerting_system_id` ASC) VISIBLE,
  CONSTRAINT `fk_RTIR_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RTIR_ThreatCorEngine`
    FOREIGN KEY (`threat_correlation_engine_id`)
    REFERENCES `cyber_db`.`ThreatCorrelationEngine` (`engine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RTIR_IncidentReport`
    FOREIGN KEY (`incident_report_id`)
    REFERENCES `cyber_db`.`IncidentReport` (`workflow_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RTIR_CollabThreatSharing`
    FOREIGN KEY (`collaborative_threat_intelligence_sharing_id`)
    REFERENCES `cyber_db`.`CollaborativeThreatIntelligenceSharing` (`sharing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RTIR_MLTool`
    FOREIGN KEY (`machine_learning_tool_session_id`)
    REFERENCES `cyber_db`.`MachineLearningTool` (`session_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RTIR_AlertingSystem`
    FOREIGN KEY (`alerting_system_id`)
    REFERENCES `cyber_db`.`AlertingSystem` (`system_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `cyber_db`.`DataExportAndIntegrationWithSIEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`DataExportAndIntegrationWithSIEM` (
   `export_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
   `user_id` INT UNSIGNED NOT NULL,
   `siem_system` VARCHAR(45) NOT NULL,
   `export_status` ENUM('pending', 'completed', 'error') NOT NULL,
   `data_format` ENUM('json', 'xml', 'csv') NOT NULL,
   `data_mapping_configuration` TEXT NOT NULL,
   `export_timestamp` DATETIME NOT NULL,
   `enhancement_enabled` BOOLEAN NOT NULL,
   PRIMARY KEY (`export_id`),
   INDEX `fk_DataExportAndIntegrationWithSIEM_User_idx` (`user_id` ASC) VISIBLE,
   CONSTRAINT `fk_DataExportAndIntegrationWithSIEM_User`
     FOREIGN KEY (`user_id`)
     REFERENCES `cyber_db`.`User` (`user_id`)
     ON DELETE CASCADE
     ON UPDATE CASCADE)
 ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cyber_db`.`CustomizableDashboardsAndWidgets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`CustomizableDashboardsAndWidgets` (
  `dashboard_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`dashboard_id`),
  INDEX `fk_CustomizableDashboardsAndWidgets_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_CustomizableDashboardsAndWidgets_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `cyber_db`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cyber_db`.`IntegrationServiceAPIsForThirdPartyIntegrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyber_db`.`IntegrationServiceAPIsForThirdPartyIntegrations` (
  `integration_service_id` INT UNSIGNED NOT NULL,
  `apis_for_third_party_integrations_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`integration_service_id`, `apis_for_third_party_integrations_id`),
  INDEX `fk_ISATPI_APIs_idx` (`apis_for_third_party_integrations_id` ASC) VISIBLE,
  INDEX `fk_ISATPI_IntegrationService_idx` (`integration_service_id` ASC) VISIBLE,
  CONSTRAINT `fk_ISATPI_IntSvc`
    FOREIGN KEY (`integration_service_id`)
    REFERENCES `cyber_db`.`IntegrationService` (`service_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ISATPI_APIs`
    FOREIGN KEY (`apis_for_third_party_integrations_id`)
    REFERENCES `cyber_db`.`APIsForThirdPartyIntegrations` (`api_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
