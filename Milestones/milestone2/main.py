"""
The code below is just representative of the implementation of a Bot. 
However, this code was not meant to be compiled as it. It is the responsability 
of all the students to modifify this code such that it can fit the 
requirements for this assignments.
"""

import os

import discord
from discord.ext import commands

from database import Database
from models import *
from datetime import datetime

TOKEN = os.environ["DISCORD_TOKEN"]

intents = discord.Intents.all()

bot = commands.Bot(command_prefix='!', intents=discord.Intents.all())

@bot.event
async def on_ready():
  print(f'{bot.user} has connected to Discord!')
  Database.connect(bot.user)



@bot.command(name="test", description="write your database business requirement for this command here")
async def _test(ctx, arg1):
    testModel = TestModel(ctx, arg1)
    response = testModel.response()
    await ctx.send(response)


# TODO: complete the following tasks:
#       (1) Replace the commands' names with your own commands
#       (2) Write the description of your business requirement in the description parameter
#       (3) Implement your commands' methods.

@bot.command(name="getUserInfo", description="Fetches user information from the database")
async def get_user_info(ctx, username: str):
    # Fetch user information from the database
    user_info = await Database.get_user_info(username)

    # Format the message with user information if user_info is not None
    if user_info:
        response = f"User Information:\nUsername: {user_info['username']}\nEmail: {user_info['email']}\nPassword hash: {user_info['password_hash']}"
    else:
        response = f"No information found for username: {username}"

    await ctx.send(response)



@bot.command(name="getActiveUsers", description="Lists all users in the database with their IDs")
async def get_active_users_command(ctx):
    users = await Database.get_all_users()
    if users:
        user_info = [f"ID: {user['user_id']}, Username: {user['username']}" for user in users]
        response = "List of users:\n" + "\n".join(user_info)
    else:
        response = "No users found in the database."

    await ctx.send(response)





@bot.command(name="listUserSubscriptions", description="Lists all subscriptions for a given username")
async def list_user_subscriptions(ctx, username: str):
    # Fetch user subscriptions from the database
    subscriptions = await Database.get_user_subscriptions(username)

    # Check if subscriptions are found and respond
    if subscriptions:
       
        response = f"Subscriptions for {username}:\n"
        for sub in subscriptions:
            response += f"- Plan: {sub['plan_name']}, Status: {sub['subscription_status']}\n"
    else:
        response = f"No subscriptions found for username: {username}"

    await ctx.send(response)


@bot.command(name="getComplianceReport", description="Retrieves information about a specific compliance report")
async def get_compliance_report_command(ctx, report_name: str):
    # Fetch compliance report from the database
    report = await Database.get_compliance_report(report_name)

    # Check if the report is found and respond
    if report:
        response = f"Compliance Report: {report['report_name']}\n"
        response += f"Regulation Type: {report['regulation_type']}\n"
        response += f"Generation Schedule: {report['generation_schedule']}\n"
        response += f"Export Format: {report['export_format']}\n"
        response += f"Archived: {'Yes' if report['archived'] else 'No'}"
        response += f"user_id: {report['user_id']}\n"
    else:
        response = f"No compliance report found with the name: {report_name}"

    await ctx.send(response)






@bot.command(name="addNewUser", description="Adds a new user with a specified username and email")
async def add_new_user_discord_command(ctx, username: str, email: str):
    # Placeholder for password hashing
    password_hash = "placeholderhash"

    # Check if the user already exists
    existing_user = await Database.get_user_info(username)
    if existing_user:
        await ctx.send(f"User {username} already exists.")
    else:
        # Add new user to the database
        success = await Database.add_new_user(username, email, password_hash)
        if success:
            await ctx.send(f"New user added: Username - {username}, Email - {email}")
        else:
            await ctx.send("Failed to add new user. Please check the details and try again.")



