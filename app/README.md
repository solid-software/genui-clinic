# GenUI Clinic — the app

The Flutter app: today's patient list, the check-in, and the brief for the
patient being seen, which the [brief agent](../brief_agent/README.md)
composes and [`genui`](https://pub.dev/packages/genui) renders. 
For an overview of the project and how its two parts fit together, see the
[main README](../README.md).

Every command below runs in this folder, `app/`.

## Setup

### 1. Install Flutter

Flutter **3.47.3 or newer**.

### 2. Get the Firebase configuration

It is not in the repo. Generate it with the FlutterFire CLI, if you have
access to the Firebase project:

```bash
flutterfire configure --project=clinical-brief
```

or ask the project maintainer for the four files and put them here:
`lib/firebase_options.dart`, `android/app/google-services.json`,
`ios/Runner/GoogleService-Info.plist` and
`macos/Runner/GoogleService-Info.plist`.

### 3. Run it

Copy `dart_defines.example.json` to `dart_defines.json` (it is git-ignored)
and put the team's App Check debug token in it. Then:

```bash
flutter pub get
flutter run --dart-define-from-file=dart_defines.json
```

### 4. Before you push

```bash
flutter analyze
flutter test
```

CI runs both. `flutter test` also checks that the agent's copy of the
catalog matches the app's.
If you change the catalog (`lib/medical_catalog/`),
regenerate the copy, commit it, and redeploy the agent:

```bash
UPDATE_AGENT_CATALOG=1 flutter test test/agent_catalog_test.dart
```

## Architecture

```
lib/
  main.dart          boots Firebase, the services and the app
  common/            shared by every feature: di/ (service locator),
                     logging/, models/ (ClinicalTone, ShellSection),
                     pages/ (the root widget), routes/ (go_router and the
                     links), utils/ (formatting, JSON reading), widgets/
                     (shared widgets; shell/ is the sidebar and frames
                     every screen sits in)
  firebase/          Firebase and App Check setup
  theme/             theme, spacing and text styles
  check_in/          screen 1, /check_in: today's list and the check-in dialog;
                     the patient, record and complaint models and their store
  dashboard/         screen 2, /dashboard?patientId=…&complaint=…: the brief
                     for the patient being seen, its hero header, refine
                     field and the full record
  brief_composer/    asks the brief agent for each brief (no UI): its client,
                     the turns, the transport into GenUI
  medical_catalog/   the component vocabulary: catalog, items, models,
                     widgets and the motion between briefs
  demo/              the fictional patients, the prompts to try, and the
                     presenter's demo widgets
  auth/              handles google sign in
test/                agent_catalog_test.dart: writes and checks the agent's
                     copy of the catalog
```

## The catalog

Fourteen custom components (eleven for content, plus `ChartGroup`,
`SplitSection` and `SectionGrid` for layout) on top
of a trimmed basic catalog (no images, video, audio or free-form inputs):

| Component         | What it is for                                                                                                 |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| `SafetyBanner`    | Allergies, active drugs, anticoagulation. Pinned first on every brief.                                         |
| `TrendChart`      | Any value with two or more readings. Hand-painted sparkline with per-point values and a dashed reference line. |
| `MeasurementRow`  | Readings taken today, as large tiles.                                                                          |
| `XRayImage`       | A radiograph from the record, enlarged on tap.                                                                 |
| `ImagingTimeline` | Scans and studies on a time line, with the gap since the last one.                                             |
| `MedicationTable` | What the patient takes, as a table.                                                                            |
| `CareGapList`     | Follow-ups the record shows as due, overdue or never done.                                                     |
| `LabPanel`        | One day's results: what is out of range in full, the rest as a count.                                          |
| `BarComparison`   | Values as bars against a target.                                                                               |
| `EcgStrip`        | A rhythm strip drawn at a given rate.                                                                          |
| `SectionGrid`     | Sections in a grid, each as wide as it asks to be.                                                             |
| `SplitSection`    | Two columns of sections, for a brief read as a dashboard.                                                      |
| `FactList`        | Chart lines with no trend: history, risk factors, prior imaging.                                               |
| `ChartGroup`      | Places trend charts two per row on wide screens, stacked on narrow ones.                                       |

The full record is not a catalog component.
The `FullRecordSection` displays it below the brief once the brief has appeared,
so it's always shown, regardless of the model's choices.

The component for conclusions is absent on purpose. The model only chooses
and orders data against the complaint; it never names a possible illness,
suggests a score or recommends an action. That judgement stays with the
doctor.

The catalog is deliberately small. A larger one lets the model invent layouts,
while a smaller one keeps its effort on deciding what to show.

## Troubleshooting

| Symptom | Cause |
|---|---|
| `UnsupportedError: firebase_options.dart is a placeholder` | `lib/firebase_options.dart` missing (step 2). |
| Android build fails on `google-services.json` | File missing from `android/app/` (step 2). |
| `unauthenticated` from `briefagent` on the first brief | Debug token not passed (step 3). |
| `unauthenticated` still, token is right | The token may have been rotated. Ask the maintainer for the current one. |
| `not-found` or a CORS error from `briefagent` | The agent is not deployed yet; see [its README](../brief_agent/README.md). |
| Brief stays on "Composing the brief" for a long time | The agent cuts a reply that stalls for 20 s and retries on the next model. It gives up after about four minutes in all; then the error appears with **Try again**. |
| Every brief fails, or nothing renders and no error | Look at the agent's logs; see [its README](../brief_agent/README.md). |
| `pub get` fails with a `meta` version conflict | Flutter older than 3.47 (step 1). |

## Image credits

The images in `assets/imaging/` are anonymised scans of real people,
taken from two NIH Clinical Center datasets, and assigned to fictional patients.
They were chosen to match the patients' records: sex, age,
no devices or surgical changes that aren't mentioned by the record,
and a dataset label consistent with the conclusion.

| File                                   | Source                                 | Dataset label      |
|----------------------------------------|----------------------------------------|--------------------|
| `john_miller_chest_2021.png`           | ChestX-ray, `00027426_000` (M, 53)     | No finding         |
| `margaret_collins_chest_2024.png`      | ChestX-ray, `00000334_002` (F, 66)     | Emphysema          |
| `patricia_evans_chest_2024.png`        | ChestX-ray, `00000458_001` (F, 53)     | Infiltration       |
| `margaret_collins_ct_abdomen_2017.png` | DeepLesion CT slice, `000435_03_2_56`  | upper abdomen      |
| `patricia_evans_ct_chest_2021.png`     | DeepLesion CT slice, `000293_06_3_203` | chest, heart level |

The chest radiographs ship as sample images with torchxrayvision and with
NIH's own [CADLab](https://github.com/rsummers11/CADLab) repository; the CT
slices ship as test data in CADLab's body-part regressor.

NIH releases the dataset for use without restriction, asking that it be
credited. Source: https://nihcc.app.box.com/v/ChestXray-NIHCC ·
Wang X, Peng Y, Lu L, Lu Z, Bagheri M, Summers RM. *ChestX-ray8:
Hospital-scale Chest X-ray Database and Benchmarks on Weakly-Supervised
Classification and Localization of Common Thorax Diseases.* IEEE CVPR 2017.

DeepLesion: https://nihcc.app.box.com/v/DeepLesion · Yan K, Wang X, Lu L,
Summers RM. *DeepLesion: automated mining of large-scale lesion annotations
and universal lesion detection with deep learning.* J Med Imaging 5(3), 2018.
