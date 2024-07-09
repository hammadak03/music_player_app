# PulsePlay

PulsePlay is a music player application built using Flutter. The app allows users to browse, search, and play their favorite music files with ease.

## Features

- **Browse Music Library:** View all music files available on your device.
- **Search Functionality:** Quickly find music by song name or artist.
- **Playback Controls:** Play, pause, skip forward, and skip backward.
- **Animated Album Art:** Enjoy a rotating album art display while music is playing.
- **Track Progress:** See the current position and duration of the song being played.
- **Background Playback:** Continue listening to music while using other apps.


## Technologies Used

- **Flutter**: For building the cross-platform mobile application.
- **GetX**: For state management and navigation.
- **Just Audio**: For audio playback.
- **On Audio Query**: For querying music files from the device.
- **Permission Handler**: For handling permissions to access storage.

## Usage

- Open the app to see the music library.
- Use the search bar to filter songs by name or artist.
- Tap on a song to start playing it.
- Use the playback controls to manage the music.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart: [Install Dart](https://dart.dev/get-dart)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/PulsePlay.git
   cd PulsePlay

## Project Structure

```sh
.
├── lib
│   ├── controllers
│   │   └── player_controller.dart
│   ├── screens
│   │   ├── home.dart
│   │   └── player.dart
│   ├── utils
│   │   ├── colors.dart
│   │   └── text_style.dart
│   └── main.dart
├── pubspec.yaml
├── README.md
└── screenshots
    ├── music_library.png
    └── player_screen.png
