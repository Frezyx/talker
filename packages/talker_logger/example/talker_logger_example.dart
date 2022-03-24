import 'dart:convert';

import 'package:talker_logger/talker_logger.dart';

void main() {
  final logger = TalkerLogger(
    settings: const TalkerLoggerSettings(
      level: LogLevel.info,
    ),
  );

  logger.log('Test debug');
  logger.log('Test info', level: LogLevel.info);
  logger.log('Test critical', level: LogLevel.critical);
  logger.log('Test error', level: LogLevel.error);
  logger.log('Test fine', level: LogLevel.fine);
  logger.log('Test good', level: LogLevel.good);
  logger.log('Test warning', level: LogLevel.warning);
  logger.log('Test verbose', level: LogLevel.verbose);
  logger.log('Test custom pen log', pen: AnsiPen()..xterm(49));
  logger.log(
    'Test log orem Ipsum is simply dummy text of\nthe printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
  );

  const encoder = JsonEncoder.withIndent('  ');
  final prettyData = encoder.convert(
    {
      "web-app": {
        "servlet": [
          {
            "servlet-name": "cofaxCDS",
            "servlet-class": "org.cofax.cds.CDSServlet",
            "init-param": {
              "configGlossary:installationAt": "Philadelphia, PA",
              "configGlossary:adminEmail": "ksm@pobox.com",
              "configGlossary:poweredBy": "Cofax",
              "configGlossary:poweredByIcon": "/images/cofax.gif",
              "configGlossary:staticPath": "/content/static",
              "templateProcessorClass": "org.cofax.WysiwygTemplate",
              "templateLoaderClass": "org.cofax.FilesTemplateLoader",
              "templatePath": "templates",
              "templateOverridePath": "",
              "defaultListTemplate": "listTemplate.htm",
              "defaultFileTemplate": "articleTemplate.htm",
              "useJSP": false,
              "jspListTemplate": "listTemplate.jsp",
              "jspFileTemplate": "articleTemplate.jsp",
              "cachePackageTagsTrack": 200,
              "cachePackageTagsStore": 200,
              "cachePackageTagsRefresh": 60,
              "cacheTemplatesTrack": 100,
              "cacheTemplatesStore": 50,
              "cacheTemplatesRefresh": 15,
              "cachePagesTrack": 200,
              "cachePagesStore": 100,
              "cachePagesRefresh": 10,
              "cachePagesDirtyRead": 10,
              "searchEngineListTemplate": "forSearchEnginesList.htm",
              "searchEngineFileTemplate": "forSearchEngines.htm",
              "searchEngineRobotsDb": "WEB-INF/robots.db",
              "useDataStore": true,
              "dataStoreClass": "org.cofax.SqlDataStore",
              "redirectionClass": "org.cofax.SqlRedirection",
              "dataStoreName": "cofax",
              "dataStoreDriver": "com.microsoft.jdbc.sqlserver.SQLServerDriver",
              "dataStoreUrl":
                  "jdbc:microsoft:sqlserver://LOCALHOST:1433;DatabaseName=goon",
              "dataStoreUser": "sa",
              "dataStorePassword": "dataStoreTestQuery",
              "dataStoreTestQuery": "SET NOCOUNT ON;select test='test';",
              "dataStoreLogFile": "/usr/local/tomcat/logs/datastore.log",
              "dataStoreInitConns": 10,
              "dataStoreMaxConns": 100,
              "dataStoreConnUsageLimit": 100,
              "dataStoreLogLevel": "debug",
              "maxUrlLength": 500
            }
          },
          {
            "servlet-name": "cofaxEmail",
            "servlet-class": "org.cofax.cds.EmailServlet",
            "init-param": {"mailHost": "mail1", "mailHostOverride": "mail2"}
          },
          {
            "servlet-name": "cofaxAdmin",
            "servlet-class": "org.cofax.cds.AdminServlet"
          },
          {
            "servlet-name": "fileServlet",
            "servlet-class": "org.cofax.cds.FileServlet"
          },
          {
            "servlet-name": "cofaxTools",
            "servlet-class": "org.cofax.cms.CofaxToolsServlet",
            "init-param": {
              "templatePath": "toolstemplates/",
              "log": 1,
              "logLocation": "/usr/local/tomcat/logs/CofaxTools.log",
              "logMaxSize": "",
              "dataLog": 1,
              "dataLogLocation": "/usr/local/tomcat/logs/dataLog.log",
              "dataLogMaxSize": "",
              "removePageCache": "/content/admin/remove?cache=pages&id=",
              "removeTemplateCache":
                  "/content/admin/remove?cache=templates&id=",
              "fileTransferFolder":
                  "/usr/local/tomcat/webapps/content/fileTransferFolder",
              "lookInContext": 1,
              "adminGroupID": 4,
              "betaServer": true
            }
          }
        ],
        "servlet-mapping": {
          "cofaxCDS": "/",
          "cofaxEmail": "/cofaxutil/aemail/*",
          "cofaxAdmin": "/admin/*",
          "fileServlet": "/static/*",
          "cofaxTools": "/tools/*"
        },
        "taglib": {
          "taglib-uri": "cofax.tld",
          "taglib-location": "/WEB-INF/tlds/cofax.tld"
        }
      }
    },
  );
  logger.log(prettyData);
}
