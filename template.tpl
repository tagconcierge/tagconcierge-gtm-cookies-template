___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Tag Concierge GTM Cookies Consent",
  "categories": ["ANALYTICS", "UTILITY", "TAG_MANAGEMENT", "PERSONALISATION"],
  "brand": {
    "id": "tagconcierge",
    "displayName": "Tag Concierge"
  },
  "description": "Basic, stand-alone (no accounts needed) cookie banner compatible with GTM Consent Mode.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "mode",
    "displayName": "Display Mode",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": "bar",
        "displayValue": "Bar (bottom of the page)"
      },
      {
        "value": "modal",
        "displayValue": "Modal (center of the page)"
      }
    ],
    "simpleValueType": true,
    "help": "Choose form of initial screen visible for first visitors. Modal appears in the center of the page may accomodate longer text and title. Bar appears at the bottom of the page and can include shorter text without title."
  },
  {
    "type": "CHECKBOX",
    "name": "wall",
    "checkboxText": "Wall",
    "simpleValueType": true,
    "help": "Wall covers website content until user provides their consent."
  },
  {
    "type": "SELECT",
    "name": "theme",
    "displayName": "Theme",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "light",
        "displayValue": "Light"
      },
      {
        "value": "dark",
        "displayValue": "Dark"
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "PARAM_TABLE",
    "name": "consent_types",
    "displayName": "Consent Types",
    "defaultValue": [{"name":"ad_storage","title":"Ad storage","description":"Enables storage, such as cookies, related to advertising.","default":"denied"},{"name":"analytics_storage","title":"Analytics storage","description":"Enables storage, such as cookies, related to analytics (for example, visit duration).","default":"denied"},{"name":"functionality_storage","title":"Functionality storage","description":"Enables storage that supports the functionality of the website or app such as language settings.","default":"denied"},{"name":"personalization_storage","title":"Personalization storage","description":"Enables storage related to personalization such as video recommendations.","default":"denied"},{"name":"security_storage","title":"Security storage","description":"Enables storage related to security such as authentication functionality, fraud prevention, and other user protection.","default":"denied"}],
    "paramTableColumns": [
      {
        "param": {
          "type": "TEXT",
          "name": "name",
          "displayName": "Name",
          "simpleValueType": true
        },
        "isUnique": true
      },
      {
        "param": {
          "type": "TEXT",
          "name": "title",
          "displayName": "Description",
          "simpleValueType": true
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "description",
          "displayName": "Description",
          "simpleValueType": true
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "SELECT",
          "name": "default",
          "displayName": "Default",
          "macrosInSelect": true,
          "selectItems": [
            {
              "value": "denied",
              "displayValue": "denied"
            },
            {
              "value": "granted",
              "displayValue": "granted"
            }
          ],
          "simpleValueType": true
        },
        "isUnique": false
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "settings",
    "displayName": "Settings Screen",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "settings.title",
        "displayName": "Title",
        "simpleValueType": true,
        "defaultValue": "Cookies Preferences"
      },
      {
        "type": "TEXT",
        "name": "settings.description",
        "displayName": "Description",
        "simpleValueType": true,
        "defaultValue": "This website uses cookies and other technology to provide their services and improve user experience. Below you can find detailed information about each category of cookies in use."
      },
      {
        "type": "GROUP",
        "name": "settings.buttons",
        "displayName": "Buttons",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "TEXT",
            "name": "settings.buttons.save",
            "displayName": "Save Button",
            "simpleValueType": true,
            "defaultValue": "Save settings"
          },
          {
            "type": "TEXT",
            "name": "settings.buttons.close",
            "displayName": "Close Button",
            "simpleValueType": true,
            "defaultValue": "Close"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "modal",
    "displayName": "Bar/Modal Screen",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "modal.title",
        "displayName": "Title",
        "simpleValueType": true,
        "defaultValue": "Cookies & Privacy"
      },
      {
        "type": "TEXT",
        "name": "modal.description",
        "displayName": "Description",
        "simpleValueType": true,
        "defaultValue": "This website uses cookies and other technology to provide their services and improve user experience. You you can accept all cookies usage or use settings to accept categories individually."
      },
      {
        "type": "GROUP",
        "name": "modal.buttons",
        "displayName": "Buttons",
        "groupStyle": "NO_ZIPPY",
        "subParams": [
          {
            "type": "TEXT",
            "name": "modal.buttons.accept",
            "displayName": "Accept Button",
            "simpleValueType": true,
            "defaultValue": "Accept all"
          },
          {
            "type": "TEXT",
            "name": "modal.buttons.settings",
            "displayName": "Settings Button",
            "simpleValueType": true,
            "defaultValue": "Settings"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const JSON = require('JSON');
const Object = require('Object');
const copyFromDataLayer = require('copyFromDataLayer');
const localStorage = require('localStorage');
const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState = require('updateConsentState');
const logToConsole = require('logToConsole');
const injectScript = require('injectScript');
const setInWindow = require('setInWindow');
const templateStorage = require('templateStorage');

const LOCAL_STORAGE_KEY = 'tag_concierge_consents';
const EVENT_HANDLERS = Object.freeze({
  'gtm.init_consent': handleInitConsent,
  'tag_concierge_consent': handleUserPrefUpdate,
});

logToConsole(data);

if (null === templateStorage.getItem('initiatlized')) {
const gtmCookiesConfig = {
    display: {
        mode: data.mode,
        wall: data.wall
    },
    styles: {
        '.button': {
            'text-decoration': 'none',
            background: 'none',
            color: '#333333',
            padding: '4px 10px',
            'border': '1px solid #000',
        },
        '#gtm-cookies-modal': {
            background: "#fff",
            padding: '10px 30px 30px',
            'box-shadow': 'rgba(0, 0, 0, 0.4) 0 0 20px'
        },
        '#gtm-cookies-modal .gtm-cookies-modal-wrapper': {
          margin: '0 auto',
          display: 'flex',
          'justify-content': 'center'
        },
        '#gtm-cookies-modal .gtm-cookies-modal-buttons': {
          'margin-top': '12px',
          'text-align': 'right'
        },
        '#gtm-cookies-modal .gtm-cookies-modal-buttons [href="#accept"]': {
            'color': 'rgb(255 255 255)',
            'border': '1px solid #083b99',
            'background-color': '#083b99'
        },
        '#gtm-cookies-modal .gtm-cookies-modal-buttons [href="#settings"]': {
            'margin-left': '10px'
        },
        '#gtm-cookies-settings .gtm-cookies-settings-buttons': {
          'margin-top': '12px',
          'text-align': 'right'
        },
        '#gtm-cookies-settings .gtm-cookies-settings-buttons [href="#save"]': {
            'color': 'rgb(255 255 255)',
            'border': '1px solid #083b99',
            'background-color': '#083b99'
        },
        '#gtm-cookies-settings .gtm-cookies-settings-buttons [href="#close"]': {
            'margin-left': '10px'
        },
        '#gtm-cookies-settings': {
          position: 'fixed',
          top: '50%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          background: '#fff',
          'box-shadow': 'rgba(0, 0, 0, 0.4) 0 0 20px',
          padding: '10px 30px 30px'
        },
        '#gtm-cookies-settings ul': {
          'list-style': 'none',
          'padding-left': 0
        },
        '#gtm-cookies-settings ul label': {
            'font-weight': 'bold',
            'font-size': '1.1em',
            'margin-left': '5px'
        },
        '#gtm-cookies-settings ul li': {
            'border-bottom': '1px solid rgba(0, 0, 0, .2)',
            'margin-bottom': '15px'
        },
        '#gtm-cookies-settings ul p': {
            'margin-left': '25px'
        }
    },
    consent_types: data.consent_types,
    settings: {
      title: data['settings.title'],
      description: data['settings.description'],
      buttons: {
        save: data['settings.buttons.save'],
        close: data['settings.buttons.close']
      }
    },
    modal: {
      title: data['modal.title'],
      description: data['modal.description'],
      buttons: {
        accept: data['modal.buttons.accept'],
        settings: data['modal.buttons.settings']
      }
    }
};
setInWindow('gtmCookiesConfig', gtmCookiesConfig);
injectScript('https://assets.tagconcierge.com/gtm-cookies.js?v=15');
  templateStorage.setItem('initialized', true);
}


const DEFAULT_CONSENT_CONFIG = Object.freeze({
  ad_storage: 'denied',
  analytics_storage: 'denied',
  functionality_storage: 'denied',
  personalization_storage: 'denied',
  security_storage: 'denied'
});

(function main(data) {
  const event = copyFromDataLayer('event');
  const consentState = copyFromDataLayer('consent_state');
  
  const handler = EVENT_HANDLERS[event];
  
  if (undefined === handler) {
    data.gtmOnSuccess();
    return;
  }
  
  if ('tag_concierge_consent' === event && undefined === consentState) {
    data.gtmOnSuccess();
    return;
  }

  const result = handler(consentState);

  if ( result ) {
    data.gtmOnSuccess();
  } else {
    data.gtmOnFailure();
  }
})(data);

function isConsentStateProvided() {
  return null !== localStorage.getItem(LOCAL_STORAGE_KEY);
}

function loadConsentState() {
  var value = localStorage.getItem(LOCAL_STORAGE_KEY);
  if (null !== value) {
    return JSON.parse(value);
  }
  return null;
}

function handleInitConsent(state) {
  if (isConsentStateProvided()) {
    setDefaultConsentState(loadConsentState());
  } else {
    setDefaultConsentState(DEFAULT_CONSENT_CONFIG);
  }
  return true;
}

function handleUserPrefUpdate(state) {
  updateConsentState(state);
  localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(state));
  return true;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_local_storage",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "tag_concierge_consents"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "event"
              },
              {
                "type": 1,
                "string": "consent_state"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://*.tagconcierge.com/"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmCookiesConfig"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_template_storage",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Untitled test 1
  code: |-
    const mockData = {
      event: 'tag_concierge_consent',
      consents: 'analytics_storage',
    };

    // Call runCode to run the template's code.
    runCode(mockData);

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();


___NOTES___

Created on 29/11/2023, 01:20:43


