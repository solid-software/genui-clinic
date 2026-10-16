/// Margaret Collins, a fictional demo patient.
abstract final class MargaretCollins {
  /// Id of Margaret Collins.
  static const String id = 'margaret-collins';

  /// Margaret Collins's stored patient and chart.
  static const Map<String, Object?> seed = <String, Object?>{
    'id': id,
    'patient': <String, Object?>{
      'id': id,
      'fullName': 'Margaret Collins',
      'age': 72,
      'sex': 'female',
      'slotLabel': 'Same-day slot',
      'slotTime': '10:40',
      'attendingDoctor': 'Dr. Reynolds',
    },
    'record': <String, Object?>{
      'patientId': id,
      'allergies': <String>[
        'Codeine (vomiting)',
      ],
      'medications': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Apixaban',
          'dose': '5 mg',
          'schedule': 'twice daily',
          'isAnticoagulant': true,
        },
        <String, Object?>{
          'name': 'Metoprolol succinate',
          'dose': '25 mg',
          'schedule': 'once daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Lisinopril',
          'dose': '10 mg',
          'schedule': 'once daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Levothyroxine',
          'dose': '75 mcg',
          'schedule': 'once daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Calcium with vitamin D',
          'dose': '600 mg / 800 IU',
          'schedule': 'once daily',
          'isAnticoagulant': false,
        },
        <String, Object?>{
          'name': 'Naproxen',
          'dose': '500 mg',
          'schedule':
              'twice daily for knee pain; over the counter, patient-reported '
              'since March 2026',
          'isAnticoagulant': false,
        },
      ],
      'conditions': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Hypothyroidism',
          'since': 2015,
          'detail': null,
        },
        <String, Object?>{
          'name': 'Hypertension',
          'since': 2014,
          'detail': null,
        },
        <String, Object?>{
          'name': 'Peptic ulcer with bleeding',
          'since': 2017,
          'detail': 'Duodenal ulcer, treated; H. pylori eradicated',
        },
        <String, Object?>{
          'name': 'Osteoarthritis, both knees',
          'since': 2017,
          'detail': null,
        },
        <String, Object?>{
          'name': 'Atrial fibrillation',
          'since': 2019,
          'detail': 'On apixaban since diagnosis',
        },
        <String, Object?>{
          'name': 'Osteoporosis',
          'since': 2021,
          'detail': null,
        },
      ],
      'riskFactors': <Map<String, Object?>>[
        <String, Object?>{
          'name': 'Former smoker',
          'detail': '10 pack-years, quit 2000',
          'lastRecordedYear': 2024,
        },
        <String, Object?>{
          'name': 'Alcohol',
          'detail': 'One glass of wine most evenings',
          'lastRecordedYear': 2025,
        },
        <String, Object?>{
          'name': 'Falls',
          'detail': 'One fall at home, no injury',
          'lastRecordedYear': 2024,
        },
        <String, Object?>{
          'name': 'Social',
          'detail': 'Lives alone since 2023',
          'lastRecordedYear': 2025,
        },
      ],
      'imaging': <Map<String, Object?>>[
        <String, Object?>{
          'modality': 'ECG',
          'takenAt': '2019-10-22T12:30:00.000Z',
          'conclusion': 'Atrial fibrillation, rate 96; first recorded',
        },
        <String, Object?>{
          'modality': 'CT abdomen',
          'takenAt': '2017-05-08T22:10:00.000Z',
          'conclusion':
              'No free air; no mass; stomach and duodenum otherwise '
              'unremarkable',
          'image': 'assets/imaging/margaret_collins_ct_abdomen_2017.png',
        },
        <String, Object?>{
          'modality': 'Upper endoscopy',
          'takenAt': '2017-05-09T08:30:00.000Z',
          'conclusion': 'Bleeding duodenal ulcer, treated endoscopically',
        },
        <String, Object?>{
          'modality': 'Echocardiogram',
          'takenAt': '2019-10-22T13:00:00.000Z',
          'conclusion': 'Normal pumping function; mildly enlarged left atrium',
        },
        <String, Object?>{
          'modality': 'Bone density scan (DEXA)',
          'takenAt': '2021-06-14T10:15:00.000Z',
          'conclusion': 'Osteoporosis, T-score -2.7',
        },
        <String, Object?>{
          'modality': 'Knee X-ray, both',
          'takenAt': '2023-02-28T11:45:00.000Z',
          'conclusion': 'Moderate osteoarthritis',
        },
        <String, Object?>{
          'modality': 'Chest X-ray',
          'takenAt': '2024-11-05T16:20:00.000Z',
          'conclusion': 'Hyperinflated lungs; no acute findings',
          'image': 'assets/imaging/margaret_collins_chest_2024.png',
        },
      ],
      'observations': <Map<String, Object?>>[
        <String, Object?>{
          'code': 'hemoglobin',
          'displayName': 'Hemoglobin',
          'unit': 'g/dL',
          'referenceLow': 12.0,
          'referenceHigh': 15.5,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2016-05-10T09:00:00.000Z',
              'value': 13.4,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2017-05-08T09:00:00.000Z',
              'value': 9.8,
              'recordedBy': 'Dr. Anthony Russo',
            },
            <String, Object?>{
              'takenAt': '2017-08-15T09:00:00.000Z',
              'value': 12.1,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2018-09-11T09:00:00.000Z',
              'value': 13.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2019-10-15T09:00:00.000Z',
              'value': 13.2,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2020-10-13T09:00:00.000Z',
              'value': 13.1,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2021-10-19T09:00:00.000Z',
              'value': 13.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2022-10-18T09:00:00.000Z',
              'value': 12.9,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2023-10-17T09:00:00.000Z',
              'value': 13.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2024-10-15T09:00:00.000Z',
              'value': 12.8,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2025-06-10T09:00:00.000Z',
              'value': 12.6,
              'recordedBy': 'Dr. Reynolds',
            },
            <String, Object?>{
              'takenAt': '2026-01-20T09:00:00.000Z',
              'value': 12.4,
              'recordedBy': 'Dr. Reynolds',
            },
            <String, Object?>{
              'takenAt': '2026-06-15T09:00:00.000Z',
              'value': 11.1,
              'recordedBy': 'NP Rachel Brooks',
            },
            <String, Object?>{
              'takenAt': '2026-09-08T09:00:00.000Z',
              'value': 9.9,
              'recordedBy': 'Dr. Lisa Nguyen',
            },
          ],
        },
        <String, Object?>{
          'code': 'bun',
          'displayName': 'Urea nitrogen (BUN)',
          'unit': 'mg/dL',
          'referenceLow': 7.0,
          'referenceHigh': 20.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2021-10-19T09:00:00.000Z',
              'value': 15.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2023-10-17T09:00:00.000Z',
              'value': 16.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2024-10-15T09:00:00.000Z',
              'value': 16.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2025-06-10T09:00:00.000Z',
              'value': 17.0,
              'recordedBy': 'Dr. Reynolds',
            },
            <String, Object?>{
              'takenAt': '2026-06-15T09:00:00.000Z',
              'value': 22.0,
              'recordedBy': 'NP Rachel Brooks',
            },
            <String, Object?>{
              'takenAt': '2026-09-08T09:00:00.000Z',
              'value': 34.0,
              'recordedBy': 'Dr. Lisa Nguyen',
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
              'takenAt': '2019-10-15T09:00:00.000Z',
              'value': 78.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2020-10-13T09:00:00.000Z',
              'value': 70.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2021-10-19T09:00:00.000Z',
              'value': 68.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2022-10-18T09:00:00.000Z',
              'value': 71.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2023-10-17T09:00:00.000Z',
              'value': 69.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-10-15T09:00:00.000Z',
              'value': 72.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2025-06-10T09:00:00.000Z',
              'value': 70.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-01-20T09:00:00.000Z',
              'value': 74.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-06-15T09:00:00.000Z',
              'value': 84.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-09-08T09:00:00.000Z',
              'value': 96.0,
              'recordedBy': 'Dr. Lisa Nguyen',
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
              'takenAt': '2016-05-10T09:00:00.000Z',
              'value': 146.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2018-09-11T09:00:00.000Z',
              'value': 140.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2019-10-15T09:00:00.000Z',
              'value': 136.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2020-10-13T09:00:00.000Z',
              'value': 134.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2021-10-19T09:00:00.000Z',
              'value': 132.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2022-10-18T09:00:00.000Z',
              'value': 130.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2023-10-17T09:00:00.000Z',
              'value': 134.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-10-15T09:00:00.000Z',
              'value': 132.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2025-06-10T09:00:00.000Z',
              'value': 130.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-01-20T09:00:00.000Z',
              'value': 128.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-06-15T09:00:00.000Z',
              'value': 122.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-09-08T09:00:00.000Z',
              'value': 110.0,
              'recordedBy': 'Dr. Lisa Nguyen',
            },
          ],
        },
        <String, Object?>{
          'code': 'ferritin',
          'displayName': 'Ferritin',
          'unit': 'ng/mL',
          'referenceLow': 15.0,
          'referenceHigh': 150.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2017-05-08T09:00:00.000Z',
              'value': 12.0,
              'recordedBy': 'Dr. Anthony Russo',
            },
            <String, Object?>{
              'takenAt': '2018-09-11T09:00:00.000Z',
              'value': 45.0,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2022-10-18T09:00:00.000Z',
              'value': 68.0,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2026-06-15T09:00:00.000Z',
              'value': 19.0,
              'recordedBy': 'NP Rachel Brooks',
            },
          ],
        },
        <String, Object?>{
          'code': 'creatinine',
          'displayName': 'Creatinine',
          'unit': 'mg/dL',
          'referenceLow': 0.6,
          'referenceHigh': 1.1,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2018-09-11T09:00:00.000Z',
              'value': 0.8,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2020-10-13T09:00:00.000Z',
              'value': 0.8,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2022-10-18T09:00:00.000Z',
              'value': 0.9,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2024-10-15T09:00:00.000Z',
              'value': 0.9,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2026-01-20T09:00:00.000Z',
              'value': 0.9,
              'recordedBy': 'Dr. Reynolds',
            },
            <String, Object?>{
              'takenAt': '2026-09-08T09:00:00.000Z',
              'value': 1.3,
              'recordedBy': 'Dr. Lisa Nguyen',
            },
          ],
        },
        <String, Object?>{
          'code': 'tsh',
          'displayName': 'TSH',
          'unit': 'mIU/L',
          'referenceLow': 0.4,
          'referenceHigh': 4.0,
          'points': <Map<String, Object?>>[
            <String, Object?>{
              'takenAt': '2016-05-10T09:00:00.000Z',
              'value': 2.4,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2018-09-11T09:00:00.000Z',
              'value': 1.9,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2020-10-13T09:00:00.000Z',
              'value': 2.2,
              'recordedBy': 'Dr. Karen Whitfield',
            },
            <String, Object?>{
              'takenAt': '2022-10-18T09:00:00.000Z',
              'value': 2.6,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2024-10-15T09:00:00.000Z',
              'value': 2.1,
              'recordedBy': 'Dr. Sarah Kim',
            },
            <String, Object?>{
              'takenAt': '2026-01-20T09:00:00.000Z',
              'value': 2.3,
              'recordedBy': 'Dr. Reynolds',
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
              'takenAt': '2016-05-10T09:00:00.000Z',
              'value': 152.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2018-09-11T09:00:00.000Z',
              'value': 150.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2020-10-13T09:00:00.000Z',
              'value': 151.0,
              'recordedBy': 'Nurse Parker',
            },
            <String, Object?>{
              'takenAt': '2022-10-18T09:00:00.000Z',
              'value': 149.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2024-10-15T09:00:00.000Z',
              'value': 150.0,
              'recordedBy': 'Nurse Hughes',
            },
            <String, Object?>{
              'takenAt': '2026-01-20T09:00:00.000Z',
              'value': 148.0,
              'recordedBy': 'MA Tyler Jenkins',
            },
            <String, Object?>{
              'takenAt': '2026-09-08T09:00:00.000Z',
              'value': 147.0,
              'recordedBy': 'Dr. Lisa Nguyen',
            },
          ],
        },
      ],
    },
  };
}
