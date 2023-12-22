
# install "pip install pytest pytest-asyncio" before runnning test
# pip install pytest pytest-asyncio pytest-mock

import pytest
from unittest.mock import AsyncMock, MagicMock, patch
from database import Database  

class TestDatabaseMethods:


  @pytest.mark.asyncio
  @patch('database.Database.connect')  # Mock the database connection
  @patch('database.Database.get_response')  # Mock the get_response method
  async def test_get_user_info(self, mock_get_response, mock_connect):
      # Setup
      username = "testuser"
      expected_result = {
          "username": "testuser",
          "email": "testuser@example.com",
          "password_hash": "hashed_password"
      }
      mock_get_response.return_value = expected_result

      # Execute
      result = await Database.get_user_info(username)

      # Assert
      mock_get_response.assert_called_once_with(
          "SELECT username, email, password_hash FROM User WHERE username = %s", 
          values=(username,), 
          fetch=True
      )

  @pytest.mark.asyncio
  @patch('database.Database.connect')  # Mock the database connection
  @patch('database.Database.get_response')  # Mock the get_response method
  async def test_get_all_users(self, mock_get_response, mock_connect):
      # Setup
      expected_result = [
          {"user_id": 1, "username": "user1"},
          {"user_id": 2, "username": "user2"},
          # Add more mock users as needed
      ]
      mock_get_response.return_value = expected_result

      # Execute
      result = await Database.get_all_users()

      # Assert
      mock_get_response.assert_called_once_with(
          "SELECT user_id, username FROM `User`",
          fetch=True,
          many_entities=True
      )
      assert result == expected_result

  @pytest.mark.asyncio
  @patch('database.Database.get_response')
  async def test_fetch_user_subscriptions(self, mock_get_response):
      # Mock database response
      mock_subscriptions = [
          {"plan_name": "Plan A", "subscription_status": "active"},
          {"plan_name": "Plan B", "subscription_status": "inactive"},
          # ... more mock data ...
      ]
      mock_get_response.return_value = mock_subscriptions

      # Execute
      result = await Database.fetch_user_subscriptions("testuser")

      # Assert
      mock_get_response.assert_called_once_with(
          "SELECT * FROM SubscriptionManagement WHERE user_id = (SELECT user_id FROM User WHERE username = %s)",
          values=("testuser",),
          fetch=True,
          many_entities=True
      )
      assert result == mock_subscriptions
    

  @pytest.mark.asyncio
  @patch('database.Database.get_response')
  async def test_fetch_compliance_report(self, mock_get_response):
      # Setup - Mock the database response
      mock_report = {
          "report_name": "Test Report",
          "regulation_type": "Type1",
          "generation_schedule": "Daily",
      }
      mock_get_response.return_value = mock_report

      # Execute
      test_report_name = "Test Report"
      result = await Database.fetch_compliance_report(test_report_name)

      # Assert
      mock_get_response.assert_called_once_with(
          "SELECT * FROM CustomizableComplianceReports WHERE report_name = %s",
          values=(test_report_name,),
          fetch=True
      )
      assert result == mock_report

  @pytest.mark.asyncio
  @patch('database.Database.get_response')
  async def test_fetch_compliance_reports(self, mock_get_response):
      # Setup - Mock the database response
      mock_reports = [
          {"report_name": "Report1", "regulation_type": "Type1", "generation_schedule": "Daily"},
          {"report_name": "Report2", "regulation_type": "Type2", "generation_schedule": "Weekly"}
        
      ]
      mock_get_response.return_value = mock_reports
  
      # Execute
      result = await Database.fetch_compliance_reports()
  
      # Assert
      mock_get_response.assert_called_once_with(
          "SELECT * FROM `CustomizableComplianceReports`",
          fetch=True,
          many_entities=True
      )
      assert result == mock_reports

  
    
  @pytest.mark.asyncio
  @patch('database.Database.get_response')
  async def test_add_new_user(self, mock_get_response):
      # Setup - Mock the database response for successful insertion
      mock_get_response.return_value = None  
  
      # User details for testing
      test_username = "newuser"
      test_email = "newuser@example.com"
      test_password_hash = "hashedpassword"
  
      # Execute
      success = await Database.test_new_user(test_username, test_email, test_password_hash)
  
      # Assert
      mock_get_response.assert_called_once_with(
          "INSERT INTO `User` (username, email, password_hash) VALUES (%s, %s, %s)",
          values=(test_username, test_email, test_password_hash),
          fetch=False
      )
      assert success is True
    
  @pytest.mark.asyncio
  @patch('database.Database.get_response')
  async def test_get_user_subscriptions(self, mock_get_response):
      # Setup mock response
      mock_subscriptions = [
          {"subscription_id": 1, "plan_name": "Basic", "subscription_status": "active"},
          # ... other mock subscription data ...
      ]
      mock_get_response.return_value = mock_subscriptions
  
      # Execute
      result = await Database.fetch_user_subscriptions("testuser")
  
      # Assert
      mock_get_response.assert_called_once_with(
          "SELECT * FROM SubscriptionManagement WHERE user_id = (SELECT user_id FROM User WHERE username = %s)",
          values=("testuser",),
          fetch=True,
          many_entities=True
      )
      assert result == mock_subscriptions



  @pytest.mark.asyncio
  @patch('database.Database.get_response')  # Correct import path for patch
  async def test_delete_user(self, mock_get_response):
    # Setup - Mock the database response for successful deletion
    mock_get_response.return_value = None  # Assuming None indicates success

    # Username for testing
    test_username = "user_to_delete"

    # Execute
    success = await Database.delete_user(test_username)

    # Assert
    mock_get_response.assert_called_once_with(
        "DELETE FROM `User` WHERE username = %s",
        values=(test_username,),
        fetch=False
    )
    assert success is True  # Assuming True indicates successful deletion


  # @pytest.mark.asyncio
  # @patch('database.Database.get_response')
  # async def test_delete_compliance_report(self, mock_get_response):
  #     # Setup - Mock the database response for successful deletion
  #     mock_get_response.return_value = None  # Assuming None indicates success
  
  #     # Report name for testing
  #     test_report_name = "test_report"
  
  #     # Execute
  #     success = await Database.delete_compliance_report_test(test_report_name)
  
  #     # Assert
  #     mock_get_response.assert_called_once_with(
  #         "DELETE FROM `CustomizableComplianceReports` WHERE report_name = %s",
  #         values=(test_report_name,),
  #         fetch=False
  #     )
  #     assert success is True  # Assuming True indicates successful deletion

  @pytest.mark.asyncio
  @patch('database.Database.get_response')
  async def test_log_system_alert(self, mock_get_response):
      # Setup - Mock the database response for successful logging
      mock_get_response.return_value = None  # Assuming None indicates success
  
      # System name for testing
      test_system_name = "TestSystem"
  
      # Execute
      success = await Database.log_system_alert_test(test_system_name)
  
      # Assert
      mock_get_response.assert_called_once_with(
          "INSERT INTO `SystemAlerts` (system_name, alert_time) VALUES (%s, NOW())",
          values=(test_system_name,),
          fetch=False
      )
      assert success is True  # Assuming True indicates successful logging

  # @pytest.mark.asyncio
  # @patch('database.Database.get_response')
  # async def test_log_incident(self, mock_get_response):
  #     # Setup - Mock the database response for successful logging
  #     mock_get_response.return_value = None  # Assuming None indicates success
  
  #     # Test data
  #     test_user_id = 123
  #     test_name = "Test Incident"
  #     test_description = "Test Description"
  
  #     # Execute
  #     success = await Database.log_incident_test(test_user_id, test_name, test_description)
  
  #     # Assert
  #     mock_get_response.assert_called_once_with(
  #         """
  #         INSERT INTO `IncidentReport` (name, description, reported_by_user_id, assigned_to_user_id, user_id) 
  #         VALUES (%s, %s, %s, %s, %s)
  #         """,
  #         values=(test_name, test_description, test_user_id, 1, test_user_id),
  #         fetch=False
  #     )
  #     assert success is True  # Assuming True indicates successful logging
  
 



  