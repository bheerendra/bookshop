# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch` 
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)


# Vscode Local Development Setup

- Install Node.js
Get latest node js Long Term Supported version (LTS) from https://nodejs.org/en/download/

- Install Git
Get latest installer from  https://git-scm.com/download/win and install

- Set Node SAP Registry

`npm config set @sap:registry http://registry.npmjs.org`

- Install ui cli

`npm install --global @ui5/cli`

- Install cds development kit command line

`npm install --global @sap/cds-dk`

- Yeoman to kickstart new projects, using generators/templates

`npm install --global yo`

- Cloud MTA Build Tool builds a deployment-ready multitarget application (MTA) archive .mtar file

`npm install -g mbt`

- SAP HANA admin and metadata inspection functionality

`npm install -g hana-cli`

- Grunt

`npm install -g grunt-cli`

- Download and Install Cloud Foundry

https://packages.cloudfoundry.org/stable?release=windows64&version=v7&source=github

- Install CF Plugin - Default-Env

`cf install-plugin DefaultEnv -f`

- CF plugin - multiapps

`cf install-plugin multiapps -f`

- Install VSCode

Download and install latest vscode from https://code.visualstudio.com/download

- Install VSCode extensions

Extension | Purpose
---------|----------
SAP CDS Language Support | CDS Language support for highlighting, linting etc
XML Toolkit | XML Syntax validation
Application Wizard | Application generator
SAP Fiori tools - Extension Pack | Bundle
SAP Fiori tools – Application Modeler | Page design, Navigations
SAP Fiori tools – Guided Development | How to guides
SAP Fiori tools – Service Modeler | OData visualization, annotation
SAP Fiori tools – XML Annotation Language Server | micro snippets, hints
    
- In VSCode, Explore and Install generators (Ctrl + Shift + P)

`starting with @sap`

# Create a CAP Project
- Run yeoman generator, provide name and choose HANA/MTA options

`yo @sap/cap-project`

- Modify mta.yaml, Adjust the path from gen/db to just db

- Modify package.json  to prefer hana deployment

```
"cds": {
			"build": {
				"tasks": [
					{
						"for": "hana",
						"dest": "../db"
					},
					{
						"for": "node-cf"
					}
				]
			},
			"hana": {
				"deploy-format": "hdbtable"
			},
			"requires": {
				"db": {
					"kind": "hana"
				}
			}
		}
```

- Update node dependencies mentione din package.json

`npm install`


- Create seperate package.json with HDI Deployer, update .hdiconfig

`hana-cli createModule`


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.
