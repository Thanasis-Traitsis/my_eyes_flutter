# Requirements Document

## Introduction

Eye Health Manager is a Flutter mobile application designed for people with eye disabilities such as nearsightedness, astigmatism, and other refractive conditions. The app allows users to store and manage their glasses prescriptions per eye, track contact lens expiry dates, and receive timely local notifications. It also integrates with Google Calendar to schedule lens replacement reminders. The project is architected as a portfolio showcase, applying clean architecture, TDD, BLoC/Cubit state management, and go_router for navigation.

## Glossary

- **App**: The Eye Health Manager Flutter application.
- **Prescription**: A set of optical measurements for one or both eyes, including sphere, cylinder, axis, addition, and pupillary distance values.
- **Eye**: Either the left eye (OS) or right eye (OD) of the user.
- **Contact_Lens**: A corrective lens worn directly on the eye, associated with an opening date and a lifespan duration.
- **Expiry_Date**: The calculated date on which a Contact_Lens should be replaced, derived from the opening date plus the lens lifespan.
- **Notification**: A local device notification delivered by the App to alert the user.
- **Calendar_Event**: An event created in the user's Google Calendar representing a lens replacement reminder.
- **Prescription_Repository**: The data layer component responsible for persisting and retrieving Prescription records.
- **Lens_Repository**: The data layer component responsible for persisting and retrieving Contact_Lens records.
- **Notification_Service**: The application service responsible for scheduling and cancelling local Notifications.
- **Calendar_Service**: The application service responsible for creating and removing Calendar_Events in Google Calendar.
- **Prescription_Cubit**: The BLoC/Cubit responsible for Prescription state management.
- **Lens_Cubit**: The BLoC/Cubit responsible for Contact_Lens state management.
- **Router**: The go_router instance responsible for all in-app navigation.
- **Test**: An in-app vision assessment consisting of a sequence of steps, producing a score and associated with the user's profile.
- **Test_Cubit**: The BLoC/Cubit responsible for Test state management.
- **Test_Repository**: The data layer component responsible for persisting and retrieving Test records.
- **Eyewear**: A pair of glasses or corrective lenses associated with a Prescription and optionally a Test history.
- **Eyewear_Repository**: The data layer component responsible for persisting and retrieving Eyewear records.
- **Home_Screen**: The main dashboard screen displayed after login, providing an overview of the user's eye health data.
- **Profile_Screen**: The screen displaying the user's personal information, prescription summary, and aggregated statistics.
- **Bottom_Navigation_Bar**: The persistent navigation component at the bottom of the App containing the four primary tabs.
- **Auth_Repository**: The domain layer interface responsible for authentication operations via Supabase Auth.
- **Auth_Cubit**: The BLoC/Cubit responsible for authentication state management.
- **Sync_Service**: The application service responsible for synchronising local Hive data with the remote Supabase database.
- **Connectivity_Service**: The domain layer interface responsible for reporting the device's current online/offline status.
- **UserProfile**: The entity representing the authenticated user, containing id, username, email, and avatarUrl.

---

## Requirements

### Requirement 1: Store and Manage Glasses Prescriptions

**User Story:** As a person with a refractive eye condition, I want to save my glasses prescription for each eye, so that I always have my optical measurements available in one place.

#### Acceptance Criteria

1. THE App SHALL allow the user to create a Prescription containing, for each Eye: sphere (diopters, range −30.00 to +30.00 in 0.25 steps), cylinder (diopters, range −10.00 to +10.00 in 0.25 steps), axis (degrees, range 0–180), addition (diopters, range 0.00 to +4.00 in 0.25 steps), and pupillary distance (millimetres, range 40–80 in 0.5 steps).
2. THE App SHALL allow the user to assign a label and an issue date to each Prescription.
3. THE Prescription_Repository SHALL persist each Prescription to local device storage.
4. WHEN the user requests the list of saved Prescriptions, THE Prescription_Repository SHALL return all stored Prescriptions ordered by issue date descending.
5. WHEN the user selects a Prescription, THE App SHALL display all field values for both Eyes.
6. WHEN the user edits a Prescription and confirms the changes, THE Prescription_Repository SHALL update the stored record with the new values.
7. WHEN the user deletes a Prescription, THE Prescription_Repository SHALL remove the record from local storage.
8. IF a required Prescription field is missing or outside its valid range, THEN THE Prescription_Cubit SHALL emit a validation error state identifying the invalid field before persisting.
9. THE Prescription_Cubit SHALL expose states for: initial, loading, loaded, and error.
10. FOR ALL valid Prescription objects, serialising then deserialising a Prescription SHALL produce an object equal to the original (round-trip property).

