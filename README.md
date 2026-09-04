# Tennis Cash Court

Keeps track of court-rental hours and who still owes for them. Flutter application, 2022.

## The problem

You book a tennis court by the hour and play with whoever is available. The court is paid for by
the hour, not per player, so the cost of each session has to be divided between the people who
actually turned up — and then someone has to remember who has already settled up.

## What it does

- **Record a session** — date, number of hours, and the partners who played
- **Cost split** derived from the hourly rate in settings and the number of players in that
  session; the rate and the currency are both configurable
- **Outstanding balance per player**, with a payment screen for marking a debt as settled
- **Filtering** by period and by player, with summary cards over the selected range
- **Accounts and sync** — Firebase Authentication for signing in, Firebase Realtime Database for
  keeping the record available on more than one device, with an administrator flag on a player
- English and Czech, through GetX `Translations`

## Screenshots

| Main screen | Add player |
|---|---|
| <img src="screenshots/Screenshot_main.png" width="260"> | <img src="screenshots/Screenshot_add_player.png" width="260"> |

| Settings | Payment |
|---|---|
| <img src="screenshots/Screenshot_settings.png" width="260"> | <img src="screenshots/Screenshot_pay_screen.png" width="260"> |

## Implementation notes

```
lib/
  controllers/   GetX controllers, including the authentication flow
  model/         player, tennis_hour, database and storage models
  view/          screens, cards, dialogs, custom navigation bar
  others/        constants, languages, file logging
```

Built on **GetX** for state, routing and dependency lookup — `Get.find()` is used from inside the
model classes themselves. This is the one project here that uses GetX; everything I wrote after it
uses BLoC instead, with the model layer kept free of any service locator.

Records are serialised with `json_serializable`, cached locally through `get_storage`, and
mirrored into Firebase Realtime Database.

## Building

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Uses its own Firebase project; `lib/firebase_options.dart` is checked in.

## Status

Archived. `TODO.txt` still holds the one thing that was never finished — automatic sync to
Firebase rather than sync on demand.
