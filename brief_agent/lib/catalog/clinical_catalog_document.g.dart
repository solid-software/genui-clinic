// Generated from the app's catalog by test/agent_catalog_test.dart; do not
// edit. To regenerate, from app/:
//
//   UPDATE_AGENT_CATALOG=1 flutter test test/agent_catalog_test.dart

/// The app's catalog as an A2UI catalog document.
abstract final class ClinicalCatalogDocument {
  /// The document, as JSON.
  static const String json = r'''
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "protocolVersion": "1.0",
  "catalogId": "com.clinicalbrief.catalog.v1",
  "instructions": "For layout, use the Row and Column components to organize other components.\n\n## Catalog Guidelines\n\n1. String Concatenation & Formatting: A2UI does not support binary operators like '+' or formatting symbols. To concatenate strings or dynamically inject data bindings into text, you must use the catalog function `formatString(value)` where the value string contains placeholders formatted as `${expression}`:\n   formatString(\"Hello ${/user/name}\")\n\n2. Strict Hierarchy: You must strictly adhere to the requested component nesting and hierarchy. If the prompt specifies that a component is 'inside' or 'contained in' another component, you MUST place it as a child of that specific component, not as a sibling or in a different container.\n\n3. Validation Checks: When components support validation checks, specify any custom error messages directly as the 'message' inside the check. Do NOT create separate text-display components to display validation errors.\n\n## Examples\n\nExample 1: Dynamic text form\n```json\n[\n  {\n    \"version\": \"1.0\",\n    \"createSurface\": {\n      \"surfaceId\": \"main\",\n      \"catalogId\": \"https://a2ui.org/specification/v1_0/catalogs/basic/catalog.json\",\n      \"components\": [\n        {\n          \"id\": \"root\",\n          \"component\": \"Column\",\n          \"children\": [\"repField\", \"valueField\"]\n        },\n        {\n          \"id\": \"repField\",\n          \"component\": \"TextField\",\n          \"label\": \"Representative\",\n          \"value\": {\"@path\": \"/form/rep\"},\n          \"placeholder\": \"Enter name\"\n        },\n        {\n          \"id\": \"valueField\",\n          \"component\": \"TextField\",\n          \"label\": \"Deal Value\",\n          \"value\": {\"@path\": \"/form/value\"},\n          \"placeholder\": \"0.00\",\n          \"variant\": \"number\",\n          \"checks\": [\n            {\n              \"condition\": {\n                \"@call\": \"required\",\n                \"args\": {\"value\": {\"@path\": \"/form/value\"}}\n              },\n              \"message\": \"Deal value is required.\"\n            }\n          ]\n        }\n      ],\n      \"dataModel\": {\n        \"form\": {\n          \"rep\": \"John Doe\",\n          \"value\": 1500.00\n        }\n      }\n    }\n  }\n]\n```\n\nExample 2: Dynamic list with templates\n```json\n[\n  {\n    \"version\": \"1.0\",\n    \"createSurface\": {\n      \"surfaceId\": \"main\",\n      \"catalogId\": \"https://a2ui.org/specification/v1_0/catalogs/basic/catalog.json\",\n      \"components\": [\n        {\n          \"id\": \"root\",\n          \"component\": \"Card\",\n          \"child\": \"breedList\"\n        },\n        {\n          \"id\": \"breedList\",\n          \"component\": \"List\",\n          \"children\": {\n            \"path\": \"/breeds\",\n            \"componentId\": \"breedTemplate\"\n          },\n          \"direction\": \"horizontal\"\n        },\n        {\n          \"id\": \"breedTemplate\",\n          \"component\": \"Image\",\n          \"url\": {\"@path\": \"url\"}\n        }\n      ],\n      \"dataModel\": {\n        \"breeds\": [\n          {\n            \"url\": \"https://example.com/poodle.jpg\"\n          },\n          {\n            \"url\": \"https://example.com/lab.jpg\"\n          }\n        ]\n      }\n    }\n  }\n]\n```",
  "components": {
    "Button": {
      "type": "object",
      "allOf": [
        {
          "$ref": "common_types.json#/$defs/Checkable"
        },
        {
          "type": "object",
          "properties": {
            "component": {
              "const": "Button"
            },
            "child": {
              "$ref": "common_types.json#/$defs/Child",
              "description": "The ID of the child component. Use a 'Text' component for a labeled button. Only use an 'Icon' if the requirements explicitly ask for an icon-only button."
            },
            "variant": {
              "type": "string",
              "description": "A hint for the button style. If omitted, a default button style is used. 'primary' indicates this is the main call-to-action button. 'borderless' means the button has no visual border or background, making its child content appear like a clickable link.",
              "enum": [
                "default",
                "primary",
                "borderless"
              ],
              "default": "default"
            },
            "action": {
              "$ref": "common_types.json#/$defs/Action"
            },
            "weight": {
              "$ref": "#/$defs/Weight"
            }
          },
          "required": [
            "component",
            "child",
            "action"
          ]
        }
      ]
    },
    "Card": {
      "type": "object",
      "properties": {
        "component": {
          "const": "Card"
        },
        "child": {
          "$ref": "common_types.json#/$defs/Child",
          "description": "The ID of the single child component to be rendered inside the card. To display multiple elements, you MUST wrap them in a layout component (like Column or Row) and pass that container's ID here. Do NOT pass multiple IDs or a non-existent ID."
        },
        "weight": {
          "$ref": "#/$defs/Weight"
        }
      },
      "required": [
        "component",
        "child"
      ]
    },
    "Column": {
      "type": "object",
      "description": "A layout component that arranges its children vertically. To create a grid layout, nest Rows within this Column.",
      "properties": {
        "component": {
          "const": "Column"
        },
        "children": {
          "description": "Defines the children. Use an array of strings for a fixed set of children, or a template object to generate children from a data list. Children cannot be defined inline, they must be referred to by ID.",
          "$ref": "common_types.json#/$defs/ChildList"
        },
        "justify": {
          "type": "string",
          "description": "Defines the arrangement of children along the main axis (vertically). Use 'spaceBetween' to push items to the edges (e.g. header at top, footer at bottom), or 'start'/'end'/'center' to pack them together.",
          "enum": [
            "start",
            "center",
            "end",
            "spaceBetween",
            "spaceAround",
            "spaceEvenly",
            "stretch"
          ],
          "default": "start"
        },
        "align": {
          "type": "string",
          "description": "Defines the alignment of children along the cross axis (horizontally). This is similar to the CSS 'align-items' property.",
          "enum": [
            "center",
            "end",
            "start",
            "stretch"
          ],
          "default": "stretch"
        },
        "weight": {
          "$ref": "#/$defs/Weight"
        }
      },
      "required": [
        "component",
        "children"
      ]
    },
    "Divider": {
      "type": "object",
      "properties": {
        "component": {
          "const": "Divider"
        },
        "axis": {
          "type": "string",
          "description": "The orientation of the divider.",
          "enum": [
            "horizontal",
            "vertical"
          ],
          "default": "horizontal"
        },
        "weight": {
          "$ref": "#/$defs/Weight"
        }
      },
      "required": [
        "component"
      ]
    },
    "Icon": {
      "type": "object",
      "properties": {
        "component": {
          "const": "Icon"
        },
        "name": {
          "description": "The name of the icon to display.",
          "oneOf": [
            {
              "type": "string",
              "enum": [
                "accountCircle",
                "add",
                "arrowBack",
                "arrowForward",
                "attachFile",
                "calendarToday",
                "call",
                "camera",
                "check",
                "close",
                "delete",
                "download",
                "edit",
                "event",
                "error",
                "fastForward",
                "favorite",
                "favoriteOff",
                "folder",
                "help",
                "home",
                "info",
                "locationOn",
                "lock",
                "lockOpen",
                "mail",
                "menu",
                "moreVert",
                "moreHoriz",
                "notificationsOff",
                "notifications",
                "pause",
                "payment",
                "person",
                "phone",
                "photo",
                "play",
                "print",
                "refresh",
                "rewind",
                "search",
                "send",
                "settings",
                "share",
                "shoppingCart",
                "skipNext",
                "skipPrevious",
                "star",
                "starHalf",
                "starOff",
                "stop",
                "upload",
                "visibility",
                "visibilityOff",
                "volumeDown",
                "volumeMute",
                "volumeOff",
                "volumeUp",
                "warning"
              ]
            },
            {
              "type": "object",
              "properties": {
                "svgPath": {
                  "$ref": "common_types.json#/$defs/DynamicString"
                }
              },
              "required": [
                "svgPath"
              ],
              "additionalProperties": false
            },
            {
              "$ref": "common_types.json#/$defs/DataBinding"
            }
          ]
        },
        "weight": {
          "$ref": "#/$defs/Weight"
        }
      },
      "required": [
        "component",
        "name"
      ]
    },
    "List": {
      "type": "object",
      "properties": {
        "component": {
          "const": "List"
        },
        "children": {
          "description": "Defines the children. Use an array of strings for a fixed set of children, or a template object to generate children from a data list.",
          "$ref": "common_types.json#/$defs/ChildList"
        },
        "direction": {
          "type": "string",
          "description": "The direction in which the list items are laid out.",
          "enum": [
            "vertical",
            "horizontal"
          ],
          "default": "vertical"
        },
        "align": {
          "type": "string",
          "description": "Defines the alignment of children along the cross axis.",
          "enum": [
            "start",
            "center",
            "end",
            "stretch"
          ],
          "default": "stretch"
        },
        "weight": {
          "$ref": "#/$defs/Weight"
        }
      },
      "required": [
        "component",
        "children"
      ]
    },
    "Row": {
      "type": "object",
      "description": "A layout component that arranges its children horizontally. To create a grid layout, nest Columns within this Row.",
      "properties": {
        "component": {
          "const": "Row"
        },
        "children": {
          "description": "Defines the children. Use an array of strings for a fixed set of children, or a template object to generate children from a data list. Children cannot be defined inline, they must be referred to by ID.",
          "$ref": "common_types.json#/$defs/ChildList"
        },
        "justify": {
          "type": "string",
          "description": "Defines the arrangement of children along the main axis (horizontally). Use 'spaceBetween' to push items to the edges, or 'start'/'end'/'center' to pack them together.",
          "enum": [
            "center",
            "end",
            "spaceAround",
            "spaceBetween",
            "spaceEvenly",
            "start",
            "stretch"
          ],
          "default": "start"
        },
        "align": {
          "type": "string",
          "description": "Defines the alignment of children along the cross axis (vertically). This is similar to the CSS 'align-items' property, but uses camelCase values (e.g., 'start').",
          "enum": [
            "start",
            "center",
            "end",
            "stretch"
          ],
          "default": "stretch"
        },
        "weight": {
          "$ref": "#/$defs/Weight"
        }
      },
      "required": [
        "component",
        "children"
      ]
    },
    "Text": {
      "type": "object",
      "properties": {
        "component": {
          "const": "Text"
        },
        "text": {
          "$ref": "common_types.json#/$defs/DynamicString",
          "description": "The text content to display. While simple Markdown formatting is supported (i.e. without HTML, images, or links), utilizing dedicated UI components is generally preferred for a richer and more structured presentation."
        },
        "variant": {
          "type": "string",
          "description": "A hint for the base text style.",
          "enum": [
            "caption",
            "body"
          ],
          "default": "body"
        },
        "weight": {
          "$ref": "#/$defs/Weight"
        }
      },
      "required": [
        "component",
        "text"
      ]
    },
    "SafetyBanner": {
      "type": "object",
      "description": "The pinned safety band at the very top of a brief. Always emit exactly one of these as the first child of the root, with the columns Allergies, Active medication and Anticoagulation.",
      "properties": {
        "entries": {
          "type": "array",
          "description": "One column per safety fact, in reading order.",
          "items": {
            "type": "object",
            "properties": {
              "label": {
                "type": "string",
                "description": "Column heading."
              },
              "value": {
                "type": "string",
                "description": "The fact itself. Never leave this blank: write \"None known\" or \"None\" when there is nothing to report."
              }
            },
            "required": [
              "label",
              "value"
            ]
          }
        },
        "tone": {
          "type": "string",
          "description": "Use \"critical\" when any column carries an allergy or an anticoagulant, otherwise \"neutral\".",
          "enum": [
            "neutral",
            "warning",
            "critical"
          ]
        }
      },
      "required": [
        "entries"
      ]
    },
    "TrendChart": {
      "type": "object",
      "description": "A measurement plotted over time. Prefer this over any list or sentence whenever a value has two or more readings on file: the shape of the line is the finding. Always place it inside a ChartGroup rather than directly in a Column.",
      "properties": {
        "title": {
          "type": "string",
          "description": "Name of the measurement."
        },
        "trailing": {
          "type": "string",
          "description": "Unit and period, e.g. \"g/L - 18 months\". Shown top right."
        },
        "caption": {
          "type": "string",
          "description": "One line of context that the numbers alone do not carry, e.g. \"4 results, 4 different doctors\" or \"-7 kg in 11 months, never reported\"."
        },
        "points": {
          "type": "array",
          "description": "Readings, oldest first.",
          "items": {
            "type": "object",
            "properties": {
              "label": {
                "type": "string",
                "description": "Short axis label, e.g. Mar 25."
              },
              "value": {
                "type": "number",
                "description": "The measured value."
              },
              "note": {
                "type": "string",
                "description": "What the record says about this one reading - who took it, at which visit, what was written that day. Shown when the doctor taps the point, so it should add something the line does not already say."
              }
            },
            "required": [
              "label",
              "value"
            ]
          }
        },
        "compact": {
          "type": "boolean",
          "description": "Half height, with the readings named in the caption instead of on the line. Use it when several charts share the screen, or when the shape matters more than each value."
        },
        "referenceValue": {
          "type": "number",
          "description": "Optional threshold drawn as a dashed line, normally the limit of normal that the series is crossing."
        },
        "tone": {
          "type": "string",
          "description": "Use \"warning\" or \"critical\" when the trend itself is the concern, not merely the latest value.",
          "enum": [
            "neutral",
            "warning",
            "critical"
          ]
        }
      },
      "required": [
        "title",
        "points"
      ]
    },
    "MeasurementRow": {
      "type": "object",
      "description": "Numbers measured today, shown large as tiles. Use it for the readings written in the complaint text - blood pressure, oxygen saturation, pulse, temperature - and for nothing else.",
      "properties": {
        "measurements": {
          "type": "array",
          "description": "Tiles, most relevant to the complaint first.",
          "items": {
            "type": "object",
            "properties": {
              "label": {
                "type": "string",
                "description": "What was measured."
              },
              "value": {
                "type": "string",
                "description": "The reading, exactly as written, e.g. \"89%\"."
              },
              "meta": {
                "type": "string",
                "description": "Optional line under the number, for where it sits against the record or an earlier reading today, e.g. \"was 95% at check-in\"."
              },
              "tone": {
                "type": "string",
                "description": "Raise this only for a reading out of range.",
                "enum": [
                  "neutral",
                  "warning",
                  "critical"
                ]
              }
            },
            "required": [
              "label",
              "value"
            ]
          }
        }
      },
      "required": [
        "measurements"
      ]
    },
    "ImagingTimeline": {
      "type": "object",
      "description": "Scans, X-rays and other studies on a time line, oldest first. Use it when what was imaged, and how long ago, bears on the complaint - especially when the gap since the last study is part of the picture.",
      "properties": {
        "title": {
          "type": "string",
          "description": "Group heading, e.g. \"Chest imaging\"."
        },
        "sinceNote": {
          "type": "string",
          "description": "What has happened since the last study, e.g. \"Nothing since November 2021.\"."
        },
        "events": {
          "type": "array",
          "description": "Studies, oldest first.",
          "items": {
            "type": "object",
            "properties": {
              "modality": {
                "type": "string",
                "description": "What was done."
              },
              "date": {
                "type": "string",
                "description": "When, e.g. \"Nov 2021\"."
              },
              "conclusion": {
                "type": "string",
                "description": "What it showed."
              },
              "image": {
                "type": "string",
                "description": "The \"image\" path from the record entry, exactly, when it has one. Shown as a thumbnail the doctor can open."
              },
              "tone": {
                "type": "string",
                "description": "Raise this only for a red-flag study.",
                "enum": [
                  "neutral",
                  "warning",
                  "critical"
                ]
              }
            },
            "required": [
              "modality",
              "date",
              "conclusion"
            ]
          }
        }
      },
      "required": [
        "title",
        "events"
      ]
    },
    "XRayImage": {
      "type": "object",
      "description": "An X-ray or CT image from the record, shown large, for the study that bears most on the complaint. Use it only for a study whose record entry has an \"image\" path, and copy that path exactly. Other studies with images go in an ImagingTimeline with their image, as thumbnails.",
      "properties": {
        "title": {
          "type": "string",
          "description": "Heading, e.g. \"Chest X-ray\" or \"CT abdomen\"."
        },
        "image": {
          "type": "string",
          "description": "The \"image\" path from the record entry, exactly."
        },
        "date": {
          "type": "string",
          "description": "When it was taken, e.g. \"Nov 2021\"."
        },
        "conclusion": {
          "type": "string",
          "description": "The reported conclusion."
        },
        "caption": {
          "type": "string",
          "description": "Optional line under the heading, e.g. \"No chest imaging since\"."
        }
      },
      "required": [
        "title",
        "image",
        "date",
        "conclusion"
      ]
    },
    "MedicationTable": {
      "type": "object",
      "description": "The medication list as a table. Use it when the complaint is about what the patient takes - a review, a new prescription, a symptom that medication bears on - rather than repeating the banner, which only names the medicines.",
      "properties": {
        "title": {
          "type": "string",
          "description": "Group heading."
        },
        "footnote": {
          "type": "string",
          "description": "Optional muted line under the table."
        },
        "medications": {
          "type": "array",
          "description": "Rows, most relevant to the complaint first.",
          "items": {
            "type": "object",
            "properties": {
              "name": {
                "type": "string",
                "description": "The medicine."
              },
              "dose": {
                "type": "string",
                "description": "The dose as written."
              },
              "schedule": {
                "type": "string",
                "description": "How it is taken."
              },
              "note": {
                "type": "string",
                "description": "Optional line under the name, for what the record says about it, e.g. \"over the counter, patient-reported\"."
              },
              "tone": {
                "type": "string",
                "description": "Raise this only for a row that needs attention.",
                "enum": [
                  "neutral",
                  "warning",
                  "critical"
                ]
              }
            },
            "required": [
              "name",
              "dose",
              "schedule"
            ]
          }
        }
      },
      "required": [
        "title",
        "medications"
      ]
    },
    "CareGapList": {
      "type": "object",
      "description": "A checklist of follow-ups the record shows as due, overdue or never done: a repeat scan advised years ago, a test left inconclusive, a risk factor last confirmed long ago. Use it when what is missing from the record matters more than what is in it.",
      "properties": {
        "title": {
          "type": "string",
          "description": "Group heading."
        },
        "gaps": {
          "type": "array",
          "description": "Items, longest overdue or most relevant first.",
          "items": {
            "type": "object",
            "properties": {
              "item": {
                "type": "string",
                "description": "What is outstanding."
              },
              "due": {
                "type": "string",
                "description": "When it was due or last done, shown on the right, e.g. \"due 2021\" or \"last done 2018\"."
              },
              "status": {
                "type": "string",
                "description": "Optional line under the item, for what the record says about it, e.g. \"advised after polyp removal\"."
              },
              "tone": {
                "type": "string",
                "description": "Raise this for an item long overdue.",
                "enum": [
                  "neutral",
                  "warning",
                  "critical"
                ]
              }
            },
            "required": [
              "item",
              "due"
            ]
          }
        }
      },
      "required": [
        "title",
        "gaps"
      ]
    },
    "LabPanel": {
      "type": "object",
      "description": "One set of results from one day: the values out of range in full, and a count of the rest. Use it for the latest results when what matters is where today's numbers sit against their ranges. Use a TrendChart instead when what matters is the direction over time.",
      "properties": {
        "title": {
          "type": "string",
          "description": "Panel name, e.g. \"Blood panel\"."
        },
        "source": {
          "type": "string",
          "description": "Where and when, e.g. \"Urgent care - 8 Sep 2026\"."
        },
        "flagged": {
          "type": "array",
          "description": "Results out of range, most striking first.",
          "items": {
            "type": "object",
            "properties": {
              "name": {
                "type": "string",
                "description": "What was measured."
              },
              "value": {
                "type": "string",
                "description": "Value with unit, e.g. \"18 ng/mL\"."
              },
              "referenceRange": {
                "type": "string",
                "description": "Normal range, e.g. \"ref 30 - 400\"."
              },
              "status": {
                "type": "string",
                "description": "Where it sits, in one to three words: \"Below range\", \"Above range\", \"Low in range\". Nothing else here."
              },
              "history": {
                "type": "string",
                "description": "Optional earlier values, shown as a small line under the result, e.g. \"was 12.4 in Jan 2026\"."
              },
              "tone": {
                "type": "string",
                "description": "Defaults to warning; raise for a stark value.",
                "enum": [
                  "neutral",
                  "warning",
                  "critical"
                ]
              }
            },
            "required": [
              "name",
              "value",
              "status"
            ]
          }
        },
        "normalSummary": {
          "type": "string",
          "description": "How the rest came back, e.g. \"7 other markers within range\". Only state a count the record supports."
        }
      },
      "required": [
        "title",
        "flagged"
      ]
    },
    "BarComparison": {
      "type": "object",
      "description": "Values compared as bars, with an optional target drawn across them. Use it to compare things measured on the same scale, or one value against its target. For a value over time use a TrendChart.",
      "properties": {
        "title": {
          "type": "string",
          "description": "Group heading."
        },
        "caption": {
          "type": "string",
          "description": "One line of context."
        },
        "target": {
          "type": "number",
          "description": "Optional target drawn as a line across the bars."
        },
        "targetLabel": {
          "type": "string",
          "description": "What the target is, e.g. \"target below 7%\"."
        },
        "entries": {
          "type": "array",
          "description": "Bars, in the order they should be read.",
          "items": {
            "type": "object",
            "properties": {
              "label": {
                "type": "string",
                "description": "What the bar stands for."
              },
              "value": {
                "type": "number",
                "description": "The plotted value."
              },
              "display": {
                "type": "string",
                "description": "How the value should read, e.g. \"9.6 %\"."
              },
              "tone": {
                "type": "string",
                "description": "Raise this for a bar past its target.",
                "enum": [
                  "neutral",
                  "warning",
                  "critical"
                ]
              }
            },
            "required": [
              "label",
              "value"
            ]
          }
        }
      },
      "required": [
        "title",
        "entries"
      ]
    },
    "EcgStrip": {
      "type": "object",
      "description": "A rhythm strip drawn at a given heart rate, for a complaint about the heartbeat or a pulse that is out of range. The trace is drawn from the rate and rhythm you give, so both must come from the record or the complaint. Do not use it to imply a reading that was not taken.",
      "properties": {
        "rate": {
          "type": "integer",
          "description": "Beats per minute."
        },
        "irregular": {
          "type": "boolean",
          "description": "True only when the record or the complaint says the rhythm is irregular."
        },
        "caption": {
          "type": "string",
          "description": "Where the rate came from, e.g. \"taken during exam\"."
        },
        "footnote": {
          "type": "string",
          "description": "Optional muted closing line."
        },
        "tone": {
          "type": "string",
          "description": "Raise this for a rate out of range.",
          "enum": [
            "neutral",
            "warning",
            "critical"
          ]
        }
      },
      "required": [
        "rate"
      ]
    },
    "SplitSection": {
      "type": "object",
      "description": "Two columns of sections side by side, the first wider than the second, stacked on a narrow screen. Use it to lay a brief out as a dashboard read at once, rather than as one stack read top to bottom.",
      "properties": {
        "primary": {
          "description": "Ids of the sections in the wider left column.",
          "$ref": "common_types.json#/$defs/ChildList"
        },
        "secondary": {
          "description": "Ids of the sections in the narrower right column.",
          "$ref": "common_types.json#/$defs/ChildList"
        }
      },
      "required": [
        "primary",
        "secondary"
      ]
    },
    "SectionGrid": {
      "type": "object",
      "description": "Sections laid out in a grid, each as wide as you say. Twelve is a full row, six a half, four a third; sections flow into rows and stack on a narrow screen. Use it to lay a whole brief out as a dashboard, with the leading section full width and the supporting ones beside each other.",
      "properties": {
        "sections": {
          "description": "Ids of the sections, in reading order.",
          "$ref": "common_types.json#/$defs/ChildList"
        },
        "widths": {
          "type": "array",
          "description": "Width of each section in twelfths, one per section, in the same order: 12, 6 or 4.",
          "items": {
            "type": "integer"
          }
        }
      },
      "required": [
        "sections",
        "widths"
      ]
    },
    "ChartGroup": {
      "type": "object",
      "description": "Places TrendCharts side by side, two per row, when the screen is wide enough, and stacks them on narrow screens. Every TrendChart belongs in one. Prefer two charts per group: half a row each is the normal size for a chart, and a chart alone in a group takes the whole row.",
      "properties": {
        "children": {
          "description": "Ids of the TrendChart components in this group, in ranking order.",
          "$ref": "common_types.json#/$defs/ChildList"
        }
      },
      "required": [
        "children"
      ]
    },
    "FactList": {
      "type": "object",
      "description": "A titled group of chart lines, for facts that have no trend to plot: history, risk factors, prior imaging, current problems.",
      "properties": {
        "title": {
          "type": "string",
          "description": "Group heading."
        },
        "footnote": {
          "type": "string",
          "description": "Optional muted line under the group. Use it to state an absence that matters, e.g. \"Nothing since.\"."
        },
        "entries": {
          "type": "array",
          "description": "Lines, most relevant to the complaint first.",
          "items": {
            "type": "object",
            "properties": {
              "label": {
                "type": "string",
                "description": "What the fact is."
              },
              "value": {
                "type": "string",
                "description": "What it says."
              },
              "meta": {
                "type": "string",
                "description": "Recency or provenance, shown muted on the right, e.g. \"since 2018\" or \"last recorded 2019\"."
              },
              "tone": {
                "type": "string",
                "description": "Raise this only for a red-flag line.",
                "enum": [
                  "neutral",
                  "warning",
                  "critical"
                ]
              }
            },
            "required": [
              "label"
            ]
          }
        }
      },
      "required": [
        "title",
        "entries"
      ]
    }
  },
  "functions": {
    "required": {
      "type": "object",
      "description": "Checks that the value is not null, undefined, or empty.",
      "returnType": "validationResult",
      "properties": {
        "@call": {
          "const": "required"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "description": "The value to check."
            }
          },
          "required": [
            "value"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "regex": {
      "type": "object",
      "description": "Checks that the value matches a regular expression string.",
      "returnType": "validationResult",
      "properties": {
        "@call": {
          "const": "regex"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicString"
            },
            "pattern": {
              "type": "string",
              "description": "The regular expression to search for in the value. Uses the A2UI regex dialect: a portable subset of ECMAScript pattern syntax in Unicode mode with no flags. Matching is case-sensitive, '.' excludes line terminators, and '^' and '$' match only at the ends of the value. Backreferences, lookbehind, named groups and '\\p{...}' are not allowed. Patterns longer than 256 code points or that could backtrack catastrophically are rejected."
            }
          },
          "required": [
            "value",
            "pattern"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "length": {
      "type": "object",
      "description": "Checks string length constraints.",
      "returnType": "validationResult",
      "properties": {
        "@call": {
          "const": "length"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicString"
            },
            "min": {
              "type": "integer",
              "minimum": 0,
              "description": "The minimum allowed length."
            },
            "max": {
              "type": "integer",
              "minimum": 0,
              "description": "The maximum allowed length."
            }
          },
          "required": [
            "value"
          ],
          "anyOf": [
            {
              "required": [
                "min"
              ]
            },
            {
              "required": [
                "max"
              ]
            }
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "numeric": {
      "type": "object",
      "description": "Checks numeric range constraints.",
      "returnType": "validationResult",
      "properties": {
        "@call": {
          "const": "numeric"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicNumber"
            },
            "min": {
              "type": "number",
              "description": "The minimum allowed value."
            },
            "max": {
              "type": "number",
              "description": "The maximum allowed value."
            }
          },
          "required": [
            "value"
          ],
          "anyOf": [
            {
              "required": [
                "min"
              ]
            },
            {
              "required": [
                "max"
              ]
            }
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "email": {
      "type": "object",
      "description": "Checks that the value is a valid email address.",
      "returnType": "validationResult",
      "properties": {
        "@call": {
          "const": "email"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicString"
            }
          },
          "required": [
            "value"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "formatString": {
      "type": "object",
      "description": "Performs string interpolation of data model values and other functions in the catalog functions list and returns the resulting string. The value string can contain interpolated expressions in the `${expression}` format. Supported expression types include: JSON Pointer paths to the data model (e.g., `${/absolute/path}` or `${relative/path}`), and renderer-side function calls (e.g., `${now()}`). Function arguments must be named (e.g., `${formatDate(value:${/currentDate}, format:'MM-dd')}`). To include a literal `${` sequence, escape it as `\\${`.",
      "returnType": "string",
      "properties": {
        "@call": {
          "const": "formatString"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicString"
            }
          },
          "required": [
            "value"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "formatNumber": {
      "type": "object",
      "description": "Formats a number with the specified grouping and decimal precision.",
      "returnType": "string",
      "properties": {
        "@call": {
          "const": "formatNumber"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicNumber",
              "description": "The number to format."
            },
            "decimals": {
              "$ref": "common_types.json#/$defs/DynamicNumber",
              "description": "Optional. The number of decimal places to show. Defaults to 0 or 2 depending on locale."
            },
            "grouping": {
              "$ref": "common_types.json#/$defs/DynamicBoolean",
              "description": "Optional. If true, uses locale-specific grouping separators (e.g. '1,000'). If false, returns raw digits (e.g. '1000'). Defaults to true."
            }
          },
          "required": [
            "value"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "formatCurrency": {
      "type": "object",
      "description": "Formats a number as a currency string.",
      "returnType": "string",
      "properties": {
        "@call": {
          "const": "formatCurrency"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicNumber",
              "description": "The monetary amount."
            },
            "currency": {
              "$ref": "common_types.json#/$defs/DynamicString",
              "description": "The ISO 4217 currency code (e.g., 'USD', 'EUR')."
            },
            "decimals": {
              "$ref": "common_types.json#/$defs/DynamicNumber",
              "description": "Optional. The number of decimal places to show. Defaults to 0 or 2 depending on locale."
            },
            "grouping": {
              "$ref": "common_types.json#/$defs/DynamicBoolean",
              "description": "Optional. If true, uses locale-specific grouping separators (e.g. '1,000'). If false, returns raw digits (e.g. '1000'). Defaults to true."
            }
          },
          "required": [
            "currency",
            "value"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "formatDate": {
      "type": "object",
      "description": "Formats a timestamp into a string using a pattern.",
      "returnType": "string",
      "properties": {
        "@call": {
          "const": "formatDate"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicValue",
              "description": "The date to format."
            },
            "format": {
              "$ref": "common_types.json#/$defs/DynamicString",
              "description": "A Unicode TR35 date pattern string.\n\nToken Reference:\n- Year: 'yy' (26), 'yyyy' (2026)\n- Month: 'M' (1), 'MM' (01), 'MMM' (Jan), 'MMMM' (January)\n- Day: 'd' (1), 'dd' (01), 'E' (Tue), 'EEEE' (Tuesday)\n- Hour (12h): 'h' (1-12), 'hh' (01-12) - requires 'a' for AM/PM\n- Hour (24h): 'H' (0-23), 'HH' (00-23) - Military Time\n- Minute: 'mm' (00-59)\n- Second: 'ss' (00-59)\n- Period: 'a' (AM/PM)\n\nExamples:\n- 'MMM dd, yyyy' -> 'Jan 16, 2026'\n- 'HH:mm' -> '14:30' (Military)\n- 'h:mm a' -> '2:30 PM'\n- 'EEEE, d MMMM' -> 'Friday, 16 January'"
            }
          },
          "required": [
            "format",
            "value"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "pluralize": {
      "type": "object",
      "description": "Returns a localized string based on the Common Locale Data Repository (CLDR) plural category of the count (zero, one, two, few, many, other). Requires an 'other' fallback. For English, just use 'one' and 'other'.",
      "returnType": "string",
      "properties": {
        "@call": {
          "const": "pluralize"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicNumber",
              "description": "The numeric value used to determine the plural category."
            },
            "zero": {
              "$ref": "common_types.json#/$defs/DynamicString",
              "description": "String for the 'zero' category (e.g., 0 items)."
            },
            "one": {
              "$ref": "common_types.json#/$defs/DynamicString",
              "description": "String for the 'one' category (e.g., 1 item)."
            },
            "two": {
              "$ref": "common_types.json#/$defs/DynamicString",
              "description": "String for the 'two' category (used in Arabic, Welsh, etc.)."
            },
            "few": {
              "$ref": "common_types.json#/$defs/DynamicString",
              "description": "String for the 'few' category (e.g., small groups in Slavic languages)."
            },
            "many": {
              "$ref": "common_types.json#/$defs/DynamicString",
              "description": "String for the 'many' category (e.g., large groups in various languages)."
            },
            "other": {
              "$ref": "common_types.json#/$defs/DynamicString",
              "description": "The default/fallback string (used for general plural cases)."
            }
          },
          "required": [
            "value",
            "other"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "openUrl": {
      "type": "object",
      "description": "Opens the specified URL in a browser or handler (requires user activation). This function has no return value.",
      "returnType": "void",
      "requiresUserActivation": true,
      "properties": {
        "@call": {
          "const": "openUrl"
        },
        "args": {
          "type": "object",
          "properties": {
            "url": {
              "description": "The URL to open.",
              "oneOf": [
                {
                  "type": "string",
                  "format": "uri"
                },
                {
                  "$ref": "common_types.json#/$defs/DataBinding"
                },
                {
                  "$ref": "common_types.json#/$defs/FunctionCall"
                }
              ]
            }
          },
          "required": [
            "url"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "and": {
      "type": "object",
      "description": "Performs a logical AND operation on a list of boolean values.",
      "returnType": "boolean",
      "properties": {
        "@call": {
          "const": "and"
        },
        "args": {
          "type": "object",
          "properties": {
            "values": {
              "type": "array",
              "description": "The list of boolean values to evaluate.",
              "items": {
                "$ref": "common_types.json#/$defs/DynamicBoolean"
              },
              "minItems": 2
            }
          },
          "required": [
            "values"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "or": {
      "type": "object",
      "description": "Performs a logical OR operation on a list of boolean values.",
      "returnType": "boolean",
      "properties": {
        "@call": {
          "const": "or"
        },
        "args": {
          "type": "object",
          "properties": {
            "values": {
              "type": "array",
              "description": "The list of boolean values to evaluate.",
              "items": {
                "$ref": "common_types.json#/$defs/DynamicBoolean"
              },
              "minItems": 2
            }
          },
          "required": [
            "values"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    },
    "not": {
      "type": "object",
      "description": "Performs a logical NOT operation on a boolean value.",
      "returnType": "boolean",
      "properties": {
        "@call": {
          "const": "not"
        },
        "args": {
          "type": "object",
          "properties": {
            "value": {
              "$ref": "common_types.json#/$defs/DynamicBoolean",
              "description": "The boolean value to negate."
            }
          },
          "required": [
            "value"
          ],
          "unevaluatedProperties": false
        }
      },
      "required": [
        "@call",
        "args"
      ]
    }
  },
  "$defs": {
    "Weight": {
      "type": "number",
      "description": "The relative weight of this component within a Row or Column. This is similar to the CSS 'flex-grow' property. Note: this may ONLY be set when the component is a direct descendant of a Row or Column."
    },
    "anyComponent": {
      "oneOf": [
        {
          "$ref": "#/components/Button"
        },
        {
          "$ref": "#/components/Card"
        },
        {
          "$ref": "#/components/Column"
        },
        {
          "$ref": "#/components/Divider"
        },
        {
          "$ref": "#/components/Icon"
        },
        {
          "$ref": "#/components/List"
        },
        {
          "$ref": "#/components/Row"
        },
        {
          "$ref": "#/components/Text"
        },
        {
          "$ref": "#/components/SafetyBanner"
        },
        {
          "$ref": "#/components/TrendChart"
        },
        {
          "$ref": "#/components/MeasurementRow"
        },
        {
          "$ref": "#/components/ImagingTimeline"
        },
        {
          "$ref": "#/components/XRayImage"
        },
        {
          "$ref": "#/components/MedicationTable"
        },
        {
          "$ref": "#/components/CareGapList"
        },
        {
          "$ref": "#/components/LabPanel"
        },
        {
          "$ref": "#/components/BarComparison"
        },
        {
          "$ref": "#/components/EcgStrip"
        },
        {
          "$ref": "#/components/SplitSection"
        },
        {
          "$ref": "#/components/SectionGrid"
        },
        {
          "$ref": "#/components/ChartGroup"
        },
        {
          "$ref": "#/components/FactList"
        }
      ],
      "discriminator": {
        "propertyName": "component"
      }
    },
    "anyFunction": {
      "oneOf": [
        {
          "$ref": "#/functions/required"
        },
        {
          "$ref": "#/functions/regex"
        },
        {
          "$ref": "#/functions/length"
        },
        {
          "$ref": "#/functions/numeric"
        },
        {
          "$ref": "#/functions/email"
        },
        {
          "$ref": "#/functions/formatString"
        },
        {
          "$ref": "#/functions/formatNumber"
        },
        {
          "$ref": "#/functions/formatCurrency"
        },
        {
          "$ref": "#/functions/formatDate"
        },
        {
          "$ref": "#/functions/pluralize"
        },
        {
          "$ref": "#/functions/openUrl"
        },
        {
          "$ref": "#/functions/and"
        },
        {
          "$ref": "#/functions/or"
        },
        {
          "$ref": "#/functions/not"
        }
      ]
    }
  }
}
''';
}