---

### Requirement 2: Track Contact Lens Expiry Dates

**User Story:** As a contact lens wearer, I want to record when I opened a new pair of lenses and how long they last, so that I know exactly when to replace them.

#### Acceptance Criteria

1. THE App SHALL allow the user to create a Contact_Lens record containing: lens type label, opening date, and lifespan in days (valid values: 1, 7, 14, 30, 90).
2. WHEN a Contact_Lens record is created, THE Lens_Repository SHALL calculate and store the Expiry_Date as opening date plus lifespan days.
3. THE Lens_Repository SHALL persist each Contact_Lens record to local device storage.
4. WHEN the user requests the list of Contact_Lens records, THE Lens_Repository SHALL return all records ordered by Expiry_Date ascending.
5. WHEN the user deletes a Contact_Lens record, THE Lens_Repository SHALL remove the record from local storage.
6. IF a Contact_Lens lifespan value is not one of the valid values (1, 7, 14, 30, 90), THEN THE Lens_Cubit SHALL emit a validation error state before persisting.
7. THE Lens_Cubit SHALL expose states for: initial, loading, loaded, and error.
8. FOR ALL valid Contact_Lens objects, serialising then deserialising a Contact_Lens record SHALL produce an object equal to the original (round-trip property).

---

### Requirement 3: Local Notifications for Lens Expiry

**User Story:** As a contact lens wearer, I want to receive a notification before my lenses expire, so that I remember to replace them on time.

#### Acceptance Criteria

1. WHEN a Contact_Lens record is created, THE Notification_Service SHALL schedule a local Notification to be delivered 1 day before the Expiry_Date at 09:00 local time.
2. WHEN a Contact_Lens record is deleted, THE Notification_Service SHALL cancel the corresponding scheduled Notification.
3. WHEN the user grants notification permission, THE Notification_Service SHALL confirm permission is active before scheduling any Notification.
4. IF the device denies notification permission, THEN THE Notification_Service SHALL emit a permission-denied state and SHALL NOT schedule any Notification.
5. WHEN a Notification is delivered and the user taps it, THE Router SHALL navigate the user to the Contact_Lens detail screen for the associated record.
6. THE Notification_Service SHALL support scheduling Notifications on both Android and iOS platforms.
7. WHILE the App is in the background, THE Notification_Service SHALL deliver scheduled Notifications without requiring the App to be in the foreground.

---

### Requirement 4: Google Calendar Integration

**User Story:** As a contact lens wearer, I want my lens replacement reminders added to my Google Calendar, so that the reminder appears alongside my other appointments.

#### Acceptance Criteria

1. WHEN the user enables Google Calendar integration for a Contact_Lens record, THE Calendar_Service SHALL create a Calendar_Event on the Expiry_Date with a title and description identifying the lens type.
2. WHEN a Contact_Lens record with an associated Calendar_Event is deleted, THE Calendar_Service SHALL remove the corresponding Calendar_Event from Google Calendar.
3. WHEN the user revokes Google Calendar access, THE Calendar_Service SHALL emit an unauthorised state and SHALL NOT attempt further Calendar_Event operations until access is re-granted.
4. IF the Google Calendar API returns an error, THEN THE Calendar_Service SHALL emit an error state containing the error code and SHALL NOT silently discard the failure.
5. THE Calendar_Service SHALL request only the minimum required Google Calendar OAuth scopes needed to create and delete Calendar_Events.
6. WHERE the user has not granted Google Calendar permission, THE App SHALL display an explanation of why the permission is needed before requesting it.

---

### Requirement 5: Application Navigation

**User Story:** As a user, I want clear and consistent navigation throughout the app, so that I can move between features without confusion.

#### Acceptance Criteria

1. THE App SHALL display a persistent Bottom_Navigation_Bar containing exactly four tabs in the following order: Home, Quick Eye Test, Eyewear/Lenses, and Profile.
2. WHEN the user taps a Bottom_Navigation_Bar tab, THE Router SHALL navigate to the corresponding top-level screen and highlight the selected tab.
3. THE Router SHALL define named routes for: home, quick eye test, eyewear/lenses list, eyewear/lenses detail, prescription list, prescription detail, prescription form, lens list, lens detail, profile, and settings.
4. WHEN the user navigates to a route that does not exist, THE Router SHALL redirect the user to the home screen.
5. WHEN the user presses the back button on a nested screen, THE Router SHALL return the user to the previous screen in the navigation stack.
6. WHEN the user presses the back button on a top-level tab screen, THE Router SHALL not pop beyond the tab root.
7. THE Router SHALL support deep linking from a Notification tap to the relevant Contact_Lens detail screen.

