# Introduction 
In this demo you will create a brand new Azure DevOps project and create a new repository and build and release pipeline using continuous integration and continuous delivery.
The build creates a Dacpac solution for release to Azure SQL DB.

# Things to note
If you create a new organisation for your project, it is important that your organisation has approved parallelism settings (which apparently can take 3 days to obtain from MS.

It states "Azure DevOps Parallelism Request
This form is for users to request increased parallelism in Azure DevOps.

Please consider that it could take 2-3 business days to proceed the request. We are working on improving this process at the moment. Sorry for the inconvenience."

If you checkout to different branch whilst folder is in dropbox path then you will run into problems. You shouldn't need to but be warned!

# Getting Started
In this section we will explain how to cleanup from past runs and what preparation and tools you made need for the session.

## Cleanup
1. Make sure that the widgets-project is deleted from your organisation.
2. Ensure that the SQL database is warm and has the right schema in table2
3. Delete the local widgets-database repository

## Preparation
1. You should map your demo folder to the R: drive (see batch file) for easy access
2. You should ensure that you have a command prompt with big enough font
3. You should have SSMS installed on your laptop and test that you can connect to SQLDB
4. Check that the database table2 schema does not have column c3
5. Leave the above query open so that you can demo the change later
6. You should have a pre-rolled backup project in case deployment fails
7. You should have pre-created an Azure SQL Database. Make a note of your server admin and password since you will use it in your pipelines via Keyvault
8. You should already have created a Keyvault in Azure with the correct secrets used in the release pipeline. I have named these secrets as follows:
* sec-devops-dbserver is your security admin account name, set content type to Security Principal
* res-devops-dbserver is your server connection string
8 pwd-devops-dbserver is your security admin account password

# Instructions
## New project
1. In demo-devops-org, create project widgets-project (git / basic)
2. So you don't forget, under pipelines\ library create a new variable group called "Primary Keyvault" to your keyvault created in your subscription and authorise these.
Ensure you select variables pwd-*, res-*, and sec-*

## New repository
1. Create new repository widgets-database
2. create new branch development
3. On main branch set BRANCH Policy to require min 1 reviewer and allow own approval
4. In development branch upload widgets-database-source files

## New build pipeline
1. Import build pipeline from widgets-database build.json
2. Rename pipeline, configure agent pool to Azure Pipelines, configure agent spec to Windows 2019
3. Check and point out continuous integration trigger is set
4. Save (but do not run)

## New release pipeline
1. Import release pipeline from widgets-database release.json
2. Rename pipeline
3. Delete artifact and add correct one back in
4. Set continuous deployment trigger
5. Fix db agent job and dacpac task (select subscription)
6. Link variable group and check variables in scope

## CICD demo part1
1. Clone widgets-database repo
2. notepad table2.sql and update to change table definition for a new [c3] column as follows:
CREATE TABLE [dbo].[Table2]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [c1] NCHAR(10) NULL, 
    [c2] NCHAR(10) NOT NULL DEFAULT 0,
    [c3] NCHAR(10)
)
3. git status
4. git add .
5. git commit -m "update to table2"
6. git push

## CICD demo part2
1. Create a new pull request in widgets-database repo to main
2. Watch running build
3. Quickly view artifact
4. Watch running release

## Time permitting
* View change table schema on SQL Database
* View IaC pipeline with focus on variables
* View ARM deployment code
