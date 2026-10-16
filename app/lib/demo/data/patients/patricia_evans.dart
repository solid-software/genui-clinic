/// Patricia Evans, a fictional demo patient.
abstract final class PatriciaEvans {
  /// Id of Patricia Evans.
  static const String id = 'patricia-evans';

  /// Patricia Evans's stored patient and chart.
  static const Map<String, Object?> seed = <String, Object?>{
    'id': id,
    'patient': <String, Object?>{
      'id': id,
      'fullName': 'Patricia Evans',
      'age': 57,
      'sex': 'female',
      'slotLabel': 'Same-day slot',
      'slotTime': '11:50',
      'attendingDoctor': 'Dr. Bennett',
    },
    'record': <String, Object?>{
      'patientId': id,
      'allergies': <String>[
        'Penicillin (hives)',
      ],
      'medications': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Metformin',
          'dose': '1000 mg',
          'schedule': 'twice daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Glipizide',
          'dose': '5 mg',
          'schedule': 'once daily, added 2023',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Lisinopril',
          'dose': '20 mg',
          'schedule': 'once daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Atorvastatin',
          'dose': '10 mg',
          'schedule': 'once daily at bedtime',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Sertraline',
          'dose': '50 mg',
          'schedule': 'once daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Sumatriptan',
          'dose': '50 mg',
          'schedule': 'as needed for migraine',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Omeprazole',
          'dose': '20 mg',
          'schedule':
              'once daily; started at urgent care 2 weeks ago for '
              'indigestion',
          'isAnticoagulant': false,
        },
      ],
      'conditions': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Migraine',
          'since': 2012,
          'detail': null,
        },
        <String, Object?>{
          'name': 'Type 2 diabetes',
          'since': 2014,
          'detail': 'Above target since 2017',
        },
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
          'name': 'Depression',
          'since': 2019,
          'detail': 'Stable on sertraline',
        },
        <String, Object?>{
          'name': 'Fatty liver',
          'since': 2020,
          'detail': null,
        },
      ],
      'riskFactors': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Current smoker',
          'detail': '15 pack-years; quit attempts 2018 and 2022',
          'lastRecordedYear': 2026,
        },
        <String, Object?>{
          'name': 'Family history',
          'detail': 'Brother: heart attack at 49',
          'lastRecordedYear': 2023,
        },
        <String, Object?>{
          'name': 'Weight',
          'detail': 'BMI 33.9',
          'lastRecordedYear': 2026,
        },
        <String, Object?>{
          'name': 'Activity',
          'detail': 'Office job, little exercise',
          'lastRecordedYear': 2024,
        },
      ],
      'imaging': <Map<String, Object?>>[
        <String, Object?>{
          'modality': 'Exercise stress ECG',
          'takenAt': '2018-06-19T09:30:00.000Z',
          'conclusion':
              'Inconclusive: target heart rate not reached; repeat advised',
        },
        <String, Object?>{
          'modality': 'Abdominal ultrasound',
          'takenAt': '2020-09-01T14:00:00.000Z',
          'conclusion': 'Fatty liver; no gallstones',
        },
        <String, Object?>{
          'modality': 'CT chest',
          'takenAt': '2021-08-17T13:30:00.000Z',
          'conclusion':
              'No rib fracture after a fall; heart at the upper limit of '
              'normal size',
          'image': 'assets/imaging/patricia_evans_ct_chest_2021.png',
        },
        <String, Object?>{
          'modality': 'ECG',
          'takenAt': '2022-04-12T10:20:00.000Z',
          'conclusion': 'Normal sinus rhythm',
        },
        <String, Object?>{
          'modality': 'Chest X-ray',
          'takenAt': '2024-01-16T09:20:00.000Z',
          'conclusion': 'Enlarged heart shadow; faint haze at the right base',
          'image': 'assets/imaging/patricia_evans_chest_2024.png',
        },
        <String, Object?>{
          'modality': 'Diabetic eye screening',
          'takenAt': '2024-05-07T15:40:00.000Z',
          'conclusion': 'Mild background retinopathy',
        },
        <String, Object?>{
          'modality': 'Mammogram',
          'takenAt': '2025-10-14T11:00:00.000Z',
          'conclusion': 'Normal',
        },
      ],
      'observations': <Map<String, Object?>>[
        <String, Object?>{
          'code': 'hba1c',
          'displayName': 'HbA1c',
          'unit': '%',
          'referenceLow': 4.0,
          'referenceHigh': 5.6,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2016-02-09T09:00:00.000Z',
              'value': 7.4,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2017-02-14T09:00:00.000Z',
              'value': 7.9,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2018-02-13T09:00:00.000Z',
              'value': 8.3,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2019-02-12T09:00:00.000Z',
              'value': 7.8,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2020-02-18T09:00:00.000Z',
              'value': 8.1,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2021-02-09T09:00:00.000Z',
              'value': 8.6,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2022-02-15T09:00:00.000Z',
              'value': 8.4,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2023-02-14T09:00:00.000Z',
              'value': 8.9,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2024-02-13T09:00:00.000Z',
              'value': 9.1,
              'recordedBy': 'Dr. Bennett',
            },
            <String, Object?>{
              'takenAt': '2025-02-11T09:00:00.000Z',
              'value': 9.4,
              'recordedBy': 'Dr. Bennett',
            },
            <String, Object?>{
              'takenAt': '2026-05-12T09:00:00.000Z',
              'value': 9.6,
              'recordedBy': 'Dr. Bennett',
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
              'takenAt': '2016-02-09T09:00:00.000Z',
              'value': 142.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2018-02-13T09:00:00.000Z',
              'value': 138.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2020-02-18T09:00:00.000Z',
              'value': 131.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2022-02-15T09:00:00.000Z',
              'value': 145.0,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2024-02-13T09:00:00.000Z',
              'value': 152.0,
              'recordedBy': 'Dr. Bennett',
            },
            <String, Object?>{
              'takenAt': '2026-05-12T09:00:00.000Z',
              'value': 158.0,
              'recordedBy': 'Dr. Bennett',
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
              'takenAt': '2016-02-09T09:00:00.000Z',
              'value': 138.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2017-02-14T09:00:00.000Z',
              'value': 136.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2018-02-13T09:00:00.000Z',
              'value': 142.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2019-02-12T09:00:00.000Z',
              'value': 140.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2020-02-18T09:00:00.000Z',
              'value': 144.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2021-02-09T09:00:00.000Z',
              'value': 146.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2022-02-15T09:00:00.000Z',
              'value': 142.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2023-02-14T09:00:00.000Z',
              'value': 148.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-02-13T09:00:00.000Z',
              'value': 150.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2025-02-11T09:00:00.000Z',
              'value': 152.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-05-12T09:00:00.000Z',
              'value': 154.0,
              'recordedBy': 'MA Tyler Jenkins',
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
              'takenAt': '2016-02-09T09:00:00.000Z',
              'value': 176.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2018-02-13T09:00:00.000Z',
              'value': 181.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2020-02-18T09:00:00.000Z',
              'value': 186.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2022-02-15T09:00:00.000Z',
              'value': 190.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-02-13T09:00:00.000Z',
              'value': 195.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2026-05-12T09:00:00.000Z',
              'value': 198.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
          ],
        },
        <String, Object?>{
          'code': 'urine-acr',
          'displayName': 'Urine albumin/creatinine ratio',
          'unit': 'mg/g',
          'referenceLow': null,
          'referenceHigh': 30.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2019-02-12T09:00:00.000Z',
              'value': 22.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2021-02-09T09:00:00.000Z',
              'value': 41.0,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2023-02-14T09:00:00.000Z',
              'value': 68.0,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2025-02-11T09:00:00.000Z',
              'value': 96.0,
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
              'takenAt': '2016-02-09T09:00:00.000Z',
              'value': 94.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2019-02-12T09:00:00.000Z',
              'value': 90.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2022-02-15T09:00:00.000Z',
              'value': 86.0,
              'recordedBy': 'Dr. James Carter',
            },
            <String, Object?>{
              'takenAt': '2024-02-13T09:00:00.000Z',
              'value': 82.0,
              'recordedBy': 'Dr. Bennett',
            },
            <String, Object?>{
              'takenAt': '2026-05-12T09:00:00.000Z',
              'value': 78.0,
              'recordedBy': 'Dr. Bennett',
            },
          ],
        },
        <String, Object?>{
          'code': 'heart-rate',
          'displayName': 'Resting heart rate',
          'unit': 'bpm',
          'referenceLow': 60.0,
          'referenceHigh': 100.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2020-02-18T09:00:00.000Z',
              'value': 76.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2022-02-15T09:00:00.000Z',
              'value': 78.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-02-13T09:00:00.000Z',
              'value': 80.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2026-05-12T09:00:00.000Z',
              'value': 82.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
          ],
        },
      ],
    },
  };
}
