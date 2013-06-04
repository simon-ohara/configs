### This is where I play with github flavoured markdown

This could be `inline code`
## Sage One SageID

### Process

1. Pull down the `sageone_sageid/xx-sageone branch`
* Make changes to your templates in Visual Studio (this is also where you view/test it in a sandbox environment)
* Push up to the `sageone_sageid` repo
* PR to `de-sageone` branch
* Code review
* Merge
* Email live services with the zip of the `de-sageone` branch
* QA on PreProd (Staging) environment
* Email live services and ask them to update the production environment

````bash
Application
├── PreProd
│   ├── Template # assets like js, css and images
│   │   └── < TEMPLATE_NAME >
|   |
│   └── Views
│       └── SSOViewer # aspx templates
│           └── < TEMPLATE_NAME >
|
└── Production
    ├── Template # assets like js, css and images
    │   └── < TEMPLATE_NAME >
    |
    └── Views
        └── SSOViewer # aspx templates
            └── < TEMPLATE_NAME >



Emails
├── PreProd
│   ├── Content
│   │   └── Email # images
│   │       └── < TEMPLATE_NAME >
|   |
│   └── Template # html and text versions of emails
|
└── Production
    ├── Content
    │   └── Email # images
    │       └── < TEMPLATE_NAME >
    |
    └── Template # html and text versions of emails
````

Enter text in [Markdown](http://daringfireball.net/projects/markdown/). Use the toolbar above, or click the **?** button for formatting help.
