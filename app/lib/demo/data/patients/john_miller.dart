/// John Miller, a fictional demo patient.
abstract final class JohnMiller {
  /// Id of John Miller.
  static const String id = 'john-miller';

  /// John Miller's stored patient and chart.
  static const Map<String, Object?> seed = <String, Object?>{
    'id': id,
    'patient': <String, Object?>{
      'id': id,
      'fullName': 'John Miller',
      'age': 61,
      'sex': 'male',
      'slotLabel': 'Same-day slot',
      'slotTime': '14:20',
      'attendingDoctor': 'Dr. Thompson',
    },
    'record': <String, Object?>{
      'patientId': id,
      'allergies': <String>[
        'Sulfa drugs (rash)',
      ],
      'medications': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Amlodipine',
          'dose': '10 mg',
          'schedule': 'once daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Metformin',
          'dose': '1000 mg',
          'schedule': 'twice daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Atorvastatin',
          'dose': '20 mg',
          'schedule': 'once daily at bedtime',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Omeprazole',
          'dose': '20 mg',
          'schedule': 'once daily before breakfast',
          'isAnticoagulant': false,
        },
      ],
      'conditions': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Hypertension',
          'since': 2016,
          'detail': null,
        },
        <String, Object?>{
          'name': 'Hyperlipidemia',
          'since': 2016,
          'detail': null,
        },
        <String, Object?>{
          'name': 'Type 2 diabetes',
          'since': 2018,
          'detail': 'Metformin only',
        },
        <String, Object?>{
          'name': 'Gastroesophageal reflux',
          'since': 2019,
          'detail': null,
        },
        <String, Object?>{
          'name': 'Fatty liver',
          'since': 2019,
          'detail': 'Found on ultrasound',
        },
        <String, Object?>{
          'name': 'Osteoarthritis, left knee',
          'since': 2021,
          'detail': 'Managed with exercise',
        },
      ],
      'riskFactors': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Smoking',
          'detail': '30 pack-years',
          'lastRecordedYear': 2019,
        },
        <String, Object?>{
          'name': 'Alcohol',
          'detail': 'Social, 2-4 drinks per week',
          'lastRecordedYear': 2024,
        },
        <String, Object?>{
          'name': 'Family history',
          'detail': 'Father: colon cancer at 70',
          'lastRecordedYear': 2020,
        },
        <String, Object?>{
          'name': 'Occupation',
          'detail': 'Accountant, mostly desk-based',
          'lastRecordedYear': 2024,
        },
      ],
      'imaging': <Map<String, Object?>>[
        <String, Object?>{
          'modality': 'ECG',
          'takenAt': '2019-06-12T10:40:00.000Z',
          'conclusion': 'Normal sinus rhythm, rate 74',
        },
        <String, Object?>{
          'modality': 'Colonoscopy',
          'takenAt': '2016-04-12T10:00:00.000Z',
          'conclusion': 'Two small polyps removed; repeat advised in 5 years',
        },
        <String, Object?>{
          'modality': 'Abdominal ultrasound',
          'takenAt': '2019-06-03T11:30:00.000Z',
          'conclusion': 'Fatty liver; no focal lesion',
        },
        <String, Object?>{
          'modality': 'Chest X-ray',
          'takenAt': '2021-11-04T15:10:00.000Z',
          'conclusion': 'No focal changes',
          'image': 'assets/imaging/john_miller_chest_2021.png',
        },
        <String, Object?>{
          'modality': 'Knee X-ray, left',
          'takenAt': '2021-11-04T15:25:00.000Z',
          'conclusion': 'Mild osteoarthritis',
        },
      ],
      'observations': <Map<String, Object?>>[
        <String, Object?>{
          'code': 'heart-rate',
          'displayName': 'Resting heart rate',
          'unit': 'bpm',
          'referenceLow': 60.0,
          'referenceHigh': 100.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2018-03-14T09:00:00.000Z',
              'value': 74.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2020-02-11T09:00:00.000Z',
              'value': 72.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2022-03-08T09:00:00.000Z',
              'value': 76.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-03-19T09:00:00.000Z',
              'value': 78.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2025-03-11T09:00:00.000Z',
              'value': 80.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2026-07-21T09:00:00.000Z',
              'value': 84.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
          ],
        },
        <String, Object?>{
          'code': 'hemoglobin',
          'displayName': 'Hemoglobin',
          'unit': 'g/dL',
          'referenceLow': 13.5,
          'referenceHigh': 17.5,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2016-04-05T09:00:00.000Z',
              'value': 15.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2018-03-14T09:00:00.000Z',
              'value': 14.9,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2020-02-11T09:00:00.000Z',
              'value': 14.8,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2022-03-08T09:00:00.000Z',
              'value': 14.6,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2024-03-19T09:00:00.000Z',
              'value': 14.4,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2025-03-11T09:00:00.000Z',
              'value': 14.1,
              'recordedBy': 'Dr. Bennett',
            },
            <String, Object?>{
              'takenAt': '2025-09-16T09:00:00.000Z',
              'value': 13.2,
              'recordedBy': 'Dr. Coleman',
            },
            <String, Object?>{
              'takenAt': '2026-02-10T09:00:00.000Z',
              'value': 12.6,
              'recordedBy': 'Dr. Harris',
            },
            <String, Object?>{
              'takenAt': '2026-07-21T09:00:00.000Z',
              'value': 11.8,
              'recordedBy': 'Dr. Reynolds',
            },
          ],
        },
        <String, Object?>{
          'code': 'ferritin',
          'displayName': 'Ferritin',
          'unit': 'ng/mL',
          'referenceLow': 30.0,
          'referenceHigh': 400.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2020-02-11T09:00:00.000Z',
              'value': 120.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2023-03-07T09:00:00.000Z',
              'value': 104.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2026-02-10T09:00:00.000Z',
              'value': 18.0,
              'recordedBy': 'Dr. Harris',
            },
          ],
        },
        <String, Object?>{
          'code': 'weight',
          'displayName': 'Weight',
          'unit': 'lb',
          'referenceLow': null,
          'referenceHigh': null,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2016-04-05T09:00:00.000Z',
              'value': 205.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2018-03-14T09:00:00.000Z',
              'value': 201.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2020-02-11T09:00:00.000Z',
              'value': 199.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2022-03-08T09:00:00.000Z',
              'value': 197.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-03-19T09:00:00.000Z',
              'value': 196.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2025-03-11T09:00:00.000Z',
              'value': 196.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2025-09-16T09:00:00.000Z',
              'value': 194.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-03-24T09:00:00.000Z',
              'value': 187.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-08-25T09:00:00.000Z',
              'value': 181.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
          ],
        },
        <String, Object?>{
          'code': 'hba1c',
          'displayName': 'HbA1c',
          'unit': '%',
          'referenceLow': 4.0,
          'referenceHigh': 5.6,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2018-03-14T09:00:00.000Z',
              'value': 7.2,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2019-03-12T09:00:00.000Z',
              'value': 6.9,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2020-02-11T09:00:00.000Z',
              'value': 6.8,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2021-02-16T09:00:00.000Z',
              'value': 7.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2022-03-08T09:00:00.000Z',
              'value': 6.7,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2023-03-07T09:00:00.000Z',
              'value': 6.9,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2024-03-19T09:00:00.000Z',
              'value': 6.8,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2025-03-11T09:00:00.000Z',
              'value': 6.9,
              'recordedBy': 'Dr. Bennett',
            },
            <String, Object?>{
              'takenAt': '2026-02-10T09:00:00.000Z',
              'value': 6.7,
              'recordedBy': 'Dr. Harris',
            },
          ],
        },
        <String, Object?>{
          'code': 'systolic-bp',
          'displayName': 'Systolic blood pressure',
          'unit': 'mmHg',
          'referenceLow': null,
          'referenceHigh': 130.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2016-04-05T09:00:00.000Z',
              'value': 152.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2017-04-11T09:00:00.000Z',
              'value': 144.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2018-03-14T09:00:00.000Z',
              'value': 138.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2019-03-12T09:00:00.000Z',
              'value': 136.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2020-02-11T09:00:00.000Z',
              'value': 134.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2021-02-16T09:00:00.000Z',
              'value': 132.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2022-03-08T09:00:00.000Z',
              'value': 136.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2023-03-07T09:00:00.000Z',
              'value': 134.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-03-19T09:00:00.000Z',
              'value': 138.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2025-03-11T09:00:00.000Z',
              'value': 136.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2026-07-21T09:00:00.000Z',
              'value': 134.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
          ],
        },
        <String, Object?>{
          'code': 'ldl',
          'displayName': 'LDL cholesterol',
          'unit': 'mg/dL',
          'referenceLow': null,
          'referenceHigh': 100.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2016-04-05T09:00:00.000Z',
              'value': 168.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2017-04-11T09:00:00.000Z',
              'value': 112.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2019-03-12T09:00:00.000Z',
              'value': 104.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2021-02-16T09:00:00.000Z',
              'value': 98.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2023-03-07T09:00:00.000Z',
              'value': 96.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2025-03-11T09:00:00.000Z',
              'value': 94.0,
              'recordedBy': 'Dr. Bennett',
            },
          ],
        },
        <String, Object?>{
          'code': 'egfr',
          'displayName': 'eGFR',
          'unit': 'mL/min/1.73m2',
          'referenceLow': 60.0,
          'referenceHigh': null,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2018-03-14T09:00:00.000Z',
              'value': 88.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2020-02-11T09:00:00.000Z',
              'value': 85.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2022-03-08T09:00:00.000Z',
              'value': 82.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2024-11-12T09:00:00.000Z',
              'value': 78.0,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2025-06-17T09:00:00.000Z',
              'value': 74.0,
              'recordedBy': 'Dr. Bennett',
            },
            <String, Object?>{
              'takenAt': '2026-02-10T09:00:00.000Z',
              'value': 71.0,
              'recordedBy': 'Dr. Harris',
            },
          ],
        },
      ],
    },
  };
}