@bot.command(name="subscribeUser", description="Subscribes a user to a new plan or updates their current plan.")
async def subscribe_user(ctx, username: str, plan_name: str):
    # Fetch existing subscriptions for the user
    user_subscriptions = await Database.get_user_subscriptions(username)

    if user_subscriptions:
        # User already has a subscription
        current_subscription = user_subscriptions[0]
        current_plan = current_subscription['plan_name']

        # Define your plan hierarchy
        plan_hierarchy = {
            'Plan1': 1,
            'Plan2': 2,
            'Plan3': 3,
            '': 0
        }

        if plan_hierarchy[plan_name] > plan_hierarchy[current_plan]:
            # User is upgrading their plan
            update_result = await Database.update_subscription(current_subscription['subscription_id'], plan_name, 'active')
            if update_result:
                response = f"User {username} has been upgraded to the {plan_name} plan."
            else:
                response = "Error updating the subscription."
        else:
            # Handle non-upgrade cases (downgrade or lateral move)
            response = "Downgrades or lateral plan changes are not allowed."
    else:
        # User does not have an existing subscription
        add_result = await Database.add_new_subscription(username, plan_name)
        if add_result:
            response = f"User {username} has been subscribed to the {plan_name} plan."
        else:
            response = "Error adding the subscription."

    await ctx.send(response)
  

@bot.command(name="deleteUser", description="Removes a user's account from the database")
async def delete_user_discord_command(ctx, username: str):
    # Delete the user from the database
    success = await Database.delete_user(username)
    if success:
        await ctx.send(f"User {username} has been successfully removed from the database.")
    else:
        await ctx.send(f"Failed to delete user {username}. Please check if the username is correct.")



@bot.command(name="cancelSubscription", description="Cancel a user's subscription plan")
async def cancel_subscription_command(ctx, username: str):
    # Cancel the user's subscription in the database
    success = await Database.cancel_subscription(username)
    if success:
        await ctx.send(f"Subscription cancelled for user {username}.")
    else:
        await ctx.send(f"Failed to cancel subscription for user {username}.")




@bot.command(name="triggerAlert", description="Activate a trigger for logging system alerts")
async def trigger_alert_command(ctx, system_name: str):
    # Log the system alert in the database
    success = await Database.log_system_alert(system_name)
    if success:
        await ctx.send(f"Alert triggered for system: {system_name}.")
    else:
        await ctx.send(f"Failed to trigger alert for system: {system_name}. Please try again.")



@bot.command(name="logIncident", description="Log a new incident report")
async def log_incident_command(ctx, user_id: int, name: str, *, description: str):
    # Log the incident in the database
    success = await Database.log_incident(user_id, name, description)
    if success:
        await ctx.send(f"Incident reported successfully for user ID {user_id}.")
    else:
        await ctx.send(f"Failed to log the incident for user ID {user_id}. Please try again.")



@bot.command(name="generateReport", description="Execute a procedure to generate a compliance report")
async def generate_report_command(ctx, report_name: str, export_format: str, user_id: int):
          # Example values for regulation_type and generation_schedule
          regulation_type = "Type1"
          generation_schedule = "Daily"
          archived = False  # Assuming not archived by default

          success = await Database.generate_compliance_report(report_name, regulation_type, generation_schedule, export_format, archived, user_id)
          if success:
              await ctx.send(f"Compliance report '{report_name}' generated successfully with format {export_format} for user ID {user_id}.")
          else:
              await ctx.send(f"Failed to generate compliance report '{report_name}'.")



@bot.command(name="showReports", description="Display names of all compliance reports")
async def show_reports_command(ctx):
    reports = await Database.fetch_compliance_reports()
    if reports:
        report_names = [report['report_name'] for report in reports]
        response = "List of Compliance Reports:\n" + "\n".join(report_names)
    else:
        response = "No compliance reports found."

    await ctx.send(response)



@bot.command(name="deleteReport", description="Delete a specific compliance report")
async def delete_report_command(ctx, report_name: str):
    # Delete the report from the database
    success = await Database.delete_compliance_report(report_name)
    if success:
        await ctx.send(f"Report '{report_name}' has been successfully deleted.")
    else:
        await ctx.send(f"Failed to delete report '{report_name}'. Please check if the report name is correct.")



@bot.command(name="updateUserPassword", description="Update the password for a user")
async def update_user_password_command(ctx, username: str, new_password: str):
    # Update the user's password in the database
    success = await Database.update_user_password(username, new_password)
    if success:
        await ctx.send(f"Password updated successfully for user {username}.")
    else:
        await ctx.send(f"Failed to update password for user {username}.")



@bot.command(name="updateUserEmail", description="Update the email address for a user")
async def update_user_email_command(ctx, username: str, new_email: str):
    # Update the user's email in the database
    success = await Database.update_user_email(username, new_email)
    if success:
        await ctx.send(f"Email updated successfully for user {username}.")
    else:
        await ctx.send(f"Failed to update email for user {username}.")



bot.run(TOKEN)