---

### Requirement 6: Clean Architecture and Testability

**User Story:** As a developer, I want the codebase to follow clean architecture with TDD, so that the app is maintainable, testable, and suitable as a portfolio showcase.

#### Acceptance Criteria

1. THE App SHALL separate code into three layers: presentation (widgets, Cubits), domain (entities, use cases, repository interfaces), and data (repository implementations, data sources).
2. THE App SHALL define repository interfaces in the domain layer and provide implementations in the data layer, so that use cases depend only on abstractions.
3. WHEN a use case is executed, THE App SHALL invoke only domain-layer interfaces and SHALL NOT reference data-layer implementations directly.
4. THE App SHALL provide unit tests for all use cases, Cubits, repository implementations, and services before the corresponding production code is written (test-first).
5. THE App SHALL achieve a minimum of 80% line coverage across the domain and data layers as measured by the Flutter test coverage tool.
6. THE App SHALL use dependency injection to supply repository and service implementations to Cubits and use cases, so that tests can substitute fakes or mocks.
7. FOR ALL Cubit state transitions, emitting the same sequence of events SHALL produce the same sequence of states (determinism property).

---

### Requirement 7: Home Screen Dashboard

**User Story:** As a user, I want a personalised dashboard on the home screen, so that I can see the most important eye health information at a glance and quickly access key actions.

#### Acceptance Criteria

1. WHEN the Home_Screen is displayed, THE App SHALL show a personalised greeting containing the user's name (e.g. "Good Morning, Thanasis") derived from the stored profile.
2. WHEN the Home_Screen is displayed and a Contact_Lens record exists, THE App SHALL show a lens alert banner indicating the number of days remaining until the nearest Expiry_Date.
3. WHEN the Home_Screen is displayed and no Contact_Lens record exists, THE App SHALL hide the lens alert banner.
4. WHEN the Home_Screen is displayed, THE App SHALL show a current prescription summary card containing the most recently issued Prescription values for both Eyes.
5. WHEN the user taps the prescription summary card edit shortcut, THE Router SHALL navigate to the prescription form screen pre-populated with the current Prescription values.
6. WHEN the Home_Screen is displayed and at least one Eyewear record exists, THE App SHALL render an eyewear collection section as a horizontally scrollable list of Eyewear items.
7. WHEN the Home_Screen is displayed, THE App SHALL show an upcoming events section listing scheduled lens replacement and eye checkup Calendar_Events ordered by date ascending.
8. WHEN the user taps the "Add New Prescription" quick action button, THE Router SHALL navigate to the prescription form screen.
9. WHEN the user taps the "Add New Lenses" quick action button, THE Router SHALL navigate to the lens creation form screen.
10. THE Home_Screen SHALL display a notification bell icon in the header that, when tapped, navigates to the notifications overview screen.
11. THE Home_Screen SHALL display a settings icon in the header that, when tapped, navigates to the settings screen.

---

### Requirement 8: Quick Eye Test

**User Story:** As a user, I want to take a step-by-step in-app vision test, so that I can monitor changes in my eyesight over time and keep a history of my results.

#### Acceptance Criteria

1. WHEN the Quick Eye Test screen is displayed, THE App SHALL show a "Start Test" call-to-action button and a test statistics section.
2. WHEN the user taps "Start Test", THE App SHALL present a guided vision test consisting of exactly 3 sequential steps, each displaying instructions before the user proceeds.
3. WHEN the user completes all 3 steps, THE Test_Repository SHALL persist the Test record containing the score (expressed as a percentage, 0–100), timestamp, and associated user profile identifier.
4. WHEN the Quick Eye Test screen is displayed, THE App SHALL show a test history list of all saved Test records ordered by timestamp descending, each entry displaying its score.
5. WHEN the test history list is displayed, THE App SHALL provide a filter control (defaulting to "All") that, when changed, updates the visible Test records to match the selected filter criterion.
6. IF the Test_Repository returns an error during save or retrieval, THEN THE Test_Cubit SHALL emit an error state containing a descriptive message.
7. THE Test_Cubit SHALL expose states for: initial, loading, loaded, and error.
8. FOR ALL valid Test objects, serialising then deserialising a Test record SHALL produce an object equal to the original (round-trip property).

