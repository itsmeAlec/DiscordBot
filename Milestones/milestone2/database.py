# In this file you must implement your main query methods 
# so they can be used by your database models to interact with your bot.

import os

import pymysql.cursors

# note that your remote host where your database is hosted
# must support user permissions to run stored triggers, procedures and functions.
db_host = os.environ["DB_HOST"]
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]


class Database:

    @staticmethod
    def connect(bot_name=None):
        """
        This method creates a connection with your database
        IMPORTANT: all the environment variables must be set correctly
                   before attempting to run this method. Otherwise, it
                   will throw an error message stating that the attempt
                   to connect to your database failed.
        """
        try:
            conn = pymysql.connect(host=db_host,
                                   port=3306,
                                   user=db_username,
                                   password=db_password,
                                   db=db_name,
                                   charset="utf8mb4",
                                   cursorclass=pymysql.cursors.DictCursor)
            print("Bot {} connected to database {}".format(bot_name, db_name))
            return conn
        except ConnectionError as err:
            print(f"An error has occurred: {err.args[1]}")
            print("\n")

    #TODO: needs to implement the internal logic of all the main query operations
    def get_response(self, query, values=None, fetch=False, many_entities=False):
        # Establish connection
        connection = self.connect()
        if not connection:
            print("Failed to connect to the database.")
            return None

        try:
            with connection.cursor() as cursor:
                # Execute the query
                cursor.execute(query, values)

                # Handle the results
                if fetch:
                    if many_entities:
                        result = cursor.fetchall()
                    else:
                        result = cursor.fetchone()
                else:
                    connection.commit()
                    result = None

                return result
        except Exception as e:
            print(f"An error occurred: {e}")
            return None
        finally:
            # Close the connection
            connection.close()
            print("Connection closed.")
        """
        query: the SQL query with wildcards (if applicable) to avoid injection attacks
        values: the values passed in the query
        fetch: If set to True, then the method fetches data from the database (i.e with SELECT)
        many_entities: If set to True, the method can insert multiple entities at a time.
        """
      
    @staticmethod
    async def get_user_info(username):
        query = "SELECT username, email, password_hash FROM User WHERE username = %s"
        values = (username,)
        database = Database()
        return database.get_response(query, values=values, fetch=True)


    @staticmethod
    async def get_all_users():
        query = "SELECT user_id, username FROM `User`"
        database = Database()
        result = database.get_response(query, fetch=True, many_entities=True)
        return result

  # test3
    @staticmethod
    async def fetch_user_subscriptions(username):
        query = "SELECT * FROM SubscriptionManagement WHERE user_id = (SELECT user_id FROM User WHERE username = %s)"
        values = (username,)
        return Database.get_response(query, values=values, fetch=True, many_entities=True)
  
  
    @staticmethod
    async def get_user_subscriptions(username):
        query = "SELECT * FROM SubscriptionManagement WHERE user_id = (SELECT user_id FROM User WHERE username = %s)"
        values = (username,)
        database_instance = Database()
        return database_instance.get_response(query, values=values, fetch=True, many_entities=True)


  # test4
    @staticmethod
    async def fetch_compliance_report(report_name):
        query = "SELECT * FROM CustomizableComplianceReports WHERE report_name = %s"
        values = (report_name,)
        return Database.get_response(query, values=values, fetch=True)

    @staticmethod
    async def get_compliance_report(report_name):
        query = "SELECT * FROM CustomizableComplianceReports WHERE report_name = %s"
        values = (report_name,)
        database_instance = Database()
        return database_instance.get_response(query, values=values, fetch=True)


  #test5
    @staticmethod
    async def test_new_user(username, email, password_hash):
        query = "INSERT INTO `User` (username, email, password_hash) VALUES (%s, %s, %s)"
        values = (username, email, password_hash)
        database = Database()
        try:
            result = database.get_response(query, values=values, fetch=False)
            if result is None:
                print("User added successfully.")
                return True
            else:
                print("Insertion result: ", result)
                return False
        except Exception as e:
            print(f"Exception in add_new_user: {e}")
            return False
  
    @staticmethod
    async def add_new_user(username, email, password_hash):
        query = "INSERT INTO `User` (username, email, password_hash) VALUES (%s, %s, %s)"
        values = (username, email, password_hash)
        database = Database()
        try:
            result = database.get_response(query, values=values, fetch=False)
            if result is None:
                print("User added successfully.")
                return True
            else:
                print("Insertion result: ", result)
                return False
        except Exception as e:
            print(f"Exception in add_new_user: {e}")
            return False


  #test6
    @staticmethod
    async def add_new_subscription(username, plan_name):
        query = """
        INSERT INTO `SubscriptionManagement` 
        (plan_name, billing_history, subscription_status, renewal_reminder_sent, payment_information, user_id, administrator_id) 
        VALUES (%s, 'history1', 'active', FALSE, 'info10', (SELECT user_id FROM `User` WHERE username = %s), NULL)
        """
        values = (plan_name, username)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        if result is None:
            return True
        else:
            return False

  
    @staticmethod
    async def update_subscription(subscription_id, plan_name, subscription_status):
        query = "UPDATE `SubscriptionManagement` SET plan_name = %s, subscription_status = %s WHERE subscription_id = %s"
        values = (plan_name, subscription_status, subscription_id)
        database = Database()
  
        try:
            result = database.get_response(query, values=values, fetch=False)
            if result is None:
                return True  # Successful update
            else:
                print("Update result:", result)  # Log for debugging
                return False
        except Exception as e:
            print(f"Exception in update_subscription: {e}")  # Log the exception
            return False
  

