# Cozcuk

A Turkish-language word puzzle game for iPhone and iPad, built with Swift and SpriteKit.

Cozcuk hides words through synonym substitutions. Find the meaningful pieces in a seemingly unfamiliar string, work out their equivalents, and reconstruct the original Turkish word. Some pieces use reversed spellings, adding another layer to the puzzle.

<img width="500" height="500" alt="instagram" src="https://github.com/user-attachments/assets/9e54228c-4611-4606-a709-3a4f681f22f7" />

## How to Play

1. Tap **Oyna** to start.
2. Examine the puzzle and identify parts that may represent synonyms of other words.
3. Enter your answer using the Turkish on-screen keyboard, then tap **Gönder**.
4. Use **İpucu** to highlight the puzzle’s component groups and reveal the answer’s letter count.
5. Tap **Pes** to reveal an animated solution, or **Geç** to move to another puzzle.

The app opens its tutorial on first launch. You can revisit the tutorial from the welcome screen.

Answer checking ignores letter case and accepts Turkish letters and their unaccented equivalents, including `ç/c`, `ğ/g`, `ı/i`, `ö/o`, `ş/s`, and `ü/u`.

## Features

- **Generated puzzles:** Builds questions from bundled Turkish word and synonym dictionaries.
- **Varied transformations:** Uses multiple construction strategies, synonym substitutions, and reversed word parts.
- **Rank-based difficulty:** Selects among **Kolay**, **Orta**, and **Zor** puzzles according to the player’s rank.
- **Progression:** Includes combo tracking and achievement logic based on puzzle characteristics and solution speed.
- **Hints and animated solutions:** Shows how a question breaks down and transforms into its answer.
- **Statistics:** Tracks attempts, direct solutions, solutions with hints, and puzzles given up.
- **Sound and haptics:** Provides feedback for input and game events.

Statistics, rank data, and selected app state are stored locally using `UserDefaults`.

## Technology and Requirements

| Item | Project configuration |
| --- | --- |
| Language | Swift, using Swift 5 language mode |
| Game interface | SpriteKit with UIKit |
| Minimum deployment target | iOS 15.5 |
| Device families | iPhone and iPad |
| Runtime orientation | Portrait |
| Purchases | StoreKit |
| Project file | `cozcuk.xcodeproj` |

Development requires macOS and Xcode with an SDK compatible with the deployment target. No third-party package dependencies are declared in the Xcode project.

## Repository Status

**The checked-in project is incomplete and needs missing files restored before it can be built as a standalone checkout.**

The Xcode project references files outside the repository through paths containing multiple `../` components. Missing references include:

- `GameRunMode.swift`, `ColorScheme.swift`, and `Enablement.swift`
- `RankManager.swift`, `UserRank.swift`, and `rank.txt`
- Tutorial infrastructure, including `Slide.swift` and `TutorialSlideSet.swift`
- Scoreboard widgets, shared button components, and additional support files

These files must be recovered and their project references corrected before building. The features described above reflect the available source and its integrations; they do not establish that the current checkout runs successfully.

## Getting Started

Clone the repository and open the project:

```sh
git clone https://github.com/keremkoseoglu/cozcuk.git
cd cozcuk
open cozcuk.xcodeproj
```

Before running:

1. Restore the missing source files and resources described above.
2. Correct their references in Xcode and confirm their target membership.
3. Select the `cozcuk` scheme and an iOS Simulator or connected device.
4. For a physical device, select your own development team in **Signing & Capabilities** and adjust the bundle identifier if needed.
5. Build and run.

The project currently uses the bundle identifier `com.keremkoseoglu.Cozcuk` and automatic signing.

## In-App Purchases

The source includes a limited free allowance for hints and solution reveals, followed by a StoreKit purchase flow using the product identifier `IpucuCevap`. Purchase restoration is also implemented.

Testing purchases requires a matching StoreKit/App Store Connect setup. Product availability and pricing cannot be determined from this repository.

## Project Layout

```text
cozcuk/
├── Assets/          # Dictionaries, images, and audio
├── Assets.xcassets/ # App icon and asset catalog
├── Data/            # Local persistence, statistics, and purchases
├── Feedback/        # Audio and haptic feedback
├── Level/           # Available rank, combo, and achievement logic
├── Question/        # Dictionaries, puzzle builders, and answer checking
├── Scenes/          # Welcome, tutorial, game, and statistics screens
└── Widgets/         # Keyboard, panels, puzzle nodes, and animations

Tests/               # Manual test helpers and a SpriteKit test scene
Playground/          # Animation experiments
cozcuk.xcodeproj/    # Xcode project and build settings
```

## Testing

`Tests/` contains manually invoked helpers for dictionary loading, string utilities, answer checking, puzzle generation, and purchases, plus a visual test scene.

These files are included in the application target. The project does not define a separate XCTest target or an automated test scheme. Some helpers also need updating to match the current implementation.

## Author

Created by [Dr. Kerem Köseoğlu](http://www.keremkoseoglu.com).