---

### Requirement 9: Eyewear/Lenses Screen

**User Story:** As a user, I want to view and manage my eyewear and lenses alongside their associated prescriptions and test history, so that I can track whether my glasses are still suitable for my current vision.

#### Acceptance Criteria

1. WHEN the Eyewear/Lenses screen is displayed, THE App SHALL show a list of all stored Eyewear records.
2. WHEN the user selects an Eyewear record, THE App SHALL display the associated Prescription details including the last updated date, with a toggle to switch between left Eye (OS) and right Eye (OD) values.
3. WHEN an Eyewear record is displayed, THE App SHALL show a status banner indicating whether the associated Prescription is current or should be updated, determined by comparing the Eyewear Prescription issue date against the most recently saved Prescription issue date.
4. WHEN the Eyewear detail screen is displayed, THE App SHALL show the Test history associated with that Eyewear record, ordered by timestamp descending.
5. THE Eyewear/Lenses screen SHALL display a floating action button (FAB) that, when tapped, navigates to the eyewear/lens creation form screen.
6. WHEN the user submits the eyewear/lens creation form, THE Eyewear_Repository SHALL persist the new Eyewear record to local device storage.
7. WHEN the user deletes an Eyewear record, THE Eyewear_Repository SHALL remove the record from local device storage.
8. IF a required Eyewear field is missing, THEN THE App SHALL emit a validation error state identifying the invalid field before persisting.

---

### Requirement 10: Profile Screen

**User Story:** As a user, I want a profile screen that summarises my eye health statistics and provides quick access to my prescription history and calendar events, so that I can review my overall eye health at a glance.

#### Acceptance Criteria

1. WHEN the Profile_Screen is displayed, THE App SHALL show the user's username with an edit option that, when tapped, allows the user to update the username.
2. WHEN the Profile_Screen is displayed, THE App SHALL show a current prescription summary section displaying the most recently issued Prescription values for both Eyes, with a toggle to switch between left Eye (OS) and right Eye (OD).
3. WHEN the Profile_Screen is displayed, THE App SHALL show a profile insights widget containing: a circular progress indicator representing the number of days remaining until the nearest Contact_Lens Expiry_Date, the total count of completed Tests, and the total count of stored Eyewear records.
4. WHEN the Profile_Screen is displayed, THE App SHALL show a Calendar Events section displaying the count of upcoming Calendar_Events and a navigation arrow that, when tapped, navigates to the full calendar events list.
5. WHEN the Profile_Screen is displayed, THE App SHALL show a Prescription History section with a navigation arrow that, when tapped, navigates to the prescription list screen showing all stored Prescriptions ordered by issue date descending.
6. WHEN the user confirms a username edit, THE App SHALL persist the updated username and immediately reflect the change in the personalised greeting on the Home_Screen.

---

### Requirement 11: Authentication and Cloud Sync

**User Story:** As a user, I want to sign in with my Google or Apple account and have my eye health data backed up to the cloud, so that I can access it on any device and never lose it.

#### Acceptance Criteria

1. WHEN the user opens the App for the first time or is unauthenticated, THE App SHALL display a sign-in screen offering "Sign in with Google" and "Sign in with Apple" options via Supabase Auth.
2. WHEN the user successfully authenticates, THE Auth_Cubit SHALL emit an `AuthAuthenticated` state containing the user's `UserProfile` (id, username, email, avatarUrl).
3. WHEN an unauthenticated user attempts to navigate to any protected route, THE Router SHALL redirect them to the sign-in screen.
4. WHEN the user creates or updates any data record while the device is offline, THE App SHALL persist the record to Hive immediately and mark it as pending sync.
5. WHEN connectivity is restored, THE Sync_Service SHALL automatically push all pending local changes to Supabase without requiring user action.
6. WHEN the same record exists both locally and remotely with different `updatedAt` timestamps, THE Sync_Service SHALL retain the version with the later `updatedAt` timestamp (last-write-wins conflict resolution).
7. WHEN a user signs in on a new device, THE Sync_Service SHALL pull all their data from Supabase and populate local Hive storage.
8. WHEN the user signs out, THE App SHALL clear all local Hive data and navigate to the sign-in screen.
9. THE App SHALL function fully offline; all read and write operations SHALL use local Hive storage as the primary source of truth.
10. ALL entities (Prescription, ContactLens, Eyewear, VisionTest, UserProfile) SHALL include an `updatedAt` DateTime field used for conflict resolution during sync.