#test7
    @staticmethod
    async def delete_user_test(username):
        query = "DELETE FROM `User` WHERE username = %s"
        values = (username,)
        return Database.get_response(query, values=values, fetch=False)
  
    

    @staticmethod
    async def delete_user(username):
        query = "DELETE FROM `User` WHERE username = %s"
        values = (username,)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        if result is None:
            return True
        else:
            return False
#test8
    @staticmethod
    async def cancel_subscription_test(username):
        query = """
        UPDATE `SubscriptionManagement` 
        SET plan_name = '', subscription_status = 'cancelled' 
        WHERE user_id = (SELECT user_id FROM `User` WHERE username = %s)
        """
        values = (username,)
        return Database.get_response(query, values=values, fetch=False)

    @staticmethod
    async def cancel_subscription(username):
        query = """
        UPDATE `SubscriptionManagement` 
        SET plan_name = '', subscription_status = 'cancelled' 
        WHERE user_id = (SELECT user_id FROM `User` WHERE username = %s)
        """
        values = (username,)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        return result is None

# test 11
    @staticmethod
    async def log_system_alert_test(system_name):
        query = "INSERT INTO `SystemAlerts` (system_name, alert_time) VALUES (%s, NOW())"
        values = (system_name,)
        result = Database.get_response(query, values=values, fetch=False)
        return result is None
#test12
    @staticmethod
    async def log_incident_test(user_id, name, description):
        query = """
        INSERT INTO `IncidentReport` (name, description, reported_by_user_id, assigned_to_user_id, user_id) 
        VALUES (%s, %s, %s, %s, %s)
        """
        # Assuming assigned_to_user_id is set to a default value, e.g., 1
        assigned_to_user_id = 1
        values = (name, description, user_id, assigned_to_user_id, user_id)
        return Database.get_response(query, values=values, fetch=False)
    
    @staticmethod
    async def log_system_alert(system_name):
        query = "INSERT INTO `SystemAlerts` (system_name, alert_time) VALUES (%s, NOW())"
        values = (system_name,)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        if result is None:
            return True
        else:
            return False

  
    @staticmethod
    async def log_incident(user_id, name, description):
        query = """
        INSERT INTO `IncidentReport` (name, description, reported_by_user_id, assigned_to_user_id, user_id) 
        VALUES (%s, %s, %s, %s, %s)
        """
        # Assuming assigned_to_user_id is set to a default value, e.g., 1
        assigned_to_user_id = 1
        values = (name, description, user_id, assigned_to_user_id, user_id)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        if result is None:
            return True
        else:
            return False


  
    @staticmethod
    async def generate_compliance_report(report_name, regulation_type, generation_schedule, export_format, archived, user_id):
        query = """
        INSERT INTO `CustomizableComplianceReports` 
        (report_name, regulation_type, generation_schedule, export_format, archived, user_id) 
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        values = (report_name, regulation_type, generation_schedule, export_format, archived, user_id)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        return result is None


    @staticmethod
    async def fetch_compliance_reports():
        query = "SELECT * FROM `CustomizableComplianceReports`"
        database = Database()
        result = database.get_response(query, fetch=True, many_entities=True)
        return result

#test10
    @staticmethod
    async def delete_compliance_report_test(report_name):
        query = "DELETE FROM `CustomizableComplianceReports` WHERE report_name = %s"
        values = (report_name,)
        return Database.get_response(query, values=values, fetch=False)
  
    @staticmethod
    async def delete_compliance_report(report_name):
        query = "DELETE FROM `CustomizableComplianceReports` WHERE report_name = %s"
        values = (report_name,)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        return result is None

  
    @staticmethod
    async def update_user_password(username, new_password):
        query = "UPDATE `User` SET password_hash = %s WHERE username = %s"
        values = (new_password, username)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        return result is None

    @staticmethod
    async def update_user_email(username, new_email):
        query = "UPDATE `User` SET email = %s WHERE username = %s"
        values = (new_email, username)
        database = Database()
        result = database.get_response(query, values=values, fetch=False)
        return result is None



  



    

    @staticmethod
    def select(query, values=None, fetch=True):
        database = Database()
        return database.get_response(query, values=values, fetch=fetch)

    @staticmethod
    def insert(query, values=None, many_entities=False):
        database = Database()
        return database.get_response(query, values=values, many_entities=many_entities)

    @staticmethod
    def update(query, values=None):
        database = Database()
        return database.get_response(query, values=values)

    @staticmethod
    def delete(query, values=None):
        database = Database()
        return database.get_response(query, values=values)