// Generated from the app's catalog by test/agent_catalog_test.dart; do not
// edit. To regenerate, from app/:
//
//   UPDATE_AGENT_CATALOG=1 flutter test test/agent_catalog_test.dart

/// The app's catalog as an A2UI catalog document.
abstract final class ClinicalCatalogDocument {
  /// The document, as JSON.
  static const String json = r'''
{
  "catalogId": "com.clinicalbrief.catalog.v1",
  "components": {
    "Button": {
      "type": "object",
      "description": "An interactive button that triggers an action when pressed.",
      "properties": {
        "child": {
          "type": "string",
          "description": "The ID of a child widget. This should always be set, e.g. to the ID of a `Text` widget."
        },
        "action": {
          "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/Action"
        },
        "variant": {
          "type": "string",
          "description": "A hint for the button style.",
          "enum": [
            "primary",
            "borderless"
          ]
        },
        "checks": {
          "type": "array",
          "description": "Validation rules for this component.",
          "items": {
            "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/CheckRule"
          }
        },
        "component": {
          "type": "string",
          "enum": [
            "Button"
          ]
        }
      },
      "required": [
        "component",
        "child",
        "action"
      ],
      "additionalProperties": true
    },
    "Card": {
      "type": "object",
      "description": "A visual container (card) that groups a single child widget.",
      "properties": {
        "child": {
          "type": "string",
          "description": "The ID of a component."
        },
        "component": {
          "type": "string",
          "enum": [
            "Card"
          ]
        }
      },
      "required": [
        "component",
        "child"
      ],
      "additionalProperties": true
    },
    "Column": {
      "type": "object",
      "description": "A layout widget that arranges its children vertically.",
      "properties": {
        "justify": {
          "type": "string",
          "description": "How children are aligned on the main axis. ",
          "enum": [
            "start",
            "center",
            "end",
            "spaceBetween",
            "spaceAround",
            "spaceEvenly",
            "stretch"
          ]
        },
        "align": {
          "type": "string",
          "description": "How children are aligned on the cross axis. ",
          "enum": [
            "start",
            "center",
            "end",
            "stretch"
          ]
        },
        "children": {
          "description": "Either an explicit list of widget IDs for the children, or a template with a data binding to the list of children.",
          "oneOf": [
            {
              "type": "array",
              "items": {
                "type": "string",
                "description": "Component ID"
              }
            },
            {
              "type": "object",
              "properties": {
                "componentId": {
                  "type": "string",
                  "description": "The ID of a component."
                },
                "path": {
                  "type": "string",
                  "description": "A relative or absolute path in the data model."
                }
              },
              "required": [
                "componentId",
                "path"
              ]
            }
          ]
        },
        "component": {
          "type": "string",
          "enum": [
            "Column"
          ]
        }
      },
      "required": [
        "component",
        "children"
      ],
      "additionalProperties": true
    },
    "Divider": {
      "type": "object",
      "description": "A thin horizontal or vertical line used to separate content.",
      "properties": {
        "axis": {
          "type": "string",
          "enum": [
            "horizontal",
            "vertical"
          ]
        },
        "component": {
          "type": "string",
          "enum": [
            "Divider"
          ]
        }
      },
      "required": [
        "component"
      ],
      "additionalProperties": true
    },
    "Icon": {
      "type": "object",
      "description": "Displays an icon from a set of available icons.",
      "properties": {
        "name": {
          "description": "The name of the icon to display. This can be a literal string or a reference to a value in the data model ('path', e.g. '/icon/name').",
          "allOf": [
            {
              "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicString"
            },
            {
              "anyOf": [
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
                    "error",
                    "event",
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
                    "moreHoriz",
                    "moreVert",
                    "notifications",
                    "notificationsOff",
                    "payment",
                    "person",
                    "phone",
                    "photo",
                    "print",
                    "refresh",
                    "search",
                    "send",
                    "settings",
                    "share",
                    "shoppingCart",
                    "star",
                    "starHalf",
                    "starOff",
                    "upload",
                    "visibility",
                    "visibilityOff",
                    "warning"
                  ]
                },
                {
                  "type": "object"
                }
              ]
            }
          ]
        },
        "component": {
          "type": "string",
          "enum": [
            "Icon"
          ]
        }
      },
      "required": [
        "component",
        "name"
      ],
      "additionalProperties": true
    },
    "List": {
      "type": "object",
      "description": "A scrollable list of child widgets.",
      "properties": {
        "children": {
          "oneOf": [
            {
              "type": "array",
              "items": {
                "type": "string",
                "description": "Component ID"
              }
            },
            {
              "type": "object",
              "properties": {
                "componentId": {
                  "type": "string",
                  "description": "The ID of a component."
                },
                "path": {
                  "type": "string",
                  "description": "A relative or absolute path in the data model."
                }
              },
              "required": [
                "componentId",
                "path"
              ]
            }
          ]
        },
        "direction": {
          "type": "string",
          "enum": [
            "vertical",
            "horizontal"
          ]
        },
        "align": {
          "type": "string",
          "enum": [
            "start",
            "center",
            "end",
            "stretch"
          ]
        },
        "component": {
          "type": "string",
          "enum": [
            "List"
          ]
        }
      },
      "required": [
        "component",
        "children"
      ],
      "additionalProperties": true
    },
    "Row": {
      "type": "object",
      "description": "A layout widget that arranges its children horizontally.",
      "properties": {
        "children": {
          "description": "Either an explicit list of widget IDs for the children, or a template with a data binding to the list of children.",
          "oneOf": [
            {
              "type": "array",
              "items": {
                "type": "string",
                "description": "Component ID"
              }
            },
            {
              "type": "object",
              "properties": {
                "componentId": {
                  "type": "string",
                  "description": "The ID of a component."
                },
                "path": {
                  "type": "string",
                  "description": "A relative or absolute path in the data model."
                }
              },
              "required": [
                "componentId",
                "path"
              ]
            }
          ]
        },
        "justify": {
          "type": "string",
          "enum": [
            "start",
            "center",
            "end",
            "spaceBetween",
            "spaceAround",
            "spaceEvenly",
            "stretch"
          ]
        },
        "align": {
          "type": "string",
          "enum": [
            "start",
            "center",
            "end",
            "stretch"
          ]
        },
        "component": {
          "type": "string",
          "enum": [
            "Row"
          ]
        }
      },
      "required": [
        "component",
        "children"
      ],
      "additionalProperties": true
    },
    "Text": {
      "type": "object",
      "description": "A block of styled text.",
      "properties": {
        "text": {
          "description": "While simple Markdown is supported (without HTML or image references), utilizing dedicated UI components is generally preferred for a richer and more structured presentation.",
          "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicString"
        },
        "variant": {
          "type": "string",
          "description": "A hint for the base text style.",
          "enum": [
            "h1",
            "h2",
            "h3",
            "h4",
            "h5",
            "caption",
            "body"
          ]
        },
        "component": {
          "type": "string",
          "enum": [
            "Text"
          ]
        }
      },
      "required": [
        "component",
        "text"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "SafetyBanner"
          ]
        }
      },
      "required": [
        "component",
        "entries"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "TrendChart"
          ]
        }
      },
      "required": [
        "component",
        "title",
        "points"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "MeasurementRow"
          ]
        }
      },
      "required": [
        "component",
        "measurements"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "ImagingTimeline"
          ]
        }
      },
      "required": [
        "component",
        "title",
        "events"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "XRayImage"
          ]
        }
      },
      "required": [
        "component",
        "title",
        "image",
        "date",
        "conclusion"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "MedicationTable"
          ]
        }
      },
      "required": [
        "component",
        "title",
        "medications"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "CareGapList"
          ]
        }
      },
      "required": [
        "component",
        "title",
        "gaps"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "LabPanel"
          ]
        }
      },
      "required": [
        "component",
        "title",
        "flagged"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "BarComparison"
          ]
        }
      },
      "required": [
        "component",
        "title",
        "entries"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "EcgStrip"
          ]
        }
      },
      "required": [
        "component",
        "rate"
      ],
      "additionalProperties": true
    },
    "SplitSection": {
      "type": "object",
      "description": "Two columns of sections side by side, the first wider than the second, stacked on a narrow screen. Use it to lay a brief out as a dashboard read at once, rather than as one stack read top to bottom.",
      "properties": {
        "primary": {
          "description": "Ids of the sections in the wider left column.",
          "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/ChildList"
        },
        "secondary": {
          "description": "Ids of the sections in the narrower right column.",
          "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/ChildList"
        },
        "component": {
          "type": "string",
          "enum": [
            "SplitSection"
          ]
        }
      },
      "required": [
        "component",
        "primary",
        "secondary"
      ],
      "additionalProperties": true
    },
    "SectionGrid": {
      "type": "object",
      "description": "Sections laid out in a grid, each as wide as you say. Twelve is a full row, six a half, four a third; sections flow into rows and stack on a narrow screen. Use it to lay a whole brief out as a dashboard, with the leading section full width and the supporting ones beside each other.",
      "properties": {
        "sections": {
          "description": "Ids of the sections, in reading order.",
          "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/ChildList"
        },
        "widths": {
          "type": "array",
          "description": "Width of each section in twelfths, one per section, in the same order: 12, 6 or 4.",
          "items": {
            "type": "integer"
          }
        },
        "component": {
          "type": "string",
          "enum": [
            "SectionGrid"
          ]
        }
      },
      "required": [
        "component",
        "sections",
        "widths"
      ],
      "additionalProperties": true
    },
    "ChartGroup": {
      "type": "object",
      "description": "Places TrendCharts side by side, two per row, when the screen is wide enough, and stacks them on narrow screens. Every TrendChart belongs in one. Prefer two charts per group: half a row each is the normal size for a chart, and a chart alone in a group takes the whole row.",
      "properties": {
        "children": {
          "description": "Ids of the TrendChart components in this group, in ranking order.",
          "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/ChildList"
        },
        "component": {
          "type": "string",
          "enum": [
            "ChartGroup"
          ]
        }
      },
      "required": [
        "component",
        "children"
      ],
      "additionalProperties": true
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
        },
        "component": {
          "type": "string",
          "enum": [
            "FactList"
          ]
        }
      },
      "required": [
        "component",
        "title",
        "entries"
      ],
      "additionalProperties": true
    }
  },
  "functions": [
    {
      "name": "required",
      "description": "Checks that the value is not null, undefined, or empty.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {}
        }
      },
      "returnType": "boolean"
    },
    {
      "name": "regex",
      "description": "Checks that the value matches a regular expression string.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {
            "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicString"
          },
          "pattern": {
            "type": "string"
          }
        }
      },
      "returnType": "boolean"
    },
    {
      "name": "length",
      "description": "Checks string length constraints.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {},
          "min": {
            "type": "integer"
          },
          "max": {
            "type": "integer"
          }
        }
      },
      "returnType": "any"
    },
    {
      "name": "numeric",
      "description": "Checks numeric range constraints.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {
            "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicNumber"
          },
          "min": {
            "type": "number"
          },
          "max": {
            "type": "number"
          }
        }
      },
      "returnType": "boolean"
    },
    {
      "name": "email",
      "description": "Checks that the value is a valid email address.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {
            "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicString"
          }
        }
      },
      "returnType": "boolean"
    },
    {
      "name": "formatString",
      "description": "Performs string interpolation of data model values and other functions in the\ncatalog functions list and returns the resulting string. The value string can\ncontain interpolated expressions in the ${expression} format. Supported\nexpression types include: JSON Pointer paths to the data model (e.g.,\n${/absolute/path} or ${relative/path}), and client-side function calls (e.g.,\n${now()}). Function arguments must be named (e.g.,\n${formatDate(value:${/currentDate}, format:'MM-dd')}). To include a literal ${\nsequence, escape it as \\${.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {}
        }
      },
      "returnType": "string"
    },
    {
      "name": "openUrl",
      "description": "Opens the specified URL in a browser or handler. This function has no return value.",
      "parameters": {
        "type": "object",
        "properties": {
          "url": {
            "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicString"
          }
        }
      },
      "returnType": "void"
    },
    {
      "name": "formatNumber",
      "description": "Formats a number with the specified grouping and decimal precision.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {
            "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicNumber"
          },
          "decimalPlaces": {
            "type": "integer"
          },
          "useGrouping": {
            "type": "boolean"
          }
        }
      },
      "returnType": "string"
    },
    {
      "name": "formatCurrency",
      "description": "Formats a number as a currency string.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {
            "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicNumber"
          },
          "currencyCode": {
            "type": "string"
          }
        }
      },
      "returnType": "string"
    },
    {
      "name": "formatDate",
      "description": "Formats a timestamp into a string using a pattern.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {},
          "pattern": {
            "type": "string"
          }
        }
      },
      "returnType": "string"
    },
    {
      "name": "pluralize",
      "description": "Returns a localized string based on the Common Locale Data Repository (CLDR) plural category of the count (zero, one, two, few, many, other). Requires an 'other' fallback.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {
            "$ref": "https://a2ui.org/specification/v0_9/common_types.json#/$defs/DynamicNumber"
          },
          "zero": {
            "type": "string"
          },
          "one": {
            "type": "string"
          },
          "two": {
            "type": "string"
          },
          "few": {
            "type": "string"
          },
          "many": {
            "type": "string"
          },
          "other": {
            "type": "string"
          }
        }
      },
      "returnType": "string"
    },
    {
      "name": "and",
      "description": "Performs a logical AND operation on a list of boolean values.",
      "parameters": {
        "type": "object",
        "properties": {
          "values": {
            "type": "array",
            "items": {}
          }
        }
      },
      "returnType": "boolean"
    },
    {
      "name": "or",
      "description": "Performs a logical OR operation on a list of boolean values.",
      "parameters": {
        "type": "object",
        "properties": {
          "values": {
            "type": "array",
            "items": {}
          }
        }
      },
      "returnType": "boolean"
    },
    {
      "name": "not",
      "description": "Performs a logical NOT operation on a boolean value.",
      "parameters": {
        "type": "object",
        "properties": {
          "value": {}
        }
      },
      "returnType": "boolean"
    }
  ]
}
''';
}
